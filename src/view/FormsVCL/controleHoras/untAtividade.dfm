object frmAtividade: TfrmAtividade
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Atividade'
  ClientHeight = 504
  ClientWidth = 875
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 875
    Height = 157
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 4
      Width = 128
      Height = 16
      Caption = 'Descri'#231#227'o da atividade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 8
      Top = 47
      Width = 97
      Height = 16
      Caption = 'OBS da atividade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 9
      Top = 91
      Width = 99
      Height = 16
      Caption = 'Tipo de Atividade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edtDescricao: TEdit
      Left = 8
      Top = 21
      Width = 386
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object edtObs: TEdit
      Left = 8
      Top = 61
      Width = 558
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object btnSalvar: TButton
      Left = 400
      Top = 104
      Width = 162
      Height = 25
      Caption = 'Salvar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = btnSalvarClick
    end
    object edtTipoAtividade: TDBLookupComboBox
      Left = 8
      Top = 108
      Width = 386
      Height = 21
      ListSource = dtsTipoAtividade
      TabOrder = 2
      OnKeyDown = edtTipoAtividadeKeyDown
    end
    object btnCancelarAlteracao: TButton
      Left = 584
      Top = 104
      Width = 217
      Height = 25
      Caption = 'Cancelar Altera'#231#227'o'
      TabOrder = 4
      OnClick = btnCancelarAlteracaoClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 157
    Width = 875
    Height = 347
    Align = alClient
    TabOrder = 1
    object Label3: TLabel
      Left = 8
      Top = 9
      Width = 83
      Height = 13
      Caption = 'Tipo de Atividade'
    end
    object Label4: TLabel
      Left = 249
      Top = 11
      Width = 109
      Height = 13
      Caption = 'Descri'#231#227'o da Atividade'
    end
    object btnListar: TButton
      Left = 646
      Top = 29
      Width = 118
      Height = 29
      Caption = 'Listar'
      TabOrder = 2
      OnClick = btnListarClick
    end
    object dbgAtividade: TJvDBUltimGrid
      Left = 1
      Top = 55
      Width = 873
      Height = 291
      Align = alBottom
      DataSource = dtsAtividade
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      PopupMenu = popMenu
      TabOrder = 3
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDrawColumnCell = dbgAtividadeDrawColumnCell
      OnTitleClick = dbgAtividadeTitleClick
      SelectColumnsDialogStrings.Caption = 'Select columns'
      SelectColumnsDialogStrings.OK = '&OK'
      SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
      EditControls = <>
      RowsHeight = 17
      TitleRowHeight = 17
      SortWith = swFields
      Columns = <
        item
          Expanded = False
          Title.Caption = 'Descri'#231#227'o'
          Width = 300
          Visible = True
        end
        item
          Expanded = False
          Title.Caption = 'OBS'
          Width = 350
          Visible = True
        end
        item
          Expanded = False
          Title.Caption = 'Tipo atividade'
          Width = 180
          Visible = True
        end>
    end
    object lcbTipoAtividadePesquisa: TDBLookupComboBox
      Left = 8
      Top = 33
      Width = 233
      Height = 21
      ListSource = dtsTipoAtividade
      TabOrder = 0
      OnKeyDown = lcbTipoAtividadePesquisaKeyDown
    end
    object edtDescricaoPesquisa: TEdit
      Left = 247
      Top = 33
      Width = 393
      Height = 21
      TabOrder = 1
    end
  end
  object dtsAtividade: TDataSource
    DataSet = cdsAtividade
    Left = 392
    Top = 288
  end
  object dtsTipoAtividade: TDataSource
    Left = 72
    Top = 125
  end
  object popMenu: TPopupMenu
    Left = 56
    Top = 269
    object Alterar1: TMenuItem
      Caption = 'Alterar'
      OnClick = Alterar1Click
    end
    object Excluir1: TMenuItem
      Caption = 'Excluir'
      OnClick = Excluir1Click
    end
  end
  object dspAtividade: TDataSetProvider
    Left = 392
    Top = 357
  end
  object cdsAtividade: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 472
    Top = 325
  end
end
