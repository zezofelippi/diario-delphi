unit uIndexEndPoint;

interface

uses Web.HTTPApp;

type
  TIndexEndPoint = class
    public
      class procedure handle(request: TWebRequest; response: TWebResponse);
  end;

implementation

uses uTipoAtividadeApiController, uTipoAtividadeModel, uAtividadeApiController,
     uAtividadeModel, System.JSON, System.SysUtils, System.Generics.Collections;

{ TIndexEndPoint }

class procedure TIndexEndPoint.handle(request: TWebRequest;
  response: TWebResponse);
var
  tipoAtividadeApiController: TTipoAtividadeApiController;
  atividadeApiController: TAtividadeApiController;

  listaTipoAtividade : TObjectList<TTipoAtividade>;
  listaAtividade : TObjectList<TAtividade>;

  json : TJSONObject;
  arrayTipoAtividade: TJSONArray;
  arrayAtividade: TJSONArray;

  tipoAtividade: TTipoAtividade;
  atividade: TAtividade;

begin
  tipoAtividadeApiController:= TTipoAtividadeApiController.Create;
  atividadeApiController:= TAtividadeApiController.Create;

  json := TJSONObject.Create;
  arrayTipoAtividade:= TJSONArray.Create;
  arrayAtividade:= TJSONArray.Create;

  try
    listaTipoAtividade:= tipoAtividadeApiController.Listar;
    listaAtividade:= atividadeApiController.listar;

    for tipoAtividade in listaTipoAtividade do
    begin
      arrayTipoAtividade.AddElement(TJSONObject.Create
                                    .AddPair('id', TJSONNumber.Create(tipoAtividade.id))
                                    .AddPair('descricao',tipoAtividade.descricao));

    end;

    for atividade in listaAtividade do
    begin
      arrayAtividade.AddElement(TJSONObject.Create
                                .AddPair('id', TJSONNumber.Create(atividade.id))
                                .AddPair('descricao', atividade.descricao)
                                .AddPair('obs', atividade.obs)
                                .AddPair('id_tipoatividade',
                                         TJSONNumber.Create(atividade.tipoAtividade.id)));
    end;

    json.AddPair('tipoAtividade', arrayTipoAtividade);
    json.AddPair('atividade', arrayAtividade);

    response.ContentType:= 'application/json';
    response.Content:= json.ToString;

  finally
    tipoAtividadeApiController.Free;
    atividadeApiController.Free;
  end;

end;

end.
