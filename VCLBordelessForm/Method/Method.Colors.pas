unit Method.Colors;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls, Vcl.ComCtrls, DwmApi, JvComponentBase, JvWndProcHook,
  System.ImageList, Vcl.ImgList, Generics.Collections;

type
  TType = (tDark, tLight);

function CorEscura(AColor: TColor; AType: TType = tDark): TColor;

implementation

function CorEscura(AColor: TColor; AType: TType = tDark): TColor;
var
  sNewColor: String;
  function getNewColor(AValue: Byte): String;
  var
    iNewValue: Integer;
  begin
    if(AType = tDark)then
    begin
      iNewValue := (AValue - 15);
      if(iNewValue < 0)then
        iNewValue := 0;
    end
    else
    begin
      iNewValue := (AValue + 15);
      if(iNewValue > 255)then
        iNewValue := 255;
    end;
    Result := IntToHex(iNewValue, 2);
  end;
begin
  sNewColor := ('$'
               +getNewColor(GetBValue(AColor))
               +getNewColor(GetGValue(AColor))
               +getNewColor(GetRValue(AColor)));

  Result := StringToColor(sNewColor);
end;

end.
