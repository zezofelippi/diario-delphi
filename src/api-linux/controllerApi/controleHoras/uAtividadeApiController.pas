unit uAtividadeApiController;

interface
uses uAtividadeModel, uAtividadeController, uAtividadeService, uAtividadeRepository,
     uAtividadeRepositoryFireDac, Web.HTTPApp, System.Generics.Collections,
     System.JSON, REST.JSON;

type

  TAtividadeApiController = class
    private
      FAtividadeController : TAtividadeController;
    public
      constructor Create;
      destructor Destroy; override;
      function listar: TObjectList<TAtividade>;

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

function TAtividadeApiController.listar: TObjectList<TAtividade>;
begin
  result := FAtividadeController.listar(0,0,'');
end;

end.
