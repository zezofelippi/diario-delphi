//ESTA UNT CARREGA POUCOS REGISTROS, A FINALIDADE DELA NÃO É TER CENTENAS DE REGISTROS
//POR ESSE MOTIVO ELA CARREGA TODOS OS DADOS NO CLIENTDATASET E A PESQUISA É FEITA NESSE CLIENTDATASET USANDO Tlistagem

unit untAtividade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uAtividadeModel, uAtividadeRepositoryFireDac,
  uAtividadeService, uAtividadeController, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, Data.DB, FireDAC.Comp.Client, untDataModule,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, JvExDBGrids, JvDBGrid, JvDBUltimGrid,
  Vcl.DBCtrls, uTipoAtividadeController, uTipoAtividadeRepository, uTipoAtividadeService, untFormBase,
  Vcl.Menus, Datasnap.DBClient, Datasnap.Provider, uMensagem, System.Generics.Collections,
  uTipoAtividadeRepositoryFireDac, uTipoAtividadeModel, uListagem, uFuncoesGerais;

type
  TfrmAtividade = class(TfrmFormBase)
    dtsAtividade: TDataSource;
    Panel1: TPanel;
    Label1: TLabel;
    edtDescricao: TEdit;
    Label2: TLabel;
    edtObs: TEdit;
    btnSalvar: TButton;
    Panel2: TPanel;
    btnListar: TButton;
    dbgAtividade: TJvDBUltimGrid;
    edtTipoAtividade: TDBLookupComboBox;
    dtsTipoAtividade: TDataSource;
    lcbTipoAtividadePesquisa: TDBLookupComboBox;
    edtDescricaoPesquisa: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    popMenu: TPopupMenu;
    Alterar1: TMenuItem;
    Excluir1: TMenuItem;
    btnCancelarAlteracao: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnListarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Alterar1Click(Sender: TObject);
    procedure dbgAtividadeDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Excluir1Click(Sender: TObject);
    procedure lcbTipoAtividadePesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtTipoAtividadeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgAtividadeTitleClick(Column: TColumn);
    procedure btnCancelarAlteracaoClick(Sender: TObject);
  private
    FAtividadeController: TAtividadeController;
    FTipoAtividadeController: TTipoAtividadeController;
    FId: integer;
    FListagem: Tlistagem;
  public

  end;

var
  frmAtividade: TfrmAtividade;

implementation

{$R *.dfm}

procedure TfrmAtividade.Alterar1Click(Sender: TObject);
begin
  FId:= Flistagem.cdsAtividade.FieldByName('ID').AsInteger;
  edtDescricao.Text:= Flistagem.cdsAtividade.FieldByName('DESCRICAO').AsString;
  edtObs.Text:= Flistagem.cdsAtividade.FieldByName('OBS').AsString;
  edtTipoAtividade.KeyValue:= Flistagem.cdsAtividade.FieldByName('ID_TIPOATIVIDADE').AsInteger;
  btnCancelarAlteracao.Enabled:= true;
  btnSalvar.Caption:= 'Alterar';
end;

procedure TfrmAtividade.btnSalvarClick(Sender: TObject);
var
  resposta: TMensagem;
  idAtividade: integer;
begin
  if edtTipoAtividade.KeyValue = null then
    idAtividade:=0
  else
    idAtividade:= edtTipoAtividade.KeyValue;

  try
    resposta:= FAtividadeController.salvar(FId, edtDescricao.Text, edtObs.Text, idAtividade);
  except
    on E: Exception do
    begin
      LogErro(E);
      MessageDlg('Erro ao acessar banco de dados',mtError,[mbOK],0);
      exit;
    end;
  end;

  if resposta.campo <> '' then
  begin
    MessageDlg(resposta.mensagem, mtWarning, [mbOK], 0);
    focoComponente(resposta.campo);
    exit;
  end;

  LimparEdits(Self);
  FId:=0;
  btnSalvar.Caption:='Salvar';
  btnCancelarAlteracao.Enabled:= false;

end;

procedure TfrmAtividade.dbgAtividadeDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (gdSelected in state) then
    with (Sender as TDBGrid).Canvas do
    begin
      Font.Style  := [fsbold];
      dbgAtividade.Canvas.Brush.Color := clWhite;
    end;

  dbgAtividade.Canvas.Font.Color:= clBlack;

  dbgAtividade.Canvas.FillRect(Rect);
  dbgAtividade.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TfrmAtividade.dbgAtividadeTitleClick(Column: TColumn);
begin
  FListagem.cdsAtividade.IndexFieldNames:= column.fieldname;
end;

procedure TfrmAtividade.edtTipoAtividadeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   IF KEY =VK_back then
  begin
    edtTipoAtividade.KeyValue := null;
  end;

end;

procedure TfrmAtividade.Excluir1Click(Sender: TObject);
var
  caminho: string;
