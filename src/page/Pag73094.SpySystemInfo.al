page 73094 SpySystemInfo
{
    ApplicationArea = All;
    Caption = 'SpySystemInfo';
    PageType = Card;
    SourceTable = "Integer";
    SourceTableView = sorting(number) where(number = filter(1));
    Editable = false;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(ApplicationBuild; ApplicationBuild)
                {

                }
                field(ApplicationBuildBranch; ApplicationBuildBranch)
                {

                }
                field(ApplicationBuildFileVersion; ApplicationBuildFileVersion)
                {

                }
                field(ApplicationOriginalApplicationVersion; ApplicationOriginalApplicationVersion)
                {

                }
                field(ApplicationPlatformFileVersion; ApplicationPlatformFileVersion)
                {

                }
                field(ApplicationPlatformProductVersion; ApplicationPlatformProductVersion)
                {

                }
                field(ApplicationVersion; ApplicationVersion)
                {

                }
                field(ExtensioinDataVersion; ExtensioinDataVersion)
                {

                }
                field(ExtensionAppVersion; ExtensionAppVersion)
                {

                }
                field(ExtensionName; ExtensionName)
                {

                }
                field(ExtensionPubliser; ExtensionPubliser)
                {

                }
            }
        }
    }

    var
        ApplicationBuild: Text;
        ApplicationVersion: Text;
        ApplicationBuildBranch: Text;
        ApplicationBuildFileVersion: text;
        ApplicationOriginalApplicationVersion: text;
        ApplicationPlatformFileVersion: Text;
        ApplicationPlatformProductVersion: Text;
        ExtensioinDataVersion: text;
        ExtensionAppVersion: Text;
        ExtensionName: Text;
        ExtensionPubliser: text;

    trigger OnAfterGetRecord()
    var
        ApplicationSystemConstants: Codeunit "Application System Constants";
        Info: ModuleInfo;
    begin
        NavApp.GetCurrentModuleInfo(Info);
        ApplicationBuild := ApplicationSystemConstants.ApplicationBuild();
        ApplicationVersion := ApplicationSystemConstants.ApplicationVersion();
        ApplicationBuildBranch := ApplicationSystemConstants.BuildBranch();
        ApplicationBuildFileVersion := ApplicationSystemConstants.BuildFileVersion();
        ApplicationOriginalApplicationVersion := ApplicationSystemConstants.OriginalApplicationVersion();
        ApplicationPlatformFileVersion := ApplicationSystemConstants.PlatformFileVersion();
        ApplicationPlatformProductVersion := ApplicationSystemConstants.PlatformProductVersion();
        ExtensionAppVersion := Format(Info.AppVersion);
        ExtensioinDataVersion := Format(info.DataVersion);
        ExtensionName := Info.Name;
        ExtensionPubliser := Info.Publisher;
    end;

    trigger OnOpenPage()
    begin
        rec.get(1);
    end;
}
