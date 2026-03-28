unit uAtividadeEndPoint;

interface

uses Web.HTTPApp;

type

  TAtividadeEndPoint = class
    public
      class procedure handle(request: TWebRequest; response: TWebResponse);

  end;

implementation

uses uAtividadeApiController, uAtividadeModel, uTipoAtividadeModel, System.JSON,
     System.SysUtils, System.Generics.Collections;

{ TAtividadeEndPoint }

class procedure TAtividadeEndPoint.handle(request: TWebRequest;
  response: TWebResponse);
var
  atividadeApiController: TAtividadeApiController;
  listaAtividade: TObjectList<TAtividade>;

  objAtividade: TJSONObject;
  json: TJSONObject;
  jsonTipoAtividade: TJSONObject;
  arrayAtividade: TJSONArray;

  atividade: TAtividade;
begin

  if request.Method = 'GET' then
  begin
    atividadeApiController:= TAtividadeApiController.Create;
    arrayAtividade:= TJSONArray.Create;

    try

      try

        listaAtividade:= atividadeApiController.listar;

        for atividade in listaAtividade do
        begin
          // cria o objeto do tipo
          jsonTipoAtividade := TJSONObject.Create;
          jsonTipoAtividade.AddPair('id', TJSONNumber.Create(atividade.tipoAtividade.id));
          jsonTipoAtividade.AddPair('descricao', atividade.tipoAtividade.descricao);

          //  cria o objeto principal (FALTAVA ISSO)
          objAtividade := TJSONObject.Create;
          objAtividade.AddPair('id', TJSONNumber.Create(atividade.id));
          objAtividade.AddPair('descricao', atividade.descricao);
          objAtividade.AddPair('obs', atividade.obs);

          //  aqui adiciona o objeto aninhado
          objAtividade.AddPair(TJSONPair.Create('tipoAtividade', jsonTipoAtividade));

          // adiciona no array
          arrayAtividade.AddElement(objAtividade);

        end;

        response.ContentType:='application/json';
        response.content:= arrayAtividade.ToString;
      except
        on E: Exception do
        begin
          response.StatusCode:=500;
          response.content:= 'Erro: ' + E.Message;
        end;

      end;
    finally
      atividadeApiController.Free;
      listaAtividade.Free;
      arrayAtividade.Free;
    end;

  end
  else if request.Method = 'POST' then
  begin
    atividadeApiController:= TAtividadeApiController.Create;
    atividade:= TAtividade.create;

    json:= TJSONObject.ParseJSONValue(request.Content) as TJSONObject;

    Writeln('ID recebido atividade: ' + json.GetValue<string>('id'));

    if not Assigned(json) then
      raise Exception.Create('JSON inválido ou não recebido');

    try
      atividade.id:= json.GetValue<integer>('id');
      atividade.descricao:= json.GetValue<string>('descricao');
      atividade.obs:= json.GetValue<string>('obs');
      atividade.tipoAtividade.id:= json.GetValue<integer>('id_tipoatividade');

      //jsonTipoAtividade:= json.GetValue<TJSONObject>('tipoAtividade');

     { if assigned(jsonTipoAtividade) then
      begin
        atividade.tipoAtividade:= TTipoAtividade.create;
        atividade.id:= jsonTipoAtividade.GetValue<integer>('id');
        atividade.descricao:= jsonTipoAtividade.GetValue<string>('descricao');
      end; }

      atividadeApiController.salvar(atividade);

    finally
      atividade.Free;
      json.Free;
     // jsonTipoAtividade.Free;
      atividadeApiController.Free;
    end;


  end;

end;

end.
