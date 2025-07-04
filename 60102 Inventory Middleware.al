table 60102 "Inventory Middleware"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Description"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Available Inventory"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Net Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Gross Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Shelf No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; " Vendor No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Item Category Code"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Item Reference"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Seller Cloud Item ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Picture URL"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Picture"; MediaSet)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Item No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}