page 73090 "Spy Template Line"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Config. Template Line";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(Template; Rec."Data Template Code")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("Field ID"; Rec."Field ID")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field(FieldName; Rec."Field Name")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("Table ID"; Rec."Table ID")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("Table Name"; Rec."Table Name")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("Template Code"; Rec."Template Code")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field("Template Description"; Rec."Template Description")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field(DefaultValue; Rec."Default Value")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
            }
        }
    }
}