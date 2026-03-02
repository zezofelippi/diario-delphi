unit untMovimentacaoHoras;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFormBase, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.DBCtrls, uTipoAtividadeRepository, uTipoAtividadeService, uAtividadeRepository, uAtividadeService,
  uTipoAtividadeController, uAtividadeController, Data.DB, Vcl.ComCtrls,
  Vcl.Mask, Datasnap.Provider, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, uMensagem,
  uMovimentacaoHorasController, uMovimentacaoHorasRepository, uMovimentacaoHorasService, Vcl.Menus,
  FireDAC.Comp.Client, System.Generics.Collections, uMovimentacaoHorasModel,
  uMovimentacaoHorasRepositoryFireDac, uAtividadeModel, uAtividadeRepositoryFireDac,
  uTipoAtividadeRepositoryFireDac, uTipoAtividadeModel, uListagem, uMovimentacaoHorasGerarHtml,
  System.IOUtils, Winapi.ShellAPI, uFuncoesGerais;

type
  TfrmMovimentacaoHoras = class(TfrmFormBase)
    pnlCadastrarHora: TPanel;
    edtTipoAtividade: TDBLookupComboBox;
    Label1: TLabel;
    Label2: TLabel;
    edtAtividade: TDBLookupComboBox;
    dtsTipoAtividade: TDataSource;
    dtsAtividade: TDataSource;
    edtData: TDateTimePicker;
    edtQtde_horas: TMaskEdit;
    edtAcordar: TMaskEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtObs: TEdit;
    btnSalvar: TButton;
    pnlPesquisar: TPanel;
    lcbTipoAtividadePesquisa: TDBLookupComboBox;
    lcbAtividadePesquisa: TDBLookupComboBox;
    edtDataInicial: TDateTimePicker;
    edtDataFinal: TDateTimePicker;
    edtObsPesquisa: TEdit;
    btnListar: TButton;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    dtsTipoAtividadePesquisa: TDataSource;
    dtsAtividadePesquisa: TDataSource;
    grdMovimentacaoHoras: TDBGrid;
    btnCancelarAlteracao: TButton;
    popMenu: TPopupMenu;
    Alterar1: TMenuItem;
    cdsMovimentacaoHoras: TClientDataSet;
    dtsMovimentacaoHoras: TDataSource;
    pnlRodape: TPanel;
    edtDias: TEdit;
    edtIntervaloDatas: TEdit;
    btnGerarHtm: TButton;
    saveDialog: TSaveDialog;
    btnGerarPdf: TButton;
    openDialog: TOpenDialog;
    Label10: TLabel;
    Label11: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure edtTipoAtividadeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtAtividadeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dtsTipoAtividadeDataChange(Sender: TObject; Field: TField);
    procedure dtsTipoAtividadePesquisaDataChange(Sender: TObject;
      Field: TField);
    procedure btnSalvarClick(Sender: TObject);
    procedure Alterar1Click(Sender: TObject);
    procedure btnCancelarAlteracaoClick(Sender: TObject);
    procedure btnListarClick(Sender: TObject);
    procedure lcbTipoAtividadePesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lcbAtividadePesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdMovimentacaoHorasDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure grdMovimentacaoHorasTitleClick(Column: TColumn);
    procedure btnGerarHtmClick(Sender: TObject);
    procedure btnGerarPdfClick(Sender: TObject);
    procedure edtAtividadeExit(Sender: TObject);
    procedure edtDataExit(Sender: TObject);


  private
    FTipoAtividadeController: TTipoAtividadeController;
    FAtividadeController : TAtividadeController;
    FMovimentacaoHorasController: TMovimentacaoHorasController;
    FListagem: TListagem;
    FId: integer;
    procedure alimentarAtividadeComboBox(idTipoAtividade: integer; tipo: TTipoListagem);
    //procedure alimentarTipoAtividadeComboBox;
  public
    { Public declarations }
  end;

var
  frmMovimentacaoHoras: TfrmMovimentacaoHoras;

implementation

{$R *.dfm}

procedure TfrmMovimentacaoHoras.alimentarAtividadeComboBox(
  idTipoAtividade: integer; tipo: TTipoListagem);
