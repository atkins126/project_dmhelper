unit uCampaigns;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uHeritageScreen, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  Vcl.ExtCtrls, Vcl.ComCtrls, RRPGControls, RLReport, RRPGRichEdit, cCampaigns,
  uDTMConnection, uEnum;

type
  TfrmCampaigns = class(TfrmHeritageScreen)
    pnCampaignInfo: TPanel;
    lblCampaignTitlePreview: TLabel;
    lblCampaignDescriptionPreview: TLabel;
    ledtCampaignId: TLabeledEdit;
    ledtCampaignName: TLabeledEdit;
    cbCampaignPlayers: TComboBox;
    redtPreview: TRRichEdit;
    lblCampaignPlayers: TLabel;
    lbCampaignPlayers: TListBox;
    SpeedButton1: TSpeedButton;
    lblPreview: TLabel;
    imgCampaign: TImage;
    scrbCampaignInfo: TScrollBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAlterClick(Sender: TObject);
    procedure grdListingCellClick(Column: TColumn);
  private
    { Private declarations }
    oCampaigns:TCampaigns;
    function Delete : Boolean; override;
    function Save(Status:TStatus): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCampaigns: TfrmCampaigns;

implementation

{$R *.dfm}

{$region 'Override'}
function TfrmCampaigns.Save(Status: TStatus): Boolean;
begin
if ledtCampaignId.Text<>EmptyStr then
   oCampaigns.campaignId := StrToInt(ledtCampaignId.Text)
else
  oCampaigns.campaignId := 0;
  oCampaigns.name :=  ledtCampaignName.Text;
  oCampaigns.description := redtPreview.Text;

  if (Status = ecInsert) then
     Result := oCampaigns.Save
  else
  if (Status = ecAlter) then
     Result := oCampaigns.Update;
end;

procedure TfrmCampaigns.btnAlterClick(Sender: TObject);
begin
  if oCampaigns.Select(QryListing.FieldByName('id').AsInteger) then
  begin
    ledtCampaignId.Text := IntToStr(oCampaigns.campaignId);
    ledtCampaignName.Text := oCampaigns.name;
    redtPreview.Text := oCampaigns.description;
  end
  else
  begin
    btnCancel.Click;
    abort;
  end;

  inherited;

end;

function TfrmCampaigns.Delete: Boolean;
begin
  if oCampaigns.Select(QryListing.FieldByName('id').AsInteger) then
  begin
  Result := oCampaigns.Delete;
  end;
end;

{$endregion}

procedure TfrmCampaigns.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(oCampaigns) then
     FreeAndNil(oCampaigns);
end;

procedure TfrmCampaigns.FormCreate(Sender: TObject);
begin
  inherited;
  oCampaigns := TCampaigns.Create(dtmConnection.dbConnection);
  CurrentIndex := 'description'
end;

procedure TfrmCampaigns.grdListingCellClick(Column: TColumn);
begin
  inherited;
  if oCampaigns.Select(QryListing.FieldByName('id').AsInteger) then
    lblCampaignTitlePreview.Caption := QryListing.FieldByName('name').Text;
    lblCampaignDescriptionPreview.Caption := QryListing.FieldByName('description').Text;
end;

end.
