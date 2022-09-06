page 73089 "Spy Post Code"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Post Code";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                    trigger OnValidate()
                    var

                    begin
                        Rec."Search City" := Rec.City;
                    end;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = ' ';
                }
            }
        }
    }

}