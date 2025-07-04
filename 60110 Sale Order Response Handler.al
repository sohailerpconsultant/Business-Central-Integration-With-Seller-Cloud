codeunit 60110 "SaleOrder Response Handler"
{
    trigger OnRun()
    begin

    end;

    procedure StoreSalesOrders(Response: Text)
    var
        So_Header: Record "SO Middleware Header";
        SO_Lines: Record "SO Middleware Lines";

        JSONManagement: Codeunit "JSON Management";
        ObjectJSONManagement: Codeunit "JSON Management";
        ArrayJSONManagement: Codeunit "JSON Management";

        SaleJsonObject: Text;
        Items: Text;
        ItemsJsonObject: Text;
        OrderDetailsJsonObject: Text;
        StatusesJsonObject: Text;
        i: Integer;
        PurchaseOrderID: text;
        LineNo: Text;
        ProductID: Text;
        ProductName: Text;
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
    begin
        Clear(SO_ID);

        JSONManagement.InitializeObject(Response);
        JSONManagement.GetArrayPropertyValueAsStringByName('OrderID', SO_ID);
        So_Header.SetRange("SO ID", SO_ID);
        if So_Header.FindFirst() then begin
            if JSONManagement.GetArrayPropertyValueAsStringByName('OrderDetails', OrderDetailsJsonObject) then begin
                ObjectJSONManagement.InitializeObject(OrderDetailsJsonObject);
                ObjectJSONManagement.GetStringPropertyValueByName('CustomerID', Cust_ID);
                Evaluate(So_Header."Customer ID", Cust_ID);
            end;
            if JSONManagement.GetArrayPropertyValueAsStringByName('Statuses', StatusesJsonObject) then begin
                ObjectJSONManagement.InitializeObject(StatusesJsonObject);
                ObjectJSONManagement.GetStringPropertyValueByName('OrderStatus', OrderStatus);
                Evaluate(OrderstatusID, OrderStatus);
                if OrderstatusID = 3 then//status completed 
                    So_Header."Order Status" := 'Completed';
                ObjectJSONManagement.GetStringPropertyValueByName('ShippingStatus', ShippingStatus);
                Evaluate(ShippingStatusID, ShippingStatus);
                if ShippingStatusID = 3 then
                    So_Header."Shipping Status" := 'Shipped';
                ObjectJSONManagement.GetStringPropertyValueByName('PaymentStatus', PaymentStatus);
                Evaluate(PaymentStatusID, PaymentStatus);
                if PaymentStatusID = 30 then
                    So_Header."Payment Status" := 'PAID';

            end;
            So_Header.Modify();
            SO_Lines.SetRange("SO ID", SO_ID);
            if SO_Lines.FindSet() then
                SO_Lines.DeleteAll();
            if JSONManagement.GetArrayPropertyValueAsStringByName('OrderItems', ItemsJsonObject) then begin
                ArrayJSONManagement.InitializeCollection(ItemsJsonObject);
                _NextLineNo := 10000;
                for i := 0 to ArrayJSONManagement.GetCollectionCount() - 1 do begin
                    ArrayJSONManagement.GetObjectFromCollectionByIndex(ItemsJsonObject, i);
                    ObjectJSONManagement.InitializeObject(ItemsJsonObject);

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
                    ObjectJSONManagement.GetStringPropertyValueByName('DiscountValue', DiscountValue);
                    Evaluate(SO_Lines."Line Discount", DiscountValue);
                    ObjectJSONManagement.GetStringPropertyValueByName('LineTotal', LineTotal);
                    Evaluate(SO_Lines."Line Total", LineTotal);
                    SO_Lines.Insert();
                    _NextLineNo += 10000;
                end;
            end;

        end
        else begin
            So_Header."SO ID" := SO_ID;
            if JSONManagement.GetArrayPropertyValueAsStringByName('OrderDetails', OrderDetailsJsonObject) then begin
                ObjectJSONManagement.InitializeObject(OrderDetailsJsonObject);
                ObjectJSONManagement.GetStringPropertyValueByName('CustomerID', Cust_ID);
                Evaluate(So_Header."Customer ID", Cust_ID);
            end;
            if JSONManagement.GetArrayPropertyValueAsStringByName('Statuses', StatusesJsonObject) then begin
                ObjectJSONManagement.InitializeObject(StatusesJsonObject);
                ObjectJSONManagement.GetStringPropertyValueByName('OrderStatus', OrderStatus);
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

            end;
            So_Header.Insert();
            SO_Lines.SetRange("SO ID", SO_ID);
            if SO_Lines.FindSet() then
                SO_Lines.DeleteAll();
            if JSONManagement.GetArrayPropertyValueAsStringByName('OrderItems', ItemsJsonObject) then begin
                ArrayJSONManagement.InitializeCollection(ItemsJsonObject);
                _NextLineNo := 10000;
                for i := 0 to ArrayJSONManagement.GetCollectionCount() - 1 do begin
                    ArrayJSONManagement.GetObjectFromCollectionByIndex(ItemsJsonObject, i);
                    ObjectJSONManagement.InitializeObject(ItemsJsonObject);

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
                    ObjectJSONManagement.GetStringPropertyValueByName('DiscountValue', DiscountValue);
                    Evaluate(SO_Lines."Line Discount", DiscountValue);
                    ObjectJSONManagement.GetStringPropertyValueByName('LineTotal', LineTotal);
                    Evaluate(SO_Lines."Line Total", LineTotal);
                    SO_Lines.Insert();
                    _NextLineNo += 10000;
                end;
            end;
        end;


    end;

    var
        myInt: Integer;
}