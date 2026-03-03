program Diario;

uses
  Vcl.Forms,
  FireDAC.Phys.FB,
  FireDAC.Phys.IBBase,
  FireDAC.Stan.Intf,
  FireDAC.VCLUI.Wait,
  untAtividade in 'src\view\FormsVCL\controleHoras\untAtividade.pas' {frmAtividade},
  uAtividadeModel in 'src\model\controleHoras\uAtividadeModel.pas',
  uAtividadeRepository in 'src\repository\controleHoras\uAtividadeRepository.pas',
  uAtividadeService in 'src\service\controleHoras\uAtividadeService.pas',
  untDataModule in 'src\dataModule\untDataModule.pas' {DataModule1: TDataModule},
  untMenu in 'src\view\FormsVCL\untMenu.pas' {frmMenu},
  uAtividadeController in 'src\controller\controleHoras\uAtividadeController.pas',
  uTipoAtividadeModel in 'src\model\controleHoras\uTipoAtividadeModel.pas',
  untTipoAtividade in 'src\view\FormsVCL\controleHoras\untTipoAtividade.pas' {frmTipoAtividade},
  uTipoAtividadeRepository in 'src\repository\controleHoras\uTipoAtividadeRepository.pas',
  uTipoAtividadeService in 'src\service\controleHoras\uTipoAtividadeService.pas',
  uTipoAtividadeController in 'src\controller\controleHoras\uTipoAtividadeController.pas',
  untFormBase in 'src\view\FormsVCL\untFormBase.pas' {frmFormBase},
  uMensagem in 'src\classesGerais\uMensagem.pas',
  untMovimentacaoHoras in 'src\view\FormsVCL\controleHoras\untMovimentacaoHoras.pas' {frmMovimentacaoHoras},
  uMovimentacaoHorasModel in 'src\model\controleHoras\uMovimentacaoHorasModel.pas',
  uMovimentacaoHorasRepositoryFireDac in 'src\repositoryFireDac\controleHoras\uMovimentacaoHorasRepositoryFireDac.pas',
  uMovimentacaoHorasService in 'src\service\controleHoras\uMovimentacaoHorasService.pas',
  uMovimentacaoHorasController in 'src\controller\controleHoras\uMovimentacaoHorasController.pas',
  uMovimentacaoHorasRepository in 'src\repository\controleHoras\uMovimentacaoHorasRepository.pas',
  uAtividadeRepositoryFireDac in 'src\repositoryFireDac\controleHoras\uAtividadeRepositoryFireDac.pas',
  uTipoAtividadeRepositoryFireDac in 'src\repositoryFireDac\controleHoras\uTipoAtividadeRepositoryFireDac.pas',
  uListagem in 'src\classesGerais\uListagem.pas',
  uMovimentacaoHorasGerarHtml in 'src\view\relatoriosHtml\controleHoras\uMovimentacaoHorasGerarHtml.pas',
  uFuncoesGerais in 'src\funcoesGerais\uFuncoesGerais.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
