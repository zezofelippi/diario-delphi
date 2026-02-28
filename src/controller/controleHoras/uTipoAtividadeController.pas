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
    function excluir(id: integer): TMensagem;
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

function TTipoAtividadeController.excluir(id: integer): TMensagem;
begin
  result:= FTipoAtividadeService.excluir(id);
end;

function TTipoAtividadeController.listar(descricao: string): TObjectList<TTipoAtividade>;
begin
  result:= FTipoAtividadeService.listar(descricao);

end;


end.
