codeunit 60114 "Bulk PO Response Handler"
{
    trigger OnRun()
    begin

    end;

    procedure StorePurchaseOrders(Response: Text)
    var

        Po_Header: Record "PO Middleware Header";
        PO_Lines: Record "PO Middleware Lines";

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

        PO_ID: Text;
        Cust_ID: Text;
        OrderStatus: Text;
        OrderstatusID: Integer;
        ReceivingStatus: text;
        ReceivingStatusID: Integer;
        PaymentStatus: Text;
        PaymentStatusID: Integer;
        _NextLineNo: Integer;
        QTY: text;
        QTYRecv: Text;
        UnitPrice: Text;
        DiscountValue: Text;
        LineTotal: Text;
        ProductID: text;
        "Vendor ID": Text;


    begin
        Clear(PO_ID);
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

                ObjectJSONManagement.GetStringPropertyValueByName('ID', PO_ID);
                Po_Header.SetRange("PO ID", PO_ID);
                if Po_Header.FindFirst() then begin
                    ObjectJSONManagement.GetStringPropertyValueByName('VendorID', "Vendor ID");
                    Evaluate(Po_Header."Vendor ID", "Vendor ID");
                    ObjectJSONManagement.GetStringPropertyValueByName('PurchaseOrderStatus', OrderStatus);
                    Evaluate(OrderstatusID, OrderStatus);
                    if OrderstatusID = 5 then
                        Po_Header."Order Status" := 'Completed';
                    ObjectJSONManagement.GetStringPropertyValueByName('ReceivingStatus', ReceivingStatus);
                    Evaluate(ReceivingStatusID, ReceivingStatus);
                    if ReceivingStatusID = 3 then
                        Po_Header."Receiving Status" := 'Received';
                    ObjectJSONManagement.GetStringPropertyValueByName('PaymentStatus', PaymentStatus);
                    Evaluate(PaymentStatusID, PaymentStatus);
                    if PaymentStatusID = 30 then
                        Po_Header."Payment Status" := 'PAID';

                    Po_Header.Modify(true);
                    PO_Lines.SetRange("PO ID", PO_ID);
                    if PO_Lines.FindSet() then
                        PO_Lines.DeleteAll();
                    if ObjectJSONManagement.GetArrayPropertyValueAsStringByName('Items', ItemsLinesJsonObject) then begin
                        ArrayJSONManagement2.InitializeCollection(ItemsLinesJsonObject);
                        _NextLineNo := 10000;
                        for j := 0 to ArrayJSONManagement2.GetCollectionCount() - 1 do begin
                            ArrayJSONManagement2.GetObjectFromCollectionByIndex(ItemsLinesJsonObject, j);
                            ObjectJSONManagement.InitializeObject(ItemsLinesJsonObject);

                            PO_Lines.Init();
                            PO_Lines."PO ID" := PO_ID;
                            PO_Lines."Line No" := _NextLineNo;
                            ObjectJSONManagement.GetStringPropertyValueByName('ID', ProductID);
                            Evaluate(PO_Lines."Product ID", ProductID);
                            ObjectJSONManagement.GetStringPropertyValueByName('DisplayName', PO_Lines.Description);
                            ObjectJSONManagement.GetStringPropertyValueByName('QtyOrdered', QTY);
                            Evaluate(PO_Lines."Quantity Order", QTY);
                            ObjectJSONManagement.GetStringPropertyValueByName('QtyReceived', QTYRecv);
                            Evaluate(PO_Lines."QTY On Hand", QTYRecv);
                            ObjectJSONManagement.GetStringPropertyValueByName('UnitPrice', UnitPrice);
                            Evaluate(PO_Lines."Actual Unit Cost", UnitPrice);
                            ObjectJSONManagement.GetStringPropertyValueByName('LineTotal', LineTotal);
                            Evaluate(PO_Lines."Line Total", LineTotal);

                            PO_Lines.Insert(true);
                            _NextLineNo += 10000;
                        end;
                    end;

                end
                else begin
                    Clear(j);
                    Clear(ItemsLinesJsonObject);
                    Clear("Vendor ID");


                    Po_Header."PO ID" := PO_ID;
                    ObjectJSONManagement.GetStringPropertyValueByName('VendorID', "Vendor ID");
                    Evaluate(Po_Header."Vendor ID", "Vendor ID");
                    ObjectJSONManagement.GetStringPropertyValueByName('PurchaseOrderStatus', OrderStatus);
                    Evaluate(OrderstatusID, OrderStatus);
                    if OrderstatusID = 5 then
                        Po_Header."Order Status" := 'Completed';
                    ObjectJSONManagement.GetStringPropertyValueByName('ReceivingStatus', ReceivingStatus);
                    Evaluate(ReceivingStatusID, ReceivingStatus);
                    if ReceivingStatusID = 3 then
                        Po_Header."Receiving Status" := 'Received';
                    ObjectJSONManagement.GetStringPropertyValueByName('PaymentStatus', PaymentStatus);
                    Evaluate(PaymentStatusID, PaymentStatus);
                    if PaymentStatusID = 30 then
                        Po_Header."Payment Status" := 'PAID';

                    Po_Header.Insert(true);
                    PO_Lines.SetRange("PO ID", PO_ID);
                    if PO_Lines.FindSet() then
                        PO_Lines.DeleteAll();
                    if ObjectJSONManagement.GetArrayPropertyValueAsStringByName('Items', ItemsLinesJsonObject) then begin
                        ArrayJSONManagement2.InitializeCollection(ItemsLinesJsonObject);
                        _NextLineNo := 10000;
                        for j := 0 to ArrayJSONManagement2.GetCollectionCount() - 1 do begin
                            ArrayJSONManagement2.GetObjectFromCollectionByIndex(ItemsLinesJsonObject, j);
                            ObjectJSONManagement.InitializeObject(ItemsLinesJsonObject);

                            PO_Lines.Init();
                            PO_Lines."PO ID" := PO_ID;
                            PO_Lines."Line No" := _NextLineNo;
                            ObjectJSONManagement.GetStringPropertyValueByName('ID', ProductID);
                            Evaluate(PO_Lines."Product ID", ProductID);
                            ObjectJSONManagement.GetStringPropertyValueByName('DisplayName', PO_Lines.Description);
                            ObjectJSONManagement.GetStringPropertyValueByName('QtyOrdered', QTY);
                            Evaluate(PO_Lines."Quantity Order", QTY);
                            ObjectJSONManagement.GetStringPropertyValueByName('QtyReceived', QTYRecv);
                            Evaluate(PO_Lines."QTY On Hand", QTYRecv);
                            ObjectJSONManagement.GetStringPropertyValueByName('UnitPrice', UnitPrice);
                            Evaluate(PO_Lines."Actual Unit Cost", UnitPrice);
                            ObjectJSONManagement.GetStringPropertyValueByName('LineTotal', LineTotal);
                            Evaluate(PO_Lines."Line Total", LineTotal);

                            PO_Lines.Insert(true);
                            _NextLineNo += 10000;
                        end;
                    end;

                end;
            end;
        end;

    end;


    var
        myInt: Integer;
}