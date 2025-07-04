codeunit 60120 "Post SO to Seller Cloud"
{
    trigger OnRun()
    begin

    end;

    procedure Post(SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        tbl_SalesRecSetuo: Record "Sales & Receivables Setup";
        JsonObject: JsonObject;
        JsonArray: JsonArray;
        SalesLine: Record "Sales Invoice Line";
        HttpClient: HttpClient;
        HttpContent: HttpContent;
        HttpResponseMsg: HttpResponseMessage;
        HttpRequestMessage: HttpRequestMessage;
        HttpHeadersContent: HttpHeaders;


        LineJsonObject: JsonObject;
        AuthString: Text;
        SellerCloudSetup: Record "Seller Cloud Setup"; // Assume you have a setup table for API configurations
        _URL: Text;
        IsSuccessfull: Boolean;
        JsonText: Text;
        response: Text;
    begin
        //Step 2:  for test purpose hardcode

        _URL := 'https://piccolino-trial.api.sellercloud.us/rest/api/Orders';


        // Step 3: Construct JSON Header
        JsonObject.Add('ID', 1012);
        JsonObject.Add('CustomerDetails', CreateCustomerJson(SalesInvoiceHeader));
        JsonObject.Add('OrderDetails', CreateOrderDetailsJson(SalesInvoiceHeader));


        // Step 4: Construct JSON Lines

        // SalesLine.SetRange("Document Type", SalesInvoiceHeader.);
        SalesLine.SetRange("Document No.", SalesInvoiceHeader."No.");
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        if SalesLine.FindSet() then begin
            repeat
                LineJsonObject.Add('ProductID', 'BATBOL');
                LineJsonObject.Add('ProductName', 'BAT BOL');
                LineJsonObject.Add('SitePrice', 100);
                LineJsonObject.Add('Qty', 10);
                LineJsonObject.Add('LineTaxTotal', 0);
                JsonArray.Add(LineJsonObject); // Add line object to the JSON array
            until SalesLine.Next() = 0;
        end;
        JsonObject.Add('Products', JsonArray);


        // Step 5: Add Additional Details (e.g., shipping method, gift wrap, notes, etc.)
        JsonObject.Add('ShippingAddress', CreateAddressJson(SalesInvoiceHeader));
        //   JsonObject.Add('ShippingMethodDetails', CreateShippingMethodDetailsJson(SalesInvoiceHeader));

        // Step 6: Convert JSON Object to Text
        JsonObject.WriteTo(JsonText);
        HttpContent.WriteFrom(JsonText);


        SellerCloudSetup.FindFirst();

        AuthString := SellerCloudSetup."Bearer Token";

        AuthString := StrSubstNo('Bearer %1', AuthString);
        // Step 7: Send POST request
        HttpRequestMessage.Method('POST');
        HttpRequestMessage.SetRequestUri(_URL);

        HttpContent.GetHeaders(HttpHeadersContent);
        HttpClient.DefaultRequestHeaders.Add('Authorization', AuthString);


        HttpContent.GetHeaders(HttpHeadersContent);
        HttpHeadersContent.Clear();
        HttpHeadersContent.Add('Content-Type', 'application/json');
        HttpRequestMessage.Content := HttpContent;
        HttpClient.Post(_URL, HttpContent, HttpResponseMsg);
        HttpResponseMsg.Content.ReadAs(response);
        if (HttpResponseMsg.IsSuccessStatusCode) then begin
            HttpResponseMsg.Content.ReadAs(response);
        end;

    end;


    local procedure CreateCustomerJson(SalesInvoiceHeader: Record "Sales Invoice Header"): JsonObject
    var
        CustomerJson: JsonObject;
    begin
        CustomerJson.Add('ID', 75498);
        CustomerJson.Add('Email', 'adilusman78@gmail.com');
        CustomerJson.Add('FirstName', 'Adil');
        CustomerJson.Add('LastName', 'Usman'); // Placeholder, adjust as needed
        CustomerJson.Add('Business', SalesInvoiceHeader."Sell-to Customer Name");
        CustomerJson.Add('IsWholesale', true); // Example static value
        CustomerJson.Add('IgnoreCreditLimit', true); // Example static value
        exit(CustomerJson);
    end;

    local procedure CreateOrderDetailsJson(SalesInvoiceHeader: Record "Sales Invoice Header"): JsonObject
    var
        OrderDetailsJson: JsonObject;
    begin
        OrderDetailsJson.Add('CompanyID', 164); // Example static value
        OrderDetailsJson.Add('OrderDate', Format(SalesInvoiceHeader."Order Date", 0, 9)); // Convert to ISO 8601 format
        OrderDetailsJson.Add('IsSampleOrder', false); // Example static value
        OrderDetailsJson.Add('GiftOrder', false); // Example static value
        OrderDetailsJson.Add('OrderSourceOrderID', 01010101);
        exit(OrderDetailsJson);
    end;

    local procedure CreateShippingMethodDetailsJson(SalesInvoiceHeader: Record "Sales Invoice Header"): JsonObject
    var
        ShippingJson: JsonObject;
    begin
        ShippingJson.Add('Carrier', SalesInvoiceHeader."Shipment Method Code");
        ShippingJson.Add('PromiseDate', Format(SalesInvoiceHeader."Shipment Date", 0, 9)); // Convert to ISO 8601 format
        exit(ShippingJson);
    end;

    local procedure CreateAddressJson(SalesInvoiceHeader: Record "Sales Invoice Header"): JsonObject
    var
        AddressJson: JsonObject;
    begin

        AddressJson.Add('Business', SalesInvoiceHeader."Ship-to Name");
        AddressJson.Add('FirstName', SalesInvoiceHeader."Ship-to Contact");
        AddressJson.Add('Country', SalesInvoiceHeader."Ship-to Country/Region Code");
        AddressJson.Add('City', SalesInvoiceHeader."Ship-to City");
        AddressJson.Add('State', SalesInvoiceHeader."Ship-to County");
        AddressJson.Add('ZipCode', SalesInvoiceHeader."Ship-to Post Code");
        AddressJson.Add('Address', SalesInvoiceHeader."Ship-to Address");


        exit(AddressJson);
    end;



    var
        myInt: Integer;
}