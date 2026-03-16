unit uTipoAtividadeModel;

interface

type

  TTipoAtividade = class
    private
      Fid   : integer;
      FDescricao : string;
    public
      property id        : integer read Fid write Fid;
      property descricao : string read FDescricao write FDescricao;

  end;

implementation

end.
