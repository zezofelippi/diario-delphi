unit untMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls, uFuncoesGerais;

type
  TfrmMenu = class(TForm)
    CategoryPanelGroup1: TCategoryPanelGroup;
    ctpMenu: TCategoryPanel;
    btnMovimentacaoHoras: TBitBtn;
    btnTipoAtividade: TBitBtn;
    btnCadastroAtividade: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btnMovimentacaoHorasClick(Sender: TObject);
    procedure btnTipoAtividadeClick(Sender: TObject);
    procedure btnCadastroAtividadeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMenu: TfrmMenu;

implementation

{$R *.dfm}

uses untAtividade, untTipoAtividade, untMovimentacaoHoras;

procedure TfrmMenu.btnCadastroAtividadeClick(Sender: TObject);
begin
 if not Assigned(frmAtividade) then
    frmAtividade := TfrmAtividade.Create(Self);

  frmAtividade.Show;
  frmAtividade.WindowState:= wsNormal;
end;

procedure TfrmMenu.btnMovimentacaoHorasClick(Sender: TObject);
begin
 if not Assigned(frmMovimentacaoHoras) then
    frmMovimentacaoHoras := TfrmMovimentacaoHoras.Create(Self);

  frmMovimentacaoHoras.Show;
  frmMovimentacaoHoras.WindowState:= wsNormal;

end;

procedure TfrmMenu.btnTipoAtividadeClick(Sender: TObject);
begin
 if not Assigned(frmTipoAtividade) then
    frmTipoAtividade := TfrmTipoAtividade.Create(Self);

  frmTipoAtividade.Show;
  //frmAtividade.BringToFront;
  frmTipoAtividade.WindowState:= wsNormal;
end;

procedure TfrmMenu.FormCreate(Sender: TObject);
var
  caminhoIni: string;
begin
  CaminhoIni := ExtractFilePath(ParamStr(0)) + 'config.ini';

  if not FileExists(CaminhoIni) then
  begin
    MessageDlg('Arquivo config.ini não encontrado na pasta do projeto ' + CaminhoIni, mtError,[mbOK],0);
    Application.Terminate;
  end;
end;

procedure TfrmMenu.FormShow(Sender: TObject);
begin
  ctpMenu.Collapsed:= true;
end;

end.
