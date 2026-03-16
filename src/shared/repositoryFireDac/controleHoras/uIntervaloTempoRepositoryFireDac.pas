unit uIntervaloTempoRepositoryFireDac;

interface

uses uIntervaloTempoRepository, uIntervaloTempoModel, FireDAC.Comp.Client, untDataModule;

type
  TIntervaloTempoRepositoryFireDac = class(TInterfacedObject, IIntervaloTempoRepository)
    function salvarIntervaloTempo(intervalorTempo: TIntervaloTempo; acordar: TTime): string;
    function buscarMovimentacaoHora(intervaloTempo: TIntervaloTempo): boolean;
  end;


implementation

{ TIntervaloTempoRepositoryFireDac }

function TIntervaloTempoRepositoryFireDac.buscarMovimentacaoHora(
  intervaloTempo: TIntervaloTempo): boolean;
var
  query: TFDQuery;
begin

  query := TFDQuery.Create(nil);

  try
    query.Connection:= DataModule1.FDConnection;

    query.Connection:= DataModule1.FDConnection;
    query.SQL.Clear;
    query.SQL.Add(' SELECT MH.ID, MH.DATA, MH.QTDE_HORAS, MH.OBS, MH.ACORDAR, MH.ID_ATIVIDADE,     ');
    query.SQL.Add(' ATI.DESCRICAO                                                                  ');
    query.SQL.Add(' FROM MOVIMENTACAOHORA MH INNER JOIN ATIVIDADE ATI ON MH.ID_ATIVIDADE = ATI.ID  ');
    query.SQL.Add(' INNER JOIN TIPOATIVIDADE TAT ON ATI.id_tipoatividade = TAT.ID                  ');
    query.SQL.Add(' WHERE DATA =:DATA AND ATI.DESCRICAO =:DESCRICAO                                ');
    //query.ParamByName('DATA').AsDate:= data;
    //query.ParamByName('DESCRICAO').AsString:= descricao;
    query.Open();

  finally

  end;

end;

function TIntervaloTempoRepositoryFireDac.salvarIntervaloTempo(
  intervalorTempo: TIntervaloTempo; acordar: TTime): string;
var
  query: TFDQuery;
  qtdeHoras: TDateTime;
begin

  qtdeHoras:= intervalorTempo.tempoFinal - intervalorTempo.tempoInicial;

  query:= TFDQuery.Create(nil);

  try
    query.Connection:= DataModule1.FDConnection;
    query.Connection:= DataModule1.FDConnection;
    query.SQL.Text:= 'INSERT INTO MOVIMENTACAOHORA (DATA, OBS, QTDE_HORAS, ACORDAR, ID_ATIVIDADE)' +
                     ' VALUES (:DATA, :OBS, :QTDE_HORAS, :ACORDAR, :ID_ATIVIDADE) ';
    query.ParamByName('DATA').AsDate:= intervalorTempo.tempoInicial;
    query.ParamByName('OBS').AsString:= intervalorTempo.obs;
    query.ParamByName('QTDE_HORAS').AsTime:= qtdeHoras;
    query.ParamByName('ACORDAR').AsTime:= acordar;
    query.ParamByName('ID_ATIVIDADE').AsInteger := intervalorTempo.id_movimentacaoHoras.atividade.id;
    query.ExecSQL;




  finally
    query.Free;
  end;

end;

end.
