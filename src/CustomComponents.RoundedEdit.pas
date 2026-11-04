unit CustomComponents.RoundedEdit;

interface

uses
  System.Classes,
  System.UITypes,
  FMX.Types,
  FMX.Controls,
  FMX.Layouts,
  FMX.Edit,
  FMX.Objects,
  FMX.Graphics;

type
  TRoundedEdit = class(TLayout)
  protected

  private
    FBackground : TRoundRect;
  public
    constructor Create(AOwner : TComponent); override;
  published

  end;

implementation

{ TRoundedEdit }

constructor TRoundedEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width := 150;
  Height := 40;

  FBackground := TRoundRect.Create(Self);
  FBackground.Parent := Self;
  FBackground.Align := TAlignLayout.Client;
end;

end.
