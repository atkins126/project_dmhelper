object frmMainScreen: TfrmMainScreen
  Left = 0
  Top = 0
  Caption = 'Main Screen'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mmScreen
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object mmScreen: TMainMenu
    Left = 32
    Top = 16
    object Users1: TMenuItem
      Caption = 'Users'
      object Registry1: TMenuItem
        Caption = 'Registry'
        OnClick = Registry1Click
      end
    end
    object FerramentasdoMestre1: TMenuItem
      Caption = 'DM Tools'
      object Rulesets1: TMenuItem
        Caption = 'Rulesets'
      end
      object CampaignNotesandWorldbuilding1: TMenuItem
        Caption = 'Campaign Notes and Worldbuilding'
        OnClick = CampaignNotesandWorldbuilding1Click
      end
      object MonstersNPCs1: TMenuItem
        Caption = 'Monsters and NPCs'
      end
      object InitiativeCounter1: TMenuItem
        Caption = 'Combat Tracker'
        OnClick = InitiativeCounter1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object mnuClose: TMenuItem
        Caption = 'Close'
        OnClick = mnuCloseClick
      end
    end
    object PlayerTools1: TMenuItem
      Caption = 'Player Tools'
      object CharacterSheet1: TMenuItem
        Caption = 'Character Sheet'
      end
    end
  end
end
