codeunit 60107 "Update Master Inventory"
{

    trigger OnRun()
    begin

    end;

    procedure UpdateInventory(var MiddleWareItem: Record "Inventory Middleware"; tbl_SCSetup: record "Seller Cloud Setup")
    var
        NoSeriesMgmt: Codeunit "No. Series";
        lRecItem: Record Item;
        InventorySetup: Record "Inventory Setup";

    begin
        lRecItem.Reset();
        if MiddleWareItem.FindSet() then begin
            repeat
                lRecItem.SetRange("SC Product ID", MiddleWareItem."Item No.");
                if lRecItem.FindFirst() then begin
                    lRecItem.Description := MiddleWareItem.Description;
                    lRecItem."SC Product ID" := MiddleWareItem."Item No.";
                    lRecItem."Gross Weight" := MiddleWareItem."Gross Weight";
                    lRecItem."Net Weight" := MiddleWareItem."Net Weight";
                    lRecItem."Shelf No." := Format(MiddleWareItem."Shelf No.", 10);
                    lRecItem.Modify(true);
                end
                else begin
                    lRecItem.Init();
                    if CreateItemFromTemplate(lRecItem, true, tbl_SCSetup."Itme Template") = true then begin
                        lRecItem.Validate(Description, MiddleWareItem.Description);
                        lRecItem.Validate("SC Product ID", MiddleWareItem."Item No.");
                        lRecItem.Validate("Gross Weight", MiddleWareItem."Gross Weight");
                        lRecItem.Validate("Net Weight", MiddleWareItem."Net Weight");
                        lRecItem.Validate("Shelf No.", Format(MiddleWareItem."Shelf No.", 10));
                        lRecItem.Modify(true);
                    end;
                end;

            until MiddleWareItem.Next() = 0
        end;

    end;

    procedure CreateItemFromTemplate(var Item: Record Item; IsHandled: Boolean; ItemTemplCode: Code[20]) Result: Boolean
    var
        ItemTempl: Record "Item Templ.";
        InventorySetup: Record "Inventory Setup";
    begin
        IsHandled := false;

        if IsHandled then
            exit(Result);
        IsHandled := true;
        if ItemTemplCode = 'ITEM' then begin
            ItemTempl.Get(ItemTemplCode);
            Item.Init();
            InitItemNo(Item, ItemTempl);
            InventorySetup.SetLoadFields("Default Costing Method");
            InventorySetup.Get();
            Item."Costing Method" := InventorySetup."Default Costing Method";
            Item.Insert(true);
            Cu_ItemTemplateMgt.ApplyItemTemplate(Item, ItemTempl, true);
            exit(true);
        end;
    END;

    local procedure InitItemNo(var Item: Record Item; ItemTempl: Record "Item Templ.")
    var
        NoSeries: Codeunit "No. Series";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        if IsHandled then
            exit;

        if ItemTempl."No. Series" = '' then
            exit;

        Item."No. Series" := ItemTempl."No. Series";
        if Item."No." <> '' then begin
            NoSeries.TestManual(Item."No. Series");
            exit;
        end;

        NoSeries.TestAutomatic(Item."No. Series");
        Item."No." := NoSeries.GetNextNo(Item."No. Series");
    end;

    var
        Cu_ItemTemplateMgt: Codeunit "Item Templ. Mgt.";

}