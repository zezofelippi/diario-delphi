unit uAtividadeRepositoryApiRest;

interface

uses uAtividadeRepository, uAtividademodel, System.Generics.Collections,
     System.JSON, System.SysUtils, System.Net.HttpClient, System.Net.HttpClientComponent,
     uTipoAtividadeModel, System.Classes;

type

  TAtividadeRepositoryApiRest = class(TInterfacedObject, IAtividadeRepository)
    private
      FBaseURL: string;
    public
      constructor Create(const ABaseURL: string);
      procedure salvar(atividade: TAtividade);
      procedure alterar(atividade: TAtividade);
      procedure excluir(id: integer);
      function listar(idAtividade, idTipoAtividade: integer;
                      descricao: string): TObjectList<TAtividade>;

  end;

implementation

{ TAtividadeRepositoryApiRest }

procedure TAtividadeRepositoryApiRest.alterar(atividade: TAtividade);
var
  client: TNetHTTPClient;
  json: TJSONObject;
  stream: TStringStream;
begin
  client:= TNetHTTPClient.Create(nil);
  client.ContentType:= 'application/json';

  try
    json:= TJSONObject.Create;
    try
      json.AddPair('id', TJSONNumber.Create(atividade.id));
      json.AddPair('descricao', atividade.descricao);
      json.AddPair('obs', atividade.obs);
      json.AddPair('id_tipoatividade', TJSONNumber.Create(atividade.tipoAtividade.id));

      stream:= TStringStream.Create(json.ToString, TEncoding.UTF8);
      try
        client.Put(FBaseURL + '/atividade', stream);
      finally
        stream.Free;
      end;
    finally
      json.Free;
    end;

  finally
    client.Free;
  end;

end;

constructor TAtividadeRepositoryApiRest.Create(const ABaseURL: string);
begin
  FBaseURL:= ABaseURL;
end;

procedure TAtividadeRepositoryApiRest.excluir(id: integer);
var
  client: TNetHTTPClient;
begin
  client:= TNetHTTPClient.Create(nil);

  try
    client.Delete(FBaseURL + '/atividade?id=' + id.ToString);
  finally
    client.Free;
  end;

end;

function TAtividadeRepositoryApiRest.listar(
  idAtividade, idTipoAtividade: integer; descricao: string): TObjectList<TAtividade>;
var
  client: TNetHTTPClient;
  response: IHTTPResponse;
  jsonArray: TJSONArray;
  objJson: TJSONObject;
  i: integer;
  atividade: TAtividade;
begin
  result:= TObjectList<TAtividade>.Create(true);
  client:= TNetHTTPClient.Create(nil);

  try
    response:= client.get(FBaseURL + '/atividade');

    //response.ContentAsString(nil):= response recebe a resposta (corpo da requisição get) e converte p/ string
    //TJSONObject.ParseJSONValue := transforma o conteudo string convertido acima em objeto json delphi
    //as TJsonArray:= aqui é um cast, veja esse objeto json delphi como um array p/ pode passar no for abaixo
    jsonArray:= TJSONObject.ParseJSONValue(response.ContentAsString(nil)) as TJSONArray;

    for i := 0 to jsonArray.Count -1 do
    begin
      objJson := jsonArray.Items[i] as TJSONObject;

      atividade := TAtividade.Create;
      atividade.id := objJson.GetValue<Integer>('id');
      atividade.descricao := objJson.GetValue<string>('descricao');
      atividade.obs := objJson.GetValue<string>('obs');

      var jsonTipo: TJSONObject;
      jsonTipo := objJson.GetValue<TJSONObject>('tipoAtividade');

      if Assigned(jsonTipo) then
      begin
        atividade.tipoAtividade := TTipoAtividade.Create;
        atividade.tipoAtividade.id := jsonTipo.GetValue<Integer>('id');
        atividade.tipoAtividade.descricao := jsonTipo.GetValue<string>('descricao');
      end;

      Result.Add(atividade);

    end;

  finally
    client.Free;
  end;

end;

procedure TAtividadeRepositoryApiRest.salvar(atividade: TAtividade);
var
  client: TNetHTTPClient;
  json: TJSONObject;
  stream: TStringStream;
begin

  client:= TNetHTTPClient.Create(nil);
  client.ContentType:= 'application/json';

  try
    json:= TJSONObject.Create;
    try
      json.AddPair('id', TJSONNumber.Create(0));
      json.AddPair('descricao', atividade.descricao);
      json.AddPair('obs', atividade.obs);
      json.AddPair('id_tipoatividade', TJSONNumber.Create(atividade.tipoAtividade.id));

      stream:= TStringStream.Create(json.ToString, TEncoding.UTF8);

      try
        client.Post(FBaseURL + '/atividade', stream);
      finally
        client.Free;
      end;
    finally
      stream.Free;
    end;
  finally
    json.Free;
  end;

end;

end.
