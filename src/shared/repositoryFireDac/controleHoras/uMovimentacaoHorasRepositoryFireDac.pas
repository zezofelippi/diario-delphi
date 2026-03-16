unit uMovimentacaoHorasRepositoryFireDac;

interface

uses FireDAC.Comp.Client, untDataModule, uMovimentacaoHorasModel,
     System.SysUtils, uMovimentacaoHorasRepository, System.Generics.Collections;

type

 //TInterfacedObject serve p/ o delphi controlar automaticamente a memoria da classe implementada e destruindo ela quando necessário
  TMovimentacaoHorasRepositoryFireDac = class(TInterfacedObject, IMovimentacaoHorasRepository)

     public

      procedure salvar(movimentacaoHoras: TMovimentacaoHoras);
      procedure alterar(movimentacaoHoras: TMovimentacaoHoras);
      procedure excluir(id: integer);
      function  listar(idTipoAtividade, idAtividade: Integer; dataInicial,
                       dataFinal: TDate; obs: string): TObjectList<TMovimentacaoHoras>;
      function  calcularTotalHorasPorColuna(idTipoAtividade, idAtividade: Integer;
                       dataInicial, dataFinal: TDate; obs: string): TObjectList<TMovimentacaoHoras>;
      function  selecionarCelula(data: TDate; descricao: string): TMovimentacaoHoras;

  end;


implementation

{ TMovimentacaoHorasRepository }

procedure TMovimentacaoHorasRepositoryFireDac.alterar(
  movimentacaoHoras: TMovimentacaoHoras);
var
  query: TFDQuery;
begin
  query:= TFDQuery.Create(nil);
  try
    try
      query.Connection:= DataModule1.FDConnection;

      query.SQL.Text:= 'UPDATE MOVIMENTACAOHORA SET DATA=:DATA, OBS=:OBS, QTDE_HORAS=:QTDE_HORAS, '+
                       'ACORDAR=:ACORDAR, ID_ATIVIDADE=:ID_ATIVIDADE '+
                       'WHERE ID=:ID ';
      query.ParamByName('ID').AsInteger:= movimentacaoHoras.id;
      query.ParamByName('DATA').AsDate:= movimentacaoHoras.data;
      query.ParamByName('OBS').AsString:= movimentacaoHoras.obs;
      query.ParamByName('QTDE_HORAS').AsTime:= movimentacaoHoras.qtdeHoras;
      query.ParamByName('ACORDAR').AsTime:= movimentacaoHoras.acordar;
      query.ParamByName('ID_ATIVIDADE').AsInteger:= movimentacaoHoras.atividade.id;
      query.ExecSQL;
    except
      raise
    end;
  finally
    query.Free;
  end;

end;

function TMovimentacaoHorasRepositoryFireDac.calcularTotalHorasPorColuna(
   idTipoAtividade, idAtividade: integer; dataInicial, dataFinal: TDate;
  obs: string): TObjectList<TMovimentacaoHoras>;
var
  movimentacaoHoras: TMovimentacaoHoras;
  query: TFDquery;
