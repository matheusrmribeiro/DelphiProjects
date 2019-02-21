unit View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, View.Base, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TViewHome = class(TfrmBase)
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  ViewHome: TViewHome;

implementation

{$R *.dfm}

procedure TViewHome.FormCreate(Sender: TObject);
begin
  inherited;
  ControleForm := True;
end;

end.