begin

  if tipo = tlAtividade then
  begin
    if idTipoAtividade > 0 then
    begin
      FListagem.cdsAtividade.Filtered := False;
      FListagem.cdsAtividade.Filter := 'ID_TIPOATIVIDADE = ' + inttostr(idTipoAtividade);
      FListagem.cdsAtividade.Filtered := True;
    end
    else if idTipoAtividade = 0 then
    begin
      FListagem.cdsAtividade.Filtered := False;
      FListagem.cdsAtividade.Filter := '';
    end;
  end
  else if tipo = tlAtividadePesquisa then
  begin
    if idTipoAtividade > 0 then
    begin
      FListagem.cdsAtividadePesquisa.Filtered := False;
      FListagem.cdsAtividadePesquisa.Filter := 'ID_TIPOATIVIDADE = ' + inttostr(idTipoAtividade);
      FListagem.cdsAtividadePesquisa.Filtered := True;
    end
    else if idTipoAtividade = 0 then
    begin
      FListagem.cdsAtividadePesquisa.Filtered := False;
      FListagem.cdsAtividadePesquisa.Filter := '';
    end;
  end;

end;

procedure TfrmMovimentacaoHoras.Alterar1Click(Sender: TObject);
var
  celulaSelecionada: TMovimentacaoHoras;
begin
  //aqui é importante, caso esteja outro tipo selecionado, a atividade nao vai ser selecionada p/ alterar
  edtTipoAtividade.KeyValue:= null;
  alimentarAtividadeComboBox(0, tlAtividade);
  //FIM aqui é importante, caso esteja outro tipo selecionado, a atividade nao vai ser selecionada p/ alterar

  FId:= FListagem.cdsAtividade.FieldByName('ID').AsInteger;

  celulaSelecionada:= FMovimentacaoHorasController.selecionarCelula(
               cdsMovimentacaoHoras.FieldByName('DATA').AsDateTime,
               grdMovimentacaoHoras.SelectedField.FieldName);

  edtAtividade.KeyValue := celulaSelecionada.atividade.id;
  edtAcordar.text := FormatDateTime('hh:nn', celulaSelecionada.acordar);
  edtData.Date := celulaSelecionada.data;
  edtQtde_horas.Text := FormatDateTime('hh:nn', celulaSelecionada.qtdeHoras);
  edtObs.Text := celulaSelecionada.obs;

  btnSalvar.Caption:='Alterar';
  btnCancelarAlteracao.Enabled:= true;

end;

procedure TfrmMovimentacaoHoras.btnCancelarAlteracaoClick(Sender: TObject);
begin
  FId:=0;
  btnSalvar.Caption:='Salvar';
  btnCancelarAlteracao.Enabled:= false;
  limparEdits(self);
end;

procedure TfrmMovimentacaoHoras.btnGerarHtmClick(Sender: TObject);
var
  gerarHtml: TMovimentacaoHorasGerarHtml;
  lista: TObjectList<TMovimentacaoHoras>;
  mov : TMovimentacaoHoras;
  cdsLocal: TClientDataSet;
  atividadeObs: TObjectList<TAtividade>;
begin
  if (lcbTipoAtividadePesquisa.Text = '') or (lcbAtividadePesquisa.Text = '') then
  begin
    messagedlg('Tipo de Atividade e Atividade precisam estar preenchidos', mtInformation, [mbOK],0);
    exit;
  end;

  gerarHtml:= TMovimentacaoHorasGerarHtml.Create;
  cdsLocal:= TClientDataSet.Create(nil);

  lista:= FMovimentacaoHorasController.listar(lcbTipoAtividadePesquisa.KeyValue,
                                              lcbAtividadePesquisa.KeyValue,
                                              edtDataInicial.Date,
                                              edtDataFinal.Date,
                                              edtObsPesquisa.Text);
  try
    cdsLocal.close;
    cdsLocal.FieldDefs.Clear;
    cdsLocal.FieldDefs.Add('DATA', ftDateTime, 0, false);
    cdsLocal.FieldDefs.Add('OBS', ftString, 500, false);
    cdsLocal.FieldDefs.Add('QTDE_HORAS', ftTime, 0, false);
    cdsLocal.CreateDataSet;

    for mov in lista do
    begin
      cdsLocal.Append;
      cdsLocal.FieldByName('DATA').AsDateTime := mov.Data;
      cdsLocal.FieldByName('OBS').AsString := mov.obs;
      cdsLocal.FieldByName('QTDE_HORAS').AsDateTime := mov.qtdeHoras;
      cdsLocal.Post;
    end;

  finally
   lista.Free;
  end;

  cdsLocal.IndexFieldNames:= 'DATA';

  ////PESQUISA TOTAL HORAS///////////////
  lista:= FMovimentacaoHorasController.calcularTotalHorasPorColuna(lcbTipoAtividadePesquisa.KeyValue,
                                                                   lcbAtividadePesquisa.KeyValue,
                                                                   edtDataInicial.Date,
                                                                   edtDataFinal.Date,
                                                                   edtObsPesquisa.Text);
  ////FIM PESQUISA TOTAL HORAS///////////////



  ////PESQUISAR OBS DE ATIVIDADE//////
  atividadeObs:= FAtividadeController.listar(lcbAtividadePesquisa.KeyValue,
                                             lcbTipoAtividadePesquisa.KeyValue, '');

  ////FIM PESQUISAR OBS DE ATIVIDADE//////

  try
    if saveDialog.Execute then
    begin
      TFile.WriteAllText(saveDialog.FileName, gerarHtml.gerarHTML(cdsLocal,
                         lcbTipoAtividadePesquisa.Text,
                         lcbAtividadePesquisa.Text,
                         atividadeObs.Items[0].obs,
                         lista.Items[0].totalHoras,
                         edtDataInicial.Date,
                         edtDataFinal.Date), TEncoding.UTF8);
    end;
  finally
    cdsLocal.Free;
    gerarHtml.Free;
    atividadeObs.Free;
    lista.Free;
  end;
