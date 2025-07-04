pageextension 60105 "VendorEXT" extends "Vendor Card"
{
    layout
    {
        addafter("No.")
        {
            field("SC Vendor ID"; Rec."SC Vendor ID")
            {
                ApplicationArea = all;
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