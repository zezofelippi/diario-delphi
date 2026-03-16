object frmTipoAtividade: TfrmTipoAtividade
  Left = 0
  Top = 0
  Caption = 'Tipo atividade'
  ClientHeight = 505
  ClientWidth = 810
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object TPanel
    Left = 0
    Top = 0
    Width = 810
    Height = 81
    Align = alTop
    TabOrder = 0
    ExplicitLeft = -1
    object Label2: TLabel
      Left = 9
      Top = 14
      Width = 20
      Height = 13
      Caption = 'Tipo'
    end
    object edtDescricao: TEdit
      Left = 6
      Top = 33
      Width = 378
      Height = 21
      TabOrder = 0
    end
    object btnSalvar: TButton
      Left = 390
      Top = 29
      Width = 93
      Height = 25
      Caption = 'Salvar'
      TabOrder = 1
      OnClick = btnSalvarClick
    end
    object btnCancelarAlteracao: TButton
      Left = 489
      Top = 29
      Width = 167
      Height = 25
      Caption = 'Cancelar Altera'#231#227'o'
      TabOrder = 2
      OnClick = btnCancelarAlteracaoClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 81
    Width = 810
    Height = 424
    Align = alClient
    TabOrder = 1
    ExplicitTop = 87
    object dbgTipoAtividade: TDBGrid
      Left = 1
      Top = 58
      Width = 808
      Height = 365
      Align = alClient
      DataSource = dtsTipoAtividade
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ParentFont = False
      PopupMenu = popMenu
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindow
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDrawColumnCell = dbgTipoAtividadeDrawColumnCell
      Columns = <
        item
          Expanded = False
          Title.Caption = 'Descri'#231#227'o'
          Title.Color = clNavy
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clBlack
          Title.Font.Height = -16
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = []
          Width = 400
          Visible = True
        end>
    end
    object pnlPesquisa: TPanel
      Left = 1
      Top = 1
      Width = 808
      Height = 57
      Align = alTop
      TabOrder = 1
      ExplicitTop = 6
      object Label1: TLabel
        Left = 5
        Top = 3
        Width = 20
        Height = 13
        Caption = 'Tipo'
      end
      object edtDescricaoPesquisa: TEdit
        Left = 5
        Top = 22
        Width = 375
        Height = 21
        TabOrder = 0
      end
      object btnListar: TButton
        Left = 386
        Top = 17
        Width = 93
        Height = 28
        Caption = 'Listar'
        TabOrder = 1
        OnClick = btnListarClick
      end
    end
  end
  object dtsTipoAtividade: TDataSource
    Left = 376
    Top = 377
  end
  object popMenu: TPopupMenu
    Left = 240
    Top = 361
    object Alterar1: TMenuItem
      Caption = 'Alterar'
      OnClick = Alterar1Click
    end
    object Excluir1: TMenuItem
      Caption = 'Excluir'
      OnClick = Excluir1Click
    end
  end
end
