program DiarioApi;
{$APPTYPE CONSOLE}
uses
  System.SysUtils,
  IdHTTPWebBrokerBridge,
  Web.WebReq,
  Web.WebBroker,
  WebModuleUnit1 in 'WebModuleUnit1.pas' {WebModule1: TWebModule},
  uAtividadeController in '..\shared\controller\controleHoras\uAtividadeController.pas',
  uIntervaloTempoController in '..\shared\controller\controleHoras\uIntervaloTempoController.pas',
  uMovimentacaoHorasController in '..\shared\controller\controleHoras\uMovimentacaoHorasController.pas',
  uTipoAtividadeController in '..\shared\controller\controleHoras\uTipoAtividadeController.pas',
  uTipoAtividadeService in '..\shared\service\controleHoras\uTipoAtividadeService.pas',
  uAtividadeService in '..\shared\service\controleHoras\uAtividadeService.pas',
  uIntervaloTempoService in '..\shared\service\controleHoras\uIntervaloTempoService.pas',
  uMovimentacaoHorasService in '..\shared\service\controleHoras\uMovimentacaoHorasService.pas',
  uAtividadeRepository in '..\shared\repository\controleHoras\uAtividadeRepository.pas',
  uIntervaloTempoRepository in '..\shared\repository\controleHoras\uIntervaloTempoRepository.pas',
  uMovimentacaoHorasRepository in '..\shared\repository\controleHoras\uMovimentacaoHorasRepository.pas',
  uTipoAtividadeRepository in '..\shared\repository\controleHoras\uTipoAtividadeRepository.pas',
  uAtividadeRepositoryFireDac in '..\shared\repositoryFireDac\controleHoras\uAtividadeRepositoryFireDac.pas',
  uIntervaloTempoRepositoryFireDac in '..\shared\repositoryFireDac\controleHoras\uIntervaloTempoRepositoryFireDac.pas',
  uMovimentacaoHorasRepositoryFireDac in '..\shared\repositoryFireDac\controleHoras\uMovimentacaoHorasRepositoryFireDac.pas',
  uTipoAtividadeRepositoryFireDac in '..\shared\repositoryFireDac\controleHoras\uTipoAtividadeRepositoryFireDac.pas',
  uAtividadeModel in '..\shared\model\controleHoras\uAtividadeModel.pas',
  uIntervaloTempoModel in '..\shared\model\controleHoras\uIntervaloTempoModel.pas',
  uMovimentacaoHorasModel in '..\shared\model\controleHoras\uMovimentacaoHorasModel.pas',
  uTipoAtividadeModel in '..\shared\model\controleHoras\uTipoAtividadeModel.pas',
  uListagem in '..\shared\classesGerais\uListagem.pas',
  uMensagem in '..\shared\classesGerais\uMensagem.pas',
  uFuncoesGerais in '..\shared\funcoesGerais\uFuncoesGerais.pas',
  untDataModule in '..\dataModule\dataModuleApiLinux\untDataModule.pas' {/ uIndexApiControlle in 'controllerApi\controleHoras\uTipoAtividadeApiControlle.pas';},
  uTipoAtividadeApiController in 'controllerApi\controleHoras\uTipoAtividadeApiController.pas',
  uAtividadeApiController in 'controllerApi\controleHoras\uAtividadeApiController.pas',
  uRouter in 'uRouter.pas',
  uTipoAtividadeEndPoint in 'endPoints\controleHoras\uTipoAtividadeEndPoint.pas',
  uIndexEndPoint in 'endPoints\uIndexEndPoint.pas';

procedure RunServer(APort: Integer);
var
  LServer: TIdHTTPWebBrokerBridge;
begin
  LServer := TIdHTTPWebBrokerBridge.Create(nil);
  try
    LServer.Bindings.Clear;
    with LServer.Bindings.Add do
    begin
      IP := '0.0.0.0';
      Port := APort;
    end;
    LServer.Active := True;
    Writeln('Servidor rodando na porta ', APort);
    //Writeln('Pressione ENTER para encerrar.');

    //Readln;

    while True do
      Sleep(1000);

  finally
    LServer.Free;
  end;
end;

begin
  try
    // Cria DataModule Linux (sem DFM)
    DataModule1 := TDataModule1.Create(nil);
    // Registra WebModuleClass corretamente
    if WebRequestHandler <> nil then
      WebRequestHandler.WebModuleClass := TWebModule1;
    // Inicia servidor
    RunServer(8080);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