end;


procedure TfrmMovimentacaoHoras.btnGerarPdfClick(Sender: TObject);
var
  caminhoHTML, caminhoPDF, WKPath: string;
begin

  //////Seleciona HTML/////////
  if not openDialog.Execute then
    Exit;

  caminhoHTML := openDialog.FileName;
  //////FIM Seleciona HTML/////////

  //////Sugere nome do PDF baseado no HTML//////
  saveDialog.FileName :=
    ChangeFileExt(ExtractFileName(CaminhoHTML), '.pdf');

  if not saveDialog.Execute then
    Exit;

  caminhoPDF := saveDialog.FileName;
  //////FIM Sugere nome do PDF baseado no HTML//////

  WKPath := '"C:\Program Files\wkhtmltopdf\bin\wkhtmltopdf.exe"';

  ShellExecute(0,
               'open',
               PChar(WKPath),
               PChar('"' + caminhoHTML + '" "' + caminhoPDF + '"'),
               nil,
               SW_HIDE);

end;

procedure TfrmMovimentacaoHoras.btnListarClick(Sender: TObject);
var
  queryLocal, queryLocalAux: TFDQuery;

  Horas, Minutos, TotalMinutos, TotalHoras, qtde_dias, i, idTipoAtividade, idAtividade: Integer;
  qtde_horas_total, atividadePesq, nomeColuna, dataStr, filtro: string;
  qtde_horas : TTime;

  lista: TObjectList<TMovimentacaoHoras>;
  cdsLocal, cdsLocalAux: TClientDataSet;
  mov : TMovimentacaoHoras;
