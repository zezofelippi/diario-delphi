unit uTipoAtividadeRepositoryApiRest;

interface

uses uTipoAtividadeRepository, uTipoAtividadeModel, System.Generics.Collections,
     System.Net.HttpClient, System.Net.HttpClientComponent, System.JSON, System.SysUtils,
     System.Classes;

type
  TTipoAtividadeRepositoryApiRest = class(TInterfacedObject, ITipoAtividadeRepository)
    private
      FBaseURL: string;
    public
      constructor Create(const ABaseURL: string);
      procedure salvar(tipoAtividade: TTipoAtividade);
      procedure alterar(tipoAtividade: TTipoAtividade);
      procedure excluir(id: integer);
      function listar( descricao: string): TObjectList<TTipoAtividade>;

  end;

implementation

{ TTipoAtividadeRepositoryApiRest }

procedure TTipoAtividadeRepositoryApiRest.alterar(
  tipoAtividade: TTipoAtividade);
var
  client: TNetHTTPClient;
  //response: THTTPResponse;
  json: TJSONObject;
  stream: TStringStream;
begin
  client:= TNetHTTPClient.Create(nil);
  client.ContentType := 'application/json';

  try
    json:= TJSONObject.Create;
    try
      json.AddPair('id', TJSONNumber.Create(tipoAtividade.id));
      json.AddPair('descricao', tipoAtividade.descricao);

      stream := TStringStream.Create(json.ToString, TEncoding.UTF8);
      try
        client.Put(FBaseURL + '/tipoatividade', stream);
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

constructor TTipoAtividadeRepositoryApiRest.Create(const ABaseURL: string);
begin
  FBaseURL:= ABaseURL;
end;

procedure TTipoAtividadeRepositoryApiRest.excluir(id: integer);
var
  client: TNetHTTPClient;
 // json: TJSONObject;
  //stream: TStringStream;
begin
  client:= TNetHTTPClient.Create(nil);
  client.ContentType:= 'application/json';

  try
    client.Delete(FBaseURL + '/tipoatividade?id=' + id.ToString);
  finally
    client.Free;
  end;

end;

function TTipoAtividadeRepositoryApiRest.listar(
  descricao: string): TObjectList<TTipoAtividade>;
var
  client: TNetHTTPClient;
  response: IHTTPResponse;
  jsonArray: TJSONArray;
  objJson: TJSONObject;
  i: integer;
  tipoatividade: TTipoAtividade;
begin
  result:= TObjectList<TTipoAtividade>.Create(true);
  client:= TNetHTTPClient.Create(nil);
  client.ContentType := 'application/json';

  try
    response:= client.get(FBaseURL + '/tipoatividade');

    //response.ContentAsString(nil):= response recebe a resposta (corpo da requisição get) e converte p/ string
    //TJSONObject.ParseJSONValue := transforma o conteudo string convertido acima em objeto json delphi
    //as TJsonArray:= aqui é um cast, veja esse objeto json delphi como um array p/ pode passar no for abaixo
    jsonArray:= TJSONObject.ParseJSONValue(response.ContentAsString(nil)) as TJSONArray;

    for i := 0 to jsonArray.Count - 1 do
    begin
      objJson:= jsonArray.Items[i] as TJSONObject;

      tipoatividade:= TTipoAtividade.Create;
      tipoatividade.id:= objJson.GetValue<integer>('id');
      tipoatividade.descricao:= objJson.GetValue<string>('descricao');

      result.Add(tipoatividade);
    end;

  finally
    client.Free;
  end;


end;

procedure TTipoAtividadeRepositoryApiRest.salvar(tipoAtividade: TTipoAtividade);
var
  client: TNetHTTPClient;
 // response: IHTTPResponse;
  json: TJSONObject;
  stream: TStringStream;
begin
  client:= TNetHTTPClient.Create(nil);
  client.ContentType := 'application/json';

  try
    json:= TJSONObject.Create;
    try
      json.AddPair('id', TJSONNumber.Create(0));
      json.AddPair('descricao', tipoAtividade.descricao);

      stream:= TStringStream.Create(json.ToString, TEncoding.UTF8);

      try
        client.Post(FBaseURL + '/tipoatividade', stream);
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

end.
