page 60107 "Sale Orders Middleware"
{
    ApplicationArea = All;
    Caption = 'Sale Orders';
    PageType = List;
    SourceTable = "SO Middleware Header";
    UsageCategory = Administration;
    CardPageId = "Sale Order Header";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("SO ID"; Rec."SO ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PO ID field.', Comment = '%';
                }
                field("Customer ID"; Rec."Customer ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor ID field.', Comment = '%';
                }
                field("Total Paid"; Rec."Total Paid")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Paid field.', Comment = '%';
                }
                field(IsProceeded; Rec.IsProceeded)
                {
                    ApplicationArea = All;
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
                    MiddleWareRec: Record "SO Middleware Header";
                    UpdateInventory: Codeunit "Inventory Adjustment SC";
                begin
                    CurrPage.SetSelectionFilter(MiddleWareRec);
                    UpdateInventory.UpdateSOInventory(MiddleWareRec);
                    Message('Negative Adjustment Created');

                end;
            }
        }
    }
}
