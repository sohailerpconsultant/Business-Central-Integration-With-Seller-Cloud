codeunit 60104 "Inventory Response Handler"
{
    trigger OnRun()
    begin

    end;

    procedure StoreInventory(Response: Text)
    var
        lRecInventory: Record "Inventory Middleware";

        JSONManagement: Codeunit "JSON Management";
        ObjectJSONManagement: Codeunit "JSON Management";
        ArrayJSONManagement: Codeunit "JSON Management";
        MiddlewareInventoryRec: Record "Inventory Middleware";

        _Items: Text;
        ItemsJsonObject: Text;
        i: Integer;
        ItemCode: Text;
        Weight: Text;
        ShippingWeight: Text;
        LocationNotes: Text;
        ProductType: Text;
        DefaultVendor: Text;
        SitePrice: Text;
        SiteCost: Text;
        TotalResults: Text;
        Reqstloopcounter: Integer;
        AggregatedQty: Text;

    begin
        Clear(i);
        Clear(_Items);

        JSONManagement.InitializeObject(Response);
        JSONManagement.GetArrayPropertyValueAsStringByName('TotalResults', TotalResults);
        if JSONManagement.GetArrayPropertyValueAsStringByName('Items', _Items) then begin
            ArrayJSONManagement.InitializeCollection(_Items);
            for i := 0 to ArrayJSONManagement.GetCollectionCount() - 1 do begin
                ArrayJSONManagement.GetObjectFromCollectionByIndex(ItemsJsonObject, i);
                ObjectJSONManagement.InitializeObject(ItemsJsonObject);

                ObjectJSONManagement.GetStringPropertyValueByName('ID', ItemCode);
                MiddlewareInventoryRec.SetRange("Item No.", ItemCode);
                if MiddlewareInventoryRec.FindFirst() then begin
                    ObjectJSONManagement.GetStringPropertyValueByName('ImageUrl', lRecInventory."Picture URL");
                    Evaluate(lRecInventory."Item No.", ItemCode);
                    Evaluate(lRecInventory."Seller Cloud Item ID", ItemCode);
                    ObjectJSONManagement.GetStringPropertyValueByName('Weight', Weight);
                    Evaluate(lRecInventory."Net Weight", Weight);
                    ObjectJSONManagement.GetStringPropertyValueByName('ShippingWeight', ShippingWeight);
                    Evaluate(lRecInventory."Gross Weight", ShippingWeight);
                    ObjectJSONManagement.GetStringPropertyValueByName('LocationNotes', LocationNotes);
                    Evaluate(lRecInventory."Shelf No.", LocationNotes);
                    ObjectJSONManagement.GetStringPropertyValueByName('ProductName', lRecInventory.Description);
                    ObjectJSONManagement.GetStringPropertyValueByName('ProductType', ProductType);
                    Evaluate(lRecInventory."Item Category Code", ProductType);
                    ObjectJSONManagement.GetStringPropertyValueByName('DefaultVendor', DefaultVendor);
                    Evaluate(lRecInventory." Vendor No", DefaultVendor);
                    ObjectJSONManagement.GetStringPropertyValueByName('SitePrice', SitePrice);
                    Evaluate(lRecInventory."Unit Price", SitePrice);
                    ObjectJSONManagement.GetStringPropertyValueByName('SiteCost', SiteCost);
                    Evaluate(lRecInventory."Unit Cost", SiteCost);
                    ObjectJSONManagement.GetStringPropertyValueByName('AggregatedQty', AggregatedQty);
                    Evaluate(lRecInventory."Available Inventory", AggregatedQty);

                    lRecInventory.Modify();
                end
                else begin
                    ObjectJSONManagement.GetStringPropertyValueByName('ImageUrl', lRecInventory."Picture URL");
                    Evaluate(lRecInventory."Item No.", ItemCode);
                    Evaluate(lRecInventory."Seller Cloud Item ID", ItemCode);
                    ObjectJSONManagement.GetStringPropertyValueByName('Weight', Weight);
                    Evaluate(lRecInventory."Net Weight", Weight);
                    ObjectJSONManagement.GetStringPropertyValueByName('ShippingWeight', ShippingWeight);
                    Evaluate(lRecInventory."Gross Weight", ShippingWeight);
                    ObjectJSONManagement.GetStringPropertyValueByName('LocationNotes', LocationNotes);
                    Evaluate(lRecInventory."Shelf No.", LocationNotes);
                    ObjectJSONManagement.GetStringPropertyValueByName('ProductName', lRecInventory.Description);
                    ObjectJSONManagement.GetStringPropertyValueByName('ProductType', ProductType);
                    Evaluate(lRecInventory."Item Category Code", ProductType);
                    ObjectJSONManagement.GetStringPropertyValueByName('DefaultVendor', DefaultVendor);
                    Evaluate(lRecInventory." Vendor No", DefaultVendor);
                    ObjectJSONManagement.GetStringPropertyValueByName('SitePrice', SitePrice);
                    Evaluate(lRecInventory."Unit Price", SitePrice);
                    ObjectJSONManagement.GetStringPropertyValueByName('SiteCost', SiteCost);
                    Evaluate(lRecInventory."Unit Cost", SiteCost);
                    ObjectJSONManagement.GetStringPropertyValueByName('AggregatedQty', AggregatedQty);
                    Evaluate(lRecInventory."Available Inventory", AggregatedQty);

                    lRecInventory.Insert();
                end;
            end;
        end;

    end;

    var
        myInt: Integer;
}