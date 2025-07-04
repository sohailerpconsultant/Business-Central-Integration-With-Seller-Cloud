table 60105 "SO Middleware Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "SO ID"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Customer Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Customer ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Total Paid"; Decimal)
        {
            FieldClass = FlowField;
            DecimalPlaces = 0 : 5;
            CalcFormula = Sum("SO Middleware Lines"."Line Total" where("SO ID" = field("SO ID")));
            Editable = false;
        }
        field(5; "Order Status"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Shipping Status"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Payment Status"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "IsProceeded"; Boolean)
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "SO ID")
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
        v: Record "Sales Header Archive";

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    var
        SOLine: Record "SO Middleware Lines";
    begin
        SOLine.SetRange("SO ID", Rec."SO ID");
        if SOLine.FindSet() then
            SOLine.DeleteAll();
    end;

    trigger OnRename()
    begin

    end;

}