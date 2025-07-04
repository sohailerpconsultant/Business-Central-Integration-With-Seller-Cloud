page 60110 "SC Job Que Log"
{
    ApplicationArea = All;
    Caption = 'SC Job Que Log';
    PageType = List;
    SourceTable = "Job Que Rqst Log";
    UsageCategory = Lists;
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Start Date Time"; Rec."Start Date Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date Time field.', Comment = '%';
                }
                field("End Date Time"; Rec."End Date Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Date Time field.', Comment = '%';
                }
                field("Inventory Job Que Status"; Rec."Inventory Job Que Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Inventory Job Que Status field.', Comment = '%';
                }
                field("SO Job Que Status"; Rec."SO Job Que Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SO Job Que Status field.', Comment = '%';
                }
                field("PO Job Que Status"; Rec."PO Job Que Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PO Job Que Status field.', Comment = '%';
                }
            }
        }
    }
}
