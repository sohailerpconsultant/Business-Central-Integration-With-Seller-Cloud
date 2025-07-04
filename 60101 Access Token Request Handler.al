codeunit 60101 "Access Token Request Handler"
{
    trigger OnRun()
    begin

    end;

    procedure AccessToken()
    var
        lRecSetup: Record "Seller Cloud Setup";
        HttpClient: HttpClient;
        HttpContent: HttpContent;
        HttpHeadersContent: HttpHeaders;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        JsonObject: JsonObject;
        _URL: Text;
        _RequestBodyContent: Text;
        _Response: Text;

        TokenResponseHandler: Codeunit "Token Response Handler";
    begin
        Clear(_URL);
        Clear(_RequestBodyContent);
        Clear(_Response);
        Clear(JsonObject);

        lRecSetup.FindFirst();
        _URL := lRecSetup."Token URL";

        HttpRequestMessage.Method('POST');
        HttpRequestMessage.SetRequestUri(_URL);

        JsonObject.Add('Username', lRecSetup."User Name");
        JsonObject.Add('Password', lRecSetup.Password);

        JsonObject.WriteTo(_RequestBodyContent);
        HttpContent.WriteFrom(_RequestBodyContent);
        HttpContent.GetHeaders(HttpHeadersContent);
        HttpHeadersContent.Clear();
        HttpHeadersContent.Add('Content-Type', 'application/json');
        HttpRequestMessage.Content := HttpContent;
        HttpClient.Post(_URL, HttpContent, HttpResponseMessage);
        if (HttpResponseMessage.IsSuccessStatusCode) then begin
            HttpResponseMessage.Content.ReadAs(_Response);
            TokenResponseHandler.StoreTokenResponse(_Response);
        end;

    end;

    var
        myInt: Integer;
}