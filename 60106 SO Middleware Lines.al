table 60106 "SO Middleware Lines"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "SO ID"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Product ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Quantity"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Line Total"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Line Discount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "SO ID", "Line No")
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