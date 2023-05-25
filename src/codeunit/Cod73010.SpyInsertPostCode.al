codeunit 73010 "SpyInsertPostCode"
{
    Procedure InsertPostCode(Country: Code[10]; City: Text[30]; PostCode: Code[20])
    var
        PostCodeRec: Record "Post Code";

    begin
        IF (Country <> '') AND (City <> '') AND (PostCode <> '') THEN BEGIN
            //PostRec.SETFILTER(PostRec."Country/Region Code",Country);
            PostCodeRec.SETFILTER(PostCodeRec.City, '%1', City);
            PostCodeRec.SETFILTER(PostCodeRec.Code, '%1', PostCode);
            IF NOT PostCodeRec.FindSet() THEN BEGIN
                PostCodeRec.Init();
                PostCodeRec.Code := PostCode;
                PostCodeRec.City := City;
                PostCodeRec."Search City" := UPPERCASE(City);
                PostCodeRec."Country/Region Code" := Country;
                PostCodeRec.INSERT(FALSE);
            end;
        end;
    end;


    trigger OnRun()
    begin

    end;

    var

}