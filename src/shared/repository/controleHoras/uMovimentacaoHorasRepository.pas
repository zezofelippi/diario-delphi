unit uMovimentacaoHorasRepository;

interface

uses uMovimentacaoHorasModel, System.Generics.Collections;

type
  IMovimentacaoHorasRepository = Interface
    ['{6f1d13c5-fd68-49ce-82a1-d55922a243a0}'] //Identificação única da interface em tempo de execução
    procedure salvar(movimentacaoHoras: TMovimentacaoHoras);
    procedure alterar(movimentacaoHoras: TMovimentacaoHoras);
    procedure excluir(id: integer);

    function listar(
      idTipoAtividade, idAtividade: Integer;
      dataInicial, dataFinal: TDate;
      obs: string): TObjectList<TMovimentacaoHoras>;

    function selecionarCelula(data: TDate; descricao: string): TMovimentacaoHoras;

    function calcularTotalHorasPorColuna(idTipoAtividade, idAtividade: Integer;
      dataInicial, dataFinal: TDate;
      obs: string): TObjectList<TMovimentacaoHoras>;

  End;

implementation

end.
