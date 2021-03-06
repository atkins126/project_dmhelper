program Project_DMHelper;

uses
  Vcl.Forms,
  uMainScreen in 'uMainScreen.pas' {frmMainScreen},
  uDTMConnection in 'DataModule\uDTMConnection.pas' {dtmConnection: TDataModule},
  uHeritageScreen in 'heritage\uHeritageScreen.pas' {frmHeritageScreen},
  uRegUsers in 'register\uRegUsers.pas' {frmRegUser},
  Enter in 'third party\Enter.pas',
  uEnum in 'heritage\uEnum.pas',
  cUserReg in 'classes\cUserReg.pas',
  cCrypto in 'classes\cCrypto.pas',
  uCombatTracker in 'tools\uCombatTracker.pas' {frmCombatTracker},
  uCampaigns in 'tools\uCampaigns.pas' {frmCampaigns},
  cCampaigns in 'classes\cCampaigns.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdtmConnection, dtmConnection);
  Application.CreateForm(TfrmMainScreen, frmMainScreen);
  Application.CreateForm(TfrmCampaigns, frmCampaigns);
  Application.Run;
end.
