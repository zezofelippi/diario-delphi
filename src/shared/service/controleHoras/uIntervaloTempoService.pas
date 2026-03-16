unit uIntervaloTempoService;

interface

uses uIntervaloTempoModel, uIntervaloTempoRepository;

type

  TIntervaloTempoService = class
    private
      FIntervalorTempoRepository: IIntervaloTempoRepository;

    public
      constructor create(intervaloTempoRepository: IIntervaloTempoRepository);
      function gravarIntervaloTempo(intervalorTempo: TIntervaloTempo; acordar:TTime): string;
  end;

implementation

{ TIntervaloTempoService }

constructor TIntervaloTempoService.create(
  intervaloTempoRepository: IIntervaloTempoRepository);
begin
  FIntervalorTempoRepository:= intervaloTempoRepository;
end;

function TIntervaloTempoService.gravarIntervaloTempo(
  intervalorTempo: TIntervaloTempo; acordar:TTime): string;
begin
  result:= FIntervalorTempoRepository.salvarIntervaloTempo(intervalorTempo, acordar);
end;

end.
