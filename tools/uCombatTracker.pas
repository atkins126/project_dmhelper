unit uCombatTracker;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uHeritageScreen, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  Vcl.ExtCtrls, Vcl.ComCtrls, System.Generics.Collections, Datasnap.DBClient;

type
  TfrmCombatTracker = class(TfrmHeritageScreen)
    pnMonsterInfo: TPanel;
    Bestiary: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    cdsCombatTracker: TClientDataSet;
    cdsCombatTrackerInitiative: TIntegerField;
    cdsCombatTrackerMonsterName: TStringField;
    cdsCombatTrackerCurrentHP: TIntegerField;
    cdsCombatTrackerMaxHP: TIntegerField;
    pnTracker: TPanel;
    scrbTracker: TScrollBox;
    Panel1: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel2: TPanel;
    btnAddNew: TBitBtn;
    ComboBox1: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure btnAddNewClick(Sender: TObject);
    procedure NextRound(AObject : TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
    FList: TObjectList<TPanel>;
    IndexPanel : Integer;
    procedure AddNewRound; overload; //add empty
    procedure AddNewRound(AInitiative: Integer; AMonsterName: String; ACurrentHP, AMaxHP: Integer); overload; //add full
    function FindMyComponent(Parent: TComponent; Name: string): TComponent;
    procedure SaveInfoEdits;
  public
    destructor Destroy; override;
  end;

var
  frmCombatTracker: TfrmCombatTracker;

implementation

{$R *.dfm}

procedure TfrmCombatTracker.btnAddNewClick(Sender: TObject);
begin
  inherited;
  AddNewRound;
end;

procedure TfrmCombatTracker.btnSaveClick(Sender: TObject);
var
  I: Integer;
  OrderData: TArray<Integer>;
begin
  inherited;

  SaveInfoEdits;

  cdsCombatTracker.First;
  while not cdsCombatTracker.Eof do
  begin
    SetLength(OrderData, Length(OrderData) + 1);
    OrderData[High(OrderData)] := cdsCombatTrackerInitiative.AsInteger;

    cdsCombatTracker.Next;
  end;

  TArray.Sort<Integer>(OrderData);
  for I := 0 to Length(OrderData) -1 do
  begin
    cdsCombatTracker.Locate('Initiative', OrderData[I], []);

    //adicionar ao banco de dados
  end;
end;

procedure TfrmCombatTracker.SaveInfoEdits;
var
  I: Integer;
  Initiative,
  CurrentHP,
  MaxHP,
  MonsterName: String;
begin
  for I := 0 to FList.Count - 1 do
  begin
    Initiative := TLabeledEdit(FindMyComponent(FList[I], 'ledtInitiativeValue' + I.ToString)).Text;
    MonsterName := TLabeledEdit(FindMyComponent(FList[I], 'ledtMonsterName' + I.ToString)).Text;
    CurrentHP := TLabeledEdit(FindMyComponent(FList[I], 'ledtCurrentHP' + I.ToString)).Text;
    MaxHP := TLabeledEdit(FindMyComponent(FList[I], 'ledtMaxHP' + I.ToString)).Text;

    cdsCombatTracker.Append;
    cdsCombatTrackerInitiative.AsInteger := StrToInt(Initiative);
    cdsCombatTrackerMonsterName.AsString := MonsterName;
    cdsCombatTrackerCurrentHP.AsInteger := StrToInt(CurrentHP);
    cdsCombatTrackerMaxHP.AsInteger := StrToInt(MaxHP);
    cdsCombatTracker.Post;
  end;
end;

destructor TfrmCombatTracker.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

procedure TfrmCombatTracker.FormCreate(Sender: TObject);
begin
  inherited;
  FList := TObjectList<TPanel>.Create;
  cdsCombatTracker.CreateDataSet;
  IndexPanel := 0;
  //list all campaign on combobox

end;

procedure TfrmCombatTracker.NextRound(AObject: TObject);
var
  I: Integer;
  OrderData: TArray<Integer>;
begin
  FList.Clear;
  cdsCombatTracker.First;
  while not cdsCombatTracker.Eof do
  begin
    SetLength(OrderData, Length(OrderData) + 1);
    OrderData[High(OrderData)] := cdsCombatTrackerInitiative.AsInteger;

    cdsCombatTracker.Next;
  end;

  TArray.Sort<Integer>(OrderData);
  for I := High(OrderData) downto 0 do
  begin
    cdsCombatTracker.Locate('Initiative', OrderData[I], []);

    AddNewRound(cdsCombatTrackerInitiative.AsInteger, cdsCombatTrackerMonsterName.AsString,
      cdsCombatTrackerCurrentHP.AsInteger, cdsCombatTrackerMaxHP.AsInteger);
  end;

end;

procedure TfrmCombatTracker.AddNewRound;
begin
  AddNewRound(0, '', 0, 0);
end;

procedure TfrmCombatTracker.AddNewRound(AInitiative: Integer; AMonsterName: String; ACurrentHP, AMaxHP: Integer);
var
  Panel: TPanel;
  LabeledEdit: TLabeledEdit;
  Button: TButton;
begin
  try
    IndexPanel := FList.Count;

    Panel := TPanel.Create(Self);
    Panel.Parent := scrbTracker;
    Panel.Name := 'pnRound' + IndexPanel.ToString;
    Panel.Height := 75;
    Panel.Width := 100;
    Panel.Align := alBottom;
    Panel.Align := alTop;
    Panel.Caption := '';

    LabeledEdit := TLabeledEdit.Create(Panel);
    LabeledEdit.Parent := Panel;
    LabeledEdit.Name := 'ledtInitiativeValue' + IndexPanel.ToString;
    LabeledEdit.Text := AInitiative.ToString;
    LabeledEdit.Align := alLeft;
    LabeledEdit.Constraints.MaxHeight := 25;
    LabeledEdit.Constraints.MaxWidth := 25;
    LabeledEdit.Constraints.MinHeight := 25;
    LabeledEdit.Constraints.MinWidth := 25;
    LabeledEdit.LabelPosition := lpBelow;
    LabeledEdit.EditLabel.Caption := 'Initiative Value';

    LabeledEdit := TLabeledEdit.Create(Panel);
    LabeledEdit.Parent := Panel;
    LabeledEdit.Name := 'ledtMonsterName' + IndexPanel.ToString;
    LabeledEdit.Text := AMonsterName;
    LabeledEdit.Align := alClient;
    LabeledEdit.Constraints.MaxHeight := 25;
    LabeledEdit.Constraints.MaxWidth := 250;
    LabeledEdit.Constraints.MinHeight := 25;
    LabeledEdit.Constraints.MinWidth := 250;
    LabeledEdit.LabelPosition := lpBelow;
    LabeledEdit.BiDiMode := bdRightToLeft;
    LabeledEdit.EditLabel.Caption := 'Name';

    LabeledEdit := TLabeledEdit.Create(Panel);
    LabeledEdit.Parent := Panel;
    LabeledEdit.Name := 'ledtCurrentHP' + IndexPanel.ToString;
    LabeledEdit.Text := ACurrentHP.ToString;
    LabeledEdit.Align := alRight;
    LabeledEdit.Constraints.MaxHeight := 25;
    LabeledEdit.Constraints.MaxWidth := 75;
    LabeledEdit.Constraints.MinHeight := 25;
    LabeledEdit.Constraints.MinWidth := 75;
    LabeledEdit.LabelPosition := lpBelow;
    LabeledEdit.EditLabel.Caption := 'Current HP';

    LabeledEdit := TLabeledEdit.Create(Panel);
    LabeledEdit.Parent := Panel;
    LabeledEdit.Name := 'ledtMaxHP' + IndexPanel.ToString;
    LabeledEdit.Text := AMaxHP.ToString;
    LabeledEdit.Align := alRight;
    LabeledEdit.Constraints.MaxHeight := 25;
    LabeledEdit.Constraints.MaxWidth := 75;
    LabeledEdit.Constraints.MinHeight := 25;
    LabeledEdit.Constraints.MinWidth := 75;
    LabeledEdit.LabelPosition := lpBelow;
    LabeledEdit.EditLabel.Caption := 'Max HP';

  finally
    FList.Add(Panel);
  end;
end;

function TfrmCombatTracker.FindMyComponent(Parent: TComponent; Name: string): TComponent;
var
  i: integer;
begin
  if Parent.ComponentCount = 0 then
    Exit(nil);
  Result := Parent.FindComponent(Name);
  if Assigned(Result) then
    Exit;
  for I := 0 to Parent.ComponentCount do
  begin
    Result := FindMyComponent(Parent.Components[i], Name);
    if Assigned(Result) then
      Exit;
  end;
end;

end.
