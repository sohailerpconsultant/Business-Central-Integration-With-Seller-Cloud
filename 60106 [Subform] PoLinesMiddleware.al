page 60106 "Po Lines Middleware"
{
    Caption = 'Po Lines Middleware';
    PageType = ListPart;
    SourceTable = "PO Middleware Lines";
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
                field("PO ID"; Rec."PO ID")
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
                field("QTY On Hand"; Rec."QTY On Hand")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the QTY On Hand field.', Comment = '%';
                }
                field("Quantity Order"; Rec."Quantity Order")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity Order field.', Comment = '%';
                }
                field("Actual Unit Cost"; Rec."Actual Unit Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Amount field.', Comment = '%';
                }
                field(Discount; Rec.Discount)
                {
                    ApplicationArea = all;
                    Caption = 'Discount Value';
                }
                field("Unit Cost(After Discount)"; Rec."Unit Cost(After Discount)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Cost field.', Comment = '%';
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
