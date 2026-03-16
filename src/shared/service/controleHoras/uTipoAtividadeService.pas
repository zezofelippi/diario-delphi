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
    procedure excluir(id: integer);
    function listar(descricao: string):TObjectList<TTipoAtividade>;

  end;


implementation

constructor TTipoAtividadeService.create(tipoAtividadeRepository: ITipoAtividadeRepository);
begin
  FTipoAtividadeRepository:= tipoAtividadeRepository;
end;

function TTipoAtividadeService.salvar(tipoAtividade: TTipoAtividade):TMensagem;
begin
  Result := Default(TMensagem);

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

procedure TTipoAtividadeService.excluir(id: integer);
begin
  FTipoAtividadeRepository.excluir(id);
end;

function TTipoAtividadeService.listar(descricao: string):TObjectList<TTipoAtividade>;
begin
  result:= FTipoAtividadeRepository.listar(descricao);
end;


end.
