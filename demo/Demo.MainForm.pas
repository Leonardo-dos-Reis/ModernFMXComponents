unit Demo.MainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts;

type
  TfrmModernFMXComponents = class(TForm)
    lytContainerCenter: TLayout;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmModernFMXComponents: TfrmModernFMXComponents;

implementation

uses
  CustomComponents.RoundedEdit;

{$R *.fmx}

procedure TfrmModernFMXComponents.FormCreate(Sender: TObject);
var
  LEditCustom : TRoundedEdit;
begin
  LEditCustom := TRoundedEdit.Create(Self);
  LEditCustom.Parent := lytContainerCenter;
  LEditCustom.Align := TAlignLayout.Client;
end;

end.
