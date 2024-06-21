page 73099 "Spy Extension Info"
{
    APIGroup = 'integration';
    APIPublisher = 'spy';
    APIVersion = 'v1.0';
    Caption = 'SpyExtensionInfoAPI';
    DelayedInsert = true;
    EntityName = 'SpyExtensionInfo';
    EntitySetName = 'SpyExtensionInfoSet';
    PageType = API;
    SourceTableTemporary = true;
    SourceTable = "Spy Extension Info Temp";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(msbcApplicationBuild; Rec.BCApplicationBuild)
                {
                    Caption = 'Microsoft BC Application Build';
                }
                field(msbcApplicationVersion; Rec.BCApplicationVersion)
                {

                }
                field(msbcBuildBranch; Rec.BCBuildBranch)
                {

                }
                field(msbcBuildFileVersion; Rec.BCBuildFileVersion)
                {

                }
                field(msbcOriginalApplicationVersion; Rec.BCOriginalApplicationVersion)
                {

                }
                field(msbcPlatformFileVersion; Rec.BCPlatformFileVersion)
                {

                }
                field(msbcPlatformProductVersion; Rec.BCPlatformProductVersion)
                {

                }
                field(spyExtensionDataVersion; Rec.SpyExtensionDataVersion)
                {

                }
                field(spyExtensionAppVersion; Rec.SpyExtensionAppVersion)
                {

                }
                field(spyExtensionName; Rec.SpyExtensionName)
                {

                }
                field(spyExtensionPubliser; Rec.SpyExtensionPubliser)
                {

                }
            }
        }
    }

    trigger OnOpenPage()
    var
        SpyExtensionInfo: Record "Spy Extension Info Temp";
        ApplicationSystemConstants: Codeunit "Application System Constants";
        Info: ModuleInfo;
    begin

        NavApp.GetCurrentModuleInfo(Info);
        Rec.BCApplicationBuild := ApplicationSystemConstants.ApplicationBuild();
        Rec.BCApplicationVersion := ApplicationSystemConstants.ApplicationVersion();
        Rec.BCBuildBranch := ApplicationSystemConstants.BuildBranch();
        Rec.BCBuildFileVersion := ApplicationSystemConstants.BuildFileVersion();
        Rec.BCOriginalApplicationVersion := ApplicationSystemConstants.OriginalApplicationVersion();
        Rec.BCPlatformFileVersion := ApplicationSystemConstants.PlatformFileVersion();
        Rec.BCPlatformProductVersion := ApplicationSystemConstants.PlatformProductVersion();
        Rec.SpyExtensionAppVersion := Format(Info.AppVersion);
        Rec.SpyExtensionDataVersion := Format(info.DataVersion);
        Rec.SpyExtensionName := Info.Name;
        Rec.SpyExtensionPubliser := Info.Publisher;
        Rec.Insert(true)
    end;
}
