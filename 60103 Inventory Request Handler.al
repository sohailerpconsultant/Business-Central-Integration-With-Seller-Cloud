codeunit 60103 "Inventory Request Handler"
{
    trigger OnRun()
    begin

    end;

    procedure GetInventory()
    var
        SellerCloudSetup: Record "Seller Cloud Setup";
        InventoryResponseHandler: Codeunit "Inventory Response Handler";
        JobQueLog: Record "Job Que Rqst Log";
        Httpclient: HttpClient;
        RequestHeaders: HttpHeaders;
        HttpRequestMSg: HttpRequestMessage;
        HttpRequestResponse: HttpResponseMessage;

        _IsSucessfull: Boolean;
        _Response: Text;
        _URL: Text;
        AuthString: Text;
        JSONManagement: Codeunit "JSON Management";
        TotalResults: Text;
        NoOfRecords: Integer;
        LoopCounter: Decimal;
        pageNumber: text;
        PageNoInteger: Integer;
        LastmodifiedDate: Text;
    begin
        Clear(_URL);
        Clear(_Response);
        Clear(_IsSucessfull);
        Clear(AuthString);
        Clear(PageNoInteger);
        Clear(pageNumber);
        PageNoInteger := 1;

        if JobQueLog.FindFirst() then
            LastmodifiedDate := Format(JobQueLog."End Date Time", 10, '<Year4>-<Month,2>-<Day,2>');
        SellerCloudSetup.FindFirst();
        _URL := SellerCloudSetup."Inventory URL" + '?pageNumber=' + Format(PageNoInteger) + '&pageSize=50' + '&LastUpdatedFrom=' + LastmodifiedDate;
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
            InventoryResponseHandler.StoreInventory(_Response);
            Evaluate(NoOfRecords, TotalResults);
            LoopCounter := Round(NoOfRecords / 50, 1, '>') - 1; // -1 is becuase loop for page 1 already is run

            if NoOfRecords >= 50 then begin
                PageNoInteger := 2;
                repeat
                    Clear(_Response);
                    Clear(_IsSucessfull);

                    _URL := SellerCloudSetup."Inventory URL" + '?pageNumber=' + Format(PageNoInteger) + '&pageSize=50';
                    _IsSucessfull := Httpclient.Get(_URL, HttpRequestResponse);
                    if _IsSucessfull then begin
                        HttpRequestResponse.Content.ReadAs(_Response);
                        InventoryResponseHandler.StoreInventory(_Response);
                    end;
                    PageNoInteger += 1;
                    LoopCounter -= 1;
                until LoopCounter = 0
            end


        end;

    end;

    var
        myInt: Integer;
}