table 73099 "Spy Extension Info Temp"
{
    DataClassification = CustomerContent;
    TableType = Temporary;

    fields
    {
        field(1; BCApplicationBuild; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'BC Application Build';
        }
        field(2; BCApplicationVersion; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'BC Application Version';
        }
        field(3; BCBuildBranch; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'BC Build Branch';
        }
        field(4; BCBuildFileVersion; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'BC Build File Version';
        }
        field(5; BCOriginalApplicationVersion; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'BC Original Application Version';
        }
        field(6; BCPlatformFileVersion; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'BC Platform File Version';
        }
        field(7; BCPlatformProductVersion; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'BC Platform Product Version';
        }
        field(8; SpyExtensionDataVersion; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Spy Extension Data Version';
        }
        field(9; SpyExtensionAppVersion; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Spy Extension App Version';
        }
        field(10; SpyExtensionName; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Spy Extension Name';
        }
        field(11; SpyExtensionPublisher; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Spy Extension Publisher';
        }
    }
}
