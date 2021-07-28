inherited frmCampaigns: TfrmCampaigns
  Caption = 'frmCampaigns'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcMain: TPageControl
    inherited tabListing: TTabSheet
      inherited grdListing: TDBGrid
        Width = 708
        Align = alLeft
        OnCellClick = grdListingCellClick
        Columns = <
          item
            Expanded = False
            FieldName = 'id'
            Title.Caption = 'Campaign ID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'name'
            Title.Caption = 'Campaign Name'
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'description'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'master_username'
            Title.Caption = 'Owner'
            Visible = True
          end>
      end
      object scrbCampaignInfo: TScrollBox
        Left = 706
        Top = 97
        Width = 378
        Height = 457
        Align = alRight
        BevelInner = bvNone
        BevelOuter = bvNone
        TabOrder = 2
        object pnCampaignInfo: TPanel
          Left = 0
          Top = 0
          Width = 374
          Height = 453
          Align = alRight
          BorderStyle = bsSingle
          Color = 11794687
          ParentBackground = False
          TabOrder = 0
          object lblCampaignTitlePreview: TLabel
            AlignWithMargins = True
            Left = 11
            Top = 4
            Width = 355
            Height = 25
            Margins.Left = 10
            Align = alTop
            Caption = 'Campaign Title'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -21
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            WordWrap = True
            ExplicitWidth = 157
          end
          object lblCampaignDescriptionPreview: TLabel
            AlignWithMargins = True
            Left = 11
            Top = 37
            Width = 355
            Height = 408
            Margins.Left = 10
            Margins.Top = 5
            Align = alClient
            Caption = 'Description Preview'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Tahoma'
            Font.Style = [fsItalic]
            ParentFont = False
            WordWrap = True
            ExplicitWidth = 139
            ExplicitHeight = 19
          end
        end
      end
    end
    inherited tabMaintenance: TTabSheet
      object lblCampaignPlayers: TLabel
        Left = 3
        Top = 97
        Width = 85
        Height = 13
        Caption = 'Campaign Players'
      end
      object SpeedButton1: TSpeedButton
        Left = 154
        Top = 109
        Width = 23
        Height = 22
      end
      object lblPreview: TLabel
        Left = 3
        Top = 257
        Width = 195
        Height = 25
        Caption = 'Campaign Preview'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object imgCampaign: TImage
        Left = 352
        Top = 3
        Width = 697
        Height = 254
      end
      object ledtCampaignId: TLabeledEdit
        Tag = 1
        Left = 3
        Top = 19
        Width = 121
        Height = 21
        EditLabel.Width = 61
        EditLabel.Height = 13
        EditLabel.Caption = 'Campaign ID'
        TabOrder = 0
      end
      object ledtCampaignName: TLabeledEdit
        Tag = 2
        Left = 3
        Top = 62
        Width = 292
        Height = 21
        EditLabel.Width = 77
        EditLabel.Height = 13
        EditLabel.Caption = 'Campaign Name'
        TabOrder = 1
      end
      object cbCampaignPlayers: TComboBox
        Left = 3
        Top = 110
        Width = 145
        Height = 21
        TabOrder = 2
      end
      object redtPreview: TRRichEdit
        Left = 3
        Top = 288
        Width = 1062
        Height = 249
        Hint = 'What is your campaign about?'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Lines.Strings = (
          'redtPreview')
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 3
        Zoom = 100
        NoRTF = False
      end
      object lbCampaignPlayers: TListBox
        Left = 3
        Top = 137
        Width = 292
        Height = 97
        ItemHeight = 13
        TabOrder = 4
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
      'SELECT '
      '    id,'
      '    name,'
      '    description,'
      '    t.master_username'
      'FROM '
      '    campaign c'
      '    left join ('
      '        select '
      '            u.id  as master_user_id,'
      '            u.name as master_username,'
      '            campaign_id'
      '        from '
      '            user u '
      '            inner join user_campaign uc on u.id = uc.user_id '
      '        where '
      '            u.user_type = 1'
      '    ) t on  c.id = t.campaign_id;')
  end
end
