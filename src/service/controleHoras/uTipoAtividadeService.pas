unit uTipoAtividadeService;

interface

uses uTipoAtividadeRepository, uTipoAtividadeModel,
     System.SysUtils, System.Generics.Collections, uMensagem;

type

  TTipoAtividadeService = class
  private
    FTipoAtividadeRepository: ITipoAtividadeRepository;

  public
    constructor create(tipoAtividadeRepository: ITipoAtividadeRepository);
    function salvar(tipoAtividade: TTipoAtividade):TMensagem;
    function excluir(id: integer): TMensagem;
    function listar(descricao: string):TObjectList<TTipoAtividade>;

  end;


implementation

constructor TTipoAtividadeService.create(tipoAtividadeRepository: ITipoAtividadeRepository);
begin
  FTipoAtividadeRepository:= tipoAtividadeRepository;
end;

function TTipoAtividadeService.salvar(tipoAtividade: TTipoAtividade):TMensagem;
begin
  if tipoAtividade.descricao.Trim = '' then
  begin
    result.mensagem:= 'Descrição é campo de preenchimento obrigatório';
    result.campo   := 'descricao';
    exit;
  end
  else
  begin
    result.campo:= '';
  end;

  if tipoAtividade.id = 0 then
    FTipoAtividadeRepository.salvar(tipoAtividade)
  else
    FTipoAtividadeRepository.alterar(tipoAtividade);



end;

function TTipoAtividadeService.excluir(id: integer): TMensagem;
begin
  try
    FTipoAtividadeRepository.excluir(id);
    result.mensagem:= '';
  Except
    result.mensagem:= 'Erro ao excluir registro, possivelmente este registro está vinculado a alguma atividade';
  end;


end;

function TTipoAtividadeService.listar(descricao: string):TObjectList<TTipoAtividade>;
begin
  result:= FTipoAtividadeRepository.listar(descricao);
end;


end.
