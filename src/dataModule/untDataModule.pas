unit untDataModule;

interface

uses
  System.SysUtils, System.Classes,
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
  FireDAC.UI.Intf, FireDAC.Stan.Error, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.VCLUI.Wait, Data.DB, System.IniFiles;

type
  TDataModule1 = class(TDataModule)
    FDConnection: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    procedure DataModuleCreate(Sender: TObject);

  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.dfm}

{ TDataModule1 }

procedure TDataModule1.DataModuleCreate(Sender: TObject);
var
  Ini: TIniFile;
  CaminhoIni: string;
begin
  CaminhoIni := ExtractFilePath(ParamStr(0)) + 'config.ini';

  Ini := TIniFile.Create(CaminhoIni);
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

  FDConnection.Connected := True;

end;

end.

