unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Generics.Collections, Data.DB, Datasnap.DBClient;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    tbData: TClientDataSet;
    tbDataid: TIntegerField;
    tbDatainiciativa: TIntegerField;
    tbDatanome: TStringField;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    FList: TObjectList<TPanel>;
    procedure ProximoTurno(AObject: TObject);
  public
    procedure AfterConstruction; override;
    destructor Destroy; override;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.AfterCOnstruction;
begin
  inherited;
  FList := TObjectList<TPanel>.Create;
  tbData.CreateDataSet;

  tbData.Insert;
  tbDataid.AsInteger := 1;
  tbDataIniciativa.AsInteger := Random(100);
  tbDatanome.AsString := 'Ramon';
  tbData.Post;

  tbData.Insert;
  tbDataid.AsInteger := 2;
  tbDataIniciativa.AsInteger := Random(100);
  tbDatanome.AsString := 'Rafael';
  tbData.Post;

  tbData.Insert;
  tbDataid.AsInteger := 3;
  tbDataIniciativa.AsInteger := Random(100);
  tbDatanome.AsString := 'Suianny';
  tbData.Post;

  tbData.Insert;
  tbDataid.AsInteger := 4;
  tbDataIniciativa.AsInteger := Random(100);
  tbDatanome.AsString := 'Vitoria';
  tbData.Post;
end;

procedure TForm1.ProximoTurno(AObject: TObject);
begin
  TPanel(TButton(AObject).Parent).Align := alBottom;
  TPanel(TButton(AObject).Parent).Align := alTop;
  TPanel(TButton(AObject).Parent).Caption := TPanel(TButton(AObject).Parent).Caption + 'Ultimo';
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  Panel: TPanel;
  Edit: TEdit;
  Button: TButton;
  I: Integer;
  OrderData: TArray<Integer>;
begin
  tbData.First;
  while not tbData.Eof do
  begin
    SetLength(OrderData, Length(OrderData) + 1);
    OrderData[High(OrderData)] := tbDatainiciativa.AsInteger;

    tbData.Next;
  end;

  TArray.Sort<Integer>(OrderData);
  for I := 0 to Length(OrderData) -1 do
  begin
    tbData.Locate('iniciativa', OrderData[I], []);

    Panel := TPanel.Create(Self);
    Panel.Parent := Self;
    Panel.Height := 100;
    Panel.Align := alBottom;
    Panel.Align := alTop;
    Panel.Tag := tbDataid.AsInteger;

    Button := TButton.Create(Panel);
    Button.Parent := Panel;
    Button.Align := alRight;
    Button.OnClick := ProximoTurno;

    Edit := TEdit.Create(Panel);
    Edit.Parent := Panel;
    Edit.Align := alLeft;
    Edit.Text := tbDatainiciativa.AsString;

    Edit := TEdit.Create(Panel);
    Edit.Parent := Panel;
    Edit.Align := alClient;
    Edit.Text := tbDatanome.AsString;

    FList.Add(Panel);
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to FList.Count -1 do
    FreeAndNil(FList[I]);

  FList.Clear;
end;

destructor TForm1.Destroy;
begin
  tbData.EmptyDataSet;
  FreeAndNil(FList);
  inherited;
end;

end.
