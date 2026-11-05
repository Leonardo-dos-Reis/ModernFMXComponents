unit CustomComponents.RoundedEdit;

interface

uses
  System.Classes,
  System.UITypes,
  FMX.Controls.Presentation,
  FMX.Dialogs,
  FMX.Types,
  FMX.Controls,
  FMX.Layouts,
  FMX.Edit,
  FMX.Objects,
  FMX.Graphics,
  Winapi.Windows;

type
  TRoundedEdit = class;

  TFillSettings = class(TPersistent)
  private
    FOwnerComponent     : TRoundedEdit;
    FBackgroundColor    : TAlphaColor;
    FBorderColor        : TAlphaColor;

    procedure SetBackgroundColor(const Value : TAlphaColor);
    function GetBackgroundColor : TAlphaColor;

    procedure SetBorderColor(const Value : TAlphaColor);
    function GetBorderColor : TAlphaColor;

  public
    constructor Create(AOwner: TRoundedEdit);
  published
    property BackgroundColor : TAlphaColor read GetBackgroundColor write SetBackgroundColor;
    property BorderColor : TAlphaColor read GetBorderColor write SetBorderColor;
  end;

  TRoundedEdit = class(TLayout)
  protected

  private
    FBackground   : TRoundRect;
    FEdit         : TCustomEdit;
    FFill         : TFillSettings;
    function GetText: String;
    procedure SetText(const Value: String);
    function GetTextPrompt: String;
    procedure SetTextPrompt(const Value: String);

    procedure EditApplyStyleLookup(Sender: TObject);
  public
    constructor Create(AOwner : TComponent); override;
    property Fill: TFillSettings read FFill;

  published
    property Text: String read GetText write SetText;
    property TextPrompt: String read GetTextPrompt write SetTextPrompt;
  end;

implementation

{ TFillSetings }

constructor TFillSettings.Create;
begin
  inherited Create;
  FOwnerComponent := AOwner;
  FBackgroundColor := $FFF7F7F7;
end;

function TFillSettings.GetBackgroundColor : TAlphaColor;
begin
  Result := FBackgroundColor;
end;

procedure TFillSettings.SetBackgroundColor(const Value: TAlphaColor);
begin
  FBackgroundColor := Value;

  if Assigned(FOwnerComponent) and Assigned(FOwnerComponent.FBackground) then
    FOwnerComponent.FBackground.Fill.Color := Value;
end;

procedure TFillSettings.SetBorderColor(const Value: TAlphaColor);
begin
    FBorderColor := Value;

if Assigned(FOwnerComponent) and Assigned(FOwnerComponent.FBackground) then
  FOwnerComponent.FBackground.Stroke.Color := Value;
end;

function TFillSettings.GetBorderColor: TAlphaColor;
begin
  Result := FBorderColor;
end;

{ TRoundedEdit }

constructor TRoundedEdit.Create(AOwner: TComponent);
var
  Obj : TFmxObject;
begin
  inherited Create(AOwner);

  FFill := TFillSettings.Create(Self);

  Width   := 150;
  Height  := 40;

  FBackground               := TRoundRect.Create(Self);
  FBackground.Parent        := Self;
  FBackground.Align         := TAlignLayout.Client;


  FBackground.Fill.Color        := $FFF7F7F7;
  FBackground.Stroke.Color      := $FF555555;
  FBackground.Stroke.Thickness  := 1;

  FBackground.HitTest := False;
  FBackground.ClipChildren := True;

  //Edit

  FEdit           := TEdit.Create(Self);
  FEdit.Parent    := FBackground;
  FEdit.Align     := TAlignLayout.Client;

  FEdit.Margins.Top     := 2;
  FEdit.Margins.Bottom  := 2;
  FEdit.Margins.Left    := 10;
  FEdit.Margins.Right   := 10;

  FEdit.TextPrompt := 'Lorem Ipsum';
  FEdit.StyledSettings := FEdit.StyledSettings - [TStyledSetting.FontColor];
  FEdit.TextSettings.FontColor := $FF202020;
  FEdit.OnApplyStyleLookup := EditApplyStyleLookup;

  FEdit.ApplyStyleLookup;

      FBackground.SendToBack;
end;

procedure TRoundedEdit.EditApplyStyleLookup(Sender: TObject);
var
  Bg: TFmxObject;
begin
  Bg := FEdit.FindStyleResource('background');
  if Bg is TControl then
    TControl(Bg).Visible := False;
end;

function TRoundedEdit.GetText: String;
begin
  Result := FEdit.Text;
end;

function TRoundedEdit.GetTextPrompt: String;
begin
  Result := FEdit.TextPrompt;
end;

procedure TRoundedEdit.SetText(const Value: String);
begin
  FEdit.Text := Value;
end;

procedure TRoundedEdit.SetTextPrompt(const Value: String);
begin
  FEdit.TextPrompt := Value;
end;

end.
