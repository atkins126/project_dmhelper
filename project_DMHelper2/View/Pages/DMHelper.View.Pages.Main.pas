unit DMHelper.View.Pages.Main;

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
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Objects,
  FMX.Layouts,

  Router4D.Interfaces;

type
  TfrmMainPage = class(TForm, iRouter4DComponent)
    layoutMain: TLayout;
    recMain: TRectangle;
    lblPageName: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    function Render : TFMXObject;
    procedure unRender;
  end;

var
  frmMainPage: TfrmMainPage;

implementation

{$R *.fmx}

{ TfrmMainPage }

function TfrmMainPage.Render: TFMXObject;
begin
  Result := layoutMain;
end;

procedure TfrmMainPage.unRender;
begin

end;

end.