begin
  cdsMovimentacaoHoras.Filtered := false;
  cdsMovimentacaoHoras.IndexFieldNames := '';

  // TIPO ATIVIDADE
  if VarToStr(lcbTipoAtividadePesquisa.KeyValue) <> '' then
    idTipoAtividade:= lcbTipoAtividadePesquisa.KeyValue
  else
    idTipoAtividade:= 0;

  // ATIVIDADE
  if VarToStr(lcbAtividadePesquisa.KeyValue) <> '' then
    idAtividade:= lcbAtividadePesquisa.KeyValue
  else
    idAtividade:= 0;


  lista:= FMovimentacaoHorasController.listar(idTipoAtividade,
                                              idAtividade,
                                              edtDataInicial.Date,
                                              edtDataFinal.Date,
                                              edtObsPesquisa.Text);

  try

    cdsLocal :=TClientDataSet.Create(self);

    cdsLocal.close;
    cdsLocal.FieldDefs.Clear;
    cdsLocal.FieldDefs.Add('ID', ftInteger, 0, false);
    cdsLocal.FieldDefs.Add('DATA', ftDateTime, 0, false);
    cdsLocal.FieldDefs.Add('QTDE_HORAS', ftTime, 0, false);
    cdsLocal.FieldDefs.Add('ACORDAR', ftTime, 0, false);
    cdsLocal.FieldDefs.Add('OBS', ftString, 200, false);
    cdsLocal.FieldDefs.Add('ID_ATIVIDADE', ftInteger, 0,  false);
    cdsLocal.FieldDefs.Add('DESCRICAO', ftString, 100, false);
    cdsLocal.FieldDefs.Add('ID_TIPOATIVIDADE', ftInteger, 0, false);
    cdsLocal.CreateDataSet;

    for mov in lista do
    begin
      cdsLocal.Append;
      cdsLocal.FieldByName('ID').AsInteger := mov.Id;
      cdsLocal.FieldByName('DATA').AsDateTime := mov.Data;
      cdsLocal.FieldByName('QTDE_HORAS').AsDateTime := mov.qtdeHoras;
      cdsLocal.FieldByName('ACORDAR').AsDateTime := mov.acordar;
      cdsLocal.FieldByName('OBS').AsString := mov.obs;
      cdsLocal.FieldByName('ID_ATIVIDADE').AsInteger := mov.atividade.id;
      cdsLocal.FieldByName('DESCRICAO').AsString := mov.atividade.descricao;
      cdsLocal.FieldByName('ID_TIPOATIVIDADE').AsInteger := mov.atividade.tipoAtividade.id;
      cdsLocal.Post;
    end;

  finally
    cdsLocal.EnableControls;
  end;

  cdsLocal.IndexFieldNames:= 'DESCRICAO';

  /////TITULOS DA GRID////////////
  cdsMovimentacaoHoras.close;
  cdsMovimentacaoHoras.FieldDefs.Clear;
  cdsMovimentacaoHoras.FieldDefs.Add('DATA', ftString, 18, false);

  cdsLocal.First;
  while not cdsLocal.eof do
  begin
    if cdsMovimentacaoHoras.FieldDefs.IndexOf(cdsLocal.fieldbyname('DESCRICAO').asstring) = -1 then //Verifica se coluna já foi registrada
         cdsMovimentacaoHoras.FieldDefs.Add(cdsLocal.fieldbyname('DESCRICAO').asstring, ftString, 10, false);

    cdsLocal.Next;
  end;

  cdsMovimentacaoHoras.FieldDefs.Add('TOTAL', ftString, 10, false);
  cdsMovimentacaoHoras.FieldDefs.Add('ACORDAR', ftString, 10, false);
  cdsMovimentacaoHoras.CreateDataSet;
  /////FIM TITULOS DA GRID////////////


  /////INSERI A QUANTIDADE DE HORAS DE CADA ATIVIDADE
  TotalMinutos := 0;

  cdsLocal.IndexFieldNames:= 'DATA';

  cdsMovimentacaoHoras.EmptyDataSet;

  cdsLocalAux := TClientDataSet.Create(self);
  cdsLocalAux.Close;
  cdsLocalAux.CloneCursor(cdsLocal, True);

  cdsLocal.first;
  dataStr:= '01/01/1900';

  while not cdsLocal.Eof do
  begin
    if cdsLocal.fieldbyname('DATA').asstring = '06/02/2026' then
      filtro:='';

    if (cdsLocal.fieldbyname('DATA').asstring <> '') and
       (cdsLocal.fieldbyname('DATA').asstring <> dataStr) AND
       (cdsLocal.FieldByName('QTDE_HORAS').AsDateTime <> 0) then
    begin
      i := 0;
      dataStr:= cdsLocal.fieldbyname('DATA').asstring;
      cdsMovimentacaoHoras.Append;
      cdsMovimentacaoHoras.FieldByName('DATA').AsString := cdsLocal.fieldbyname('DATA').asstring;

      cdsLocalAux.Filtered := False;

      filtro:= '';

      //DATA
      if cdsLocal.fieldbyname('DATA').AsDateTime <> 0 then
      begin
        Filtro := Filtro +
          'DATA = ' + QuotedStr(FormatDateTime('dd/mm/yyyy',
          cdsLocal.FieldByName('DATA').AsDateTime));
      end;

      // TIPO ATIVIDADE
      if VarToStr(lcbTipoAtividadePesquisa.KeyValue) <> '' then
      begin
        if filtro <> '' then
          filtro := filtro + ' AND ';

        filtro := filtro +
          'ID_TIPOATIVIDADE = ' +
          IntToStr(lcbTipoAtividadePesquisa.KeyValue);
      end;

      // ATIVIDADE
      if VarToStr(lcbAtividadePesquisa.KeyValue) <> '' then
      begin
        if filtro <> '' then
          filtro := filtro + ' AND ';

        filtro := filtro +
          'ID_ATIVIDADE = ' +
          IntToStr(lcbAtividadePesquisa.KeyValue);
      end;

      // OBS
      if Trim(edtObsPesquisa.Text) <> '' then
      begin
        if filtro <> '' then
          filtro := filtro + ' AND ';

        filtro := filtro +
          'OBS LIKE ' +
          QuotedStr('%' + edtObsPesquisa.Text + '%');
      end;

      cdsLocalAux.Filter := filtro;
      cdsLocalAux.Filtered := True;
      cdsLocalAux.IndexFieldNames:= 'DESCRICAO';

      qtde_horas:=0;

      while (i < grdMovimentacaoHoras.Columns.Count) do
      begin
        nomeColuna := grdMovimentacaoHoras.Columns[i].FieldName;

        if (nomeColuna <> 'DATA') and (nomeColuna <> 'TOTAL') and (nomeColuna = cdsLocalAux.fieldbyname('DESCRICAO').asstring) then
        begin
          IF (cdsLocalAux.fieldbyname('OBS').asstring <> '') then
            cdsMovimentacaoHoras.FieldByName(nomeColuna).AsString := cdsLocalAux.fieldbyname('QTDE_HORAS').asstring + '_'
          ELSE
            cdsMovimentacaoHoras.FieldByName(nomeColuna).AsString := cdsLocalAux.fieldbyname('QTDE_HORAS').asstring;

          if cdsLocalAux.fieldbyname('QTDE_HORAS').asstring <> '' then
          begin
            qtde_horas:= qtde_horas + StrToTime(cdsLocalAux.fieldbyname('QTDE_HORAS').asstring);//soma horas por dia

            // Converte 'HH:MM' para horas e minutos
            Horas := StrToInt(Copy(cdsLocalAux.fieldbyname('QTDE_HORAS').asstring, 1, Pos(':', cdsLocalAux.fieldbyname('QTDE_HORAS').asstring) - 1)); // Pega a parte das horas
            Minutos := StrToInt(Copy(cdsLocalAux.fieldbyname('QTDE_HORAS').asstring, Pos(':', cdsLocalAux.fieldbyname('QTDE_HORAS').asstring) + 1, 2));

            // Soma tudo em minutos
            TotalMinutos := TotalMinutos + (Horas * 60) + Minutos;
          end;

          cdsLocalAux.Next;
        end;
        cdsMovimentacaoHoras.FieldByName('TOTAL').AsString := timetostr(qtde_horas);
        Inc(i);  // Incrementa o índice
      end;

      cdsMovimentacaoHoras.FieldByName('ACORDAR').AsString := cdsLocalAux.fieldbyname('ACORDAR').asstring;

      cdsMovimentacaoHoras.post;
    end;
    cdsLocal.Next;
  end;

  cdsMovimentacaoHoras.Append;
  cdsMovimentacaoHoras.post;
 /////FIM INSERI A QUANTIDADE DE HORAS DE CADA ATIVIDADE



 /////CALCULAR TOTAL HORA POR COLUNA/////////////
  cdsMovimentacaoHoras.Append;
  qtde_horas := 0;

  lista:= FMovimentacaoHorasController.calcularTotalHorasPorColuna(idTipoAtividade,
                idAtividade,
                edtDataInicial.Date, edtDataFinal.Date, edtObsPesquisa.Text);



  cdsLocalAux.Free;
  cdsLocalAux := TClientDataSet.Create(self);
  cdsLocalAux.FieldDefs.Clear;
  cdsLocalAux.Fields.Clear;
  cdsLocalAux.FieldDefs.Add('DESCRICAO', ftString, 100, false);
  cdsLocalAux.FieldDefs.Add('TOTALHORAS', ftString, 8, false);
  cdsLocalAux.CreateDataSet;

  try

    for mov in lista do
    begin
      cdsLocalAux.Append;
      cdsLocalAux.FieldByName('DESCRICAO').AsString := mov.atividade.descricao;
      cdsLocalAux.FieldByName('TOTALHORAS').AsString := mov.totalHoras;
      cdsLocalAux.Post;
    end;

  finally
    cdsLocalAux.EnableControls;
    Lista.Free;
  end;

  cdsLocalAux.First;
  while not cdsLocalAux.Eof do
  begin
    cdsMovimentacaoHoras.fieldbyname(cdsLocalAux.fieldbyname('DESCRICAO').asstring).asstring:= cdsLocalAux.fieldbyname('TOTALHORAS').asstring;
    cdsLocalAux.Next;
  end;
  /////FIM CALCULAR TOTAL HORA POR COLUNA/////////////

  /////CALCULAR TOTAL GERAL///////////
  // Converte de volta para HH:MM, garantindo que pode ultrapassar 24 horas
  TotalHoras := TotalMinutos div 60;
  TotalMinutos := TotalMinutos mod 60;

  qtde_horas_total := Format('%d:%2.2d', [TotalHoras, TotalMinutos]);

  cdsMovimentacaoHoras.FieldByName('DATA').AsString := 'TOTAL';
  cdsMovimentacaoHoras.FieldByName('TOTAL').AsString :=  qtde_horas_total;
  cdsMovimentacaoHoras.post;
  /////FIM CALCULAR TOTAL GERAL///////////


  ///////CALCULAR QUANTIDADE DE DIAS PESQUISADOS/////////////////////
  edtDias.Text := inttostr(cdsMovimentacaoHoras.RecordCount - 2); //-2 é para NAO contar linha verde escuro e TOTAL
  qtde_dias := diasEntreDatas(edtDataInicial.Date, edtDataFinal.Date);
  edtIntervaloDatas.text := IntToStr(qtde_dias);
  ///////FIM CALCULAR QUANTIDADE DE DIAS PESQUISADOS/////////////////////

