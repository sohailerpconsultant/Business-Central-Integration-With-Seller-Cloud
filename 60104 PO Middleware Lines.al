table 60104 "PO Middleware Lines"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "PO ID"; Code[20])
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
        field(5; "Quantity Order"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "QTY On Hand"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Unit Cost(After Discount)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Actual Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Line Total"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Discount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "PO ID", "Line No")
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