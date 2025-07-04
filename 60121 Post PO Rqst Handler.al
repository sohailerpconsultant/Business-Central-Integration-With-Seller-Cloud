codeunit 60121 "Post PO to Seller Cloud"
{
    trigger OnRun()
    begin
    end;

    procedure Post(PurchaseHeader: Record "Purch. Inv. Header")
    var
        JsonObject: JsonObject;
        JsonArray: JsonArray;
        PurchaseLine: Record "Purch. Inv. Line";
        HttpClient: HttpClient;
        HttpContent: HttpContent;
        HttpResponseMsg: HttpResponseMessage;
        HttpRequestMessage: HttpRequestMessage;
        HttpHeadersContent: HttpHeaders;
        LineJsonObject: JsonObject;
        AuthString: Text;
        SellerCloudSetup: Record "Seller Cloud Setup";
        _URL: Text;
        IsSuccessfull: Boolean;
        JsonText: Text;
        ResponseText: Text;
    begin
        // Step 1: Define API URL
        _URL := 'https://piccolino-trial.api.sellercloud.us/rest/api/PurchaseOrders';

        // Step 2: Construct JSON Header
        JsonObject.Add('CompanyID', 164);
        JsonObject.Add('VendorID', 13291);
        JsonObject.Add('POType', 'PurchaseOrder');
        JsonObject.Add('CaseQtyMode', true);
        JsonObject.Add('DefaultWarehouseID', 0);
        JsonObject.Add('Description', 'string');
        JsonObject.Add('VendorNote', 'string');
        JsonObject.Add('PaymentTermID', 0);
        JsonObject.Add('ExpectedDeliveryDate', '2020-05-25T21:58:33.197Z');

        // Step 3: Construct JSON Lines
        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
        PurchaseLine.SetRange(Type, PurchaseLine.Type::Item);
        if PurchaseLine.FindSet() then begin
            repeat
                LineJsonObject.Add('ProductID', 'BATBOL');
                LineJsonObject.Add('QtyCasesOrdered', 100);
                LineJsonObject.Add('QtyUnitsPerCase', 100);
                LineJsonObject.Add('CasePrice', 20);
                LineJsonObject.Add('DiscountType', 'FixedAmount');
                LineJsonObject.Add('DiscountValue', 0);
                LineJsonObject.Add('ItemNotes', '');
                JsonArray.Add(LineJsonObject);
            until PurchaseLine.Next() = 0;
        end;
        JsonObject.Add('Products', JsonArray);

        // Step 4: Add Shipping Address
        JsonObject.Add('ShippingAddress', CreateShippingAddressJson());

        // Step 5: Convert JSON Object to Text
        JsonObject.WriteTo(JsonText);
        HttpContent.WriteFrom(JsonText);

        // Step 6: API Authorization
        SellerCloudSetup.FindFirst();
        AuthString := SellerCloudSetup."Bearer Token";
        AuthString := StrSubstNo('Bearer %1', AuthString);

        // Step 7: Send POST Request
        HttpRequestMessage.Method('POST');
        HttpRequestMessage.SetRequestUri(_URL);

        HttpContent.GetHeaders(HttpHeadersContent);
        HttpClient.DefaultRequestHeaders.Add('Authorization', AuthString);


        HttpContent.GetHeaders(HttpHeadersContent);
        HttpHeadersContent.Clear();
        HttpHeadersContent.Add('Content-Type', 'application/json');
        HttpRequestMessage.Content := HttpContent;
        HttpClient.Post(_URL, HttpContent, HttpResponseMsg);
        HttpResponseMsg.Content.ReadAs(ResponseText);
        if HttpResponseMsg.IsSuccessStatusCode then begin
            Message('Purchase Order created successfully. Response: %1', ResponseText);
        end else begin
            Error('Failed to create Purchase Order. Error: %1', ResponseText);
        end;
    end;

    // Create Shipping Address JSON
    local procedure CreateShippingAddressJson(): JsonObject
    var
        ShippingJson: JsonObject;
    begin
        ShippingJson.Add('FirstName', 'string');
        ShippingJson.Add('LastName', 'string');
        ShippingJson.Add('MiddleName', 'string');
        ShippingJson.Add('ZipCode', 'string');
        ShippingJson.Add('City', 'string');
        ShippingJson.Add('Country', 'US');
        ShippingJson.Add('Business', 'string');
        ShippingJson.Add('AddressLine1', 'string');
        ShippingJson.Add('AddressLine2', 'string');
        ShippingJson.Add('Fax', 'string');
        ShippingJson.Add('Region', 'string');
        ShippingJson.Add('State', 'string');
        ShippingJson.Add('Phone', 'string');
        exit(ShippingJson);
    end;
}
