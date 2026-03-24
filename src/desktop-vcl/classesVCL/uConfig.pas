unit uConfig;

interface

uses IniFiles, SysUtils;

type

  TConfig = class
    private
      FTipoRepositorio: string;
      FBaseURL: string;
    public
      constructor create;
      property tipoRepositorio: string read FTipoRepositorio;
      property baseURL: string read FBaseURL;

  end;

implementation

{ TConfig }

constructor TConfig.create;
var
  ini: TIniFile;
  caminho: string;
begin
  caminho := ExtractFilePath(ParamStr(0)) + 'config.ini';

  if not FileExists(caminho) then
    raise Exception.Create('Arquivo config.ini não encontrado');

  ini:= TIniFile.Create(caminho);

  try
    FTipoRepositorio:= UpperCase(Trim(
                       ini.ReadString('GERAL', 'TipoRepositorio', '' ))); //se tipoRepositorio estiver errado pega o terceiro parametro ''

    if  FTipoRepositorio = '' then
      raise Exception.Create('TipoRepositorio não definido no config.ini');

    FBaseURL:= Trim(ini.ReadString('API','BaseURL', ''));

  finally
    ini.Free;
  end;

end;

end.
