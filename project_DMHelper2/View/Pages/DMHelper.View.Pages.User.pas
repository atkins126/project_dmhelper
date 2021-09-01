unit DMHelper.View.Pages.User;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,

  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Objects,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Layouts,

  Router4D.Interfaces;

type
  TfrmPageUser = class(TForm, iRouter4DComponent)
    layoutUser: TLayout;
    lblPageName: TLabel;
    recMain: TRectangle;
  private
    { Private declarations }
  public
    { Public declarations }
    function Render : TFMXObject;
    procedure unRender;
  end;

var
  frmPageUser: TfrmPageUser;

implementation

{$R *.fmx}

{ TfrmPageUser }

function TfrmPageUser.Render: TFMXObject;
begin
  Result := layoutUser;
end;

procedure TfrmPageUser.unRender;
begin

end;

end.
