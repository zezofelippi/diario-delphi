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

    constructor Create(AOwner: TComponent);

    procedure WebModuleBeforeDispatch(Sender: TObject; Request: TWebRequest;
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

uses uRouter;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

constructor TWebModule1.Create(AOwner: TComponent);
begin
 inherited Create(AOwner);
end;

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  TRouter.HandleRequest(Request, Response, Handled);
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
