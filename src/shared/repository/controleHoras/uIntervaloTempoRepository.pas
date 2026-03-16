unit uIntervaloTempoRepository;

interface

uses uIntervaloTempoModel;

type
  IIntervaloTempoRepository= interface
    function salvarIntervaloTempo(intervalorTempo: TIntervaloTempo; acordar: TTime): string;
  end;

implementation

end.
