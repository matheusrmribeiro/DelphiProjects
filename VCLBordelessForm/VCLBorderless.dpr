program VCLBorderless;

uses
  Vcl.Forms,
  View.Principal in 'View\View.Principal.pas' {ViewHome},
  View.Base in 'View\View.Base.pas' {frmBase};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TViewHome, ViewHome);
  Application.CreateForm(TfrmBase, frmBase);
  Application.Run;
end.
