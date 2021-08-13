program proj_dmhelper;

uses
  System.StartUpCopy,
  FMX.Forms,
  project_dmhelper in 'project_dmhelper.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
