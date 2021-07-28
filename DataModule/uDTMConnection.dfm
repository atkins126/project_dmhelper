object dtmConnection: TdtmConnection
  OldCreateOrder = False
  Height = 221
  Width = 292
  object dbConnection: TFDConnection
    Params.Strings = (
      'Database=D:\MEGA\Programa'#231#227'o\project_dmhelper\Data\dmhelper.db'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 48
    Top = 24
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 136
    Top = 24
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    VendorHome = 'D:\MEGA\Programa'#231#227'o\project_dmhelper\Data\s'
    VendorLib = 'sqlite3.dll'
    Left = 48
    Top = 80
  end
end
