unit uTipoAtividadeEndPoint;

interface

uses Web.HTTPApp;

type

  TTipoAtividadeEndPoint = class
    public
      class procedure handle(request: TWebRequest; response: TWebResponse);
  end;

implementation

uses uTipoAtividadeApiController, uTipoAtividadeModel, System.JSON,
     System.SysUtils, System.Generics.Collections;

{ TTipoAtividadeEndPoint }

class procedure TTipoAtividadeEndPoint.handle(request: TWebRequest;
  response: TWebResponse);
var
  tipoAtividadeApiController: TTipoAtividadeApiController;
  listaTipoAtividade : TObjectList<TTipoAtividade>;

  json : TJSONObject;
  arrayTipoAtividade: TJSONArray;

  tipoAtividade: TTipoAtividade;
begin
  if request.Method = 'GET' then
  begin
     tipoAtividadeApiController:= TTipoAtividadeApiController.Create;
     arrayTipoAtividade:= TJSONArray.Create;

     try
       listaTipoAtividade:= tipoAtividadeApiController.listar;

       for tipoAtividade in listaTipoAtividade do
       begin
         arrayTipoAtividade.AddElement(
           TJSONObject.Create
             .AddPair('id', TJSONNumber.Create(tipoAtividade.id))
             .AddPair('descricao', tipoAtividade.descricao));
       end;

       Response.ContentType:= 'application/json';
       response.content:= arrayTipoAtividade.ToString;

     finally
       listaTipoAtividade.Free;
       tipoAtividadeApiController.Free;

     end;
  end;

  if request.Method = 'POST' then
  begin
    tipoAtividadeApiController:= TTipoAtividadeApiController.Create;

    tipoAtividade:= TTipoAtividade.Create;
    json:= TJSONObject.ParseJSONValue(Request.content) as TJSONObject;

    if not Assigned(json) then
      raise Exception.Create('JSON inválido ou não recebido');

    try
      tipoAtividade.id:= json.GetValue<integer>('id');
      tipoAtividade.descricao:= json.GetValue<string>('descricao');
      tipoAtividadeApiController.salvar(tipoAtividade);
    finally
      tipoAtividade.Free;
      json.Free;
      tipoAtividadeApiController.Free;
    end;

  end;
end;

end.
