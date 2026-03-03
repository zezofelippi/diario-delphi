unit uFuncoesGerais;

interface

uses DateUtils, System.SysUtils;

  function diasEntreDatas(DataInicial, DataFinal: TDate): Integer;
  procedure logErro(E: Exception);

implementation

function diasEntreDatas(DataInicial, DataFinal: TDate): Integer;
begin
  Result := DaysBetween(DataFinal, DataInicial) +1;
end;

procedure logErro(E: Exception);
var
  Arquivo: TextFile;
  Caminho: string;
begin
  Caminho := ExtractFilePath(ParamStr(0)) + 'log.txt';

  AssignFile(Arquivo, Caminho);

  if FileExists(Caminho) then
    Append(Arquivo)
  else
    Rewrite(Arquivo);

  Writeln(Arquivo,
    '------------------------------------------');
  Writeln(Arquivo, 'Data/Hora: ' + DateTimeToStr(Now));
  Writeln(Arquivo, 'Tipo: ' + E.ClassName);
  Writeln(Arquivo, 'Mensagem: ' + E.Message);
  Writeln(Arquivo,
    '------------------------------------------');
  Writeln(Arquivo);

  CloseFile(Arquivo);
end;


end.
