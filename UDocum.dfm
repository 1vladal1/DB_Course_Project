object FDocum: TFDocum
  Left = 156
  Top = 205
  BorderStyle = bsDialog
  Caption = #1057#1086#1089#1090#1072#1074#1083#1077#1085#1080#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1072#1094#1080#1080
  ClientHeight = 449
  ClientWidth = 770
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
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 770
    Height = 449
    ActivePage = TabSheet2
    Align = alClient
    TabIndex = 1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #1057#1087#1080#1089#1086#1082' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
      object SpeedButton1: TSpeedButton
        Left = 608
        Top = 376
        Width = 145
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
        OnClick = SpeedButton1Click
      end
      object SBPosmNaryad: TSpeedButton
        Left = 344
        Top = 376
        Width = 257
        Height = 35
        Caption = #1055#1086#1089#1084#1086#1090#1088#1077#1090#1100' '#1085#1072#1088#1103#1076#1099' '#1087#1086' '#1076#1086#1082#1091#1084#1077#1085#1090#1091
        Flat = True
        OnClick = SBPosmNaryadClick
      end
      object SGS: TStringGrid
        Left = 8
        Top = 8
        Width = 745
        Height = 361
        ColCount = 8
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
        TabOrder = 0
        OnSelectCell = SGSSelectCell
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      ImageIndex = 1
      object SBAddDoc: TSpeedButton
        Left = 600
        Top = 368
        Width = 150
        Height = 35
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100
        Flat = True
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
        OnClick = SBAddDocClick
      end
      object GroupBox1: TGroupBox
        Left = 8
        Top = 8
        Width = 409
        Height = 177
        Caption = ' '#1040#1090#1088#1080#1073#1091#1090#1099' '#1076#1086#1082#1091#1084#1077#1085#1090#1099' '
        TabOrder = 0
        object Label1: TLabel
          Left = 24
          Top = 32
          Width = 146
          Height = 16
          Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' :'
        end
        object Label2: TLabel
          Left = 50
          Top = 67
          Width = 119
          Height = 16
          Caption = #1044#1072#1090#1072' '#1087#1086#1076#1087#1080#1089#1072#1085#1080#1103' :'
        end
        object Label3: TLabel
          Left = 57
          Top = 98
          Width = 111
          Height = 16
          Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' :'
        end
        object Label4: TLabel
          Left = 92
          Top = 130
          Width = 76
          Height = 16
          Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' :'
        end
        object ENazDoc: TEdit
          Left = 176
          Top = 29
          Width = 209
          Height = 24
          TabOrder = 0
        end
        object MEDatP: TMaskEdit
          Left = 176
          Top = 64
          Width = 65
          Height = 24
          EditMask = '!99/99/00;1;_'
          MaxLength = 8
          TabOrder = 1
          Text = '  .  .  '
        end
        object MEDatO: TMaskEdit
          Left = 176
          Top = 96
          Width = 64
          Height = 24
          EditMask = '!99/99/00;1;_'
          MaxLength = 8
          TabOrder = 2
          Text = '  .  .  '
        end
        object EStoim: TEdit
          Left = 176
          Top = 128
          Width = 97
          Height = 24
          TabOrder = 3
        end
      end
      object GroupBox2: TGroupBox
        Left = 424
        Top = 8
        Width = 329
        Height = 65
        Caption = ' '#1058#1080#1087' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '
        TabOrder = 1
        object CBTipD: TComboBox
          Left = 16
          Top = 24
          Width = 297
          Height = 24
          ItemHeight = 16
          TabOrder = 0
        end
      end
      object GroupBox3: TGroupBox
        Left = 424
        Top = 80
        Width = 329
        Height = 65
        Caption = ' '#1047#1072#1082#1079#1095#1080#1082' '
        TabOrder = 2
        object CBZak: TComboBox
          Left = 16
          Top = 24
          Width = 297
          Height = 24
          ItemHeight = 16
          TabOrder = 0
        end
      end
      object GroupBox4: TGroupBox
        Left = 8
        Top = 192
        Width = 409
        Height = 73
        Caption = ' '#1057#1086#1090#1088#1091#1076#1085#1080#1082' '
        TabOrder = 3
        object CBSotr: TComboBox
          Left = 16
          Top = 32
          Width = 377
          Height = 24
          ItemHeight = 16
          TabOrder = 0
        end
      end
      object GroupBox5: TGroupBox
        Left = 8
        Top = 272
        Width = 409
        Height = 73
        Caption = ' '#1055#1088#1080#1095#1080#1085#1072' '
        TabOrder = 4
        object CBPrich: TComboBox
          Left = 16
          Top = 32
          Width = 377
          Height = 24
          ItemHeight = 16
          TabOrder = 0
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = #1053#1072#1088#1103#1076#1099
      ImageIndex = 2
      object SBPrint: TSpeedButton
        Left = 616
        Top = 376
        Width = 137
        Height = 35
        Caption = #1055#1077#1095#1072#1090#1100
        Flat = True
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
          0003377777777777777308888888888888807F33333333333337088888888888
          88807FFFFFFFFFFFFFF7000000000000000077777777777777770F8F8F8F8F8F
          8F807F333333333333F708F8F8F8F8F8F9F07F333333333337370F8F8F8F8F8F
          8F807FFFFFFFFFFFFFF7000000000000000077777777777777773330FFFFFFFF
          03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
          03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
          33333337F3F37F3733333330F08F0F0333333337F7337F7333333330FFFF0033
          33333337FFFF7733333333300000033333333337777773333333}
        NumGlyphs = 2
        OnClick = SBPrintClick
      end
      object DBG: TDBGrid
        Left = 8
        Top = 16
        Width = 745
        Height = 353
        DataSource = DataSource1
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'FIO'
            ReadOnly = True
            Title.Alignment = taCenter
            Title.Caption = #1060#1048#1054
            Width = 150
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'DATA_NACH'
            Title.Alignment = taCenter
            Title.Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072
            Width = 150
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'DATA_SDACHI'
            Title.Alignment = taCenter
            Title.Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'OTVET_LICO'
            Title.Alignment = taCenter
            Title.Caption = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1086#1077' '#1083#1080#1094#1086
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VID_ROBOTI'
            Title.Alignment = taCenter
            Title.Caption = #1042#1080#1076' '#1088#1086#1073#1086#1090#1099
            Width = 150
            Visible = True
          end>
      end
    end
  end
  object ibs4: TIBSQL
    Database = FGlav.ibd
    ParamCheck = True
    Transaction = FGlav.ibt
    Left = 272
    Top = 112
  end
  object DataSource1: TDataSource
    DataSet = ibs5
    Left = 216
    Top = 72
  end
  object ibs5: TIBQuery
    Database = FGlav.ibd
    Transaction = FGlav.ibt
    BufferChunks = 1000
    CachedUpdates = False
    Left = 504
    Top = 120
  end
end
