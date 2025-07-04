pageextension 60104 "CustomerCard_Ext" extends "Customer Card"
{
    layout
    {
        addafter("No.")
        {
            field("SC Customer ID"; Rec."SC Customer ID")
            {
                ApplicationArea = all;
                Caption = 'Seller Cloud Customer ID';
            }
        }
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}