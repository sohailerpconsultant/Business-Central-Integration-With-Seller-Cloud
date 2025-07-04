table 60100 "Seller Cloud Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Store Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Store URL"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "User Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Password"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Token URL"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Bearer Token"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Inventory URL"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "PO URL"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "PO ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "SO URL"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "SO ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Order Status"; Enum "Order Status")
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Itme Template"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Templ.";
        }
        field(14; "Customer No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";

            trigger OnValidate()
            var
                cust: Record Customer;
            begin
                cust.Reset();
                cust.SetRange("No.", Rec."Customer No");
                if FindFirst() then begin
                    "Customer Name" := cust.Name;
                end;

            end;
        }
        field(15; "Customer Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Vendor No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";

            trigger OnValidate()
            var
                Vendor: Record Vendor;
            begin
                Vendor.Reset();
                Vendor.SetRange("No.", Rec."Vendor No");
                if Vendor.FindFirst() then begin
                    "Vendor Name" := Vendor.Name;
                end;

            end;
        }
        field(17; "Vendor Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Store Code")
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