unit CustomComponents.TRectangleHoverButton;

interface

uses
  System.Classes,
  System.UITypes,
  FMX.Controls,
  FMX.Objects,
  FMX.Types;

type TRectangleHoverButton = class(TRectangle)
  protected
    procedure DoMouseEnter; override;
    procedure DoMouseLeave; override;

  public
    constructor Create(AOwner : TComponent); override;

  published

  property XRadius;
  property YRadius;
end;

implementation

{ TRectangleHoverButton }

constructor TRectangleHoverButton.Create(AOwner: TComponent);
begin
  inherited;

  Width := 120;
  Height := 40;
  HitTest := True;


end;


procedure TRectangleHoverButton.DoMouseEnter;
begin
  inherited;
  Fill.Color := TAlphaColors.Dimgray;
end;

procedure TRectangleHoverButton.DoMouseLeave;
begin
  inherited;
  Fill.Color := TAlphaColors.Gray;
end;

end.
