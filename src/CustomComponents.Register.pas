unit CustomComponents.Register;

interface

procedure Register;

implementation

uses
  System.Classes,
  CustomComponents.RoundedEdit;

procedure Register;
begin
  RegisterComponents('ModernFMXComponents', [TRoundedEdit]);
end;

end.
