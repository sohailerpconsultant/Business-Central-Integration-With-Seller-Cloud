codeunit 60106 "PO Response Handler"
{
    trigger OnRun()
    begin

    end;

    procedure PO_ResponseHandler(Response: Text)
    var
        PO_Header: Record "PO Middleware Header";
        PO_Lines: Record "PO Middleware Lines";

        JSONManagement: Codeunit "JSON Management";
        ObjectJSONManagement: Codeunit "JSON Management";
        ArrayJSONManagement: Codeunit "JSON Management";

        _PurchaseJsonObject: Text;
        _Items: Text;
        ItemsJsonObject: Text;
        i: Integer;
        PurchaseOrderID: text;
        LineNo: Text;
        ProductID: Text;
        ProductName: Text;
        QtyOrdered: Text;
        QtyOnHand: Text;
        UnitPrice: Text;
        AdjustedPrice: Text;
        Total: Text;
        Discount: Text;
    begin
        JSONManagement.InitializeObject(Response);
        if JSONManagement.GetArrayPropertyValueAsStringByName('Purchase', _PurchaseJsonObject) then begin
            ObjectJSONManagement.InitializeObject(_PurchaseJsonObject);
            ObjectJSONManagement.GetStringPropertyValueByName('POId', PurchaseOrderID);
            PO_Header.SetRange("PO ID", PurchaseOrderID);
            if PO_Header.FindFirst() then begin
                Evaluate(PO_Header."PO ID", PurchaseOrderID);
                ObjectJSONManagement.GetStringPropertyValueByName('Description', PO_Header.Description);

                PO_Header.Modify();

                PO_Lines.SetRange("PO ID", PurchaseOrderID);
                if PO_Lines.FindSet() then
                    PO_Lines.DeleteAll();
                if JSONManagement.GetArrayPropertyValueAsStringByName('Items', _Items) then begin
                    ArrayJSONManagement.InitializeCollection(_Items);
                    for i := 0 to ArrayJSONManagement.GetCollectionCount() - 1 do begin
                        ArrayJSONManagement.GetObjectFromCollectionByIndex(ItemsJsonObject, i);
                        ObjectJSONManagement.InitializeObject(ItemsJsonObject);

                        ObjectJSONManagement.GetStringPropertyValueByName('ID', LineNo);
                        Evaluate(PO_Lines."Line No", LineNo);
                        Evaluate(PO_Lines."PO ID", PurchaseOrderID);
                        ObjectJSONManagement.GetStringPropertyValueByName('ProductID', ProductID);
                        Evaluate(PO_Lines."Product ID", ProductID);
                        ObjectJSONManagement.GetStringPropertyValueByName('ProductName', PO_Lines.Description);
                        ObjectJSONManagement.GetStringPropertyValueByName('QtyOrdered', QtyOrdered);
                        Evaluate(PO_Lines."Quantity Order", QtyOrdered);
                        ObjectJSONManagement.GetStringPropertyValueByName('QtyOnHand', QtyOnHand);
                        Evaluate(PO_Lines."QTY On Hand", QtyOnHand);
                        ObjectJSONManagement.GetStringPropertyValueByName('UnitPrice', UnitPrice);
                        Evaluate(PO_Lines."Actual Unit Cost", UnitPrice);
                        ObjectJSONManagement.GetStringPropertyValueByName('DiscountValue', Discount);
                        Evaluate(PO_Lines.Discount, Discount);
                        ObjectJSONManagement.GetStringPropertyValueByName('AdjustedPrice', AdjustedPrice);
                        Evaluate(PO_Lines."Unit Cost(After Discount)", AdjustedPrice);
                        ObjectJSONManagement.GetStringPropertyValueByName('Total', Total);
                        Evaluate(PO_Lines."Line Total", Total);


                        PO_Lines.Insert();

                    end;
                end;
            end
            else begin
                Evaluate(PO_Header."PO ID", PurchaseOrderID);
                ObjectJSONManagement.GetStringPropertyValueByName('Description', PO_Header.Description);

                PO_Header.Insert();

                if JSONManagement.GetArrayPropertyValueAsStringByName('Items', _Items) then begin
                    ArrayJSONManagement.InitializeCollection(_Items);
                    for i := 0 to ArrayJSONManagement.GetCollectionCount() - 1 do begin
                        ArrayJSONManagement.GetObjectFromCollectionByIndex(ItemsJsonObject, i);
                        ObjectJSONManagement.InitializeObject(ItemsJsonObject);

                        ObjectJSONManagement.GetStringPropertyValueByName('ID', LineNo);
                        Evaluate(PO_Lines."Line No", LineNo);
                        Evaluate(PO_Lines."PO ID", PurchaseOrderID);
                        ObjectJSONManagement.GetStringPropertyValueByName('ProductID', ProductID);
                        Evaluate(PO_Lines."Product ID", ProductID);
                        ObjectJSONManagement.GetStringPropertyValueByName('ProductName', PO_Lines.Description);
                        ObjectJSONManagement.GetStringPropertyValueByName('QtyOrdered', QtyOrdered);
                        Evaluate(PO_Lines."Quantity Order", QtyOrdered);
                        Evaluate(PO_Lines."Quantity Order", QtyOrdered);
                        ObjectJSONManagement.GetStringPropertyValueByName('QtyOnHand', QtyOnHand);
                        Evaluate(PO_Lines."QTY On Hand", QtyOnHand);
                        ObjectJSONManagement.GetStringPropertyValueByName('UnitPrice', UnitPrice);
                        Evaluate(PO_Lines."Actual Unit Cost", UnitPrice);
                        ObjectJSONManagement.GetStringPropertyValueByName('DiscountValue', Discount);
                        Evaluate(PO_Lines.Discount, Discount);
                        ObjectJSONManagement.GetStringPropertyValueByName('AdjustedPrice', AdjustedPrice);
                        Evaluate(PO_Lines."Unit Cost(After Discount)", AdjustedPrice);
                        ObjectJSONManagement.GetStringPropertyValueByName('Total', Total);
                        Evaluate(PO_Lines."Line Total", Total);

                        PO_Lines.Insert();

                    end;
                end;
            end;

        end;

    end;

    var
        myInt: Integer;
        v: Page "Customer Card";
}