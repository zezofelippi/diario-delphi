unit uAtividadeRepository;

interface

uses
  uAtividadeModel, System.Generics.Collections,  System.SysUtils;

type
  IAtividadeRepository = interface
    ['{2c753e47-a994-4fcd-8b02-feb13bb36f7e}']
    procedure salvar(atividade: TAtividade);
    procedure alterar(atividade: TAtividade);
    procedure excluir(id: integer);
    function listar(idAtividade, idTipoAtividade: integer; obs: string): TObjectList<TAtividade>;

  End;

implementation


end.