end;

procedure TfrmMovimentacaoHoras.btnSalvarClick(Sender: TObject);
var
  resposta: TMensagem;
  qtdeHoras, acordar: TTime;
  idAtividade: integer;
  lista: TObjectList<TMovimentacaoHoras>;
begin

  ////VERIFICA SE QTDE_HORAS E ACORDAR ESTÃO VAZIOS E SE ESTÃO COM FORMATO VÁLIDO, ACIMA DE 23:59 ERRO
  ///  A VALIDAÇÃO DO FORMATO É IMPORTANTE AQUI PORQUE OS CAMPOS SÃO TTime que só aceita até 23:59
  try
    if verificarTimeMaskEditVazio(edtQtde_horas) then
      qtdeHoras:=0
    else
      qtdeHoras:= StrToTime(edtQtde_horas.Text);

    if verificarTimeMaskEditVazio(edtAcordar) then
      acordar:=0
    else
      acordar:= StrToTime(edtAcordar.Text);
  except
    on E: EConvertError do
    begin
      MessageDlg('Horário inválido. Verifique o formato.',
               mtError,
               [mbOK],
               0);
      exit;
    end;
  end;
  ////FIM VERIFICA SE QTDE_HORAS E ACORDAR ESTÃO VAZIOS E SE ESTÃO COM FORMATO VÁLIDO, ACIMA DE 23:59 ERRO

  if edtAtividade.KeyValue = null then
    idAtividade:=0
  else
    idAtividade:= edtAtividade.KeyValue;

  //verificar se atividade ja foi inserida na mesma data
  if (qtdeHoras <> 0) then //qtdeHoras for = 0, ele deverá passar no salvar do service p/ entrar na validação e retornar mensagem de qtde_horas vazio
  begin
    lista:= FMovimentacaoHorasController.listar(0, edtAtividade.KeyValue,
                          edtData.Date, edtData.Date, edtObsPesquisa.Text);

    if lista.Count > 0 then
    begin
      FId:= lista[0].Id; //aqui o FID é inserido um  ID e vai direto p/ alteração do registro do repository
      if (btnSalvar.Caption = 'Salvar') then
        qtdeHoras:= qtdeHoras + lista[0].qtdeHoras;
    end;

    lista.Free;
  end;
  //FIM verificar se atividade ja foi inserida na mesma data

  try
    resposta := FMovimentacaoHorasController.salvar(FId, idAtividade, edtData.Date,
               qtdeHoras, acordar, edtObs.Text);
  except
    on E: Exception do
    begin
      LogErro(E);
      MessageDlg('Erro ao acessar banco de dados: ', mtError, [mbOK],0);
      exit;
    end;
  end;

  if resposta.campo <> '' then
  begin
    messagedlg(resposta.mensagem, mtWarning, [mbOK],0);
    focoComponente(resposta.campo);
    exit;
  end;
  limparEdits(self);
  FId:=0;
  btnSalvar.Caption:= 'Salvar';
  btnCancelarAlteracao.Enabled:= false;

