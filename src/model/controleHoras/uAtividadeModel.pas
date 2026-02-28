unit uAtividadeModel;

interface

uses uTipoAtividadeModel;

type

  TAtividade = class
    private
      FId            : integer;
      FDescricao     : string;
      FObs           : string;
      FTipoAtividade : TTipoAtividade;

    public
      constructor create;
      destructor destroy;
      property id: integer read FId write FId;
      property descricao: string read FDescricao write FDescricao;
      property obs: string read FObs write FObs;
      property tipoAtividade: TTipoAtividade read FTipoAtividade write FTipoAtividade;

  end;

implementation

{ TAtividade }

constructor TAtividade.create;
begin
  inherited;
  FTipoAtividade := TTipoAtividade.create;
end;

destructor TAtividade.destroy;
begin
  FTipoAtividade.Free;
  inherited;
end;

end.
