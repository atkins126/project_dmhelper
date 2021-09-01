program proj_dmhelper2;

uses
  System.StartUpCopy,
  FMX.Forms,
  DMHelper.MainScreen.View in 'DMHelper.MainScreen.View.pas' {frmMain},
  DMHelper.View.Styles.Colors in 'View\Styles\DMHelper.View.Styles.Colors.pas',
  DMHelper.View.Pages.Main in 'View\Pages\DMHelper.View.Pages.Main.pas' {frmMainPage},
  DMHelper.View.Pages.User in 'View\Pages\DMHelper.View.Pages.User.pas' {frmPageUser},
  DMHelper.View.Routers in 'View\Routers\DMHelper.View.Routers.pas';

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
