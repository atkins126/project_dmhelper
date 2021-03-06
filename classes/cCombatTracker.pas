unit cCombatTracker;

interface

uses System.Classes, Vcl.Controls, Vcl.ExtCtrls,Vcl.Dialogs,System.SysUtils,
     FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
     FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
     FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, cCrypto;

type
  TCombatTracker = class
  private
    dbConnection:TFDConnection;
    F_initiativeValue : Integer;
    F_monsterName : String;
    F_monsterHP : Integer;
    F_roundCounter : Integer;
    F_turnCounter : Integer;

  public
    constructor Create(aConnection : TFDConnection);
    destructor Destroy; override;

  published

  end;

implementation

uses uCombatTracker;

end.
