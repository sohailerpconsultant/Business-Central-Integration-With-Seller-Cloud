page 60102 "Seller Cloud Items"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Inventory Middleware";
    CardPageId = 60103;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field(" Vendor No"; Rec." Vendor No")
                {
                    ApplicationArea = all;
                }
                field("Available Inventory"; Rec."Available Inventory")
                {
                    ApplicationArea = all;
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    ApplicationArea = all;
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    ApplicationArea = all;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = all;
                }
                field("Item Reference"; Rec."Item Reference")
                {
                    ApplicationArea = all;
                }
                field("Seller Cloud Item ID"; Rec."Seller Cloud Item ID")
                {
                    ApplicationArea = all;
                }
                field("Shelf No."; Rec."Shelf No.")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action("Update Master Inventory")
            {
                Caption = 'Update Master Inventory';
                trigger OnAction()
                var
                    MiddleWareRec: Record "Inventory Middleware";
                    UpdateMasterItems: Codeunit "Update Master Inventory";
                    tbl_SCSetup: record "Seller Cloud Setup";
                begin
                    CurrPage.SetSelectionFilter(MiddleWareRec);
                    if tbl_SCSetup.FindFirst() then
                        UpdateMasterItems.UpdateInventory(MiddleWareRec, tbl_SCSetup);
                    Message('Item Master Updated');
                end;
            }
        }
    }
}