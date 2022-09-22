page 73083 SpyTempJournalLines
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Gen. Journal Line";
    SourceTableTemporary = true;

    layout
    {
        area(Content)
        {
            group(Repeater)
            {
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                    Caption = 'Journal Batch Name';

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(UPJO)
            {
                ApplicationArea = All;
                ToolTip = ' ';

                trigger OnAction()
                begin
                    message('UPJO');
                end;
            }
        }
    }

}