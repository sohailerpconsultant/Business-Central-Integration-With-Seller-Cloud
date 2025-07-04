tableextension 60102 "CustomerEXT" extends Customer
{
    fields
    {
        field(60100; "SC Customer ID"; Code[20])
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