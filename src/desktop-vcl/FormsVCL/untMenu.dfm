object frmMenu: TfrmMenu
  Left = 0
  Top = 0
  Caption = 'Menu de op'#231#245'es'
  ClientHeight = 325
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object CategoryPanelGroup1: TCategoryPanelGroup
    Left = 0
    Top = 0
    Width = 169
    Height = 325
    VertScrollBar.Tracking = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -11
    HeaderFont.Name = 'Tahoma'
    HeaderFont.Style = []
    ParentFont = False
    TabOrder = 0
    object ctpMenu: TCategoryPanel
      Top = 0
      Height = 121
      Caption = 'Controle de Horas'
      TabOrder = 0
      object btnMovimentacaoHoras: TBitBtn
        Left = 0
        Top = 50
        Width = 165
        Height = 25
        Align = alTop
        Caption = 'Movimenta'#231#227'o de horas'
        TabOrder = 0
        OnClick = btnMovimentacaoHorasClick
      end
      object btnTipoAtividade: TBitBtn
        Left = 0
        Top = 0
        Width = 165
        Height = 25
        Align = alTop
        Caption = 'Tipo de Atividade'
        TabOrder = 1
        OnClick = btnTipoAtividadeClick
      end
      object btnCadastroAtividade: TBitBtn
        Left = 0
        Top = 25
        Width = 165
        Height = 25
        Align = alTop
        Caption = 'Cadastro de Atividade'
        TabOrder = 2
        OnClick = btnCadastroAtividadeClick
      end
    end
  end
end
