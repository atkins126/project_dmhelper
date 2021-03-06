inherited frmCombatTracker: TfrmCombatTracker
  Caption = 'frmCombatTracker'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcMain: TPageControl
    inherited tabListing: TTabSheet
      inherited pnlListingTop: TPanel
        inherited lblIndex: TLabel
          Top = 23
          ExplicitTop = 23
        end
        object Bestiary: TLabel [1]
          Left = 4
          Top = 68
          Width = 86
          Height = 25
          Caption = 'Bestiary'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label1: TLabel [2]
          Left = 330
          Top = 70
          Width = 80
          Height = 25
          Caption = 'Tracker'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label2: TLabel [3]
          Left = 720
          Top = 70
          Width = 153
          Height = 25
          Caption = 'Monster Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        inherited mskSearch: TMaskEdit
          Left = 4
          Top = 41
          Width = 245
          ExplicitLeft = 4
          ExplicitTop = 41
          ExplicitWidth = 245
        end
        inherited btnSearch: TBitBtn
          Left = 255
          Top = 39
          ExplicitLeft = 255
          ExplicitTop = 39
        end
      end
      inherited grdListing: TDBGrid
        Width = 330
        Align = alLeft
        Columns = <
          item
            Expanded = False
            FieldName = 'cr'
            Title.Caption = 'Challenge'
            Width = 50
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'name'
            Title.Caption = 'Monster'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'type'
            Title.Caption = 'Type & Source'
            Visible = True
          end>
      end
      object pnMonsterInfo: TPanel
        Left = 720
        Top = 97
        Width = 364
        Height = 457
        Align = alRight
        BorderStyle = bsSingle
        Color = 11794687
        ParentBackground = False
        TabOrder = 2
      end
      object pnTracker: TPanel
        Left = 330
        Top = 97
        Width = 390
        Height = 457
        Align = alClient
        BevelOuter = bvNone
        Caption = 'pnTracker'
        TabOrder = 3
        object scrbTracker: TScrollBox
          Left = 0
          Top = 49
          Width = 390
          Height = 344
          Align = alClient
          TabOrder = 0
        end
        object Panel1: TPanel
          Left = 0
          Top = 393
          Width = 390
          Height = 64
          Align = alBottom
          BorderStyle = bsSingle
          TabOrder = 1
          DesignSize = (
            386
            60)
          object Label4: TLabel
            Left = 99
            Top = 4
            Width = 79
            Height = 25
            Anchors = [akTop, akRight, akBottom]
            Caption = 'ROUND'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -21
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitLeft = 105
          end
          object Label5: TLabel
            Left = 213
            Top = 4
            Width = 60
            Height = 25
            Anchors = [akTop, akRight, akBottom]
            Caption = 'TURN'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -21
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitLeft = 219
          end
          object Label6: TLabel
            Left = 103
            Top = 28
            Width = 62
            Height = 25
            Anchors = [akTop, akRight, akBottom]
            Caption = 'VALUE'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -21
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ExplicitLeft = 109
          end
          object Label7: TLabel
            Left = 211
            Top = 28
            Width = 62
            Height = 25
            Anchors = [akTop, akRight, akBottom]
            Caption = 'VALUE'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -21
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ExplicitLeft = 217
          end
          object BitBtn1: TBitBtn
            Left = 297
            Top = 23
            Width = 75
            Height = 25
            Anchors = [akTop, akRight]
            Caption = 'Next'
            TabOrder = 0
            OnClick = NextRound
          end
          object BitBtn2: TBitBtn
            Left = 11
            Top = 23
            Width = 75
            Height = 25
            Caption = 'Undo'
            TabOrder = 1
          end
        end
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 390
          Height = 49
          Align = alTop
          BevelOuter = bvNone
          BorderStyle = bsSingle
          TabOrder = 2
          object btnAddNew: TBitBtn
            AlignWithMargins = True
            Left = 308
            Top = 3
            Width = 75
            Height = 39
            Cursor = crHandPoint
            Align = alRight
            Caption = 'Add Turn'
            TabOrder = 0
            OnClick = btnAddNewClick
          end
          object ComboBox1: TComboBox
            AlignWithMargins = True
            Left = 5
            Top = 12
            Width = 297
            Height = 21
            Margins.Left = 5
            Margins.Top = 12
            Align = alClient
            TabOrder = 1
          end
        end
      end
    end
  end
  inherited pnlFooter: TPanel
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited qryListing: TFDQuery
    Active = True
    SQL.Strings = (
      'SELECT name,'
      '       type,'
      '       cr'
      '    FROM bestiary')
    Left = 832
    Top = 32
  end
  inherited dtsListing: TDataSource
    Left = 904
    Top = 32
  end
  object cdsCombatTracker: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 768
    Top = 32
    object cdsCombatTrackerInitiative: TIntegerField
      FieldName = 'Initiative'
    end
    object cdsCombatTrackerMonsterName: TStringField
      FieldName = 'MonsterName'
      Size = 50
    end
    object cdsCombatTrackerCurrentHP: TIntegerField
      FieldName = 'CurrentHP'
    end
    object cdsCombatTrackerMaxHP: TIntegerField
      FieldName = 'MaxHP'
    end
  end
end
