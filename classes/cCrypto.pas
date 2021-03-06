unit cCrypto;

interface

uses
Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs;

  function Encrypt(const aEntry:string): string;
  function Decrypt(const aEntry:string): string;

implementation

function Encrypt(const aEntry:string): string;
Var i, iEntryQt, iBetween:Integer;
    sExit:String;
    sNextChar :String;
begin
  iBetween:= 6;
  i         := 0;
  iEntryQt  := 0;

  if (aEntry <> EmptyStr) then
  begin
    iEntryQt    := Length(aEntry);
    for i  := iEntryQt downto 1 do //Loop Backwards
    begin
      sNextChar  := Copy(aEntry, i, 1);
      sExit := sExit + (char(ord(sNextChar[1])+iBetween));
    end;
  end;

  Result:= sExit;
end;

function Decrypt(const aEntry:string): string;
Var i, iEntryQt, iBetween:Integer;
    sExit : String;
    sNextChar : String;
begin
  iBetween := 6;
  i          := 0;
  iEntryQt   := 0;
  if (aEntry <> EmptyStr) then begin
    iEntryQt := Length(aEntry);

    for i := iEntryQt downto 1 do
    begin
      sNextChar  := Copy(aEntry, i, 1);
      sExit := sExit + (char(ord(sNextChar[1])-iBetween));
    end;
  end;

  Result:= sExit;
end;


end.
