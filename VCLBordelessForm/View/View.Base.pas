unit View.Base;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls, Vcl.ComCtrls, DwmApi, JvComponentBase, JvWndProcHook, Method.Colors;

type
  TProc    = procedure of Object;
  TBorda   = (bLeft, bTop, bRight, bBottom, bBottomLeft, bBottomRight);

  TfrmBase = class(TForm)
    pnlActionBar: TPanel;
    pnlClose: TPanel;
    imgClose: TImage;
    pnlMinimize: TPanel;
    imgMinimize: TImage;
    pnlPrincipal: TPanel;
    pnlMaximize: TPanel;
    imgMaximize: TImage;
    lblCaption: TLabel;
    pnlTop: TPanel;
    pnlSubCaption: TPanel;
    lblSubCaption: TLabel;
    imgIcon: TImage;
    procedure pnlActionBarMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgCloseClick(Sender: TObject);
    procedure imgMinimizeClick(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgMaximizeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FControleForm: Boolean;
    FSubCaption: String;
    FCaption: String;
    FFormColor: TColor;
    FWndFrameSize: Integer;
    function TipoMouse(ABorda: TBorda): TCursor;
    procedure setControleForm(const Value: Boolean);
    procedure setCaption(const Value: String);
    procedure setSubCaption(const Value: String);
    procedure setFormColor(const Value: TColor);
  public
    constructor Create(AOwner: TComponent; AControlarForm: Boolean = True);
    property ControleForm: Boolean read FControleForm write setControleForm;
    property FormColor: TColor read FFormColor write setFormColor;
  protected
    procedure WmNCCalcSize(var Msg: TWMNCCalcSize); message WM_NCCALCSIZE;
    property Caption: String read FCaption write setCaption;
    property SubCaption: String read FSubCaption write setSubCaption;
  end;

var
  frmBase: TfrmBase;

implementation

{$R *.dfm}

procedure TfrmBase.WmNCCalcSize(var Msg: TWMNCCalcSize);
begin
  Msg.Result := 0;
end;

procedure TfrmBase.FormCreate(Sender: TObject);
begin
  BorderStyle := bsNone;
  SetWindowLong(Handle
               ,GWL_STYLE
               ,WS_CLIPCHILDREN or WS_OVERLAPPEDWINDOW
               );

  FormColor := clPurple;
end;

procedure TfrmBase.FormShow(Sender: TObject);
begin
  Width := (Width - 1);
end;

constructor TfrmBase.Create(AOwner: TComponent; AControlarForm: Boolean = True);
begin
  inherited Create(AOwner);
  ControleForm := AControlarForm;
end;

function TfrmBase.TipoMouse(ABorda: TBorda): TCursor;
begin
  case(ABorda)of
    bLeft, bRight: Result := crSizeWE;
    bTop, bBottom: Result := crSizeNS;
    bBottomLeft:   Result := crSizeNESW;
    bBottomRight:  Result := crSizeNWSE;
  end;
end;

procedure TfrmBase.FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if((Button = mbLeft)and(FControleForm))then
  begin
    ReleaseCapture;

    {Left Bottom}
    if(((X >= 0)and(X <= 8)) and ((Y >= (Self.ClientHeight -8))and(Y <= Self.ClientHeight)))then
    begin
      TForm(Self).Perform(WM_SYSCOMMAND, SC_SIZE + WMSZ_BOTTOMLEFT, 0);
      Exit;
    end;

    {Right Bottom}
    if(((X >= (Self.ClientWidth -8))and(X <= Self.ClientWidth)) and ((Y >= (Self.ClientHeight -8))and(Y <= Self.ClientHeight)))then
    begin
      TForm(Self).Perform(WM_SYSCOMMAND, SC_SIZE + WMSZ_BOTTOMRIGHT, 0);
      Exit;
    end;

    {Left}
    if((X >= 0)and(X <= 8))then
    begin
      TForm(Self).Perform(WM_SYSCOMMAND, SC_SIZE + WMSZ_LEFT, 0);
    end;

    {Right}
    if((X >= (Self.ClientWidth -8))and(X <= Self.ClientWidth))then
    begin
      TForm(Self).Perform(WM_SYSCOMMAND, SC_SIZE + WMSZ_RIGHT, 0);
    end;

    {Bottom}
    if((Y >= (Self.ClientHeight -8))and(Y <= Self.ClientHeight))then
    begin
      TForm(Self).Perform(WM_SYSCOMMAND, SC_SIZE + WMSZ_BOTTOM, 0);
    end;

    {Top}
    if((Y >= 0)and(Y <= 10))then
    begin
      TForm(Self).Perform(WM_SYSCOMMAND, SC_SIZE + WMSZ_TOP, 0);
    end;
  end;
end;

procedure TfrmBase.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if(FControleForm)then
  begin
    {Left}
    if((X >= 0)and(X <= 8))then
    begin
      Self.Cursor := TipoMouse(bLeft);
    end;

    {Right}
    if((X >= (Self.ClientWidth -8))and(X <= Self.ClientWidth))then
    begin
      Self.Cursor := TipoMouse(bRight);
    end;

    {Bottom}
    if((Y >= (Self.ClientHeight -8))and(Y <= Self.ClientHeight))then
    begin
      Self.Cursor := TipoMouse(bBottom);
    end;

    {Top}
    if((Y >= 0)and(Y <= 10))then
    begin
      Self.Cursor := TipoMouse(bTop);
    end;

    {Left Bottom}
    if(((X >= 0)and(X <= 8)) and ((Y >= (Self.ClientHeight -8))and(Y <= Self.ClientHeight)))then
    begin
      Self.Cursor := TipoMouse(bBottomLeft);
    end;

    {Right Bottom}
    if(((X >= (Self.ClientWidth -8))and(X <= Self.ClientWidth)) and ((Y >= (Self.ClientHeight -8))and(Y <= Self.ClientHeight)))then
    begin
      Self.Cursor := TipoMouse(bBottomRight);
    end;
  end;
end;

procedure TfrmBase.imgCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmBase.imgMaximizeClick(Sender: TObject);
begin
  if(Self.Parent = Nil)then
  begin
    if(WindowState = wsNormal)then
      WindowState := TWindowState.wsMaximized
    else
      WindowState := TWindowState.wsNormal;
  end
  else
  begin
    Self.Parent      := Nil;
    Self.Align       := alNone;
    Self.WindowState := wsMaximized;
  end;
end;

procedure TfrmBase.imgMinimizeClick(Sender: TObject);
begin
  WindowState := TWindowState.wsMinimized;
end;

procedure TfrmBase.pnlActionBarMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
const
  sc_DragMove = $f012;
begin
  ReleaseCapture;
  Perform(wm_SysCommand, sc_DragMove, 0);
end;

procedure TfrmBase.setCaption(const Value: String);
begin
  FCaption := Value;
  lblCaption.Caption := FCaption;
  lblCaption.Hint    := FCaption;
end;

procedure TfrmBase.setSubCaption(const Value: String);
begin
  FSubCaption := Value;
  lblSubCaption.Caption := FSubCaption;
  lblSubCaption.Hint    := FSubCaption;
end;

procedure TfrmBase.setControleForm(const Value: Boolean);
begin
  FControleForm                 := Value;
  pnlActionBar.Visible          := FControleForm;
  pnlPrincipal.AlignWithMargins := FControleForm;
end;

procedure TfrmBase.setFormColor(const Value: TColor);
begin
  FFormColor          := Value;
  Self.Color          := FFormColor;
  pnlActionBar.Color  := FFormColor;
  pnlSubCaption.Color := CorEscura(FFormColor);
  lblCaption.Color    := FFormColor;
  lblSubCaption.Color := FFormColor;
  pnlMinimize.Color   := FFormColor;
  pnlMaximize.Color   := FFormColor;
  pnlMaximize.Color   := FFormColor;
end;

end.
