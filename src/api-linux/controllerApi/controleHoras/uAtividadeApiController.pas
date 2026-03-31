unit uAtividadeApiController;

interface
uses uAtividadeModel, uAtividadeController, uAtividadeService, uAtividadeRepository,
     uAtividadeRepositoryFireDac, Web.HTTPApp, System.Generics.Collections,
     System.JSON, REST.JSON, uMensagem;

type

  TAtividadeApiController = class
    private
      FAtividadeController : TAtividadeController;
    public
      constructor Create;
      destructor Destroy; override;
      function listar: TObjectList<TAtividade>;
      function salvar(atividade: TAtividade):TMensagem;
      procedure excluir(id: integer);

  end;

implementation


{ TAtividadeApiController }

constructor TAtividadeApiController.Create;
var
  atividadeService: TAtividadeService;
  atividadeRepository: IAtividadeRepository;
begin
  atividadeRepository:= TAtividadeRepositoryFireDac.Create;
  atividadeService:= TAtividadeService.create(atividadeRepository);
  FAtividadeController:= TAtividadeController.create(atividadeService)


end;

destructor TAtividadeApiController.Destroy;
begin
  FAtividadeController.Free;
  inherited;
end;

procedure TAtividadeApiController.excluir(id: integer);
begin
  FAtividadeController.excluir(id);
end;

function TAtividadeApiController.listar: TObjectList<TAtividade>;
begin
  result := FAtividadeController.listar(0,0,'');
end;

function TAtividadeApiController.salvar(atividade: TAtividade): TMensagem;
begin
  result:= FAtividadeController.salvar(atividade.id, atividade.descricao,
           atividade.obs, atividade.tipoAtividade.id);
end;

end.
