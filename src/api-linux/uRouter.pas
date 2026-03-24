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

uses uTipoAtividadeEndPoint, uIndexEndPoint;

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
  end;

end;

end.
