unit cCampaigns;

interface

uses System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs, System.SysUtils,
      FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
      FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
      FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
      FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite,
      FireDAC.Comp.UI;

type
  TCampaigns = class
    private
    {private declarations}
      ConnectionDB : TFDConnection;
      F_campaignId : Integer;
      F_name : String;
      F_description : String;
      F_master_user_id : Integer;
    function getCampaignId: Integer;
    function getDescription: String;
    function getName: String;
    function getUserId: Integer;
    procedure setCampaignId(const Value: Integer);
    procedure setDescription(const Value: String);
    procedure setUserId(const Value: Integer);
    procedure setName(const Value: String);
    public
    {public declarations}
      constructor Create(aConnection:TFDConnection);
      destructor Destroy; override;

      function Save : Boolean;
      function Update : Boolean;
      function Delete : Boolean;
      function Select(id:Integer) : Boolean;

    published
      property campaignId : Integer read getCampaignId write setCampaignId;
      property name : String read getName write setName;
      property description : String read getDescription write setDescription;
      property userId : Integer read getUserId write setUserId;
  end;

implementation

{ TCampaigns }

{$region 'CONSTRUCTOR AND DESTRUCTOR'}
constructor TCampaigns.Create(aConnection:TFDConnection);
begin
  ConnectionDB := aConnection;
end;

destructor TCampaigns.Destroy;
begin

  inherited;
end;
{$endregion}

{$region 'CRUD'}
function TCampaigns.Save: Boolean;
var
  Qry : TFDQuery;
begin
  try
    Result := True;
    Qry := TFDQuery.Create(nil);
    Qry.Connection := ConnectionDB;
    Qry.SQL.Text := 'INSERT INTO campaign ( '+
                           'name, '+
                           'description '+
                         ' ) '+
                         ' VALUES ( '+
                           ' :name,'+
                           ' :description '+
                         ' )';
    Qry.ParamByName('name').AsString := Self.F_name;
    Qry.ParamByName('description').AsString := Self.F_description;

    Try
      ConnectionDB.StartTransaction;
      Qry.ExecSQL;
      ConnectionDB.Commit;
    Except
      ConnectionDB.Rollback;
      Result := False;
    End;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry)
  end;
end;

function TCampaigns.Delete: Boolean;
var
  Qry : TFDQuery;
begin
  if MessageDlg('Delete campaign:' +#13+#13+ 'ID:'+IntToStr(F_campaignId)+#13+
                'Campaign Name: ' +F_name,mtConfirmation,[mbYes, mbNo],0) = MrNo then
  begin
    Result := False;
    Abort;
  end;


  try
    Result := True;
    Qry := TFDQuery.Create(nil);
    Qry.Connection := ConnectionDB;
    Qry.SQL.Text :=
      'DELETE FROM campaign '+
          ' WHERE id=:id ';
    Qry.ParamByName('id').AsInteger := F_campaignId;

    Try
      ConnectionDB.StartTransaction;
      Qry.ExecSQL;
      ConnectionDB.Commit;
    Except
      Result := False;
      ConnectionDB.Rollback;
    End;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry)
  end;
end;

function TCampaigns.Update: Boolean;
var
  Qry : TFDQuery;
begin
  try
    Result := True;
    Qry := TFDQuery.Create(nil);
    Qry.Connection := ConnectionDB;
    Qry.SQL.Text :=
      'UPDATE campaign '+
          ' SET name=:name, description=:description '+
          ' WHERE id=:id ';
    Qry.ParamByName('id').AsInteger := Self.F_campaignId;
    Qry.ParamByName('name').AsString := Self.F_name;
    Qry.ParamByName('description').AsString := Self.F_description;

    Try
      ConnectionDB.StartTransaction;
      Qry.ExecSQL;
      ConnectionDB.Commit;
    Except
      Result := False;
      ConnectionDB.Rollback;
    End;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry)
  end;
end;

function TCampaigns.Select(id: Integer): Boolean;
var
  Qry : TFDQuery;
begin
  try
    Result := True;
    Qry := TFDQuery.Create(nil);
    Qry.Connection := ConnectionDB;
    Qry.SQL.Text :=
      'SELECT '+
          'c.id, '+
          'c.name, '+
          'c.description, '+
          't.master_user_id, '+
          't.master_username '+
      'FROM  '+
          'campaign c '+
          'LEFT JOIN ( '+
              'SELECT '+
                  'u.id  as master_user_id, '+
                  'u.name as master_username,'+
                  'uc.campaign_id '+
              'FROM '+
                  'user u  '+
                  'INNER JOIN user_campaign as uc on u.id = uc.user_id '+
              'WHERE '+
                  'u.user_type = 1 '+
          ') t on  c.id = t.campaign_id '+
        'WHERE c.id = :id';
    Qry.ParamByName('id').AsInteger := id;

    Try
      ConnectionDB.StartTransaction;
      Qry.Open;
      Self.F_campaignId := Qry.FieldByName('id').AsInteger;
      Self.F_name := Qry.FieldByName('name').AsString;
      Self.F_description := Qry.FieldByName('description').AsString;
      Self.F_master_user_id := Qry.FieldByName('master_user_id').AsInteger;
      ConnectionDB.Commit;
    Except
      Result := False;
      ConnectionDB.Rollback;
    End;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry)
  end;
end;
{$endregion}

{$region 'GETS AND SETS'}

function TCampaigns.getCampaignId: Integer;
begin
  Result := Self.F_campaignId;
end;

function TCampaigns.getDescription: String;
begin
  Result := Self.F_description;
end;

function TCampaigns.getName: String;
begin
  Result := Self.F_name;
end;

function TCampaigns.getUserId: Integer;
begin
  Result := Self.F_master_user_id;
end;

procedure TCampaigns.setCampaignId(const Value: Integer);
begin
  Self.F_campaignId := Value;
end;

procedure TCampaigns.setDescription(const Value: String);
begin
  Self.F_description := Value;
end;

procedure TCampaigns.setName(const Value: String);
begin
  Self.F_name := Value;
end;

procedure TCampaigns.setUserId(const Value: Integer);
begin
  Self.F_master_user_id := Value;
end;
{$endregion}

end.
