unit uTipoAtividadeController;

interface

uses uTipoAtividadeService, uTipoAtividadeModel, System.Generics.Collections, uMensagem;

type

  TTipoAtividadeController = class
  private
    FTipoAtividadeService: TTipoAtividadeService;
  public
    constructor create(tipoAtividadeService: TTipoAtividadeService);
    function salvar(id: integer; descricao: string): TMensagem;
    procedure excluir(id: integer);
    function listar(descricao: string):TObjectList<TTipoAtividade>;

  end;

implementation

constructor TTipoAtividadeController.create(tipoAtividadeService: TTipoAtividadeService);
begin
  self.FTipoAtividadeService:= tipoAtividadeService;
end;

function TTipoAtividadeController.salvar(id: integer; descricao: string): TMensagem;
var
  tipoAtividade: TTipoAtividade;
begin
  tipoAtividade:= TTipoAtividade.Create;

  try
    tipoAtividade.descricao:= descricao;
    tipoAtividade.id:= id;
    result:= FTipoAtividadeService.salvar(tipoAtividade);
  finally
    tipoAtividade.Free;
  end;

end;

procedure TTipoAtividadeController.excluir(id: integer);
begin
  FTipoAtividadeService.excluir(id);
end;

function TTipoAtividadeController.listar(descricao: string): TObjectList<TTipoAtividade>;
begin
  result:= FTipoAtividadeService.listar(descricao);

end;


end.
