tableextension 60103 MyExtension extends Vendor
{
    fields
    {
        field(60100; "SC Vendor ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        // Add changes to table fields here
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