end;

procedure TfrmMovimentacaoHoras.dtsTipoAtividadeDataChange(Sender: TObject;
  Field: TField);
var
  idTipoAtividade: integer;
begin
  if edtTipoAtividade.KeyValue = null then
    idTipoAtividade:= 0
  else
    idTipoAtividade:= edtTipoAtividade.KeyValue;

  alimentarAtividadeComboBox(idTipoAtividade, tlAtividade);

end;

procedure TfrmMovimentacaoHoras.dtsTipoAtividadePesquisaDataChange(
  Sender: TObject; Field: TField);
var
  idTipoAtividade: integer;
begin
  if lcbTipoAtividadePesquisa.KeyValue = null then
    idTipoAtividade:= 0
  else
    idTipoAtividade:= lcbTipoAtividadePesquisa.KeyValue;

  alimentarAtividadeComboBox(idTipoAtividade, tlAtividadePesquisa);

end;

procedure TfrmMovimentacaoHoras.edtAtividadeExit(Sender: TObject);
var
  lista: TObjectList<TMovimentacaoHoras>;
begin
  if (edtAtividade.text = '') then
    exit;

  try
    lista:= FMovimentacaoHorasController.listar(0,
                                              edtAtividade.KeyValue,
                                              edtData.Date,
                                              edtData.Date,
                                              '');

    if lista.Count > 0 then
      edtObs.Text:= lista.Items[0].obs
    else
      edtObs.Clear;
  finally
    lista.Free;
  end;

