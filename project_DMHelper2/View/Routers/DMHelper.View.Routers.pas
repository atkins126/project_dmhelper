unit DMHelper.View.Routers;

interface

type
  TRouters = class
    private
    public
      constructor Create;
      destructor Destroy; override;
  end;

var
  Router : TRouters;

implementation

uses
  Router4D,
  DMHelper.View.Pages.Main,
  DMHelper.View.Pages.User;

{ TRouters }

constructor TRouters.Create;
begin
  TRouter4D
    .Switch
    .Router('Main', TfrmMainPage)
    .Router('User', TfrmPageUser);
end;

destructor TRouters.Destroy;
begin

  inherited;
end;

initialization
  Router := TRouters.Create;

finalization
  Router.Free;

end.
