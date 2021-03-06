unit uRegUsers;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uHeritageScreen, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.ComCtrls, uEnum, cUserReg, uDTMConnection;

type
  TfrmRegUser = class(TfrmHeritageScreen)
    edtUserId: TLabeledEdit;
    edtUsername: TLabeledEdit;
    edtPassword: TLabeledEdit;
    procedure btnAlterClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FUser : TUser;
    function Save(Status:TStatus):Boolean;
    function Delete:Boolean;
  public
    { Public declarations }
  end;

var
  frmRegUser: TfrmRegUser;

implementation

{$R *.dfm}

{ TfrmRegUser }

procedure TfrmRegUser.btnAlterClick(Sender: TObject);
begin
  if FUser.Select(QryListing.FieldByName('id').AsInteger) then
  begin
    edtUserId.Text := IntToStr(FUser.id);
    edtUsername.Text := FUser.username;
    edtPassword.Text := FUser.password;
  end
  else
  begin
    btnCancel.Click;
    Abort;
  end;

  inherited;
end;

procedure TfrmRegUser.btnNewClick(Sender: TObject);
begin
  inherited;
  edtUsername.SetFocus;
end;

procedure TfrmRegUser.btnSaveClick(Sender: TObject);
begin
  if edtUserId.Text <> EmptyStr then
    FUser.id := StrToInt(edtUserId.Text)
  else
    FUser.id := 0;

  FUser.username := edtUsername.Text;
  FUser.password := edtPassword.Text;

  inherited;
end;

function TfrmRegUser.Delete: Boolean;
begin
  if FUser.Select(QryListing.FieldByName('id').AsInteger) then
  begin
    Result := FUser.Delete;
  end;

end;

procedure TfrmRegUser.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(FUser) then
     FreeAndNil(FUser);
end;

procedure TfrmRegUser.FormCreate(Sender: TObject);
begin
  inherited;
  FUser := TUser.Create(dtmConnection.dbConnection);
  CurrentIndex := 'name';
end;

function TfrmRegUser.Save(Status: TStatus): Boolean;
begin
  if Status=ecInsert then
    Result := FUser.Insert
  else if Status=ecAlter then
    Result := FUser.Update;
end;

end.
