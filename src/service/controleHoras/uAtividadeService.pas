unit uAtividadeService;

interface

uses uAtividadeModel, uAtividadeRepository,
     System.Generics.Collections, System.SysUtils, uMensagem;

type

  TAtividadeService = class
  private
    FAtividadeRepository: IAtividadeRepository;

  public
    constructor create(atividadeRepository: IAtividadeRepository);
    function salvar(atividade: TAtividade): TMensagem;
    procedure excluir(id: integer);
    function listar(idAtividade, idTipoAtividade: integer; descricao: string): TObjectList<TAtividade>;
end;

implementation

constructor TAtividadeService.create(atividadeRepository: IAtividadeRepository);
begin
  FAtividadeRepository:= atividadeRepository;
end;

function TAtividadeService.salvar(atividade: TAtividade): TMensagem;
begin
  Result := Default(TMensagem);

  if atividade.descricao.Trim = '' then
  begin
    result.mensagem:= 'Descrição é campo de preenchimento obrigatório';
    result.campo:= 'descricao';
    exit;
  end
  else if atividade.tipoAtividade.id = 0 then
  begin
    result.mensagem:= 'Tipo de atividade é obrigatório';
    result.campo:= 'tipoAtividade';
    exit;
  end;

  if atividade.id = 0 then
    FAtividadeRepository.salvar(atividade)
  else
    FAtividadeRepository.alterar(atividade);

end;

procedure TAtividadeService.excluir(id: integer);
begin
  FAtividadeRepository.excluir(id);
end;

function TAtividadeService.listar(idAtividade, idTipoAtividade: integer; descricao: string): TObjectList<TAtividade>;
begin
  result:= FAtividadeRepository.listar(idAtividade, idTipoAtividade, descricao);
end;

end.
