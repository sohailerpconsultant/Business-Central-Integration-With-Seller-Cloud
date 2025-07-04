page 60104 "Purchase Orders Middleware"
{
    ApplicationArea = All;
    Caption = 'Purchase Orders';
    PageType = List;
    SourceTable = "PO Middleware Header";
    UsageCategory = Administration;
    CardPageId = "Purchase Order Header";
    DeleteAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("PO ID"; Rec."PO ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PO ID field.', Comment = '%';
                }

                field("Vendor ID"; Rec."Vendor ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor ID field.', Comment = '%';
                }
                field("Total Paid"; Rec."Total Paid")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Paid field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Item Inventory Adjustment")
            {
                Caption = 'Item Inventory Adjustment';
                trigger OnAction()
                var
                    MiddleWareRec: Record "PO Middleware Header";
                    UpdateInventory: Codeunit "Inventory Adjustment SC";
                begin
                    CurrPage.SetSelectionFilter(MiddleWareRec);
                    UpdateInventory.UpdateInventory(MiddleWareRec);
                    Message('Adjustment Created');

                end;
            }
        }
    }
}
