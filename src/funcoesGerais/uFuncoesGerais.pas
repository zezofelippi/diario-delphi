unit uFuncoesGerais;

interface

uses DateUtils;
  function DiasEntreDatas(DataInicial, DataFinal: TDate): Integer;

implementation

function diasEntreDatas(DataInicial, DataFinal: TDate): Integer;
begin
  Result := DaysBetween(DataFinal, DataInicial) +1;
end;


end.