end;

procedure TfrmMovimentacaoHoras.edtAtividadeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  IF KEY =VK_back then
  begin
    edtAtividade.KeyValue := null;
  end;

end;

procedure TfrmMovimentacaoHoras.edtDataExit(Sender: TObject);
var
  lista: TObjectList<TMovimentacaoHoras>;
begin
  if (edtAtividade.text = '') then
    exit;

  try
    lista:= FMovimentacaoHorasController.listar(0,
                                              edtAtividade.KeyValue,
                                              edtData.Date,
                                              edtData.Date,
                                              '');
  if lista.Count > 0 then
    edtObs.Text:= lista.Items[0].obs
  else
    edtObs.Clear;
  finally
    lista.Free;
  end;


end;

procedure TfrmMovimentacaoHoras.edtTipoAtividadeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  IF KEY =VK_back then
  begin
    edtTipoAtividade.KeyValue := null;
    alimentarAtividadeComboBox(0, tlAtividade);
  end;

end;

procedure TfrmMovimentacaoHoras.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
//  listagem.destroy;
  FListagem.Free;
  FAtividadeController.Free;
  FTipoAtividadeController.Free;
  FMovimentacaoHorasController.Free;
  frmMovimentacaoHoras := nil;
end;

procedure TfrmMovimentacaoHoras.FormCreate(Sender: TObject);
var
  movimentacaoHorasRepository: TMovimentacaoHorasRepositoryFireDac;
  movimentacaoHorasService: TMovimentacaoHorasService;

  atividadeRepository: TAtividadeRepositoryFireDac;
  atividadeService: TAtividadeService;

  tipoAtividadeRepository: TTipoAtividadeRepositoryFireDac;
  tipoAtividadeService: TTipoAtividadeService;

