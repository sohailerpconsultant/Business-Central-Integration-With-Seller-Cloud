page 60101 "Seller Cloud Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Seller Cloud Setup";
    PromotedActionCategories = 'New,Process,Report,SellerCloud';


    layout
    {
        area(Content)
        {
            group("General")
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
            group("Access Token")
            {
                field("Token URL"; Rec."Token URL")
                {
                    ApplicationArea = all;
                }
                field("User Name"; Rec."User Name")
                {
                    ApplicationArea = all;
                }
                field(Password; Rec.Password)
                {
                    ApplicationArea = all;
                }
                field("Bearer Token"; Rec."Bearer Token")
                {
                    ApplicationArea = all;
                }
            }
            group("Inventory")
            {
                field("Inventory URL"; Rec."Inventory URL")
                {
                    ApplicationArea = all;
                }
                field("Itme Template"; Rec."Itme Template")
                {
                    ApplicationArea = All;
                }
            }
            group("Purchase Orders")
            {
                field("Vendor No"; Rec."Vendor No")
                {
                    ApplicationArea = all;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = all;
                }
                field("PO URL"; Rec."PO URL")
                {
                    ApplicationArea = all;
                }
                field("PO ID"; Rec."PO ID")
                {
                    ApplicationArea = all;
                }
            }
            group("Sale Orders")
            {
                field("Customer No"; Rec."Customer No")
                {
                    ApplicationArea = all;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = all;
                }
                field("SO URL"; Rec."SO URL")
                {
                    ApplicationArea = all;
                }
                field("Order Status"; Rec."Order Status")
                {
                    ApplicationArea = all;
                }
                field("SO ID"; Rec."SO ID")
                {
                    ApplicationArea = all;
                    ToolTip = 'For fetching only single order';
                }
            }
        }
    }

    actions
    {

        area(Processing)
        {
            action(GetToken)
            {
                Caption = 'Update Access Token';
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    TokenReqstHandler: Codeunit "Access Token Request Handler";
                begin
                    TokenReqstHandler.AccessToken();
                    Message('Token Updated Successfully');
                end;
            }
            action(GetInventory)
            {
                Caption = 'Sync Inventory';
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    InventoryReqstHandler: Codeunit "Inventory Request Handler";
                begin
                    InventoryReqstHandler.GetInventory();
                    Message('Inventory Updated Successfully');
                end;
            }
            action(SyncPurchaseOrder)
            {
                Caption = 'Sync Purchase Orders';
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    POReqstHandler: Codeunit "Purchase Order Request Handler";
                begin
                    POReqstHandler.PO_RequestHandler();
                    Message('Purchase Orders Updated Successfully');
                end;
            }
            action(SyncSalesOrder)
            {
                Caption = 'Sync Sales Orders';
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    SOReqstHandler: Codeunit "Sale Order Request Handler";
                begin
                    SOReqstHandler.SO_RequestHandler();
                    Message('Sales Orders Updated Successfully');
                end;
            }
            action(SyncBulkSalesOrder)
            {
                Caption = 'Sync Bulk Sales Orders';
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;


                trigger OnAction()
                var
                    SOReqstHandler: Codeunit "Bulk SO Request Handler";
                begin
                    SOReqstHandler.GetBulkSaleOrders();
                    Message('Sales Orders Updated Successfully');
                end;
            }
            action(SyncBulkPurchaseOrder)
            {
                Caption = 'Sync Bulk Purchase Orders';

                trigger OnAction()
                var
                    POReqstHandler: Codeunit "Bulk PO Request Handler";
                begin
                    POReqstHandler.GetBulkPurchaseOrders();
                    Message('Purchase Orders Updated Successfully');
                end;
            }
        }

    }

    var
        myInt: Integer;
}