unit uHeritageScreen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ComCtrls, Vcl.ExtCtrls,
  uDTMConnection, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  uEnum;

type
  TfrmHeritageScreen = class(TForm)
    pgcMain: TPageControl;
    pnlFooter: TPanel;
    tabListing: TTabSheet;
    tabMaintenance: TTabSheet;
    btnNew: TBitBtn;
    btnAlter: TBitBtn;
    btnCancel: TBitBtn;
    btnSave: TBitBtn;
    btnDelete: TBitBtn;
    btnClose: TBitBtn;
    btnNavigator: TDBNavigator;
    qryListing: TFDQuery;
    dtsListing: TDataSource;
    pnlListingTop: TPanel;
    lblIndex: TLabel;
    mskSearch: TMaskEdit;
    btnSearch: TBitBtn;
    grdListing: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnAlterClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdListingTitleClick(Column: TColumn);
    procedure mskSearchChange(Sender: TObject);
    procedure grdListingDblClick(Sender: TObject);
  private
  { Private declarations }
    procedure ButtonControl(btnNew, btnAlter, btnCancel,
          btnSave, btnDelete : TBitBtn; btnNavigator : TDBNavigator;
          pgcMain : TPageControl; Flag : Boolean);
    procedure PageControl(pgcMain: TPageControl; CurrentIndex: Integer);
    function ReturnField(Field: String): String;
    procedure ShowLabelIndex(Field: String; aLabel: TLabel);
    function MandatoryField: Boolean;
    procedure DisableEditPK;
    procedure CleanFields;


  public
    { Public declarations }
    Status : TStatus;
    CurrentIndex : String;
    function Delete : Boolean; virtual;
    function Save(Status:TStatus): Boolean; virtual;
  end;

var
  frmHeritageScreen: TfrmHeritageScreen;

implementation

{$R *.dfm}

