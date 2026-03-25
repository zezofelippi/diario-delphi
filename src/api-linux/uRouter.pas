unit uRouter;

interface

uses Web.HTTPApp;

type

  TRouter = class
    public
      class procedure handleRequest(Request: TWebRequest;
                                    Response: TWebResponse; var Handled: Boolean);
  end;

implementation

uses uTipoAtividadeEndPoint, uIndexEndPoint, uAtividadeEndPoint;

{ TRouter }

class procedure TRouter.handleRequest(Request: TWebRequest;
  Response: TWebResponse; var Handled: Boolean);
begin
  if Request.PathInfo = '/index' then
  begin
    TIndexEndPoint.handle(request, response);
    Handled:= true;
    exit;
  end
  else if Request.PathInfo = '/tipoatividade' then
  begin
    TTipoAtividadeEndPoint.handle(request, response);
    Handled:= true;
    exit;
  end
  else if Request.PathInfo = '/atividade' then
  begin
    TAtividadeEndPoint.handle(request, response);
    handled:= true;
    exit;
  end;

end;

end.
