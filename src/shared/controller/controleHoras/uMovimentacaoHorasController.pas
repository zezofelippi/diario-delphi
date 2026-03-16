unit uMovimentacaoHorasController;

interface

uses uMovimentacaoHorasService, uMensagem,
     uMovimentacaoHorasModel, System.SysUtils, System.Generics.Collections;

type
  TMovimentacaoHorasController = class
    private
      FMovimentacaoHorasService: TMovimentacaoHorasService;

    public
      constructor create(movimentacaoHorasService: TMovimentacaoHorasService);
      function salvar(id, idAtividade: integer; data: TDate;
                      qtdeHoras, acordar: TTime; obs: string): TMensagem;
      procedure excluir(id: integer);
      function listar(idTipoAtividade, idAtividade: integer; dataInicial, dataFinal: TDate;
                      obs: string): TObjectList<TMovimentacaoHoras>;
      function calcularTotalHorasPorColuna(idTipoAtividade, idAtividade: integer; dataInicial, dataFinal: TDate;
                      obs: string): TObjectList<TMovimentacaoHoras>;
      function selecionarCelula(data: TDate; descricao: string): TMovimentacaoHoras;

  end;


implementation

{ TMovimentacaoHorasController }

function TMovimentacaoHorasController.calcularTotalHorasPorColuna(idTipoAtividade,
  idAtividade: integer; dataInicial, dataFinal: TDate; obs: string): TObjectList<TMovimentacaoHoras>;
begin
  result:= FMovimentacaoHorasService.calcularTotalHorasPorColuna(idTipoAtividade, idAtividade, dataInicial, dataFinal, obs);
end;

constructor TMovimentacaoHorasController.create(
  movimentacaoHorasService: TMovimentacaoHorasService);
begin
  self.FMovimentacaoHorasService:= movimentacaoHorasService;
end;

procedure TMovimentacaoHorasController.excluir(id: integer);
begin
  FMovimentacaoHorasService.excluir(id);
end;

function TMovimentacaoHorasController.listar(idTipoAtividade, idAtividade: integer;
  dataInicial, dataFinal: TDate; obs: string): TObjectList<TMovimentacaoHoras>;
begin
  result:= FMovimentacaoHorasService.listar(idTipoAtividade, idAtividade, dataInicial, dataFinal, obs);

end;

function TMovimentacaoHorasController.salvar(id, idAtividade: integer;
  data: TDate; qtdeHoras, acordar: TTime; obs: string): TMensagem;
var
  movimentacaoHoras: TMovimentacaoHoras;
begin

  movimentacaoHoras := TMovimentacaoHoras.create;
  try
    movimentacaoHoras.id:= id;
    movimentacaoHoras.data:= data;
    movimentacaoHoras.obs:= obs;
    movimentacaoHoras.qtdeHoras:= qtdeHoras;
    movimentacaoHoras.acordar:= acordar;
    movimentacaoHoras.atividade.id:= idAtividade;

    result:= FMovimentacaoHorasService.salvar(movimentacaoHoras);

  finally
    movimentacaoHoras.Free;
  end;

end;

function TMovimentacaoHorasController.selecionarCelula(data: TDate;
  descricao: string): TMovimentacaoHoras;
begin
  result:= FMovimentacaoHorasService.selecionarCelula(data, descricao);
end;

end.
