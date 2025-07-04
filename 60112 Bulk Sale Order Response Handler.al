codeunit 60112 "Bulk SO Response Handler"
{
    trigger OnRun()
    begin

    end;

    procedure StoreSaleOrders(Response: Text)
    begin
        Clear(SO_ID);
        Clear(ItemsJsonObject);
        Clear(_Items);
        Clear(ItemsLinesJsonObject);
        Clear(i);
        Clear(j);

        JSONManagement.InitializeObject(Response);
        if JSONManagement.GetArrayPropertyValueAsStringByName('Items', _Items) then begin
            ArrayJSONManagement.InitializeCollection(_Items);
            for i := 0 to ArrayJSONManagement.GetCollectionCount() - 1 do begin
                ArrayJSONManagement.GetObjectFromCollectionByIndex(ItemsJsonObject, i);
                ObjectJSONManagement.InitializeObject(ItemsJsonObject);

                ObjectJSONManagement.GetStringPropertyValueByName('ID', SO_ID);
                So_Header.SetRange("SO ID", SO_ID);
                if So_Header.FindFirst() then begin
                    ObjectJSONManagement.GetStringPropertyValueByName('FirstName', So_Header."Customer Name");
                    ObjectJSONManagement.GetStringPropertyValueByName('UserID', "Customer ID");
                    Evaluate(So_Header."Customer ID", "Customer ID");
                    ObjectJSONManagement.GetStringPropertyValueByName('StatusCode', OrderStatus);
                    Evaluate(OrderstatusID, OrderStatus);
                    if OrderstatusID = 3 then
                        So_Header."Order Status" := 'Completed';
                    ObjectJSONManagement.GetStringPropertyValueByName('ShippingStatus', ShippingStatus);
                    Evaluate(ShippingStatusID, ShippingStatus);
                    if ShippingStatusID = 3 then
                        So_Header."Shipping Status" := 'Shipped';
                    ObjectJSONManagement.GetStringPropertyValueByName('PaymentStatus', PaymentStatus);
                    Evaluate(PaymentStatusID, PaymentStatus);
                    if PaymentStatusID = 30 then
                        So_Header."Payment Status" := 'PAID';

                    So_Header.Modify(true);
                    SO_Lines.SetRange("SO ID", SO_ID);
                    if SO_Lines.FindSet() then
                        SO_Lines.DeleteAll();
                    if ObjectJSONManagement.GetArrayPropertyValueAsStringByName('Items', ItemsLinesJsonObject) then begin
                        ArrayJSONManagement2.InitializeCollection(ItemsLinesJsonObject);
                        _NextLineNo := 10000;
                        for j := 0 to ArrayJSONManagement2.GetCollectionCount() - 1 do begin
                            ArrayJSONManagement2.GetObjectFromCollectionByIndex(ItemsLinesJsonObject, j);
                            ObjectJSONManagement.InitializeObject(ItemsLinesJsonObject);

                            SO_Lines.Init();
                            SO_Lines."SO ID" := SO_ID;
                            SO_Lines."Line No" := _NextLineNo;
                            ObjectJSONManagement.GetStringPropertyValueByName('ProductID', ProductID);
                            Evaluate(SO_Lines."Product ID", ProductID);
                            ObjectJSONManagement.GetStringPropertyValueByName('DisplayName', SO_Lines.Description);
                            ObjectJSONManagement.GetStringPropertyValueByName('Qty', QTY);
                            Evaluate(SO_Lines.Quantity, QTY);
                            ObjectJSONManagement.GetStringPropertyValueByName('SitePrice', SitePrice);
                            Evaluate(SO_Lines."Unit Cost", SitePrice);
                            ObjectJSONManagement.GetStringPropertyValueByName('DiscountAmount', DiscountValue);
                            Evaluate(SO_Lines."Line Discount", DiscountValue);
                            ObjectJSONManagement.GetStringPropertyValueByName('LineTotal', LineTotal);
                            Evaluate(SO_Lines."Line Total", LineTotal);

                            SO_Lines.Insert(true);
                            _NextLineNo += 10000;
                        end;
                    end;

                end
                else begin
                    Clear(j);
                    Clear(ItemsLinesJsonObject);
                    Clear("Customer ID");


                    So_Header."SO ID" := SO_ID;
                    ObjectJSONManagement.GetStringPropertyValueByName('FirstName', So_Header."Customer Name");
                    ObjectJSONManagement.GetStringPropertyValueByName('UserID', "Customer ID");
                    Evaluate(So_Header."Customer ID", "Customer ID");
                    ObjectJSONManagement.GetStringPropertyValueByName('StatusCode', OrderStatus);
                    Evaluate(OrderstatusID, OrderStatus);
                    if OrderstatusID = 3 then
                        So_Header."Order Status" := 'Completed';
                    ObjectJSONManagement.GetStringPropertyValueByName('ShippingStatus', ShippingStatus);
                    Evaluate(ShippingStatusID, ShippingStatus);
                    if ShippingStatusID = 3 then
                        So_Header."Shipping Status" := 'Shipped';
                    ObjectJSONManagement.GetStringPropertyValueByName('PaymentStatus', PaymentStatus);
                    Evaluate(PaymentStatusID, PaymentStatus);
                    if PaymentStatusID = 30 then
                        So_Header."Payment Status" := 'PAID';

                    So_Header.Insert(true);
                    SO_Lines.SetRange("SO ID", SO_ID);
                    if SO_Lines.FindSet() then
                        SO_Lines.DeleteAll();
                    if ObjectJSONManagement.GetArrayPropertyValueAsStringByName('Items', ItemsLinesJsonObject) then begin
                        ArrayJSONManagement2.InitializeCollection(ItemsLinesJsonObject);
                        _NextLineNo := 10000;
                        for j := 0 to ArrayJSONManagement2.GetCollectionCount() - 1 do begin
                            ArrayJSONManagement2.GetObjectFromCollectionByIndex(ItemsLinesJsonObject, j);
                            ObjectJSONManagement.InitializeObject(ItemsLinesJsonObject);

                            SO_Lines.Init();
                            SO_Lines."SO ID" := SO_ID;
                            SO_Lines."Line No" := _NextLineNo;
                            ObjectJSONManagement.GetStringPropertyValueByName('ProductID', ProductID);
                            Evaluate(SO_Lines."Product ID", ProductID);
                            ObjectJSONManagement.GetStringPropertyValueByName('DisplayName', SO_Lines.Description);
                            ObjectJSONManagement.GetStringPropertyValueByName('Qty', QTY);
                            Evaluate(SO_Lines.Quantity, QTY);
                            ObjectJSONManagement.GetStringPropertyValueByName('SitePrice', SitePrice);
                            Evaluate(SO_Lines."Unit Cost", SitePrice);
                            ObjectJSONManagement.GetStringPropertyValueByName('DiscountAmount', DiscountValue);
                            Evaluate(SO_Lines."Line Discount", DiscountValue);
                            ObjectJSONManagement.GetStringPropertyValueByName('LineTotal', LineTotal);
                            Evaluate(SO_Lines."Line Total", LineTotal);
                            SO_Lines.Insert(true);
                            _NextLineNo += 10000;
                        end;
                    end;

                end;
            end;
        end;

    end;


    var
        So_Header: Record "SO Middleware Header";
        SO_Lines: Record "SO Middleware Lines";

        JSONManagement: Codeunit "JSON Management";
        ObjectJSONManagement: Codeunit "JSON Management";
        ArrayJSONManagement: Codeunit "JSON Management";

        ArrayJSONManagement2: Codeunit "JSON Management";


        _Items: Text;
        ItemsJsonObject: Text;
        ItemsLinesJsonObject: text;
        SaleJsonObject: Text;
        OrderDetailsJsonObject: Text;
        StatusesJsonObject: Text;
        i: Integer;
        j: Integer;

        SO_ID: Text;
        Cust_ID: Text;
        OrderStatus: Text;
        OrderstatusID: Integer;
        ShippingStatus: text;
        ShippingStatusID: Integer;
        PaymentStatus: Text;
        PaymentStatusID: Integer;
        _NextLineNo: Integer;
        QTY: text;
        SitePrice: Text;
        DiscountValue: Text;
        LineTotal: Text;
        ProductID: text;
        "Customer ID": Text;
}