pageextension 60103 "PurchaseInvEXT" extends "Posted Purchase Invoice"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("&Invoice")
        {
            action("Post To Sellercloud")
            {
                ApplicationArea = all;
                trigger OnAction()
                var
                    PO_RqstHandler: Codeunit "Post PO to Seller Cloud";
                begin
                    PO_RqstHandler.Post(Rec);
                    Message('Purchase Created');
                end;
            }
        }
    }

    var
        myInt: Integer;
}