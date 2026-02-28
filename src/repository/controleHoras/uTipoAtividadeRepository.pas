unit uTipoAtividadeRepository;

interface

uses
  uTipoAtividadeModel, System.Generics.Collections, System.SysUtils;

type
  ITipoAtividadeRepository = Interface
     ['{6117e13f-4602-46c8-846f-0c8ae64c7d44}']
      procedure salvar(tipoAtividade: TTipoAtividade);
      procedure alterar(tipoAtividade: TTipoAtividade);
      procedure excluir(id: integer);
      function listar(descricao: string): TObjectList<TTipoAtividade>;

  end;

implementation


end.
