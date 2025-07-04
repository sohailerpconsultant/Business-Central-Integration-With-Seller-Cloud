page 60100 "Seller Cloud Setups"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Seller Cloud Setup";
    CardPageId = "Seller Cloud Setup";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Store Code"; Rec."Store Code")
                {
                    ApplicationArea = all;
                }
                field("Store URL"; Rec."Store URL")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }
}