begin
  case MessageBox (Application.Handle, Pchar ('Confirmar exclus�o do registro? ' +
                                FListagem.cdsAtividade.FieldByName('DESCRICAO').AsString),
                               'Alerta' ,
                                MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON1) of
  IDNO:
    begin
      exit;
    end;
  end;

  try
    FAtividadeController.excluir(FListagem.cdsAtividade.FieldByName('ID').AsInteger);
  except
    on E: exception do
    begin
      logErro(E);
      caminho := ExtractFilePath(ParamStr(0));
      MessageDlg('Erro ao excluir registro, verificar detalhes no arquivo log '+ caminho + 'log.txt',mtError, [mbOK],0);
      exit;
    end;
  end;
  btnListar.Click;
end;

procedure TfrmAtividade.btnCancelarAlteracaoClick(Sender: TObject);
begin
  btnSalvar.Caption:='Salvar';
  btnCancelarAlteracao.Enabled:= false;
  FId:=0;
  limparEdits(self);
end;

procedure TfrmAtividade.btnListarClick(Sender: TObject);
var
  filtro: string;
begin

  FListagem.alimentarAtividade(tlAtividade);
  dtsAtividade.DataSet:= FListagem.cdsAtividade;

  filtro := '';

  // Filtro por descri��o
  if Trim(edtDescricaoPesquisa.Text) <> '' then
    filtro := Format(
      'DESCRICAO LIKE %s',
      [QuotedStr('%' + edtDescricaoPesquisa.Text + '%')]
    );

  // Filtro por tipo
  if VarToStr(lcbTipoAtividadePesquisa.KeyValue) <> '' then
  begin
    if filtro <> '' then
      filtro := filtro + ' AND ';

    filtro := filtro + 'ID_TIPOATIVIDADE = ' + inttostr(lcbTipoAtividadePesquisa.KeyValue);
  end;

  FListagem.cdsAtividade.Filtered := False;
  FListagem.cdsAtividade.Filter := filtro;
  FListagem.cdsAtividade.Filtered := True;

  FListagem.cdsAtividade.IndexFieldNames:= 'DESCRICAO';

  dbgAtividade.Columns[0].FieldName:='Descricao';
  dbgAtividade.Columns[1].FieldName:='OBS';
  dbgAtividade.Columns[2].FieldName:='TIPO_DESCRICAO';

end;

procedure TfrmAtividade.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FListagem.Free;
  FAtividadeController.Free;
  FTipoAtividadeController.Free;
  frmAtividade := nil; //sem esse comando frmAtividade continua apontando p/ um endere�o invalido, por isso o uso do nil
end;

procedure TfrmAtividade.FormCreate(Sender: TObject);
var
  atividadeRepository: TAtividadeRepositoryFireDac;
  atividadeService: TAtividadeService;

  tipoAtividadeRepository: TTipoAtividadeRepositoryFireDac;
  tipoAtividadeService: TTipoAtividadeService;

begin
  inherited;

  ///INSTANCIANDO ATIVIDADE///////////////////
  atividadeRepository:= TAtividadeRepositoryFireDac.create();
  atividadeService:= TAtividadeService.create(atividadeRepository);
  FAtividadeController := TAtividadeController.Create(atividadeService);
  ///FIM INSTANCIANDO ATIVIDADE///////////////////

  ///INSTANCIANDO TIPO ATIVIDADE/////////////////////
  tipoAtividadeRepository:= TTipoAtividadeRepositoryFireDac.create();
  tipoAtividadeService:= TTipoAtividadeService.create(tipoAtividadeRepository);
  FTipoAtividadeController := TTipoAtividadeController.Create(tipoAtividadeService);
  ///FIM INSTANCIANDO TIPO ATIVIDADE/////////////////////

  ////ALIMENTANDO DBLOOKUPCOMBOBOX TIPO ATIVIDADE/////////////
  FListagem:= TListagem.create(FAtividadeController, FTipoAtividadeController);
  FListagem.alimentarTipoAtividade;
  dtsTipoAtividade.DataSet:= FListagem.cdsTipoAtividade;

  edtTipoAtividade.KeyField:= 'id';
  edtTipoAtividade.ListField:= 'DESCRICAO';

  lcbTipoAtividadePesquisa.KeyField:= 'id';
  lcbTipoAtividadePesquisa.ListField:= 'DESCRICAO';
  ////FIM ALIMENTANDO DBLOOKUPCOMBOBOX TIPO ATIVIDADE/////////////

  FId := 0;
  btnCancelarAlteracao.Enabled:= false;

end;

procedure TfrmAtividade.lcbTipoAtividadePesquisaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  IF KEY =VK_back then
  begin
    lcbTipoAtividadePesquisa.KeyValue := null;
  end;

end;

end.
