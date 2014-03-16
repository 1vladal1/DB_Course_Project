object FGlav: TFGlav
  Left = 212
  Top = 113
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1041#1072#1079#1072' '#1079#1072#1082#1072#1079#1086#1074
  ClientHeight = 453
  ClientWidth = 619
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 305
    Height = 289
    Caption = ' '#1042#1080#1076' '#1090#1086#1074#1072#1088#1072' '
    TabOrder = 0
    object LBVid: TListBox
      Left = 16
      Top = 24
      Width = 273
      Height = 241
      ItemHeight = 16
      PopupMenu = PopupMenu1
      TabOrder = 0
      OnClick = LBVidClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 312
    Top = 0
    Width = 305
    Height = 289
    Caption = ' '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1090#1086#1074#1072#1088#1086#1074' '
    TabOrder = 1
    object LBTovar: TListBox
      Left = 16
      Top = 24
      Width = 273
      Height = 241
      ItemHeight = 16
      PopupMenu = PopupMenu2
      TabOrder = 0
      OnClick = LBTovarClick
      OnDblClick = LBTovarDblClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 296
    Width = 619
    Height = 158
    Caption = ' '#1056#1072#1073#1086#1090#1072' '#1089' '#1073#1072#1079#1086#1081' '
    TabOrder = 2
    object BBSotrud: TBitBtn
      Left = 24
      Top = 32
      Width = 170
      Height = 35
      Caption = #1044#1072#1085#1085#1099#1077' '#1086' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1072#1093
      TabOrder = 0
      OnClick = BBSotrudClick
    end
    object BBNaryad: TBitBtn
      Left = 24
      Top = 88
      Width = 170
      Height = 35
      Caption = #1054#1092#1086#1088#1084#1080#1090#1100' '#1085#1072#1088#1103#1076
      TabOrder = 1
      OnClick = BBNaryadClick
    end
    object BBZakaz: TBitBtn
      Left = 224
      Top = 32
      Width = 170
      Height = 35
      Caption = #1047#1072#1082#1072#1079#1099
      TabOrder = 2
      OnClick = BBZakazClick
    end
    object BBVihod: TBitBtn
      Left = 424
      Top = 88
      Width = 170
      Height = 35
      Caption = #1042#1099#1093#1086#1076
      TabOrder = 3
      OnClick = BBVihodClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
        03333377777777777F333301BBBBBBBB033333773F3333337F3333011BBBBBBB
        0333337F73F333337F33330111BBBBBB0333337F373F33337F333301110BBBBB
        0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
        0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
        0333337F337F33337F333301110BBBBB0333337F337FF3337F33330111B0BBBB
        0333337F337733337F333301110BBBBB0333337F337F33337F333301110BBBBB
        0333337F3F7F33337F333301E10BBBBB0333337F7F7F33337F333301EE0BBBBB
        0333337F777FFFFF7F3333000000000003333377777777777333}
      NumGlyphs = 2
    end
    object BBZakazchik: TBitBtn
      Left = 224
      Top = 88
      Width = 170
      Height = 35
      Caption = #1047#1072#1082#1072#1079#1095#1080#1082#1080
      TabOrder = 4
      OnClick = BBZakazchikClick
    end
    object BBDocum: TBitBtn
      Left = 424
      Top = 32
      Width = 170
      Height = 35
      Caption = #1044#1086#1082#1091#1084#1077#1085#1090#1072#1094#1080#1103
      TabOrder = 5
      OnClick = BBDocumClick
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 434
    Width = 619
    Height = 19
    Panels = <>
    SimplePanel = True
    SimpleText = 
      #1044#1083#1103' '#1090#1086#1075#1086' '#1095#1090#1086#1073#1099' '#1087#1086#1103#1074#1080#1083#1089#1103' '#1089#1087#1080#1089#1086#1082' '#1090#1086#1074#1072#1088#1086#1074', '#1082#1083#1080#1082#1085#1080#1090#1077' '#1084#1099#1096#1082#1086#1081' '#1085#1072' '#1086#1076#1085#1086#1084 +
      ' '#1080#1079' '#1074#1080#1076#1086#1074' '#1090#1086#1074#1072#1088#1072
  end
  object ibd: TIBDatabase
    Connected = True
    DatabaseName = 'D:\Projects\Baza\Zakazi\ZAKAZI.GDB'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    IdleTimer = 0
    SQLDialect = 1
    TraceFlags = []
    Left = 136
    Top = 40
  end
  object ibt: TIBTransaction
    Active = True
    DefaultDatabase = ibd
    AutoStopAction = saNone
    Left = 224
    Top = 88
  end
  object ibs: TIBSQL
    Database = ibd
    ParamCheck = True
    Transaction = ibt
    Left = 32
    Top = 128
  end
  object PopupMenu1: TPopupMenu
    Left = 136
    Top = 184
    object N1: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      OnClick = N3Click
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 408
    Top = 104
    object N4: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      OnClick = N4Click
    end
    object N5: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnClick = N5Click
    end
    object N6: TMenuItem
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      OnClick = N6Click
    end
  end
  object MainMenu1: TMainMenu
    Left = 288
    Top = 104
    object N8: TMenuItem
      Caption = #1060#1072#1081#1083
      object N9: TMenuItem
        Caption = #1057#1084#1077#1085#1080#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
        OnClick = N9Click
      end
      object N10: TMenuItem
        Caption = '-'
      end
      object N11: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        OnClick = BBVihodClick
      end
    end
  end
end
