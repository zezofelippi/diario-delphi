unit uTipoAtividadeApiController;

interface

uses  Web.HTTPApp, uTipoAtividadeController, uTipoAtividadeService,
      uTipoAtividadeRepository, uTipoAtividadeRepositoryFireDac,
      uTipoAtividadeModel, uMensagem,
      System.JSON, REST.JSON, System.Generics.Collections;

type

  TTipoAtividadeApiController = class
    private
      FTipoAtividadeController: TTipoAtividadeController;
    public
      constructor Create;
      destructor Destroy; override;

      function listar: TObjectList<TTipoAtividade>;
      function salvar(tipoAtividade: TTipoAtividade):TMensagem;


  end;

implementation

{ TTipoAtividadeApiController }

constructor TTipoAtividadeApiController.Create;
var
  tipoAtividadeRepository: ITipoAtividadeRepository;
  tipoAtividadeService: TTipoAtividadeService;
begin
  tipoAtividadeRepository := TTipoAtividadeRepositoryFireDac.Create;
  tipoAtividadeService := TTipoAtividadeService.Create(tipoAtividadeRepository);
  FTipoAtividadeController := TTipoAtividadeController.Create(tipoAtividadeService);

end;

destructor TTipoAtividadeApiController.Destroy;
begin
  FTipoAtividadeController.Free;
  inherited;
end;

function TTipoAtividadeApiController.Listar: TObjectList<TTipoAtividade>;
begin
  result := FTipoAtividadeController.listar('');
end;

function TTipoAtividadeApiController.salvar(
  tipoAtividade: TTipoAtividade): TMensagem;
begin
  result:= FTipoAtividadeController.salvar(tipoAtividade.id, tipoAtividade.descricao);
end;

end.
