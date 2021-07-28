unit cUserReg;

interface

uses System.Classes, Vcl.Controls, Vcl.ExtCtrls,Vcl.Dialogs,System.SysUtils,
     FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
     FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
     FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, cCrypto;

type
  TUser = class
  private
    dbConnection:TFDConnection;
    F_id : Integer;
    F_username : String;
    F_password : String;
    function getPassword : String;
    procedure setPassword(const Value : String);

  public
    constructor Create(aConnection : TFDConnection);
    destructor Destroy; override;
    function Insert : Boolean;
    function Update : Boolean;
    function Delete : Boolean;
    function Select(id:Integer) : Boolean;
    function ExistingUser(aUser:String):Boolean;
    function ChangePassword: Boolean;
    function Login(aUser:String; aPassword:String):Boolean;

  published
    property id : Integer read F_id write F_id;
    property username : string read F_username write F_username;
    property password : string read getPassword write setPassword;

  end;

implementation


{$region 'Constructor and Destructor'}
constructor TUser.Create(aConnection : TFDConnection);
begin
  dbConnection := TFDConnection.Create(nil);
end;

destructor TUser.Destroy;
begin
  FreeAndNil(dbConnection);
  inherited;
end;
{$endRegion}

{$region 'CRUD'}
function TUser.Delete: Boolean;
var Qry:TFDQuery;
begin
  if MessageDlg('Delete the register: '+#13+#13+
                'ID: '+IntToStr(F_id)+#13+
                'Username: '  +F_username,mtConfirmation,[mbYes, mbNo],0)=mrNo then begin
     Result:=false;
     abort;
  end;

  try
    Result:=true;
    Qry:=TFDQuery.Create(nil);
    Qry.Connection:=dbConnection;
    Qry.SQL.Clear;
    Qry.SQL.Add('DELETE FROM user '+
                ' WHERE id=:id ');
    Qry.ParamByName('id').AsInteger :=F_id;
    Try
      dbConnection.StartTransaction;
      Qry.ExecSQL;
      dbConnection.Commit;
    Except
      dbConnection.Rollback;
      Result:=false;
    End;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;

function TUser.Update: Boolean;
var Qry:TFDQuery;
begin
  try
    Result:=true;
    Qry:=TFDQuery.Create(nil);
    Qry.Connection:=dbConnection;
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE user '+
                '   SET name           =:name '+
                '       ,password         =:password '+
                ' WHERE id=:id ');
    Qry.ParamByName('id').AsInteger       :=Self.F_id;
    Qry.ParamByName('name').AsString             :=Self.F_username;
    Qry.ParamByName('password').AsString            :=Self.F_password;

    Try
      dbConnection.StartTransaction;
      Qry.ExecSQL;
      dbConnection.Commit;
    Except
      dbConnection.Rollback;
      Result:=false;
    End;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;

function TUser.Insert: Boolean;
var Qry:TFDQuery;
begin
  try
    Result:=true;
    Qry:=TFDQuery.Create(nil);
    Qry.Connection:=dbConnection;
    Qry.SQL.Clear;
    Qry.SQL.Add('INSERT INTO user (name, '+
                '                      password )'+
                ' VALUES              (:name, '+
                '                      :password )' );

    Qry.ParamByName('name').AsString             :=Self.F_username;
    Qry.ParamByName('password').AsString            :=Self.F_password;

    Try
      dbConnection.StartTransaction;
      Qry.ExecSQL;
      dbConnection.Commit;
    Except
      dbConnection.Rollback;
      Result:=false;
    End;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;

function TUser.Select(id: Integer): Boolean;
var Qry:TFDQuery;
begin
  try
    Result:=true;
    Qry:=TFDQuery.Create(nil);
    Qry.Connection:=dbConnection;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT id,'+
                '       name, '+
                '       password '+
                '  FROM user '+
                ' WHERE id=:id');
    Qry.ParamByName('id').AsInteger:=id;
    Try
      Qry.Open;

      Self.F_id     := Qry.FieldByName('id').AsInteger;
      Self.F_username          := Qry.FieldByName('name').AsString;
      Self.F_password         := Qry.FieldByName('password').AsString;;
    Except
      Result:=false;
    End;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;

function TUser.ExistingUser(aUser:String):Boolean;
var Qry:TFDQuery;
begin
  try
    Qry:=TFDQuery.Create(nil);
    Qry.Connection:=dbConnection;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT COUNT(id) AS Qt '+
                '  FROM user '+
                ' WHERE name =:name ');
    Qry.ParamByName('name').AsString :=aUser;
    Try
      Qry.Open;

      if Qry.FieldByName('Qt').AsInteger>0 then
         result := true
      else
         result := false;

    Except
      Result:=false;
    End;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;

{$endregion}

{$region 'GET E SET'}

function TUser.getPassword: String;
begin
  Result := Decrypt(Self.F_password);
end;

procedure TUser.setPassword(const Value: String);
begin
  Self.F_password := Encrypt(Value);
end;
{$endregion}

{$region 'LOGIN'}
function TUser.Login(aUser:String; aPassword:String):Boolean;
var Qry:TFDQuery;
begin
  try
    Qry:=TFDQuery.Create(nil);
    Qry.Connection:=dbConnection;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT id, '+
                '       name, '+
                '       password '+
                '  FROM user '+
                ' WHERE name=:name '+
                '   AND password=:password');
    Qry.ParamByName('name').AsString :=aUser;
    Qry.ParamByName('password').AsString:=Encrypt(aPassword);
    Try
      Qry.Open;

      if Qry.FieldByName('id').AsInteger>0 then begin
         result := true;
         F_id:= Qry.FieldByName('usuarioId').AsInteger;
         F_username     := Qry.FieldByName('name').AsString;
         F_password    := Qry.FieldByName('password').AsString;
      end
      else
         result := false;

    Except
      Result:=false;
    End;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;
{$endregion}

{$region 'CHANGE PASSWORD'}
function TUser.ChangePassword: Boolean;
var Qry:TFDQuery;
begin
  try
    Result:=true;
    Qry:=TFDQuery.Create(nil);
    Qry.Connection:=dbConnection;
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE user '+
                '   SET password =:password '+
                ' WHERE id=:id ');
    Qry.ParamByName('id').AsInteger       :=Self.F_id;
    Qry.ParamByName('password').AsString            :=Self.F_password;

    Try
      dbConnection.StartTransaction;
      Qry.ExecSQL;
      dbConnection.Commit;
    Except
      dbConnection.Rollback;
      Result:=false;
    End;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;

{$endregion}


end.
