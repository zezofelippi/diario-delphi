unit untDataModule;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Comp.Client,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Phys.Intf,
  FireDAC.Phys,
  FireDAC.Phys.FB,
  FireDAC.Phys.IBBase,
  FireDAC.Comp.UI,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.UI.Intf,
  FireDAC.Stan.Error,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  System.IniFiles,
  uFuncoesGerais, FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait, Data.DB,
  Vcl.Dialogs, Vcl.Forms;


type
  TDataModule1 = class(TDataModule)
    FDConnection: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    {$IFDEF MSWINDOWS}
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    {$ENDIF}

    procedure DataModuleCreate(Sender: TObject);
  end;
var
  DataModule1: TDataModule1;
implementation

{$R *.dfm}

{ TDataModule1 }

uses uConfig;


procedure TDataModule1.DataModuleCreate(Sender: TObject);

var
  Ini: TIniFile;
  CaminhoIni: string;
  config: TConfig;
begin
  CaminhoIni := ExtractFilePath(ParamStr(0)) + 'config.ini';

  Ini := TIniFile.Create(CaminhoIni);
  config:= TConfig.create;

  try
    if config.tipoRepositorio = 'FIREBIRD' then
    begin

      try
        FDConnection.Params.Clear;

        FDConnection.Params.Values['DriverID'] :=
          Ini.ReadString('BANCO', 'DriverID', '');

        FDConnection.Params.Values['Database'] :=
          Ini.ReadString('BANCO', 'Database', '');

        FDConnection.Params.Values['User_Name'] :=
          Ini.ReadString('BANCO', 'User_Name', '');

        FDConnection.Params.Values['Password'] :=
          Ini.ReadString('BANCO', 'Password', '');

        FDConnection.Params.Values['Server'] :=
          Ini.ReadString('BANCO', 'Server', '');

        FDConnection.Params.Values['Port'] :=
          Ini.ReadString('BANCO', 'Port', '');
      finally
        Ini.Free;

      end;

      try
        FDConnection.Connected := True;
      except
        on E: exception do
        begin
          CaminhoIni := ExtractFilePath(ParamStr(0));
          logErro(E);
          MessageDlg('Erro ao carregar arquivo config.ini, verificar log.txt na pasta '+
          CaminhoIni, mtError, [mbOK],0);
          Application.Terminate;
        end;
      end;

    end;
  finally
    config.Free;
  end;

end;

end.

