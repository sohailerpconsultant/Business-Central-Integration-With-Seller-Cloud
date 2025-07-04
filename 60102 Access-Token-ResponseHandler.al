codeunit 60102 "Token Response Handler"
{
    trigger OnRun()
    begin

    end;

    procedure StoreTokenResponse(response: Text)
    var
        Json_Array: JsonArray;
        Json_Token: JsonToken;
        Json_Object: JsonObject;
        Cloud_Setup: Record "Seller Cloud Setup";
        i: Integer;
    begin
        if Json_Token.ReadFrom(response) then begin
            if Json_Token.IsArray then begin                // First We will check if the response is in Array [] or Object
                Json_Array := Json_Token.AsArray();
                for i := 0 to Json_Array.Count - 1 do begin
                    Json_Array.Get(i, Json_Token);
                    if Json_Token.IsObject then begin
                        Json_Object := Json_Token.AsObject();
                        StoreToken(Json_Object);
                    end;
                end;
            end
            else begin                                      // if response is not in array that means it will be in OBject {}
                Json_Object := Json_Token.AsObject();
                StoreToken(Json_Object);
            end;
        end;
    end;
    // Store Toekn in AWS Setup table

    procedure StoreToken(LWA_Json_Object: JsonObject): Boolean
    var
        Json_Methods: Codeunit JSON_Methods;
        Cloud_Setup: Record "Seller Cloud Setup";
    begin
        Cloud_Setup.FindFirst();
        Cloud_Setup."Bearer Token" := Json_Methods.GetJsonToken(LWA_Json_Object, 'access_token').AsValue().AsText();
        Cloud_Setup.Modify();
    end;
}