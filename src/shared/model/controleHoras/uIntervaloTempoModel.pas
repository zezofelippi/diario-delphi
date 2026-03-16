unit uIntervaloTempoModel;

interface

uses uMovimentacaoHorasModel;

type

  TIntervaloTempo = class
    private
      FId : integer;
      FTempoInicial: TDateTime;
      FTempoFinal  : TDateTime;
      FObs         : string;
      FId_MovimentacaoHoras : TMovimentacaoHoras;

    public
      constructor create;
      destructor destroy;
      property id: integer read FId write FId;
      property tempoInicial: TDateTime read FTempoInicial write FTempoInicial;
      property tempoFinal : TDateTime read FTempoInicial write FTempoInicial;
      property id_movimentacaoHoras : TMovimentacaoHoras read FId_MovimentacaoHoras write FId_MovimentacaoHoras;
      property obs : string read FObs write FObs;

  end;

implementation

{ TIntervaloTempo }

constructor TIntervaloTempo.create;
begin
  inherited;
  FId_MovimentacaoHoras := TMovimentacaoHoras.create;
end;

destructor TIntervaloTempo.destroy;
begin
  FId_MovimentacaoHoras.Free;
  inherited;
end;

end.
