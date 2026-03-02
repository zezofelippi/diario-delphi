unit uTipoAtividadeRepositoryFireDac;

interface

uses
  uTipoAtividadeModel, uTipoAtividadeRepository, FireDAC.Comp.Client,
  System.Generics.Collections, untDataModule, System.SysUtils;

type
  TTipoAtividadeRepositoryFireDac = class(TInterfacedObject, ITipoAtividadeRepository)

    public
      procedure salvar(tipoAtividade: TTipoAtividade);
      procedure alterar(tipoAtividade: TTipoAtividade);
      procedure excluir(id: integer);
      function listar(descricao: string): TObjectList<TTipoAtividade>;

  end;

implementation


procedure TTipoAtividadeRepositoryFireDac.salvar(tipoAtividade: TTipoAtividade);
var
  query: TFDQuery;
begin
  query:= TFDQuery.Create(nil);

  try
    try
      query.Connection:= DataModule1.FDConnection;
      query.SQL.Text:= 'INSERT INTO TIPOATIVIDADE(DESCRICAO) VALUES (:DESCRICAO)';
      query.ParamByName('DESCRICAO').AsString:= tipoAtividade.descricao;
      query.ExecSQL;
    except
      raise
    end;
  finally
    query.Free;
  end;
end;

procedure TTipoAtividadeRepositoryFireDac.alterar(tipoAtividade: TTipoAtividade);
var
  query: TFDQuery;
begin
  query:= TFDQuery.Create(nil);
  try
    try
      query.Connection:= DataModule1.FDConnection;
      query.SQL.Text:= 'UPDATE TIPOATIVIDADE SET DESCRICAO=:DESCRICAO WHERE ID=:ID';
      query.ParamByName('ID').AsInteger:= tipoAtividade.id;
      query.ParamByName('DESCRICAO').AsString:= tipoAtividade.descricao;
      query.ExecSQL;
    except
      raise
    end;
  finally
    query.Free;
  end;

end;

procedure TTipoAtividadeRepositoryFireDac.excluir(id: integer);
var
  query: TFDQuery;
begin
  query:= TFDQuery.Create(nil);
  try
    try
      query.Connection:= DataModule1.FDConnection;
      query.SQL.Text:= 'DELETE FROM TIPOATIVIDADE WHERE ID=:ID';
      query.ParamByName('ID').AsInteger:= id;
      query.ExecSQL;
    except
      raise
    end;
  finally
    query.Free;
  end;
end;

function TTipoAtividadeRepositoryFireDac.listar(descricao: string): TObjectList<TTipoAtividade>;
var
  query: TFDQuery;
  tipoAtividade: TTipoAtividade;
begin
 { if descricao.Trim <> '' then
    descricao:= ' AND DESCRICAO LIKE '+ #39 + '%' + descricao + '%' + #39
  else
    descricao:= '';}
  Result := TObjectList<TTipoAtividade>.Create(True);
  query:= TFDquery.Create(nil);

  try
    query.Connection:= DataModule1.FDConnection;
    query.SQL.Add('SELECT ID, DESCRICAO FROM TIPOATIVIDADE ');
   { if descricao <> '' then
      query.SQL.Add('WHERE DESCRICAO LIKE :DESCRICAO ');
    query.SQL.Add('ORDER BY DESCRICAO');
    if descricao <> '' then
      query.ParamByName('DESCRICAO').AsString:= ''+ #39 + '%' + descricao + '%' + #39; }
    query.Open();

    query.First;

    while not query.Eof do
    begin
      tipoAtividade := TTipoAtividade.Create;

      tipoAtividade.Id := query.FieldByName('ID').AsInteger;
      tipoAtividade.descricao := query.FieldByName('DESCRICAO').AsString;

      Result.Add(tipoAtividade);

      query.Next;
    end;
  finally
    query.Free;
  end;
end;

end.
