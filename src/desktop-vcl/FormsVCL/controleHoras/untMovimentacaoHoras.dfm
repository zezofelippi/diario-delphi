inherited frmMovimentacaoHoras: TfrmMovimentacaoHoras
  Caption = 'Movimenta'#231#227'o de Horas'
  ClientHeight = 571
  ClientWidth = 869
  ExplicitWidth = 885
  ExplicitHeight = 610
  PixelsPerInch = 96
  TextHeight = 13
  object pnlCadastrarHora: TPanel
    Left = 0
    Top = 0
    Width = 869
    Height = 188
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 11
      Top = 16
      Width = 83
      Height = 13
      Caption = 'Tipo de Atividade'
    end
    object Label2: TLabel
      Left = 227
      Top = 16
      Width = 45
      Height = 13
      Caption = 'Atividade'
    end
    object Label3: TLabel
      Left = 587
      Top = 16
      Width = 38
      Height = 13
      Caption = 'Acordar'
    end
    object Label4: TLabel
      Left = 11
      Top = 74
      Width = 23
      Height = 13
      Caption = 'Data'
    end
    object Label5: TLabel
      Left = 208
      Top = 74
      Width = 32
      Height = 13
      Caption = 'Tempo'
    end
    object Label6: TLabel
      Left = 11
      Top = 125
      Width = 20
      Height = 13
      Caption = 'OBS'
    end
    object edtTipoAtividade: TDBLookupComboBox
      Left = 11
      Top = 35
      Width = 201
      Height = 21
      ListSource = dtsTipoAtividade
      TabOrder = 0
      OnKeyDown = edtTipoAtividadeKeyDown
    end
    object edtAtividade: TDBLookupComboBox
      Left = 218
      Top = 35
      Width = 353
      Height = 21
      ListSource = dtsAtividade
      TabOrder = 1
      OnExit = edtAtividadeExit
      OnKeyDown = edtAtividadeKeyDown
    end
    object edtData: TDateTimePicker
      Left = 11
      Top = 93
      Width = 161
      Height = 21
      Date = 46058.000000000000000000
      Time = 0.687450150457152600
      TabOrder = 3
      OnExit = edtDataExit
    end
    object edtQtde_horas: TMaskEdit
      Left = 195
      Top = 93
      Width = 77
      Height = 21
      EditMask = '!90:00;1;_'
      MaxLength = 5
      TabOrder = 4
      Text = '  :  '
    end
    object edtAcordar: TMaskEdit
      Left = 587
      Top = 35
      Width = 89
      Height = 21
      EditMask = '!90:00;1;_'
      MaxLength = 5
      TabOrder = 2
      Text = '  :  '
    end
    object edtObs: TEdit
      Left = 11
      Top = 144
      Width = 665
      Height = 21
      MaxLength = 500
      TabOrder = 5
    end
    object btnSalvar: TButton
      Left = 464
      Top = 85
      Width = 143
      Height = 34
      Caption = 'Salvar'
      TabOrder = 6
      OnClick = btnSalvarClick
    end
    object btnCancelarAlteracao: TButton
      Left = 613
      Top = 84
      Width = 145
      Height = 35
      Caption = 'Cancelar Altera'#231#227'o'
      TabOrder = 7
      OnClick = btnCancelarAlteracaoClick
    end
  end
  object pnlPesquisar: TPanel
    Left = 0
    Top = 188
    Width = 869
    Height = 134
    Align = alTop
    TabOrder = 1
    object Label7: TLabel
      Left = 11
      Top = 14
      Width = 83
      Height = 13
      Caption = 'Tipo de Atividade'
    end
    object Label8: TLabel
      Left = 275
      Top = 15
      Width = 45
      Height = 13
      Caption = 'Atividade'
    end
    object Label9: TLabel
      Left = 11
      Top = 66
      Width = 20
      Height = 13
      Caption = 'OBS'
    end
    object lcbTipoAtividadePesquisa: TDBLookupComboBox
      Left = 11
      Top = 33
      Width = 255
      Height = 21
      ListSource = dtsTipoAtividadePesquisa
      TabOrder = 0
      OnKeyDown = lcbTipoAtividadePesquisaKeyDown
    end
    object lcbAtividadePesquisa: TDBLookupComboBox
      Left = 275
      Top = 34
      Width = 322
      Height = 21
      ListSource = dtsAtividadePesquisa
      TabOrder = 1
      OnKeyDown = lcbAtividadePesquisaKeyDown
    end
    object edtDataInicial: TDateTimePicker
      Left = 604
      Top = 32
      Width = 125
      Height = 21
      Date = 46058.000000000000000000
      Time = 0.701073182870459300
      TabOrder = 2
    end
    object edtDataFinal: TDateTimePicker
      Left = 746
      Top = 32
      Width = 114
      Height = 21
      Date = 46058.000000000000000000
      Time = 0.701268368058663300
      TabOrder = 3
    end
    object edtObsPesquisa: TEdit
      Left = 11
      Top = 85
      Width = 449
      Height = 21
      TabOrder = 4
    end
    object btnListar: TButton
      Left = 466
      Top = 82
      Width = 126
      Height = 28
      Caption = 'Listar'
      TabOrder = 5
      OnClick = btnListarClick
    end
    object btnGerarHtm: TButton
      Left = 613
      Top = 81
      Width = 130
      Height = 29
      Caption = 'Gerar HTML'
      TabOrder = 6
      OnClick = btnGerarHtmClick
    end
    object btnGerarPdf: TButton
      Left = 749
      Top = 81
      Width = 114
      Height = 29
      Caption = 'Gerar PDF'
      TabOrder = 7
      OnClick = btnGerarPdfClick
    end
  end
  object grdMovimentacaoHoras: TDBGrid
    Left = 0
    Top = 322
    Width = 869
    Height = 177
    Align = alClient
    DataSource = dtsMovimentacaoHoras
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    PopupMenu = popMenu
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDrawColumnCell = grdMovimentacaoHorasDrawColumnCell
    OnTitleClick = grdMovimentacaoHorasTitleClick
  end
  object pnlRodape: TPanel
    Left = 0
    Top = 499
    Width = 869
    Height = 72
    Align = alBottom
    TabOrder = 3
    object Label10: TLabel
      Left = 11
      Top = 24
      Width = 123
      Height = 13
      Caption = 'Qtde de dias pesquisados'
    end
    object Label11: TLabel
      Left = 253
      Top = 24
      Width = 151
      Height = 13
      Caption = 'Intervalo de datas pesquisadas'
    end
    object edtDias: TEdit
      Left = 11
      Top = 43
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object edtIntervaloDatas: TEdit
      Left = 253
      Top = 43
      Width = 149
      Height = 21
      TabOrder = 1
    end
  end
  object dtsTipoAtividade: TDataSource
    OnDataChange = dtsTipoAtividadeDataChange
    Left = 144
    Top = 8
  end
  object dtsAtividade: TDataSource
    Left = 400
    Top = 8
  end
  object dtsTipoAtividadePesquisa: TDataSource
    OnDataChange = dtsTipoAtividadePesquisaDataChange
    Left = 144
    Top = 212
  end
  object dtsAtividadePesquisa: TDataSource
    Left = 376
    Top = 212
  end
  object popMenu: TPopupMenu
    Left = 80
    Top = 344
    object Alterar1: TMenuItem
      Caption = 'Alterar'
      OnClick = Alterar1Click
    end
    object Excluir1: TMenuItem
      Caption = 'Excluir'
      OnClick = Excluir1Click
    end
  end
  object cdsMovimentacaoHoras: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 616
    Top = 352
  end
  object dtsMovimentacaoHoras: TDataSource
    DataSet = cdsMovimentacaoHoras
    Left = 480
    Top = 352
  end
  object saveDialog: TSaveDialog
    DefaultExt = 'html'
    Filter = 'Arquivo HTML (*.html)|*.html'
    Title = 'Salvar relat'#243'rio'
    Left = 368
    Top = 352
  end
  object openDialog: TOpenDialog
    DefaultExt = 'html'
    Filter = 'arquivos html|*.html'
    Left = 296
    Top = 368
  end
end