begin
  inherited;

  ////INSTANCIANDO MOVIMENTACAO HORAS////////////////
  movimentacaoHorasRepository:= TMovimentacaoHorasRepositoryFireDac.Create;
  movimentacaoHorasService := TMovimentacaoHorasService.create(movimentacaoHorasRepository);
  FMovimentacaoHorasController:= TMovimentacaoHorasController.create(movimentacaoHorasService);
  ////FIM INSTANCIANDO MOVIMENTACAO HORAS////////////////


  /////INSTANCIANDO ATIVIDADE////////////////////////
  atividadeRepository:= TAtividadeRepositoryFireDac.Create;
  atividadeService := TAtividadeService.create(atividadeRepository);
  FAtividadeController:= TAtividadeController.create(atividadeService);
  /////FIM INSTANCIANDO ATIVIDADE////////////////////////

  /////INSTANCIANDO TIPO ATIVIDADE////////////////////////
  tipoAtividadeRepository:= TTipoAtividadeRepositoryFireDac.Create();
  tipoAtividadeService := TTipoAtividadeService.create(tipoAtividadeRepository);
  FTipoAtividadeController:= TTipoAtividadeController.create(tipoAtividadeService);
  /////FIM INSTANCIANDO TIPO ATIVIDADE////////////////////////


  FListagem:= TListagem.create(FAtividadeController, FTipoAtividadeController);

  ////ALIMENTANDO DBLOOKUPCOMBOBOX ATIVIDADE////////
  FListagem.alimentarAtividade(tlAtividade);
  dtsAtividade.DataSet:= FListagem.cdsAtividade;
  FListagem.alimentarAtividade(tlAtividadePesquisa);
  dtsAtividadePesquisa.DataSet:= FListagem.cdsAtividadePesquisa;
  FListagem.cdsAtividade.IndexFieldNames:= 'DESCRICAO';
  FListagem.cdsAtividadePesquisa.IndexFieldNames:= 'DESCRICAO';

  edtAtividade.KeyField:= 'ID';
  edtAtividade.ListField:= 'DESCRICAO';
  lcbAtividadePesquisa.KeyField:= 'ID';
  lcbAtividadePesquisa.ListField:= 'DESCRICAO';
  ////FIM ALIMENTANDO DBLOOKUPCOMBOBOX ATIVIDADE////////


  ////ALIMENTANDO DBLOOKUPCOMBOBOX TIPO ATIVIDADE////////
  FListagem.alimentarTipoAtividade;
  dtsTipoAtividade.DataSet:= FListagem.cdsTipoAtividade;
  dtsTipoAtividadePesquisa.DataSet:= FListagem.cdsTipoAtividade;
  FListagem.cdsTipoAtividade.IndexFieldNames:= 'DESCRICAO';

  edtTipoAtividade.KeyField:= 'ID';
  edtTipoAtividade.ListField:= 'DESCRICAO';
  lcbTipoAtividadePesquisa.KeyField:= 'ID';
  lcbTipoAtividadePesquisa.ListField:= 'DESCRICAO';
  ////FIM ALIMENTANDO DBLOOKUPCOMBOBOX TIPO ATIVIDADE/////////

  FId := 0;

  edtData.Date:= now;
  edtDataInicial.Date:= now;
  edtDataFinal.Date:= now;

  btnSalvar.Caption:='Salvar';
  btnCancelarAlteracao.Enabled:= false;

  self.Width:= 1350;
  self.Height:= 780;

  edtObs.Width:=1200;

end;

procedure TfrmMovimentacaoHoras.grdMovimentacaoHorasDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  caracter: string;
  Texto: string;
  TextoLargura, TextoAltura, PosX, PosY: Integer;
begin

  with grdMovimentacaoHoras.Canvas do
  begin
    Font.Style := [];
    Font.Size := 12;
    Brush.Color := clWindow;
    Font.Color := clWindowText;

    // ----- Cabeçalho -----
    if gdFixed in State then
    begin
      Font.Style := [fsBold];
      FillRect(Rect);

      Texto := Column.Title.Caption;
      PosX := Rect.Left + ((Rect.Width - TextWidth(Texto)) div 2);
      PosY := Rect.Top + ((Rect.Height - TextHeight(Texto)) div 2);

      TextRect(Rect, PosX, PosY, Texto);
      Exit;
    end;

    // ----- Células normais -----
    Texto := Column.Field.AsString;

    // Se estiver selecionado
    if gdSelected in State then
    begin
      Brush.Color := clHighlight;
      Font.Color := clHighlightText;
    end
    else
    begin
      if Copy(Texto, Length(Texto), 1) = '_' then
        Brush.Color := clAqua;

      if cdsMovimentacaoHoras.FieldByName('DATA').AsString = '' then
        Brush.Color := clGreen;

      if cdsMovimentacaoHoras.FieldByName('DATA').AsString = 'TOTAL' then
        Font.Style := [fsBold];
    end;

    FillRect(Rect);

    PosX := Rect.Left + ((Rect.Width - TextWidth(Texto)) div 2);
    PosY := Rect.Top + ((Rect.Height - TextHeight(Texto)) div 2);

    TextRect(Rect, PosX, PosY, Texto);
  end;

end;

procedure TfrmMovimentacaoHoras.grdMovimentacaoHorasTitleClick(Column: TColumn);
begin
  cdsMovimentacaoHoras.IndexFieldNames:= column.fieldname;
end;

procedure TfrmMovimentacaoHoras.lcbAtividadePesquisaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   IF KEY =VK_back then
  begin
    lcbAtividadePesquisa.KeyValue := null;
  end;
end;

procedure TfrmMovimentacaoHoras.lcbTipoAtividadePesquisaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  IF KEY =VK_back then
  begin
    lcbTipoAtividadePesquisa.KeyValue := null;
    alimentarAtividadeComboBox(0, tlAtividadePesquisa);
  end;
end;

end.



