unit uAtividadeRepositoryApiRest;

interface

uses uAtividadeRepository, uAtividademodel, System.Generics.Collections,
     System.JSON, System.SysUtils, System.Net.HttpClient, System.Net.HttpClientComponent,
     uTipoAtividadeModel;

type

  TAtividadeRepositoryApiRest = class(TInterfacedObject, IAtividadeRepository)
    private
      FBaseURL: string;
    public
      constructor Create(const ABaseURL: string);
      procedure salvar(tipoAtividade: TAtividade);
      procedure alterar(tipoAtividade: TAtividade);
      procedure excluir(id: integer);
      function listar(idAtividade, idTipoAtividade: integer;
                      descricao: string): TObjectList<TAtividade>;

  end;

implementation

{ TAtividadeRepositoryApiRest }

procedure TAtividadeRepositoryApiRest.alterar(tipoAtividade: TAtividade);
begin

end;

constructor TAtividadeRepositoryApiRest.Create(const ABaseURL: string);
begin
  FBaseURL:= ABaseURL;
end;

procedure TAtividadeRepositoryApiRest.excluir(id: integer);
begin

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

procedure TAtividadeRepositoryApiRest.salvar(tipoAtividade: TAtividade);
begin

end;

end.
