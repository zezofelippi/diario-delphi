unit uControleHorasRepositoryFactory;

interface

uses uTipoAtividadeRepository, uTipoAtividadeRepositoryFireDac,
     uTipoAtividadeRepositoryApiRest, uAtividadeRepository,
     uAtividadeRepositoryFireDac, uAtividadeRepositoryApiRest,
     uConfig, SysUtils;

type

  TControleHorasRepositoryFactory = class
    public
      class function criarTipoAtividadeRepository: ITipoAtividadeRepository;
      class function criarAtividadeRepository: IAtividadeRepository;
  end;

implementation

{ TRepositoryFactory }

class function TControleHorasRepositoryFactory.criarAtividadeRepository: IAtividadeRepository;
var
  config: TConfig;
begin
  config:= TConfig.create;
  try
    if config.tipoRepositorio = 'API' then
    begin
      if config.baseURL = '' then
        raise Exception.Create('BaseURL da API não configurada no config.ini');

      result:= TAtividadeRepositoryApiRest.Create(config.baseURL);
    end
    else if config.tipoRepositorio = 'FIREBIRD' then
    begin
      Result := TAtividadeRepositoryFireDac.Create;
    end
    else
    begin
      raise Exception.Create('TipoRepositorio inválido no config.ini');
    end;
  finally
    config.Free;
  end;

end;

class function TControleHorasRepositoryFactory.criarTipoAtividadeRepository: ITipoAtividadeRepository;
var
  config: TConfig;
begin
  config:= TConfig.create;

  try
    if config.tipoRepositorio = 'API' then
    begin
      if config.baseURL = '' then
        raise Exception.Create('BaseURL da API não configurada no config.ini');

      result:= TTipoAtividadeRepositoryApiRest.Create(config.baseURL);
    end
    else if config.tipoRepositorio = 'FIREBIRD' then
    begin
      Result := TTipoAtividadeRepositoryFireDac.Create;
    end
    else
    begin
      raise Exception.Create('TipoRepositorio inválido no config.ini');
    end;
  finally
    config.Free;
  end;

end;

end.
