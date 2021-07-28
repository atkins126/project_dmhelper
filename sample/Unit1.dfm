object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 624
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    635
    624)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 278
    Top = 591
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Criar'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 368
    Top = 591
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Limpar Lista'
    TabOrder = 1
    OnClick = Button2Click
  end
  object tbData: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 312
    Top = 320
    object tbDataid: TIntegerField
      FieldName = 'id'
    end
    object tbDatainiciativa: TIntegerField
      FieldName = 'iniciativa'
    end
    object tbDatanome: TStringField
      FieldName = 'nome'
      Size = 50
    end
  end
end
