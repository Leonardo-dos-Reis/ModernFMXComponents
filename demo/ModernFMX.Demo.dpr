program ModernFMX.Demo;

uses
  System.StartUpCopy,
  FMX.Forms,
  Demo.MainForm in 'Demo.MainForm.pas' {frmModernFMXComponents},
  CustomComponents.RoundedEdit in '..\src\CustomComponents.RoundedEdit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmModernFMXComponents, frmModernFMXComponents);
  Application.Run;
end.
