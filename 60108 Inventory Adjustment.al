codeunit 60108 "Inventory Adjustment SC"
{
    trigger OnRun()
    begin

    end;

    procedure UpdateInventory(Var POHeader: Record "PO Middleware Header")
    var
        ItemJournal: Record "Item Journal Line";
        POLines: Record "PO Middleware Lines";
        LineNo: Integer;
    begin
        if POHeader.FindSet() then begin
            repeat
                POLines.SetRange("PO ID", POHeader."PO ID");
                if POLines.FindSet() then begin
                    repeat
                        ItemJournal.Init();
                        ItemJournal."Line No." := GetNextLineNo();
                        ItemJournal.Validate(ItemJournal."Entry Type", ItemJournal."Entry Type"::"Negative Adjmt.");
                        ItemJournal.Validate("Journal Template Name", 'ITEM');
                        ItemJournal.Validate("Journal Batch Name", 'START-MANF');
                        ItemJournal.Validate("Posting Date", Today);
                        ItemJournal.Validate("Document No.", POLines."PO ID");
                        ItemJournal.Validate("Item No.", GetBCItemNo(POLines."Product ID"));
                        ItemJournal.Validate("Location Code", 'MAIN');
                        ItemJournal.Validate(Quantity, POLines."Quantity Order");
                        ItemJournal.Validate("Unit Amount", POLines."Unit Cost(After Discount)");


                        ItemJournal.Insert();

                    until POLines.Next() = 0
                end;
            // CODEUNIT.Run(CODEUNIT::"Item Jnl.-Post", ItemJournal);
            until POHeader.Next() = 0;
        end;

    end;

    procedure UpdateSOInventory(Var SOHeader: Record "SO Middleware Header")
    var
        ItemJournal: Record "Item Journal Line";
        SC_ItemJournal: Record "Item Journal Line";
        SOLines: Record "SO Middleware Lines";
        LineNo: Integer;
        Noseries: Codeunit NoSeriesManagement;
        _DocumentNo: Code[20];
    begin
        if SOHeader.FindSet() then begin
            repeat
                SOLines.SetRange("SO ID", SOHeader."SO ID");
                if SOLines.FindSet() then begin
                    _DocumentNo := Noseries.GetNextNo('CASH-PAY', Today, true);
                    repeat
                        ItemJournal.Init();
                        ItemJournal."Line No." := GetNextLineNo();
                        ItemJournal.Validate("Journal Template Name", 'ITEM');
                        ItemJournal.Validate("Journal Batch Name", 'DEFAULT');
                        ItemJournal.Validate(ItemJournal."Entry Type", ItemJournal."Entry Type"::"Negative Adjmt.");
                        ItemJournal.Validate("Posting Date", Today);
                        ItemJournal.Validate("Document No.", _DocumentNo);
                        ItemJournal.Validate("Item No.", GetBCItemNo(SOLines."Product ID"));
                        ItemJournal.Validate("Location Code", 'MAIN');
                        ItemJournal.Validate(Quantity, SOLines.Quantity);
                        ItemJournal.Validate("Unit Amount", SOLines."Unit Cost");
                        ItemJournal."External Document No." := SOLines."SO ID";
                        ItemJournal.Insert();
                    until SOLines.Next() = 0
                end;
            // CODEUNIT.Run(CODEUNIT::"Item Jnl.-Post", ItemJournal);
            // SC_ItemJournal.Reset();
            // SC_ItemJournal.Validate("Journal Template Name", 'ITEM');
            // SC_ItemJournal.Validate("Journal Batch Name", 'DEFAULT');
            // SC_ItemJournal.SetFilter("Document No.", '=%1|%2', _DocumentNo);
            // if SC_ItemJournal.FindSet() then begin
            //     ItemjournalBatch.Run(SC_ItemJournal);
            //     ModifySalesInvStaggingLog(SOHeader);
            // end;
            until SOHeader.Next() = 0;
        end;

    end;

    local procedure ModifySalesInvStaggingLog(Var SOMiddlewareHeader: Record "SO Middleware Header")
    begin
        SOMiddlewareHeader.IsProceeded := true;
        SOMiddlewareHeader.Modify();
    end;

    local procedure GetNextLineNo(): Integer
    var
        ItemJournal: Record "Item Journal Line";
    begin
        ItemJournal.SetRange("Journal Template Name", 'ITEM');
        ItemJournal.SetRange("Journal Batch Name", 'START-MANF');
        if ItemJournal.FindLast() then
            exit(ItemJournal."Line No." + 10000)
        else
            exit(10000);
    end;

    local procedure GetBCItemNo(SCItemID: Code[20]): Code[20]
    var
        itemlrec: Record Item;
    begin
        itemlrec.Reset();
        itemlrec.SetCurrentKey("SC Product ID");
        itemlrec.SetRange("SC Product ID", SCItemID);
        if itemlrec.FindFirst() then
            exit(itemlrec."No.");
    end;

    var
        myInt: Integer;
        v: Page "Item Journal";
        GenJnlPostBatch: Codeunit "Gen. Jnl.-Post Batch";
        ItemjournalBatch: Codeunit "Item Jnl.-Post";
}