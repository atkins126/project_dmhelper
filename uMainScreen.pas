unit uMainScreen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, uDTMConnection, Enter, uCombatTracker,
  uCampaigns;

type
  TfrmMainScreen = class(TForm)
    mmScreen: TMainMenu;
    FerramentasdoMestre1: TMenuItem;
    PlayerTools1: TMenuItem;
    InitiativeCounter1: TMenuItem;
    MonstersNPCs1: TMenuItem;
    CampaignNotesandWorldbuilding1: TMenuItem;
    CharacterSheet1: TMenuItem;
    Rulesets1: TMenuItem;
    N1: TMenuItem;
    mnuClose: TMenuItem;
    Users1: TMenuItem;
    Registry1: TMenuItem;
    procedure mnuCloseClick(Sender: TObject);
    procedure Registry1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure InitiativeCounter1Click(Sender: TObject);
    procedure CampaignNotesandWorldbuilding1Click(Sender: TObject);
  private
    { Private declarations }
    EnterButton : TMREnter;
  public
    { Public declarations }
  end;

var
  frmMainScreen: TfrmMainScreen;

implementation

{$R *.dfm}

uses uRegUsers;

procedure TfrmMainScreen.Registry1Click(Sender: TObject);
begin
  Try
    frmRegUser := TfrmRegUser.Create(Self);
    frmRegUser.ShowModal;
  Finally
    frmRegUser.Release;
  End;
end;

procedure TfrmMainScreen.CampaignNotesandWorldbuilding1Click(Sender: TObject);
begin
  Try
    frmCampaigns := TfrmCampaigns.Create(Self);
    frmCampaigns.ShowModal;
  Finally
    frmCampaigns.Release;
  End;
end;

procedure TfrmMainScreen.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(EnterButton);
end;

procedure TfrmMainScreen.FormCreate(Sender: TObject);
begin
  EnterButton := TMREnter.Create(Self);
  EnterButton.FocusEnabled := True;
  EnterButton.FocusColor := clInfoBk;
end;

procedure TfrmMainScreen.InitiativeCounter1Click(Sender: TObject);
begin
  Try
    frmCombatTracker := TfrmCombatTracker.Create(Self);
    frmCombatTracker.ShowModal;
  Finally
    frmCombatTracker.Release;
  End;
end;

procedure TfrmMainScreen.mnuCloseClick(Sender: TObject);
begin
  //Close;
  Application.Terminate;
end;

end.
