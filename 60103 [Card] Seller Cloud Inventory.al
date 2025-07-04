page 60103 "Seller Cloud Item"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Inventory Middleware";
    Editable = false;

    layout
    {
        area(Content)
        {
            group(GroupName)
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
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}