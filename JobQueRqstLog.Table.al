table 60107 "Job Que Rqst Log"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;

        }
        field(2; "Start Date Time"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "End Date Time"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Inventory Job Que Status"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "SO Job Que Status"; Enum "SC Inventroy Status")
        {
            DataClassification = ToBeClassified;
        }
        field(6; "PO Job Que Status"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Entry No.")
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