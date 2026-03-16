unit untDataModule;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Comp.Client,
  FireDAC.Phys.FB,
  FireDAC.Phys.IBBase,
  FireDAC.Phys,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  System.IniFiles,
  uFuncoesGerais,
  FireDAC.DApt,
  FireDAC.Phys.PG,
  FireDAC.Stan.Async;

type
  TDataModule1 = class(TDataModule)
  private
    procedure Initialize; // inicialização manual
  public
    FDConnection: TFDConnection;
  //  FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDPhysPgDriverLink1 : TFDPhysPgDriverLink;
   // constructor Create; reintroduce;
   constructor Create(AOwner: TComponent); override;
  end;

  var
  DataModule1: TDataModule1;

implementation

constructor TDataModule1.Create(AOwner: TComponent);
begin
  inherited CreateNew(AOwner);
 // inherited Create(); // mas sem tentar carregar DFM
  //DataModule1 := TDataModule1.Create();
  //inherited Create(AOwner);
  FDConnection := TFDConnection.Create(self);
 // FDPhysFBDriverLink1 := TFDPhysFBDriverLink.Create(self);
  FDPhysPgDriverLink1 := TFDPhysPgDriverLink.Create(Self);

  FDPhysPgDriverLink1.VendorLib := '/lib/x86_64-linux-gnu/libpq.so';
  Initialize; // configura a conexão
end;

procedure  TDataModule1.Initialize;

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

  try
    FDConnection.Connected := True;
  except
    on E: exception do
    begin
      CaminhoIni := ExtractFilePath(ParamStr(0));
      logErro(E);
       {$IFDEF MSWINDOWS}
      MessageDlg('Erro ao carregar arquivo config.ini, verificar log.txt na pasta '+
      CaminhoIni, mtError, [mbOK],0);
      Application.Terminate;
      {$ENDIF}
    end;
  end;

end;

end.
