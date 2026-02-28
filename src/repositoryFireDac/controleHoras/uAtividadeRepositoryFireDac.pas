unit uAtividadeRepositoryFireDac;

interface

uses
  uAtividadeModel, FireDAC.Comp.Client, System.Generics.Collections,
  untDataModule, System.SysUtils, System.Variants, uAtividadeRepository;

type
  TAtividadeRepositoryFireDac = class(TInterfacedObject, IAtividadeRepository)

    public
      procedure salvar(atividade: TAtividade);
      procedure alterar(atividade: TAtividade);
      procedure excluir(id: integer);
      function listar(idAtividade, idTipoAtividade: integer; obs: string): TObjectList<TAtividade>;

  End;

implementation

procedure TAtividadeRepositoryFireDac.salvar(atividade: TAtividade);
var
  query: TFDQuery;
begin
  query:= TFDQuery.Create(nil);

  try
    query.Connection:= DataModule1.FDConnection;
    query.SQL.Text:= 'INSERT INTO ATIVIDADE(DESCRICAO, OBS, ID_TIPOATIVIDADE) VALUES '+
                                            '(:DESCRICAO, :OBS, :ID_TIPOATIVIDADE)';
    query.ParamByName('DESCRICAO').AsString:= atividade.descricao;
    query.ParamByName('OBS').AsString:= atividade.obs;
    query.ParamByName('ID_TIPOATIVIDADE').AsInteger:= atividade.tipoAtividade.id;
    query.ExecSQL;
  finally
    query.Free;
  end;

end;

procedure TAtividadeRepositoryFireDac.alterar(atividade: TAtividade);
var
  query: TFDquery;
begin
  query:= TFDQuery.Create(nil);

  try
    query.Connection:= DataModule1.FDConnection;
    query.SQL.Text:= 'UPDATE ATIVIDADE SET DESCRICAO=:DESCRICAO, OBS=:OBS,  '+
                     'ID_TIPOATIVIDADE=:ID_TIPO_ATIVIDADE WHERE ID=:ID      ';
    query.ParamByName('ID').AsInteger:= atividade.id;
    query.ParamByName('DESCRICAO').AsString:= atividade.descricao;
    query.ParamByName('OBS').AsString:= atividade.obs;
    query.ParamByName('ID_TIPO_ATIVIDADE').AsInteger:= atividade.tipoAtividade.id;
    query.ExecSQL;
  finally
    query.Free;
  end;
end;

procedure TAtividadeRepositoryFireDac.excluir(id: integer);
var
  query : TFDQuery;
begin
  query:= TFDQuery.Create(nil);

  try
    query.Connection:= DataModule1.FDConnection;
    query.SQL.Text:= 'DELETE FROM ATIVIDADE WHERE ID=:ID';
    query.ParamByName('ID').AsInteger:= id;
    query.ExecSQL;
  finally
    query.Free;
  end;
end;

function TAtividadeRepositoryFireDac.listar(idAtividade, idTipoAtividade: integer;
                                            obs: string): TObjectList<TAtividade>;
var
  query : TFDquery;
  atividade: TAtividade;
begin
  Result := TObjectList<TAtividade>.Create(True); //Aqui é quando o objeto que instanciou aqui (lista) quando der free tambem libera o TAtividade da memoria

  query := TFDQuery.Create(nil);

  try
    query.Connection:= DataModule1.FDConnection;
    query.SQL.Clear;
    query.SQL.Add(' SELECT ATI.ID, ATI.DESCRICAO, ATI.OBS,                                          ');
    query.SQL.Add(' ATI.ID_TIPOATIVIDADE, TA.DESCRICAO as TIPO_DESCRICAO                            ');
    query.SQL.Add(' FROM ATIVIDADE ATI INNER JOIN TIPOATIVIDADE TA ON ATI.ID_TIPOATIVIDADE = TA.ID  ');
    query.SQL.Add(' WHERE 1=1                                                                       ');

    if obs.Trim <> '' then
    begin
      query.SQL.Add(' AND OBS LIKE ''%'' :OBS ''%''                                                ');
      query.ParamByName('OBS').AsString:= obs;
    end;
    if idAtividade <> 0 then
    begin
      query.SQL.Add(' AND ATI.ID =:ID                                                              ');
      query.ParamByName('ID').AsInteger:= idAtividade;
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
      atividade := TAtividade.Create;

      atividade.Id := query.FieldByName('ID').AsInteger;
      atividade.descricao := query.FieldByName('DESCRICAO').AsString;
      atividade.Obs := query.FieldByName('OBS').AsString;
      atividade.tipoAtividade.id := query.FieldByName('ID_TIPOATIVIDADE').AsInteger;
      atividade.tipoAtividade.descricao:=  query.FieldByName('TIPO_DESCRICAO').AsString;

      Result.Add(atividade);

      query.Next;
    end;

  finally
    query.Free;
  end;

end;

end.
