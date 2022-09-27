page 73007 SpyGenJnlTemplate
{
    ApplicationArea = All;
    Caption = 'SpyGenJnlTemplate';
    PageType = List;
    SourceTable = "Gen. Journal Template";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the journal template you are creating.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a brief description of the journal template you are creating.';
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the journal type.';
                }
                field("No. Series"; Rec."No. Series") { Caption = 'No. Series'; ApplicationArea = All; ToolTip = 'No. Series'; }

                field("Posting No. Series"; Rec."Posting No. Series") { Caption = 'Posting No. Series'; ApplicationArea = All; ToolTip = 'Posting No. Series'; }

                field(SystemId; Rec.SystemId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
            }
        }
    }
}
