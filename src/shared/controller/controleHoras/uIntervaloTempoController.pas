unit uIntervaloTempoController;

interface

uses uIntervaloTempoModel, uIntervaloTempoService;

type

  TIntervaloTempoController = class
    private
      FIntervaloTempoService: TIntervaloTempoService;
    public
      constructor create(intervalorTempoService: TIntervaloTempoService);
      function gravarIntervaloTempo(tempoInicial, tempoFinal: TDateTime; acordar: TTime;
                                    idAtividade: integer; obs: string): string;
  end;

implementation

{ TIntervaloTempoController }

constructor TIntervaloTempoController.create(
  intervalorTempoService: TIntervaloTempoService);
begin
  FIntervaloTempoService:= intervalorTempoService;
end;

function TIntervaloTempoController.gravarIntervaloTempo(tempoInicial,
  tempoFinal: TDateTime; acordar: TTime; idAtividade: integer; obs: string): string;
var
  intervaloTempo : TIntervaloTempo;
begin
  intervaloTempo := TIntervaloTempo.create;

  try
    intervaloTempo.tempoInicial:= tempoInicial;
    intervaloTempo.tempoFinal:= tempoFinal;
    intervaloTempo.id_movimentacaoHoras.atividade.id:= idAtividade;
    intervaloTempo.obs:= obs;

    result:= FIntervaloTempoService.gravarIntervaloTempo(intervaloTempo, acordar);
  finally
   // FIntervaloTempoService
    intervaloTempo.Free;
  end;


end;

end.
