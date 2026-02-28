object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 174
  Width = 288
  object FDConnection: TFDConnection
    Params.Strings = (
      'Server=localhost'
      
        'Database=D:\Sistema de Horas Delphi\controle de horas xe6\banco_' +
        'de_dados\base_dados_horas.gdb'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'CharacterSet=UTF8'
      'Protocol=TCPIP'
      'DriverID=FB')
    LoginPrompt = False
    Left = 48
    Top = 40
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 192
    Top = 48
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    VendorLib = 
      'D:\Sistema de Horas Delphi\controle de horas xe6\Win32\Debug\fbc' +
      'lient.dll'
    Left = 128
    Top = 104
  end
end
