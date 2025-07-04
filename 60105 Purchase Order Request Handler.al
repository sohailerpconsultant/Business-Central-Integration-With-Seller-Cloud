codeunit 60105 "Purchase Order Request Handler"
{
    trigger OnRun()
    begin

    end;

    procedure PO_RequestHandler()
    var
        SellerCloudSetup: Record "Seller Cloud Setup";
        PO_ResponseHandler: Codeunit "PO Response Handler";
        //abcResponse: Codeunit 60107;

        HttpClient: HttpClient;
        RequestHeaders: HttpHeaders;
        HttpResponseMsg: HttpResponseMessage;
        HttpRqstMsg: HttpRequestMessage;

        IsSuccessfull: Boolean;
        _Response: Text;
        _URL: Text;
        AuthString: Text;
    begin
        Clear(_URL);
        Clear(_Response);
        Clear(IsSuccessfull);
        Clear(AuthString);

        SellerCloudSetup.FindFirst();

        _URL := SellerCloudSetup."PO URL" + '&ID=' + SellerCloudSetup."PO ID";
        AuthString := SellerCloudSetup."Bearer Token";

        AuthString := StrSubstNo('Bearer %1', AuthString);
        RequestHeaders.Clear();
        HttpRqstMsg.GetHeaders(RequestHeaders);
        HttpRqstMsg.Method('GET');
        HttpClient.DefaultRequestHeaders.Add('Authorization', AuthString);
        IsSuccessfull := HttpClient.Get(_URL, HttpResponseMsg);
        if IsSuccessfull then begin
            HttpResponseMsg.Content.ReadAs(_Response);
            PO_ResponseHandler.PO_ResponseHandler(_Response);
        end;

    end;

    var
        myInt: Integer;
}