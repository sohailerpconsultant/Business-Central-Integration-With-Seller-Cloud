codeunit 60113 "Bulk PO Request Handler"
{
    trigger OnRun()
    begin

    end;

    procedure GetBulkPurchaseOrders()
    var
        SellerCloudSetup: Record "Seller Cloud Setup";
        BulkPOResponseHandler: Codeunit "Bulk PO Response Handler";

        Httpclient: HttpClient;
        RequestHeaders: HttpHeaders;
        HttpRequestMSg: HttpRequestMessage;
        HttpRequestResponse: HttpResponseMessage;

        _IsSucessfull: Boolean;
        _Response: Text;
        _URL: Text;
        AuthString: Text;
        OrderStatus: Text;
        JSONManagement: Codeunit "JSON Management";
        TotalResults: Text;
        NoOfRecords: Integer;
        LoopCounter: Decimal;
        pageNumber: text;
        PageNoInteger: Integer;
    begin
        Clear(_URL);
        Clear(_Response);
        Clear(_IsSucessfull);
        Clear(AuthString);
        Clear(PageNoInteger);
        Clear(pageNumber);
        Clear(OrderStatus);
        PageNoInteger := 1;

        SellerCloudSetup.FindFirst();
        if (SellerCloudSetup."Order Status" = SellerCloudSetup."Order Status"::Completed) then
            OrderStatus := 'Completed'
        else
            OrderStatus := '';

        _URL := SellerCloudSetup."PO URL" + '?pageNumber=' + Format(PageNoInteger) + '&pageSize=50' + '&pOStatuses=' + OrderStatus;
        AuthString := SellerCloudSetup."Bearer Token";

        AuthString := StrSubstNo('Bearer %1', AuthString);

        RequestHeaders.Clear();
        HttpRequestMSg.GetHeaders(RequestHeaders);
        HttpRequestMSg.Method('GET');
        HttpClient.DefaultRequestHeaders.Add('Authorization', AuthString);
        _IsSucessfull := Httpclient.Get(_URL, HttpRequestResponse);
        if _IsSucessfull then begin
            HttpRequestResponse.Content.ReadAs(_Response);
            JSONManagement.InitializeObject(_Response); // for checking total records so that if it is greater than 50 we can make pagination request as seller cloud max defulat limit is 50 record per page
            JSONManagement.GetArrayPropertyValueAsStringByName('TotalResults', TotalResults);
            BulkPOResponseHandler.StorePurchaseOrders(_Response);

        end;

    end;

    var
        myInt: Integer;
}