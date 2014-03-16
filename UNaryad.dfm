object FNaryad: TFNaryad
  Left = 214
  Top = 243
  BorderStyle = bsDialog
  Caption = #1054#1092#1086#1088#1084#1083#1077#1085#1080#1077' '#1085#1072#1088#1103#1076#1072
  ClientHeight = 264
  ClientWidth = 645
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 645
    Height = 264
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 40
      Top = 32
      Width = 233
      Height = 16
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '#1085#1072' '#1086#1089#1085#1086#1074#1072#1085#1080#1080
    end
    object Label2: TLabel
      Left = 112
      Top = 48
      Width = 164
      Height = 16
      Caption = #1082#1086#1090#1086#1088#1086#1075#1086' '#1074#1099#1087#1080#1089#1072#1085' '#1085#1072#1088#1103#1076':'
    end
    object Label3: TLabel
      Left = 40
      Top = 88
      Width = 86
      Height = 16
      Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072':'
    end
    object Label4: TLabel
      Left = 224
      Top = 88
      Width = 108
      Height = 16
      Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103':'
    end
    object Label5: TLabel
      Left = 40
      Top = 132
      Width = 102
      Height = 16
      Caption = #1054#1090#1074#1077#1090#1085#1086#1077' '#1083#1080#1094#1086':'
    end
    object Label6: TLabel
      Left = 46
      Top = 164
      Width = 94
      Height = 16
      Caption = #1048#1089#1087#1086#1083#1085#1103#1102#1097#1080#1081':'
    end
    object Label7: TLabel
      Left = 60
      Top = 195
      Width = 79
      Height = 16
      Caption = #1042#1080#1076' '#1088#1086#1073#1086#1090#1099':'
    end
    object CBDocum: TComboBox
      Left = 280
      Top = 40
      Width = 305
      Height = 24
      ItemHeight = 16
      TabOrder = 0
    end
    object MEDats: TMaskEdit
      Left = 128
      Top = 84
      Width = 73
      Height = 24
      EditMask = '!99/99/00;1;_'
      MaxLength = 8
      TabOrder = 1
      Text = '  .  .  '
    end
    object MEDatK: TMaskEdit
      Left = 336
      Top = 84
      Width = 72
      Height = 24
      EditMask = '!99/99/00;1;_'
      MaxLength = 8
      TabOrder = 2
      Text = '  .  .  '
    end
    object EOtvl: TEdit
      Left = 144
      Top = 128
      Width = 225
      Height = 24
      TabOrder = 3
    end
    object CBIspol: TComboBox
      Left = 144
      Top = 160
      Width = 225
      Height = 24
      ItemHeight = 16
      TabOrder = 4
    end
    object EVidR: TEdit
      Left = 144
      Top = 192
      Width = 225
      Height = 24
      TabOrder = 5
    end
    object BBOfor: TBitBtn
      Left = 456
      Top = 168
      Width = 161
      Height = 35
      Caption = #1054#1092#1086#1088#1084#1080#1090#1100
      TabOrder = 6
      OnClick = BBOforClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        555555555555555555555555555555555555555555FF55555555555559055555
        55555555577FF5555555555599905555555555557777F5555555555599905555
        555555557777FF5555555559999905555555555777777F555555559999990555
        5555557777777FF5555557990599905555555777757777F55555790555599055
        55557775555777FF5555555555599905555555555557777F5555555555559905
        555555555555777FF5555555555559905555555555555777FF55555555555579
        05555555555555777FF5555555555557905555555555555777FF555555555555
        5990555555555555577755555555555555555555555555555555}
      NumGlyphs = 2
    end
    object BitBtn1: TBitBtn
      Left = 456
      Top = 208
      Width = 161
      Height = 35
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      TabOrder = 7
      OnClick = BitBtn1Click
      Kind = bkCancel
    end
  end
  object ibs2: TIBSQL
    Database = FGlav.ibd
    ParamCheck = True
    Transaction = FGlav.ibt
    Left = 280
    Top = 40
  end
end
