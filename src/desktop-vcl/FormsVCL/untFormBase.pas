unit untFormBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.Mask, DateUtils;

type
  TfrmFormBase = class(TForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure limparEdits(Control: TWinControl);
    procedure ajustarUpperCase(control: TWinControl);
    procedure focoComponente(componente: string);
    function verificarTimeMaskEditVazio(maskTime: TMaskEdit): boolean;
  end;

var
  frmFormBase: TfrmFormBase;

implementation

{$R *.dfm}



procedure TfrmFormBase.LimparEdits(Control: TWinControl);
var
  i: Integer;
begin
  for i := 0 to Control.ControlCount - 1 do
  begin
    if Control.Controls[i] is TEdit then
      TEdit(Control.Controls[i]).Clear
    else if Control.Controls[i] is TDBLookupComboBox then
      TDBLookupComboBox(Control.Controls[i]).KeyValue:= null
    else if Control.Controls[i] is TMaskEdit then
      TMaskEdit(Control.Controls[i]).Clear
    else if Control.Controls[i] is TWinControl then //aqui é caso o edit esteja num panel, groupbox, etc, ou seja form nao é o pai direto do edit, faz recursividade até achar edit
      LimparEdits(TWinControl(Control.Controls[i]));
  end;
end;

function TfrmFormBase.verificarTimeMaskEditVazio(maskTime: TMaskEdit): boolean;
var
  campo_str: string;
begin
  campo_str:= Trim(maskTime.Text);

  if campo_str = ':' then
    result:= true
  else
    result:= false;

end;

procedure TfrmFormBase.ajustarUpperCase(control: TWinControl);
var
  i: Integer;
begin
  for i := 0 to control.ControlCount - 1 do
  begin
    if control.Controls[i] is TEdit then
      TEdit(control.Controls[i]).CharCase := ecUpperCase;

    if control.Controls[i] is TWinControl then
      AjustarUpperCase(TWinControl(control.Controls[i]));
  end;
end;

procedure TfrmFormBase.focoComponente(componente: string);
var
  Comp: TComponent;

begin

  Comp := FindComponent('edt' + componente);

  if Comp is TCustomEdit then
    TCustomEdit(Comp).SetFocus
  else if Comp is TDBLookupComboBox then
    TDBLookupComboBox(Comp).SetFocus;


end;

procedure TfrmFormBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree; //destroi o form da memoria
end;

procedure TfrmFormBase.FormCreate(Sender: TObject);
begin
  //self.Width:= 881;
  self.Width:= 1250;
  self.Height:= 789;
  //self.Height:= 589;

  self.Top:= 0;
  self.left:= 0;

  self.Font.Name:= 'Segoe UI';
  self.Font.Size:= 12;

  ajustarUpperCase(self);

end;

procedure TfrmFormBase.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;

  if Key = VK_RETURN then
  begin
    Key := 0;              // cancela o Enter
    Perform(WM_NEXTDLGCTL, 0, 0); // vai para o próximo controle
  end;
end;

end.
