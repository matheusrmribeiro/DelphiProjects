inherited ViewHome: TViewHome
  Caption = 'Home'
  ClientHeight = 201
  ClientWidth = 447
  ExplicitWidth = 453
  ExplicitHeight = 230
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlPrincipal: TPanel
    Width = 437
    Height = 126
    ExplicitWidth = 437
    ExplicitHeight = 126
  end
  inherited pnlTop: TPanel
    Width = 437
    ExplicitWidth = 437
    inherited pnlActionBar: TPanel
      Width = 431
      ExplicitWidth = 431
      inherited pnlClose: TPanel
        Left = 400
        ExplicitLeft = 400
      end
      inherited pnlMinimize: TPanel
        Left = 338
        ExplicitLeft = 338
      end
      inherited pnlMaximize: TPanel
        Left = 369
        ExplicitLeft = 369
      end
    end
    inherited pnlSubCaption: TPanel
      Width = 437
      ExplicitWidth = 437
      inherited lblSubCaption: TLabel
        Width = 424
        Height = 17
      end
    end
  end
end
