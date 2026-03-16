//ESTA UNT CARREGA POUCOS REGISTROS, A FINALIDADE DELA NÃO É TER CENTENAS DE REGISTROS
//POR ESSE MOTIVO ELA CARREGA TODOS OS DADOS NO CLIENTDATASET E A PESQUISA É FEITA NESSE CLIENTDATASET USANDO Tlistagem

unit untTipoAtividade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB, untDataModule,
  Vcl.Grids, Vcl.DBGrids, uTipoAtividadeController, uTipoAtividadeService, uTipoAtividadeRepository,
  untFormBase, Datasnap.DBClient, Datasnap.Provider, Vcl.Menus, uMensagem, System.Generics.Collections,
  uTipoAtividadeModel, uTipoAtividadeRepositoryFireDac, uListagem, uFuncoesGerais;

type
  TfrmTipoAtividade = class(TfrmFormBase)
    edtDescricao: TEdit;
    Label2: TLabel;
    btnSalvar: TButton;
    Panel1: TPanel;
    dtsTipoAtividade: TDataSource;
    dbgTipoAtividade: TDBGrid;
    popMenu: TPopupMenu;
    Alterar1: TMenuItem;
    Excluir1: TMenuItem;
    btnCancelarAlteracao: TButton;
    pnlPesquisa: TPanel;
    edtDescricaoPesquisa: TEdit;
    Label1: TLabel;
    btnListar: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnListarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure dbgTipoAtividadeDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Alterar1Click(Sender: TObject);
    procedure btnCancelarAlteracaoClick(Sender: TObject);
    procedure Excluir1Click(Sender: TObject);
  private
    FTipoAtividadeController: TTipoAtividadeController;
    FId: integer;
    Flistagem: TListagem;
  public
    { Public declarations }
  end;

var
  frmTipoAtividade: TfrmTipoAtividade;

implementation

{$R *.dfm}

procedure TfrmTipoAtividade.Alterar1Click(Sender: TObject);
begin
  FId:= Flistagem.cdsTipoAtividade.FieldByName('ID').AsInteger;
  edtDescricao.Text:= Flistagem.cdsTipoAtividade.FieldByName('DESCRICAO').AsString;
  btnCancelarAlteracao.Enabled:= true;
  btnSalvar.Caption:= 'Alterar';
end;

procedure TfrmTipoAtividade.btnCancelarAlteracaoClick(Sender: TObject);
begin
  btnSalvar.Caption:='Salvar';
  btnCancelarAlteracao.Enabled:= false;
  FId:=0;
  limparEdits(self);
end;

procedure TfrmTipoAtividade.btnListarClick(Sender: TObject);
begin

  Flistagem.alimentarTipoAtividade;
  dtsTipoAtividade.DataSet:= FListagem.cdsTipoAtividade;

  FListagem.cdsTipoAtividade.Filtered:= false;
  FListagem.cdsTipoAtividade.Filter:= 'DESCRICAO LIKE ' + #39 + '%' + edtDescricaoPesquisa.Text + '%' + #39;
  FListagem.cdsTipoAtividade.Filtered := True;

  FListagem.cdsTipoAtividade.IndexFieldNames:= 'DESCRICAO';

  dbgTipoAtividade.Columns[0].FieldName:= 'DESCRICAO';
end;

procedure TfrmTipoAtividade.btnSalvarClick(Sender: TObject);
var
  resposta: TMensagem;
  caminho: string;
begin

  try
    resposta:= FTipoAtividadeController.salvar(FId, edtDescricao.Text);
  except
    on E: Exception do
    begin
      logErro(E);
      caminho := ExtractFilePath(ParamStr(0));
      MessageDlg('Erro ao acessar banco de dados, ver arquivo log.txt em ' + caminho + 'log.txt', mtError, [mbOK], 0);
      exit;
    end;
  end;

  if resposta.campo <> '' then
  begin
    MessageDlg(resposta.mensagem, mtWarning, [mbOK],0);
    focoComponente(resposta.campo);
    exit;
  end;

  limparEdits(self);
  FId:=0;
  btnSalvar.Caption:='Salvar';
  btnCancelarAlteracao.Enabled:= false;
end;

procedure TfrmTipoAtividade.dbgTipoAtividadeDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (gdSelected in state) then
    with (Sender as TDBGrid).Canvas do
    begin
      Font.Style  := [fsbold];
      dbgTipoAtividade.Canvas.Brush.Color := clWhite;
    end;

  dbgTipoAtividade.Canvas.Font.Color:= clBlack;

  dbgTipoAtividade.Canvas.FillRect(Rect);
  dbgTipoAtividade.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmTipoAtividade.Excluir1Click(Sender: TObject);
var
  caminho: string;
begin
  case MessageBox (Application.Handle, Pchar ('Confirmar exclusão do registro? ' +
                                FListagem.cdsTipoAtividade.FieldByName('DESCRICAO').AsString),
                               'Alerta' ,
                                MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON1) of
  IDNO:
    begin
      exit;
    end;
  end;

  try
    FTipoAtividadeController.excluir(FListagem.cdsTipoAtividade.FieldByName('ID').AsInteger);
  except
    on E: exception do
    begin
      logErro(E);
      caminho := ExtractFilePath(ParamStr(0));
      messagedlg('Erro ao excluir registro, ver detalhes no arquivo log ' + caminho + 'log.txt',mtError, [mbOk],0);
      exit;
    end;
  end;
  btnListar.Click;
end;

procedure TfrmTipoAtividade.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FListagem.Free;
  FTipoAtividadeController.Free;
  frmTipoAtividade := nil; //sem esse comando frmAtividade continua apontando p/ um endereço invalido, por isso o uso do nil
end;

procedure TfrmTipoAtividade.FormCreate(Sender: TObject);
var
  tipoAtividadeService: TTipoAtividadeService;
  tipoAtividadeRepository: TTipoAtividadeRepositoryFireDac;
begin

  inherited;

  tipoAtividadeRepository:= TTipoAtividadeRepositoryFireDac.create();
  tipoAtividadeService:= TTipoAtividadeService.create(tipoAtividadeRepository);
  FTipoAtividadeController := TTipoAtividadeController.Create(tipoAtividadeService);

  FListagem:= TListagem.create(nil, FTipoAtividadeController);

 // tipoAtividadeRepository:= TTipoAtividadeRepositoryFireDac.create();
 // tipoAtividadeService := TTipoAtividadeService.create(tipoAtividadeRepository);

 // FTipoAtividadeController := TTipoAtividadeController.create(tipoAtividadeService);

  FId:=0;

  btnCancelarAlteracao.Enabled:= false;

end;

end.
