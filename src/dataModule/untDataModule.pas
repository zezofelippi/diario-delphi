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
  FireDAC.Stan.Async, FireDAC.VCLUI.Wait, Data.DB;

type
  TDataModule1 = class(TDataModule)
    FDConnection: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
  private
   // FConnection: TFDConnection;
   // FWaitCursor: TFDGUIxWaitCursor;
   // FDriverLink: TFDPhysFBDriverLink;
  {published
    FDConnection: TFDConnection;
    FWaitCursor: TFDGUIxWaitCursor;
    FDriverLink: TFDPhysFBDriverLink; }

  public

   // constructor Create(AOwner: TComponent); override;
    //destructor Destroy; override;

    //property Connection: TFDConnection read FConnection;
  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.dfm}

//constructor TDataModule1.Create(AOwner: TComponent);
//begin
 { inherited Create(AOwner);

  // === Driver Firebird ===
  FDriverLink := TFDPhysFBDriverLink.Create(Self);
  FDriverLink.VendorLib := 'fbclient.dll';

  // === Wait Cursor ===
  FWaitCursor := TFDGUIxWaitCursor.Create(Self);
  FWaitCursor.Provider := 'Forms';

  // === Conexão ===
  FDConnection := TFDConnection.Create(self);
  FDConnection.Params.Clear;
  FDConnection.DriverName := 'FB';
FDConnection.Params.Add('Database=D:\Sistema de Horas Delphi\controle de horas xe6\banco de dados\base_dados_horas.gdb');
FDConnection.Params.Add('User_Name=SYSDBA');
FDConnection.Params.Add('Password=masterkey');
FDConnection.Params.Add('Protocol=TCPIP');
FDConnection.Params.Add('Server=localhost');
FDConnection.Params.Add('CharacterSet=UTF8');
FDConnection.LoginPrompt := False;
  FDConnection.Connected := True;    }
//end;

{destructor TDataModule1.Destroy;
begin
  FConnection.Free;
  FWaitCursor.Free;
  FDriverLink.Free;
  inherited Destroy;
end;  }

end.

