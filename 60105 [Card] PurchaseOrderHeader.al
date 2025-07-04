page 60105 "Purchase Order Header"
{
    Caption = 'Purchase Order Header';
    PageType = Card;
    SourceTable = "PO Middleware Header";
    DeleteAllowed = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("PO ID"; Rec."PO ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PO ID field.', Comment = '%';
                }
                field("Total Paid"; Rec."Total Paid")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Paid field.', Comment = '%';
                }
                field("Vendor ID"; Rec."Vendor ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor ID field.', Comment = '%';
                }
            }
            part(PoLines; "Po Lines Middleware")
            {
                SubPageLink = "PO ID" = field("PO ID");
                UpdatePropagation = Both;
                ApplicationArea = all;
            }
        }
    }
    var
        v: Page "Sales Order";
}
