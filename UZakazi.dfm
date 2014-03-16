object FZakaz: TFZakaz
  Left = 337
  Top = 101
  BorderStyle = bsDialog
  Caption = #1057#1086#1089#1090#1072#1074#1083#1077#1085#1080#1077' '#1079#1072#1082#1072#1079#1072
  ClientHeight = 479
  ClientWidth = 502
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
  object SBSost: TSpeedButton
    Left = 8
    Top = 440
    Width = 129
    Height = 35
    Caption = #1047#1072#1082#1072#1079#1072#1090#1100
    Flat = True
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
      000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
      00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
      F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
      0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
      FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
      FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
      0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
      00333377737FFFFF773333303300000003333337337777777333}
    NumGlyphs = 2
    OnClick = SBSostClick
  end
  object SBCan: TSpeedButton
    Left = 392
    Top = 440
    Width = 105
    Height = 35
    Caption = #1054#1090#1084#1077#1085#1072
    Flat = True
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
    OnClick = SBCanClick
  end
  object SBProsZak: TSpeedButton
    Left = 144
    Top = 440
    Width = 140
    Height = 35
    Caption = #1055#1086#1089#1084#1086#1090#1088#1077#1090#1100' '#1079#1072#1082#1072#1079
    Flat = True
    OnClick = SBProsZakClick
  end
  object SBOplat: TSpeedButton
    Left = 288
    Top = 440
    Width = 97
    Height = 35
    Caption = #1054#1087#1083#1072#1090#1080#1090#1100
    Flat = True
    OnClick = SBOplatClick
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 497
    Height = 97
    Caption = ' '#1053#1072#1079#1074#1072#1085#1080#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 64
      Width = 105
      Height = 16
      Caption = #1058#1080#1087' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' :'
    end
    object Label2: TLabel
      Left = 136
      Top = 64
      Width = 3
      Height = 16
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object CBNazDocum: TComboBox
      Left = 24
      Top = 32
      Width = 449
      Height = 24
      ItemHeight = 16
      TabOrder = 0
      OnChange = CBNazDocumChange
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 104
    Width = 497
    Height = 329
    Caption = ' '#1053#1072#1079#1074#1072#1085#1080#1077' '#1090#1086#1074#1072#1088#1086#1074' '
    TabOrder = 1
    object Label3: TLabel
      Left = 24
      Top = 296
      Width = 134
      Height = 16
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1090#1086#1074#1072#1088#1072' :'
    end
    object Label4: TLabel
      Left = 328
      Top = 300
      Width = 5
      Height = 16
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object EKol: TEdit
      Left = 162
      Top = 293
      Width = 73
      Height = 24
      TabOrder = 0
    end
    object CLTovar: TListBox
      Left = 16
      Top = 24
      Width = 465
      Height = 265
      ItemHeight = 16
      TabOrder = 1
      OnClick = CLTovarClick
    end
  end
  object ibs3: TIBSQL
    Database = FGlav.ibd
    ParamCheck = True
    Transaction = FGlav.ibt
    Left = 224
    Top = 8
  end
  object ibsp1: TIBStoredProc
    Database = FGlav.ibd
    Transaction = FGlav.ibt
    StoredProcName = 'KOL_TOVAR'
    Left = 88
    Top = 32
  end
end
