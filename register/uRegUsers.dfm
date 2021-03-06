inherited frmRegUser: TfrmRegUser
  Caption = 'User Registry'
  ClientHeight = 256
  ClientWidth = 748
  ExplicitWidth = 754
  ExplicitHeight = 285
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcMain: TPageControl
    Width = 748
    Height = 195
    ExplicitWidth = 748
    ExplicitHeight = 195
    inherited tabListing: TTabSheet
      ExplicitWidth = 740
      ExplicitHeight = 167
      inherited pnlListingTop: TPanel
        Width = 740
        Height = 57
        ExplicitWidth = 740
        ExplicitHeight = 57
        inherited lblIndex: TLabel
          Top = 4
          ExplicitTop = 4
        end
        inherited mskSearch: TMaskEdit
          Top = 23
          ExplicitTop = 23
        end
        inherited btnSearch: TBitBtn
          Top = 21
          ExplicitTop = 21
        end
      end
      inherited grdListing: TDBGrid
        Top = 57
        Width = 740
        Height = 110
        Columns = <
          item
            Expanded = False
            FieldName = 'id'
            Title.Caption = 'ID'
            Width = 36
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'name'
            Title.Caption = 'Username'
            Width = 664
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'password'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'user_type'
            Visible = False
          end>
      end
    end
    inherited tabMaintenance: TTabSheet
      ExplicitWidth = 740
      ExplicitHeight = 167
      object edtUserId: TLabeledEdit
        Tag = 1
        Left = 3
        Top = 16
        Width = 84
        Height = 21
        EditLabel.Width = 11
        EditLabel.Height = 13
        EditLabel.Caption = 'ID'
        TabOrder = 0
      end
      object edtUsername: TLabeledEdit
        Tag = 2
        Left = 3
        Top = 64
        Width = 241
        Height = 21
        EditLabel.Width = 48
        EditLabel.Height = 13
        EditLabel.Caption = 'Username'
        MaxLength = 50
        TabOrder = 1
      end
      object edtPassword: TLabeledEdit
        Tag = 3
        Left = 3
        Top = 112
        Width = 241
        Height = 21
        EditLabel.Width = 46
        EditLabel.Height = 13
        EditLabel.Caption = 'Password'
        MaxLength = 50
        TabOrder = 2
      end
    end
  end
  inherited pnlFooter: TPanel
    Top = 195
    Width = 748
    ExplicitTop = 195
    ExplicitWidth = 748
    inherited btnClose: TBitBtn
      Left = 669
      ExplicitLeft = 669
    end
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited qryListing: TFDQuery
    Active = True
    SQL.Strings = (
      'SELECT id,'
      '             name,'
      '             password,'
      '             user_type'
      '    FROM user')
    Left = 616
    Top = 24
  end
  inherited dtsListing: TDataSource
    Left = 672
    Top = 24
  end
end
