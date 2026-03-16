unit WebModuleUnit1;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, System.Generics.Collections,
  uTipoAtividadeController, uListagem, uTipoAtividadeModel, uTipoAtividadeService,
  uTipoAtividadeRepository, uTipoAtividadeRepositoryFireDac, REST.JSON, untDataModule,
  uAtividadeModel, uAtividadeController, uAtividadeService, uAtividadeRepository,
  uAtividadeRepositoryFireDac, System.JSON;

type
  TWebModule1 = class(TWebModule)
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);

    procedure WebModule1WebActionItem1Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);

  //  procedure listarTipoAtividade(Sender: TObject;
  //    Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);

   // procedure listarAtividade(Sender: TObject;
   //   Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);

    constructor Create(AOwner: TComponent);

    procedure WebModuleBeforeDispatch(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);

    procedure listarTudo(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;
 // DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

constructor TWebModule1.Create(AOwner: TComponent);
begin
 inherited Create(AOwner);
end;

{procedure TWebModule1.listarAtividade(Sender: TObject; Request: TWebRequest;
  Response: TWebResponse; var Handled: Boolean);
var
  atividadeService: TAtividadeService;
  atividadeRepository: IAtividadeRepository;
  atividadeController: TAtividadeController;
  lista: TObjectList<TAtividade>;
begin
  if not Assigned(DataModule1) then
    raise Exception.Create('DataModule1 NIL');

  if not Assigned(DataModule1.FDConnection) then
    raise Exception.Create('FDConnection NIL');

  if not DataModule1.FDConnection.Connected then
    raise Exception.Create('Conexao nao aberta');

  atividadeRepository:= TAtividadeRepositoryFireDac.create();
  atividadeService:= TAtividadeService.create(atividadeRepository);
  atividadeController:= TAtividadeController.create(atividadeService);

  try
    lista:= atividadeController.listar(0,0,'');
    response.ContentType:= 'application/json';
    Response.content:= TJson.ObjectToJsonString(Lista);
  finally
    atividadeController.Free;
    lista.Free;
  end;

  Handled := True;
end;

procedure TWebModule1.listarTipoAtividade(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  tipoAtividadeService: TTipoAtividadeService;
  tipoAtividadeRepository: ITipoAtividadeRepository;
  tipoAtividadeController: TTipoAtividadeController;
  listaTipo: TObjectList<TTipoAtividade>;


begin

  if not Assigned(DataModule1) then
    raise Exception.Create('DataModule1 NIL');

  if not Assigned(DataModule1.FDConnection) then
    raise Exception.Create('FDConnection NIL');

  if not DataModule1.FDConnection.Connected then
    raise Exception.Create('Conexao nao aberta');

  tipoAtividadeRepository:= TTipoAtividadeRepositoryFireDac.create();
  tipoAtividadeService:= TTipoAtividadeService.create(tipoAtividadeRepository);
  tipoAtividadeController:= TTipoAtividadeController.create(tipoAtividadeService);

  try
    lista:= tipoAtividadeController.listar('');
    response.ContentType:= 'application/json';
    Response.content:= TJson.ObjectToJsonString(Lista);
  finally
    tipoAtividadeController.Free;
    lista.Free;
  end;

  Handled := True;

end; }

procedure TWebModule1.listarTudo(Sender: TObject; Request: TWebRequest;
  Response: TWebResponse; var Handled: Boolean);
var
  tipoAtividadeService: TTipoAtividadeService;
  tipoAtividadeRepository: ITipoAtividadeRepository;
  tipoAtividadeController: TTipoAtividadeController;
  listaTipoAtividade: TObjectList<TTipoAtividade>;

  atividadeService: TAtividadeService;
  atividadeRepository: IAtividadeRepository;
  atividadeController: TAtividadeController;
  listaAtividade: TObjectList<TAtividade>;

  json: TJSONObject;

  arrTipoAtividade: TJSONArray;
  arrAtividade: TJSONArray;
  tipoAtividade: TTipoAtividade;
  atividade: TAtividade;
begin

  if not Assigned(DataModule1) then
    raise Exception.Create('DataModule1 NIL');

  if not Assigned(DataModule1.FDConnection) then
    raise Exception.Create('FDConnection NIL');

  if not DataModule1.FDConnection.Connected then
    raise Exception.Create('Conexao nao aberta');

  json := TJSONObject.Create;

  tipoAtividadeRepository:= TTipoAtividadeRepositoryFireDac.create();
  tipoAtividadeService:= TTipoAtividadeService.create(tipoAtividadeRepository);
  tipoAtividadeController:= TTipoAtividadeController.create(tipoAtividadeService);

  atividadeRepository:= TAtividadeRepositoryFireDac.create();
  atividadeService:= TAtividadeService.create(atividadeRepository);
  atividadeController:= TAtividadeController.create(atividadeService);

  arrTipoAtividade := TJSONArray.Create;
  arrAtividade := TJSONArray.Create;

  try
    listaTipoAtividade := tipoAtividadeController.listar('');
    listaAtividade := atividadeController.listar(0,0,'');

    for tipoAtividade in listaTipoAtividade do
    begin
      arrTipoAtividade.AddElement(
        TJSONObject.Create
          .AddPair('id', TJSONNumber.Create(tipoAtividade.id))
          .AddPair('descricao', tipoAtividade.descricao));
    end;

    for atividade in listaAtividade do
    begin
      arrAtividade.AddElement(
        TJSONObject.Create
          .AddPair('id', TJSONNumber.Create(atividade.id))
          .AddPair('descricao', atividade.descricao)
          .AddPair('obs', atividade.obs)
          .AddPair('idTipoAtividade', TJSONNumber.Create(atividade.tipoAtividade.id)));
    end;

    json.AddPair('tipoAtividade', arrTipoAtividade);
    json.AddPair('atividade', arrAtividade);

    Response.ContentType := 'application/json';
    Response.Content := json.ToString;

  finally
    json.Free;
  end;

  Handled := True;

end;

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  if Request.PathInfo = '/atividade/listar' then
  begin
    listarTudo(Sender, Request, Response, Handled);
    Exit;
  end;

  Response.Content :=
    '<html><body>API rodando</body></html>';
end;

procedure TWebModule1.WebModule1WebActionItem1Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.ContentType := 'application/json';
  Response.Content := '{"status":"ok"}';
  Handled := True;
end;

procedure TWebModule1.WebModuleBeforeDispatch(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  // Permite qualquer origem (pode trocar '*' pelo domínio do frontend)
  Response.SetCustomHeader('Access-Control-Allow-Origin', '*');

  // Permite métodos comuns
  Response.SetCustomHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');

  // Permite headers comuns de requisições
  Response.SetCustomHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');

  // Se for uma requisição OPTIONS (preflight), respondemos OK e paramos o processamento
  if Request.Method = 'OPTIONS' then
  begin
    Response.StatusCode := 200;
    Handled := True; // evita que a requisição vá para a rota normal
  end;
end;

end.
