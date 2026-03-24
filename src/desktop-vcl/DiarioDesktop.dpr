program DiarioDesktop;

uses
  Vcl.Forms,
  untMenu in 'FormsVCL\untMenu.pas' {frmMenu},
  untAtividade in 'FormsVCL\controleHoras\untAtividade.pas' {frmAtividade},
  untTipoAtividade in 'FormsVCL\controleHoras\untTipoAtividade.pas' {frmTipoAtividade},
  untMovimentacaoHoras in 'FormsVCL\controleHoras\untMovimentacaoHoras.pas' {frmMovimentacaoHoras},
  untDataModule in '..\dataModule\dataModuleVCL\untDataModule.pas' {DataModule1: TDataModule},
  untFormBase in 'FormsVCL\untFormBase.pas' {frmFormBase},
  uTipoAtividadeRepositoryApiRest in '..\shared\repositoryApiRest\controleHoras\uTipoAtividadeRepositoryApiRest.pas',
  uConfig in 'classesVCL\uConfig.pas',
  uControleHorasRepositoryFactory in 'classesVCL\controleHoras\uControleHorasRepositoryFactory.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