begin

  query:= TFDQuery.Create(nil);

  try
    query.Connection:= DataModule1.FDConnection;

    Result := TObjectList<TMovimentacaoHoras>.Create(True); // True = OwnsObjects

    query.SQL.Clear;
    query.SQL.Add(' SELECT TOTALHORAS.DESCRICAO,                                     ');
    query.SQL.Add(' case when (QTDE_HORAS/3600) > 10 then ''''||(QTDE_HORAS/3600)    ');
    query.SQL.Add(' else (QTDE_HORAS/3600) end ||'':''||                             ');
    query.SQL.Add('   CASE when ((QTDE_HORAS-((QTDE_HORAS)/3600)*3600)/60) < 10 then ');
    query.SQL.Add(' ''0''||((QTDE_HORAS-((QTDE_HORAS)/3600)*3600)/60) else           ');
    query.SQL.Add(' ((QTDE_HORAS-((QTDE_HORAS)/3600)*3600)/60) end AS TOTAL_HORAS    ');
    query.SQL.Add(' FROM                                                             ');
    query.SQL.Add(' (                                                                ');
    query.SQL.Add(' SELECT ATI.DESCRICAO,                                            ');
    query.SQL.Add('   CAST(SUM(                                                      ');
    query.SQL.Add('       EXTRACT( HOUR FROM QTDE_HORAS ) * 3600 +                   ');
    query.SQL.Add('       EXTRACT( MINUTE FROM QTDE_HORAS ) * 60 +                   ');
    query.SQL.Add('      EXTRACT( SECOND FROM QTDE_HORAS )                           ');
    query.SQL.Add('   ) AS INTEGER) AS QTDE_HORAS                                    ');
    query.SQL.Add(' FROM MOVIMENTACAOHORA MH INNER JOIN ATIVIDADE  ATI               ');
    query.SQL.Add(' ON MH.ID_ATIVIDADE = ATI.ID                                      ');
    query.SQL.Add(' INNER JOIN TIPOATIVIDADE TAT ON ATI.id_tipoatividade = TAT.ID    ');
    query.SQL.Add(' WHERE 1=1                                                        ');
    if (dataInicial <> 0) and (dataFinal <> 0) then
    begin
      query.SQL.Add(' AND DATA BETWEEN :DATAINICIAL AND :DATAFINAL                   ');
      query.ParamByName('DATAINICIAL').AsDate:= dataInicial;
      query.ParamByName('DATAFINAL').AsDate:= dataFinal;
    end;
    if obs.Trim <> '' then
    begin
      query.SQL.Add(' AND MH.OBS LIKE :OBS                                           ');
      query.ParamByName('OBS').AsString:= '%' + obs + '%';
    end;
    if idAtividade <> 0 then
    begin
      query.SQL.Add(' AND MH.ID_ATIVIDADE =:ID_ATIVIDADE                             ');
      query.ParamByName('ID_ATIVIDADE').AsInteger:= idAtividade;
    end;
    if idTipoAtividade <> 0 then
    begin
      query.SQL.Add(' AND ATI.ID_TIPOATIVIDADE =:ID_TIPOATIVIDADE                    ');
      query.ParamByName('ID_TIPOATIVIDADE').AsInteger:= idTipoAtividade;
    end;
    query.SQL.Add(' GROUP BY ATI.DESCRICAO ) TOTALHORAS                              ');
    query.SQL.Add(' ORDER BY TOTALHORAS.DESCRICAO                                    ');

    query.Open();
    query.First;

    while not query.Eof do
    begin
      movimentacaoHoras := TMovimentacaoHoras.Create;

      movimentacaoHoras.totalHoras := query.FieldByName('TOTAL_HORAS').AsString;
      movimentacaoHoras.Atividade.Descricao := query.FieldByName('DESCRICAO').AsString;

      Result.Add(movimentacaoHoras);

      query.Next;
    end;
  finally
    query.Free;
  end;

end;


procedure TMovimentacaoHorasRepositoryFireDac.excluir(id: integer);
var
  query: TFDquery;
begin
  query:= TFDquery.Create(nil);
  try
    try
      query.Connection:= DataModule1.FDConnection;
      query.SQL.Text:= 'DELETE FROM MOVIMENTACAOHORA WHERE ID=:ID';
      query.ParamByName('ID').AsInteger := id;
      query.ExecSQL;
    except
      raise
    end;
  finally
    query.Free;
  end;
end;

function TMovimentacaoHorasRepositoryFireDac.listar(
  idTipoAtividade, idAtividade: integer; dataInicial, dataFinal: TDate; obs: string): TObjectList<TMovimentacaoHoras>;
var
  movimentacaoHoras: TMovimentacaoHoras;
  query: TFDquery;
begin
  Result := TObjectList<TMovimentacaoHoras>.Create(True); // True = OwnsObjects

  query:= TFDquery.Create(nil);

  try
    query.Connection:= DataModule1.FDConnection;
    query.SQL.Clear;
    query.SQL.Add(' SELECT MH.ID, MH.DATA, MH.QTDE_HORAS, MH.OBS, MH.ACORDAR, MH.ID_ATIVIDADE,     ');
    query.SQL.Add(' ATI.DESCRICAO, ATI.ID_TIPOATIVIDADE                                            ');
    query.SQL.Add(' FROM MOVIMENTACAOHORA MH INNER JOIN ATIVIDADE ATI ON MH.ID_ATIVIDADE = ATI.ID  ');
    query.SQL.Add(' INNER JOIN TIPOATIVIDADE TAT ON ATI.id_tipoatividade = TAT.ID                  ');
    query.SQL.Add(' WHERE 1=1                                                                      ');
    if (dataInicial <> 0) and (dataFinal <> 0) then
    begin
      query.SQL.Add(' AND DATA BETWEEN :DATAINICIAL AND :DATAFINAL                                 ');
      query.ParamByName('DATAINICIAL').AsDate:= dataInicial;
      query.ParamByName('DATAFINAL').AsDate:= dataFinal;
    end;
    if obs.Trim <> '' then
    begin
      query.SQL.Add(' AND MH.OBS LIKE :OBS                                                         ');
      query.ParamByName('OBS').AsString:= '%' + obs + '%';
    end;
    if idAtividade <> 0 then
    begin
      query.SQL.Add(' AND MH.ID_ATIVIDADE =:ID_ATIVIDADE                                           ');
      query.ParamByName('ID_ATIVIDADE').AsInteger:= idAtividade;
    end;
    if idTipoAtividade <> 0 then
    begin
      query.SQL.Add(' AND ATI.ID_TIPOATIVIDADE =:ID_TIPOATIVIDADE                                  ');
      query.ParamByName('ID_TIPOATIVIDADE').AsInteger:= idTipoAtividade;
    end;

    query.Open();

    query.First;

    while not query.Eof do
    begin
      movimentacaoHoras := TMovimentacaoHoras.Create;

      movimentacaoHoras.id := query.FieldByName('ID').AsInteger;
      movimentacaoHoras.data := query.FieldByName('DATA').AsDateTime;
      movimentacaoHoras.qtdeHoras := query.FieldByName('QTDE_HORAS').AsDateTime;
      movimentacaoHoras.obs := query.FieldByName('OBS').AsString;
      movimentacaoHoras.acordar := query.FieldByName('ACORDAR').AsDateTime;

      movimentacaoHoras.Atividade.id := query.FieldByName('ID_ATIVIDADE').AsInteger;
      movimentacaoHoras.Atividade.descricao := query.FieldByName('DESCRICAO').AsString;

      movimentacaoHoras.atividade.tipoAtividade.id:= query.FieldByName('ID_TIPOATIVIDADE').AsInteger;

      Result.Add(movimentacaoHoras);

      query.Next;
    end;
  finally
    query.Free;
  end;

end;

procedure TMovimentacaoHorasRepositoryFireDac.salvar(
  movimentacaoHoras: TMovimentacaoHoras);
var
  query: TFDquery;
begin
  query:= TFDquery.Create(nil);
  try
    try
      query.Connection:= DataModule1.FDConnection;
      query.SQL.Text:= 'INSERT INTO MOVIMENTACAOHORA (DATA, OBS, QTDE_HORAS, ACORDAR, ID_ATIVIDADE)' +
                       ' VALUES (:DATA, :OBS, :QTDE_HORAS, :ACORDAR, :ID_ATIVIDADE) ';
      query.ParamByName('DATA').AsDate:= movimentacaoHoras.data;
      query.ParamByName('OBS').AsString:= movimentacaoHoras.obs;
      query.ParamByName('QTDE_HORAS').AsTime:= movimentacaoHoras.qtdeHoras;
      query.ParamByName('ACORDAR').AsTime:= movimentacaoHoras.acordar;
      query.ParamByName('ID_ATIVIDADE').AsInteger := movimentacaoHoras.atividade.id;
      query.ExecSQL;
    except
      raise
    end;
  finally
    query.Free;
  end;

end;

function TMovimentacaoHorasRepositoryFireDac.selecionarCelula(data: TDate;
  descricao: string): TMovimentacaoHoras;
var
  movimentacaoHoras: TMovimentacaoHoras;
  query: TFDquery;
begin
  query:= TFDQuery.Create(nil);

  try
    query.Connection:= DataModule1.FDConnection;
    query.SQL.Clear;
    query.SQL.Add(' SELECT MH.ID, MH.DATA, MH.QTDE_HORAS, MH.OBS, MH.ACORDAR, MH.ID_ATIVIDADE,     ');
    query.SQL.Add(' ATI.DESCRICAO                                                                  ');
    query.SQL.Add(' FROM MOVIMENTACAOHORA MH INNER JOIN ATIVIDADE ATI ON MH.ID_ATIVIDADE = ATI.ID  ');
    query.SQL.Add(' INNER JOIN TIPOATIVIDADE TAT ON ATI.id_tipoatividade = TAT.ID                  ');
    query.SQL.Add(' WHERE DATA =:DATA AND ATI.DESCRICAO =:DESCRICAO                                ');
    query.ParamByName('DATA').AsDate:= data;
    query.ParamByName('DESCRICAO').AsString:= descricao;
    query.Open();

    movimentacaoHoras := TMovimentacaoHoras.Create;

    movimentacaoHoras.id := query.FieldByName('ID').AsInteger;
    movimentacaoHoras.data := query.FieldByName('DATA').AsDateTime;
    movimentacaoHoras.qtdeHoras := query.FieldByName('QTDE_HORAS').AsDateTime;
    movimentacaoHoras.obs := query.FieldByName('OBS').AsString;
    movimentacaoHoras.acordar := query.FieldByName('ACORDAR').AsDateTime;

    movimentacaoHoras.Atividade.id := query.FieldByName('ID_ATIVIDADE').AsInteger;
    movimentacaoHoras.Atividade.descricao := query.FieldByName('DESCRICAO').AsString;

    result:= movimentacaoHoras;
  finally
    query.Free;
  end;

end;

end.
