codeunit 73000 "EDK Automatic Journal Posting"
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    var
        Param: Text;
        Set: List of [text];

        Template: Text;
        Batch: Text;
        ErrorNoValidTeplateBatchSet: Label 'Cannot resolve %1 to Journal Template/Batch set, Use "/" as a delimiter';

    begin
        Rec.Testfield("Parameter String");

        foreach Param in GetParameters(Rec) do begin
            if strpos(Param, '/') = 0 then
                Error(ErrorNoValidTeplateBatchSet, Param);
            Set := param.Split('/');
            Template := Set.Get(1);
            Batch := Set.get(2);

            Code(Template, Batch);
        end;
    end;

    local Procedure Code(TemplateName: Code[20]; BatchName: Code[20])
    var
        GenJournalLine: Record "Gen. Journal Line";
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
    begin
        GenJournalLine.SetRange("Journal Template Name", TemplateName);
        GenJournalLine.SetRange("Journal Batch Name", BatchName);
        if not GenJournalLine.FindFirst() then
            Error('Could not find records in %1/%2', TemplateName, BatchName);


        Codeunit.run(Codeunit::"Adjust Gen. Journal Balance", GenJournalLine);
        Commit;

        codeunit.run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
        Commit;
    end;

    local procedure GetParameters(LocalRec: Record "Job Queue Entry") Result: List of [Text];
    var
        temp: List of [text];

    begin
        clear(result);
        result := LocalRec."Parameter String".Split(';');
    end;
}
