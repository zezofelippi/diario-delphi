unit uMovimentacaoHorasService;

interface

uses uMovimentacaoHorasRepository, uMovimentacaoHorasModel, uMensagem, System.Generics.Collections,
     System.SysUtils;

type

  TMovimentacaoHorasService = class
    private
      FMovimentacaoHorasRepository: IMovimentacaoHorasRepository;
    public
      constructor create(movimentacaoHorasRepository: IMovimentacaoHorasRepository);
      function salvar(movimentacaoHoras: TMovimentacaoHoras): TMensagem;
      function excluir(id: integer): TMensagem;
      function listar(idTipoAtividade, idAtividade: integer;
                       dataInicial, dataFinal: TDate; obs: string):TObjectList<TMovimentacaoHoras>;
      function calcularTotalHorasPorColuna(idTipoAtividade, idAtividade: integer;
                       dataInicial, dataFinal: TDate; obs: string): TObjectList<TMovimentacaoHoras>;
      function selecionarCelula(data: TDate; descricao: string): TMovimentacaoHoras;

  end;



implementation

{ TMovimentacaoHorasService }

function TMovimentacaoHorasService.calcularTotalHorasPorColuna(
  idTipoAtividade, idAtividade: integer; dataInicial, dataFinal: TDate; obs: string):TObjectList<TMovimentacaoHoras>;
begin
  result:= FMovimentacaoHorasRepository.calcularTotalHorasPorColuna(idTipoAtividade, idAtividade, dataInicial, dataFinal, obs);
end;

constructor TMovimentacaoHorasService.create(
  movimentacaoHorasRepository: IMovimentacaoHorasRepository);
begin
  FMovimentacaoHorasRepository:= movimentacaoHorasRepository;
end;

function TMovimentacaoHorasService.excluir(id: integer): TMensagem;
begin
  //Se não cair no except, o Result nunca recebe valor.
  //Como record não é automaticamente zerado de forma garantida, você pode retornar lixo de memória
  //Isso pode dar comportamento indefinido
  //Isso zera o record inteiro.
  result := Default(TMensagem);

  try
    FMovimentacaoHorasRepository.excluir(id);
  except
    result.mensagem:='Erro ao excluir registro de movimentação de horas';
  end;
end;

function TMovimentacaoHorasService.listar(idTipoAtividade, idAtividade: integer;
  dataInicial, dataFinal: TDate; obs: string):TObjectList<TMovimentacaoHoras>;
begin
  result:= FMovimentacaoHorasRepository.listar(idTipoAtividade, idAtividade, dataInicial, dataFinal, obs);
end;

function TMovimentacaoHorasService.salvar(movimentacaoHoras: TMovimentacaoHoras): TMensagem;
var
  lista: TObjectList<TMovimentacaoHoras>;
begin
  Result := Default(TMensagem);

  if movimentacaoHoras.data = 0 then
  begin
    result.mensagem:= 'Campo data é de preenchimento obrigatório';
    result.campo := 'Data';
    exit;
  end
  else if movimentacaoHoras.atividade.id = 0 then
  begin
    result.mensagem:= 'Atividade é de preenchimento obritatório';
    result.campo:= 'atividade';
    exit;
  end
  else if movimentacaoHoras.acordar = 0 then
  begin
    result.mensagem:= 'Acordar é de preenchimento obrigatório';
    result.campo := 'Acordar';
    exit;
  end
  else if movimentacaoHoras.qtdeHoras = 0 then
  begin
    result.mensagem:= 'Qtde horas é de preenchimento obrigatório';
    result.campo:= 'Qtde_horas';
    exit;
  end;

  //PROIBE CADASTRO DE DATA FUTURA///////////////
  if trunc(movimentacaoHoras.data) > Date then
  begin
    result.mensagem:= 'Não é permitido gravar data futura';
    result.campo := 'Data';
    exit;
  end;
  //FIM PROIBE CADASTRO DE DATA FUTURA///////////////

  ////VERIFICAR SE ACORDAR JÁ FOI INCLUÍDO NA DATA. SE JÁ, NÃO DEIXAR CADASTRAR ACORDAR DIFERENTE
  lista:= FMovimentacaoHorasRepository.listar(0, 0, movimentacaoHoras.data, movimentacaoHoras.data, '');

  if lista.Count > 0 then
    if movimentacaoHoras.acordar <> lista.Items[0].acordar then
    begin
      result.mensagem:= 'Acordar está diferente do acordar já '+
                        'cadastrado nessa data. Acordar está ' +
                        FormatDateTime('hh:mm',lista.Items[0].acordar);
      result.campo:= 'Acordar';
      lista.Free;
      exit;
    end;
  ///FIM VERIFICAR SE ACORDAR JÁ FOI INCLUÍDO NA DATA. SE JÁ, NÃO DEIXAR CADASTRAR ACORDAR DIFERENTE


  if movimentacaoHoras.id = 0 then
    FMovimentacaoHorasRepository.salvar(movimentacaoHoras)
  else
    FMovimentacaoHorasRepository.alterar(movimentacaoHoras);

end;

function TMovimentacaoHorasService.selecionarCelula(data: TDate; descricao: string):TMovimentacaoHoras;
begin
  result:= FMovimentacaoHorasRepository.selecionarCelula(data, descricao);
end;

end.
