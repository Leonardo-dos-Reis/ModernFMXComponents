unit CustomComponents.RoundedEdit;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UITypes,
  FMX.Controls,
  FMX.Edit,
  FMX.Graphics,
  FMX.Layouts,
  FMX.Objects,
  FMX.Text,
  FMX.Types;

type
  TRoundedEdit = class;
//  TStrokeSettings = class;

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

//  TStrokeSettings = class

  TRoundedEdit = class(TLayout)
  protected

  private
    FBackground   : TRoundRect;
    FEdit         : TEdit;
    FFill         : TFillSettings;
    FOnlyNumbers  : Boolean;

    function GetText: String;
    procedure SetText(const Value: String);

    function GetTextPrompt: String;
    procedure SetTextPrompt(const Value: String);

    procedure SetTextSettings(const Value: TTextSettings);
    function GetTextSettings: TTextSettings;

    procedure EditApplyStyleLookup(Sender: TObject);

    procedure SetOnlyNumbers(const Value : Boolean);
    procedure FilterNumbers(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
  public
    constructor Create(AOwner : TComponent); override;
    destructor  Destroy; override;
  published
    property Text: String read GetText write SetText;
    property TextPrompt: String read GetTextPrompt write SetTextPrompt;
    property TextSettings: TTextSettings read GetTextSettings write SetTextSettings;

    property Fill: TFillSettings read FFill;
//    property Stroke : TStrokeSettings read FStroke;

    property OnlyNumbers : Boolean read FOnlyNumbers write SetOnlyNumbers;
  end;

implementation

const
  DEFAULT_BACKGROUND_COLOR    : TAlphaColor = $FFF7F7F7;
  DEFAULT_BORDER_COLOR        : TAlphaColor = $FF555555;

{ TFillSetings }

constructor TFillSettings.Create(AOwner: TRoundedEdit);
begin
  inherited Create;
  FOwnerComponent  := AOwner;
  FBackgroundColor := DEFAULT_BACKGROUND_COLOR;
  FBorderColor     := DEFAULT_BORDER_COLOR;
end;

function TFillSettings.GetBackgroundColor : TAlphaColor;
begin
  Result := FBackgroundColor;
end;

procedure TFillSettings.SetBackgroundColor(const Value: TAlphaColor);
begin
  FBackgroundColor := Value;

  if Assigned(FOwnerComponent) and Assigned(FOwnerComponent.FBackground) then
  begin
    FOwnerComponent.FBackground.Fill.Color := Value;
  end;
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
  FBackground.Stored        := False;
  FBackground.Parent        := Self;
  FBackground.Align         := TAlignLayout.Client;


  FBackground.Fill.Color        := FFill.BackgroundColor;
  FBackground.Stroke.Color      := FFill.BorderColor;
  FBackground.Stroke.Thickness  := 1;

  FBackground.HitTest := False;
  FBackground.ClipChildren := True;

  //Edit

  FEdit           := TEdit.Create(Self);
  FEdit.Stored    := False;
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
  FEdit.StyleLookup := 'transparentedit';

  FEdit.ApplyStyleLookup;

      FBackground.SendToBack;
end;

destructor TRoundedEdit.Destroy;
begin
  FFill.Free;
  inherited;
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

function TRoundedEdit.GetTextSettings: TTextSettings;
begin
  Result := FEdit.TextSettings;
end;

procedure TRoundedEdit.SetTextSettings(const Value: TTextSettings);
begin
  FEdit.TextSettings.Assign(Value);
end;

procedure TRoundedEdit.SetOnlyNumbers(const Value: Boolean);
begin
  FOnlyNumbers := Value;

  if FOnlyNumbers then
    FEdit.OnKeyDown := FilterNumbers
  else
    FEdit.OnKeyDown := nil;
end;

procedure TRoundedEdit.FilterNumbers(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if not (CharInSet(KeyChar, ['0'..'9', #8])) then
    begin
     KeyChar := #0;
      Key := 0; // Anula a tecla
    end;
end;

end.
