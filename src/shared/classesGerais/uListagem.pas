//////ESTA UNIT É UTILIZADA P/ ALIMENTAR COMPONENTES VCL CONECTADOS COM BANCO DE DADOS
//////ESTA UNIT É P/ SER UTILIZADA EM LISTAGENS COM POUCOS REGISTROS, NÃO É INDICADO P/ GRANDE NÚMERO DE REGISTROS
//////ESTA UNIT CARREGA TODOS OS DADOS DA TABELA NO CLIENTDATASET, A PESQUISA NAS UNITS C/ DFM SÃO FEITAS NO PRÓPRIO CLIENTDATASET QUE ESTÁ CARREGADO COM TODOS OS REGISTRO

unit uListagem;

interface

uses Datasnap.DBClient, System.Generics.Collections, uAtividadeModel, uTipoAtividadeModel,
uAtividadeController, uAtividadeService, uAtividadeRepositoryFireDac, Data.DB,
uTipoAtividadeController, uTipoAtividadeService, uTipoAtividadeRepositoryFireDac;

type
  TTipoListagem = (tlAtividade, tlAtividadePesquisa);//ENUM

  TListagem= class
     private
       FAtividadeController: TAtividadeController;
       FTipoAtividadeController: TTipoAtividadeController;
     public
     cdsAtividade, cdsAtividadePesquisa, cdsTipoAtividade: TClientDataSet;
     constructor create(atividadeController: TAtividadeController;
                        tipoAtividadeController: TTipoAtividadeController);
     destructor destroy; override;
     procedure alimentarAtividade(tipo: TTipoListagem);
     procedure alimentarTipoAtividade;

  end;

implementation

{ TListagem }

procedure TListagem.alimentarAtividade(tipo: TTipoListagem);
var
  lista : TObjectList<TAtividade>;
  atividade: TAtividade;
begin
  lista:= FAtividadeController.listar(0,0,'');

  if tipo = tlAtividade then
  begin
    cdsAtividade.DisableControls;
    try
      cdsAtividade.close;
      cdsAtividade.FieldDefs.Clear;
      cdsAtividade.FieldDefs.Add('ID', ftInteger, 0, false);
      cdsAtividade.FieldDefs.Add('DESCRICAO', ftString, 100, false);
      cdsAtividade.FieldDefs.Add('OBS', ftString, 200, false);
      cdsAtividade.FieldDefs.Add('TIPO_DESCRICAO', ftString, 100, false);
      cdsAtividade.FieldDefs.Add('ID_TIPOATIVIDADE', ftInteger, 0, false);
      cdsAtividade.CreateDataSet;

      for atividade in Lista do
      begin
        cdsAtividade.Append;
        cdsAtividade.FieldByName('ID').AsInteger := atividade.Id;
        cdsAtividade.FieldByName('DESCRICAO').AsString := atividade.descricao;
        cdsAtividade.FieldByName('OBS').AsString := atividade.obs;
        cdsAtividade.FieldByName('TIPO_DESCRICAO').AsString := atividade.tipoAtividade.descricao;
        cdsAtividade.FieldByName('ID_TIPOATIVIDADE').AsInteger := atividade.tipoAtividade.id;
        cdsAtividade.Post;
      end;

    finally
      cdsAtividade.EnableControls;
      lista.Free; //dou free porque o listar vai até o TAtividadeRepositoryFireDac.listar onde tem  Result := TObjectList<TAtividade>.Create(True);
    end;
  end
  else if tipo = tlAtividadePesquisa then
  begin
    cdsAtividadePesquisa.DisableControls;
    try
      cdsAtividadePesquisa.close;
      cdsAtividadePesquisa.FieldDefs.Clear;
      cdsAtividadePesquisa.FieldDefs.Add('ID', ftInteger, 0, false);
      cdsAtividadePesquisa.FieldDefs.Add('DESCRICAO', ftString, 100, false);
      cdsAtividadePesquisa.FieldDefs.Add('OBS', ftString, 200, false);
      cdsAtividadePesquisa.FieldDefs.Add('TIPO_DESCRICAO', ftString, 100, false);
      cdsAtividadePesquisa.FieldDefs.Add('ID_TIPOATIVIDADE', ftInteger, 0, false);
      cdsAtividadePesquisa.CreateDataSet;

      for atividade in Lista do
      begin
        cdsAtividadePesquisa.Append;
        cdsAtividadePesquisa.FieldByName('ID').AsInteger := atividade.Id;
        cdsAtividadePesquisa.FieldByName('DESCRICAO').AsString := atividade.descricao;
        cdsAtividadePesquisa.FieldByName('OBS').AsString := atividade.obs;
        cdsAtividadePesquisa.FieldByName('TIPO_DESCRICAO').AsString := atividade.tipoAtividade.descricao;
        cdsAtividadePesquisa.FieldByName('ID_TIPOATIVIDADE').AsInteger := atividade.tipoAtividade.id;
        cdsAtividadePesquisa.Post;
      end;

    finally
      cdsAtividadePesquisa.EnableControls;
      lista.Free;
    end;
  end;

end;

procedure TListagem.alimentarTipoAtividade;
var
  lista: TObjectList<TTipoAtividade>;
  tipoAtividade: TTipoAtividade;
begin
  lista:= FTipoAtividadeController.listar('');
  cdsTipoAtividade.DisableControls;
  try
    cdsTipoAtividade.close;
    cdsTipoAtividade.FieldDefs.Clear;
    cdsTipoAtividade.FieldDefs.Add('ID', ftInteger, 0, false);
    cdsTipoAtividade.FieldDefs.Add('DESCRICAO', ftString, 100, false);
    cdsTipoAtividade.CreateDataSet;

    for tipoAtividade in Lista do
    begin
      cdsTipoAtividade.Append;
      cdsTipoAtividade.FieldByName('ID').AsInteger := tipoAtividade.Id;
      cdsTipoAtividade.FieldByName('DESCRICAO').AsString := tipoAtividade.descricao;
      cdsTipoAtividade.Post;
    end;

  finally
      cdsTipoAtividade.EnableControls;
      lista.Free;
  end;

end;

constructor TListagem.create(atividadeController: TAtividadeController;
                        tipoAtividadeController: TTipoAtividadeController);
begin

  FAtividadeController := atividadeController;

  FTipoAtividadeController:= tipoAtividadeController;

  cdsAtividade := TClientDataSet.Create(nil);
  cdsAtividadePesquisa:= TClientDataSet.Create(nil);
  cdsTipoAtividade:= TClientDataSet.Create(nil);

end;

destructor TListagem.destroy;
begin
  cdsAtividade.Free;
  cdsAtividadePesquisa.free;
  cdsTipoAtividade.Free;

  inherited;
end;

end.
