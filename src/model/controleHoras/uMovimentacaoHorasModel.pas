unit uMovimentacaoHorasModel;

interface

uses uAtividadeModel;

type

  TMovimentacaoHoras= class
    private
      FId         : integer;
      FData       : TDate;
      FObs        : string;
      FQtdeHoras : TTime;
      FAcordar    : TTime;
      FAtividade  : TAtividade;
      FTotalHoras : string;

    public
      constructor create;
      destructor  destroy;
      property id: integer read FId write FId;
      property data: TDate read FData write FData;
      property obs : string read FObs write FObs;
      property qtdeHoras : TTime read FQtdeHoras write FQtdeHoras;
      property acordar : TTime read FAcordar write FAcordar;
      property atividade : TAtividade read FAtividade;
      property totalHoras: string read FTotalHoras write FTotalHoras;

  end;



implementation

{ TMovimentacaoHoras }

constructor TMovimentacaoHoras.create;
begin
  inherited;
  FAtividade := TAtividade.create;
end;

destructor TMovimentacaoHoras.destroy;
begin
  FAtividade.Free;
  inherited;

end;

end.
