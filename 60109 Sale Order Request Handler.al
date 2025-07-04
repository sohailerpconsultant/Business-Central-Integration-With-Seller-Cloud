codeunit 60109 "Sale Order Request Handler"
{
    trigger OnRun()
    begin

    end;

    procedure SO_RequestHandler()
    var
        SellerCloudSetup: Record "Seller Cloud Setup";
        Cu_SoResponseHandler: Codeunit "SaleOrder Response Handler";

        HttpClient: HttpClient;
        RequestHeaders: HttpHeaders;
        HttpResponseMsg: HttpResponseMessage;
        HttpRqstMsg: HttpRequestMessage;

        IsSuccessfull: Boolean;
        _Response: Text;
        _URL: Text;
        AuthString: Text;
        OrderStatus: Text;

        PageNoInteger: Integer;

    begin
        Clear(_URL);
        Clear(_Response);
        Clear(IsSuccessfull);
        Clear(AuthString);

        SellerCloudSetup.FindFirst();

        _URL := SellerCloudSetup."SO URL" + SellerCloudSetup."SO ID";
        AuthString := SellerCloudSetup."Bearer Token";

        AuthString := StrSubstNo('Bearer %1', AuthString);
        RequestHeaders.Clear();
        HttpRqstMsg.GetHeaders(RequestHeaders);
        HttpRqstMsg.Method('GET');
        HttpClient.DefaultRequestHeaders.Add('Authorization', AuthString);
        IsSuccessfull := HttpClient.Get(_URL, HttpResponseMsg);
        if IsSuccessfull then begin
            HttpResponseMsg.Content.ReadAs(_Response);
            Cu_SoResponseHandler.StoreSalesOrders(_Response);
        end;

    end;

    var
        myInt: Integer;
}