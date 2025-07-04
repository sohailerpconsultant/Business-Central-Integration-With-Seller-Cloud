page 60109 "So Lines Middleware"
{
    Caption = 'So Lines Middleware';
    PageType = ListPart;
    SourceTable = "SO Middleware Lines";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No field.', Comment = '%';
                }
                field("SO ID"; Rec."SO ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PO ID field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Product ID"; Rec."Product ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Product ID field.', Comment = '%';
                }
                field("Quantity"; Rec."Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity Order field.', Comment = '%';
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Amount field.', Comment = '%';
                }
                field(Discount; Rec."Line Discount")
                {
                    ApplicationArea = all;
                    Caption = 'Line Discount';
                }

                field(Total; Rec."Line Total")
                {
                    ApplicationArea = all;
                    Caption = 'Line Total';
                }
            }
        }
    }
}
