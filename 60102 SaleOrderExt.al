pageextension 60102 "SaleInvoiceHeaderExt" extends "Posted Sales Invoice"
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
                    postsaleInvoice: Codeunit "Post SO to Seller Cloud";
                begin
                    postsaleInvoice.Post(Rec);
                    message('Order Posted to Sellercloud');
                end;
            }
        }

    }

    var
        myInt: Integer;
}