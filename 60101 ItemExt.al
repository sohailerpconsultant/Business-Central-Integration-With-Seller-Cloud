tableextension 60101 "Item Master Extend" extends Item
{
    fields
    {
        field(60100; "SC Product ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}