table 60103 "PO Middleware Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "PO ID"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Vendor ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Total Paid"; Decimal)
        {
            FieldClass = FlowField;
            DecimalPlaces = 0 : 5;
            CalcFormula = Sum("PO Middleware Lines"."Line Total" where("PO ID" = field("PO ID")));
            Editable = false;
        }
        field(5; "Order Status"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Receiving Status"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Payment Status"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Vendor Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "PO ID")
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
        POLine: Record "PO Middleware Lines";
    begin
        POLine.SetRange("PO ID", rec."PO ID");
        if POLine.FindSet() then
            POLine.DeleteAll();
    end;

    trigger OnRename()
    begin

    end;

}