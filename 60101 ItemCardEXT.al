pageextension 60101 "ItemCardExt" extends "Item Card"
{
    layout
    {
        addafter(Description)
        {
            field("SC Product ID"; Rec."SC Product ID")
            {
                ApplicationArea = all;
            }
        }

    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}