unit uMovimentacaoHorasGerarHtml;

interface

uses System.SysUtils, System.Classes, Data.DB, uFuncoesGerais;

type

  TMovimentacaoHorasGerarHtml = class
    public
      function gerarHtml(dataSet: TDataSet; tipoAtividade,
                         atividade, obs, totalHoras: string; dataInicial, dataFinal: TDate): string;
  end;


implementation

{ TGerarHtmlPdf }

function TMovimentacaoHorasGerarHtml.gerarHtml(dataSet: TDataSet; tipoAtividade, atividade,
                                               obs, totalHoras: string; dataInicial, dataFinal: TDate): string;
var
  html: TStringList;
  qtdeDias, intervaloDias: integer;
begin
  html := TStringList.Create;

  ///////CALCULAR QUANTIDADE DE DIAS PESQUISADOS/////////////////////
  qtdeDias := DataSet.RecordCount;
  intervaloDias := diasEntreDatas(dataInicial, dataFinal);

  ///////FIM CALCULAR QUANTIDADE DE DIAS PESQUISADOS/////////////////////

  try
    html.Add('<html>');
    html.Add('<head>');
    html.Add('<meta charset="utf-8">');
    html.Add('<style>');
    html.Add('body { font-family: Arial; }');
    html.Add('table { width:100%; border-collapse: collapse; }');
    html.Add('th, td { border:1px solid #000; padding:5px; text-align:left; }');
    html.Add('th { background-color:#f2f2f2; }');
    html.Add('</style>');
    html.Add('</head>');
    html.Add('<body>');
    html.Add('<h4>' + tipoAtividade +'</h4>');
    html.Add('<h4>' + atividade +'</h4>');
    html.Add('<h5>OBS: ' + obs +'</h5>');
    html.Add('<h4>' + datetostr(dataInicial) + ' a '+ datetostr(dataFinal) + '</h4>');
    html.Add('<h4>' + inttostr(qtdeDias) + ' dia(s) filtrado(s) em um intervalo de '+ inttostr(intervaloDias)+ ' dia(s)</h4>');
    html.Add('<table>');
    html.Add('<tr><th>Data</th><th>Descrição</th><th>Qtde Horas</th></tr>');

    DataSet.First;
    while not DataSet.Eof do
    begin
      html.Add('<tr>');
      html.Add('<td>' + DataSet.FieldByName('DATA').AsString + '</td>');
      html.Add('<td>' + DataSet.FieldByName('OBS').AsString + '</td>');
      html.Add('<td>' + DataSet.FieldByName('QTDE_HORAS').AsString + '</td>');
      html.Add('</tr>');
      DataSet.Next;
    end;

    html.Add('<tr> <th>Total</th>' + ' <th></th> <th> ' + totalHoras +'</th></tr>');
    html.Add('</table>');
    html.Add('</body>');
    html.Add('</html>');

    Result := html.Text;
  finally
    html.Free;
  end;

end;

end.
