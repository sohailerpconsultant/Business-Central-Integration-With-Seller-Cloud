page 60108 "Sale Order Header"
{
    Caption = 'Sale Order Header';
    PageType = Card;
    SourceTable = "SO Middleware Header";
    DeleteAllowed = true;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("SO ID"; Rec."SO ID")
                {
                    ApplicationArea = All;
                    Caption = 'Order ID';
                    ToolTip = 'Specifies the value of the PO ID field.', Comment = '%';
                }

                field("Customer ID"; Rec."Customer ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor ID field.', Comment = '%';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = all;
                }
                field("Order Status"; Rec."Order Status")
                {
                    ApplicationArea = all;
                }
                field("Shipping Status"; Rec."Shipping Status")
                {
                    ApplicationArea = all;
                }

                field("Total Paid"; Rec."Total Paid")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Paid field.', Comment = '%';
                }
                field("Payment Status"; Rec."Payment Status")
                {
                    ApplicationArea = all;
                }

            }
            part(SoLines; "So Lines Middleware")
            {
                SubPageLink = "SO ID" = field("SO ID");
                UpdatePropagation = Both;
                ApplicationArea = all;
            }
        }
    }
    var
        v: Page "Sales Order";
}
