unit DMHelper.MainScreen.View;

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
  FMX.Layouts,
  FMX.Objects,
  FMX.Controls.Presentation,
  FMX.StdCtrls;

type
  TfrmMain = class(TForm)
    layoutMain: TLayout;
    layoutFull: TLayout;
    layoutMenu: TLayout;
    recMenu: TRectangle;
    btnPrincipal: TSpeedButton;
    btnUsuario: TSpeedButton;
    layoutTop: TLayout;
    recTop: TRectangle;
    recMain: TRectangle;
    procedure FormCreate(Sender: TObject);
  private
    procedure ApplyStyle;
    { Private declarations }
  public
    { Public declarations }

  end;

var
  frmMain: TfrmMain;

implementation

uses
  DMHelper.View.Styles.Colors,
  DMHelper.View.Pages.Main,
  Router4D;

{$R *.fmx}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
   TRouter4D.Render<TfrmMainPage>.SetElement(layoutMain);
    ApplyStyle;
end;

procedure TfrmMain.ApplyStyle;
var
  Settings: ITextSettings;
  Instance: TComponent;
  I: Integer;
begin
  recMain.Fill.Color := COLOR_BACKGROUND;
  recMenu.Fill.Color := COLOR_BACKGROUND_MENU;
  recTop.Fill.Color := COLOR_BACKGROUND_TOP;
  //recLogo.Fill.Color := COLOR_BACKGROUND_DESTAK;

  for I := 0 to ComponentCount - 1 do
  begin
    Instance := Components[i];
    if IInterface(Instance).QueryInterface(ITextSettings, Settings) = S_OK then
    begin
      Settings.TextSettings.BeginUpdate;
      try
        Settings.DefaultTextSettings.Font.Size := FONT_H6;
        Settings.DefaultTextSettings.Font.Family := FONT;
        Settings.DefaultTextSettings.FontColor := FONT_COLOR;
      finally
        Settings.TextSettings.EndUpdate;
      end;
    end;
  end;
end;

end.