{$region 'OBSERVATIONS}
//COMPONENT TAG: 1 - PRIMARY KEY (PK);
//COMPONENT TAG: 2 - MANDATORY FIELD;
{$endregion}

{$region 'BUTTONS'}
procedure TfrmHeritageScreen.btnNewClick(Sender: TObject);
begin
  Try
    ButtonControl(btnNew, btnAlter, btnCancel, btnSave, btnDelete, btnNavigator,
                pgcMain, False);
  Finally
    Status := ecInsert;
    CleanFields;
    QryListing.Refresh;
  End;
end;

procedure TfrmHeritageScreen.btnSaveClick(Sender: TObject);
begin
  if (MandatoryField) then
    Abort;
    Try
      if Save(Status) then
      begin
        ButtonControl(btnNew, btnAlter, btnCancel, btnSave, btnDelete, btnNavigator,
                      pgcMain, True);
        PageControl(pgcMain, 0);
        Status := ecNone;
        CleanFields;
        QryListing.Refresh;
      end
      else
      begin
        MessageDlg('Error on saving process.', mtError, [mbOK], 0);
      end;
    Finally
    End;
end;

procedure TfrmHeritageScreen.btnAlterClick(Sender: TObject);
begin
  Try
  ButtonControl(btnNew, btnAlter, btnCancel, btnSave, btnDelete, btnNavigator,
                pgcMain, False);
  Finally
  Status := ecAlter;
  QryListing.Refresh;
  End;
end;

procedure TfrmHeritageScreen.btnCancelClick(Sender: TObject);
begin
  Try
    ButtonControl(btnNew, btnAlter, btnCancel, btnSave, btnDelete, btnNavigator,
                  pgcMain, True);
    PageControl(pgcMain, 0);
  Finally
    Status := ecNone;
    CleanFields;
  End;
end;

procedure TfrmHeritageScreen.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmHeritageScreen.btnDeleteClick(Sender: TObject);
begin
  Try
     if Delete then
     begin
       ButtonControl(btnNew, btnAlter, btnCancel, btnSave, btnDelete, btnNavigator,
                          pgcMain, True);
       PageControl(pgcMain, 0);
     end
     else
     begin
       MessageDlg('Error on delete process.', mtError, [mbOK], 0);
     end
  Finally
  Status := ecNone;
  CleanFields;
  QryListing.Refresh;
  End;
end;

{$endregion}

{$region 'EVENTS'}
procedure TfrmHeritageScreen.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  QryListing.Close;
end;

procedure TfrmHeritageScreen.FormCreate(Sender: TObject);
begin
  qryListing.Connection := DTMConnection.dbConnection;
  dtsListing.DataSet := QryListing;
  grdListing.DataSource := dtsListing;
  grdListing.Options := [dgTitles,dgIndicator,dgColumnResize,dgColLines
                        ,dgRowLines,dgTabs,dgRowSelect,dgAlwaysShowSelection,
                        dgCancelOnExit,dgTitleClick,dgTitleHotTrack];
end;

procedure TfrmHeritageScreen.FormShow(Sender: TObject);
begin
  PageControl(pgcMain, 0);
  lblIndex.Caption:=CurrentIndex;
  DisableEditPK;
  if (QryListing.SQL.Text <> EmptyStr) then
  begin
    QryListing.IndexFieldNames := CurrentIndex;
    ShowLabelIndex(CurrentIndex, lblIndex);
    QryListing.Open;
  end;
  ButtonControl(btnNew, btnAlter, btnCancel, btnSave, btnDelete, btnNavigator,
                  pgcMain, True);
end;

procedure TfrmHeritageScreen.grdListingDblClick(Sender: TObject);
begin
  btnAlter.Click;
end;

procedure TfrmHeritageScreen.grdListingTitleClick(Column: TColumn);
begin
  CurrentIndex := Column.FieldName;
  QryListing.IndexFieldNames := CurrentIndex;
  ShowLabelIndex(CurrentIndex, lblIndex);
end;

{$endregion}

{$region 'Screen Control'}
procedure TfrmHeritageScreen.ButtonControl(btnNew, btnAlter, btnCancel,
          btnSave, btnDelete : TBitBtn; btnNavigator : TDBNavigator;
          pgcMain : TPageControl; Flag : Boolean);
begin
  btnNew.Enabled := Flag;
  btnDelete.Enabled := Flag;
  btnAlter.Enabled := Flag;
  btnNavigator.Enabled := Flag;
  pgcMain.Pages[0].TabVisible := Flag;

  btnCancel.Enabled := not(Flag);
  btnSave.Enabled := not (Flag);


end;

{$region 'VIRTUAL METHODS'}
function TfrmHeritageScreen.Delete: Boolean;
begin
  ShowMessage('DELETED');
  Result := True;
end;
{$endregion}

procedure TfrmHeritageScreen.PageControl(pgcMain : TPageControl; CurrentIndex : Integer);
begin
  if (pgcMain.Pages[CurrentIndex].TabVisible) then
     pgcMain.TabIndex := CurrentIndex;

end;
{$endregion}

{$region 'FUNCTIONS & PROCEDURES'}
procedure TfrmHeritageScreen.mskSearchChange(Sender: TObject);
begin
  QryListing.Locate(CurrentIndex, TMaskEdit(Sender).Text, [loPartialKey]);
end;

function TfrmHeritageScreen.ReturnField(Field:String):String;
var
  i : integer;
begin
  for I := 0 to grdListing.Columns.Count-1 do
  begin
    if lowercase(grdListing.Columns[i].FieldName) = lowercase(Field) then
    begin
      Result := grdListing.Columns[i].Title.Caption;
      Break;
    end;
  end;
end;

function TfrmHeritageScreen.Save(Status: TStatus): Boolean;
begin
  if (Status = ecInsert) then
    ShowMessage('Inserted')
  else
  if (Status = ecAlter) then
    ShowMessage('Altered');

    Result := True;
end;

function TfrmHeritageScreen.MandatoryField : Boolean;
var
  i : integer;
begin
  Result := False;
  for i := 0 to ComponentCount -1 do
  begin
    if (Components[i] is TLabeledEdit) then
      if (TLabeledEdit(Components[i]).Tag = 2) and
         (TLabeledEdit(Components[i]).Text = EmptyStr) then
      begin
        MessageDlg(TLabeledEdit(Components[i]).EditLabel.Caption +
          ' is a mandatory field.', mtInformation,[mbOK],0);
          TLabeledEdit(Components[i]).SetFocus;
        Result := True;
        Break;
      end;
  end;
end;

procedure TfrmHeritageScreen.ShowLabelIndex(Field:String; aLabel: TLabel);
begin
  aLabel.Caption := ReturnField(Field);
end;

procedure TfrmHeritageScreen.DisableEditPK;
var
  i : integer;
begin
  for i := 0 to ComponentCount -1 do
  begin
    if (Components[i] is TLabeledEdit) then
      if (TLabeledEdit(Components[i]).Tag = 1) then
      begin
        TLabeledEdit(Components[i]).Enabled := False;
        Break;
      end;
  end;
end;

procedure TfrmHeritageScreen.CleanFields;
var
  i : integer;
begin
  for i := 0 to ComponentCount -1 do
  begin
    if (Components[i] is TLabeledEdit) then
      begin
        TLabeledEdit(Components[i]).Text := EmptyStr
      end
      else
      if (Components[i] is TEdit) then
      TEdit(Components[i]).Text := EmptyStr;
  end;
end;

{$endregion}

end.
