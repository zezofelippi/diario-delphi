unit uAtividadeController;

interface

uses
  System.SysUtils, uAtividadeModel, uAtividadeService, System.Generics.Collections, uMensagem;

type

  TAtividadeController = Class
  private
    FAtividadeService: TAtividadeService;
  public
    constructor create(atividadeService: TAtividadeService);
    function salvar(id: integer; descricao, obs: String; idTipoAtividade: integer): TMensagem;
    procedure excluir(id: integer);
    function listar(idAtividade, idTipoAtividade: integer; descricao: string): TObjectList<TAtividade>;

  End;

implementation

constructor TAtividadeController.create(atividadeService: TAtividadeService);
begin
  self.FAtividadeService:= atividadeService;
end;

procedure TAtividadeController.excluir(id: integer);
begin
  FAtividadeService.excluir(id);
end;

function TAtividadeController.salvar(id: integer; descricao,
                                     obs: String; idTipoAtividade: integer): TMensagem;
var
  atividade: TAtividade;
begin
  atividade:= TAtividade.Create;
  try
    atividade.descricao:= descricao;
    atividade.obs:= obs;
    atividade.id:= id;
    atividade.tipoAtividade.id:= idTipoAtividade; //aqui o tipo é variant, primeiro tenta converter p/ string e depois p/ inteiro, se der problema conversao de string p/ inteiro joga valor 0
    result:= FAtividadeService.salvar(atividade);
  finally
    atividade.Free;
  end;
end;

function TAtividadeController.listar(idAtividade, idTipoAtividade: integer; descricao: string): TObjectList<TAtividade>;
begin
  result:= FAtividadeService.listar(idAtividade, idTipoAtividade, descricao);
end;

end.
