pageextension 60100 "SellerCloudRoleCenter" extends "Business Manager Role Center"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addlast(sections)
        {
            group("Seller Cloud")
            {

                action("Seller Cloud-Setup")
                {
                    ApplicationArea = All;
                    Caption = 'Seller Cloud-Setup';
                    Image = Web;
                    RunObject = page "Seller Cloud Setups";

                }
                action("Seller Cloud Inventory")
                {
                    ApplicationArea = All;
                    Caption = 'Seller Cloud Inventory';
                    Image = Web;
                    RunObject = page "Seller Cloud Items";

                }
                action("Purchase Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Inventory';
                    Image = Web;
                    RunObject = page "Purchase Orders Middleware";

                }

                action("Sale Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Sale Inventory';
                    Image = Web;
                    RunObject = page "Sale Orders Middleware";

                }
                action("SC Job Que Log")
                {
                    ApplicationArea = All;
                    Caption = 'SC Job Que Log';
                    Image = Web;
                    RunObject = page "SC Job Que Log";

                }
            }
        }
    }
}