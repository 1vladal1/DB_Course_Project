object FZakazchik: TFZakazchik
  Left = 213
  Top = 176
  BorderStyle = bsDialog
  Caption = #1047#1072#1082#1072#1079#1095#1080#1082#1080
  ClientHeight = 446
  ClientWidth = 688
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
  object SBAddZak: TSpeedButton
    Left = 16
    Top = 400
    Width = 150
    Height = 35
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    Flat = True
    Glyph.Data = {
      E6000000424DE60000000000000076000000280000000E0000000E0000000100
      04000000000070000000C40E0000C40E00001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3300333333333333330033333333333333003333399933333300333339993333
      3300333339993333330033999999999333003399999999933300339999999993
      3300333339993333330033333999333333003333399933333300333333333333
      33003333333333333300}
    OnClick = SBAddZakClick
  end
  object SBDelZak: TSpeedButton
    Left = 184
    Top = 400
    Width = 150
    Height = 35
    Caption = #1059#1076#1072#1083#1080#1090#1100
    Flat = True
    Glyph.Data = {
      E6000000424DE60000000000000076000000280000000E0000000E0000000100
      04000000000070000000C40E0000C40E00001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3300333333333333330033333333333333003333333333333300333333333333
      3300333333333333330033999999999933003399999999993300339999999999
      3300333333333333330033333333333333003333333333333300333333333333
      33003333333333333300}
    OnClick = SBDelZakClick
  end
  object SBEditzak: TSpeedButton
    Left = 352
    Top = 400
    Width = 150
    Height = 35
    Caption = #1048#1079#1084#1077#1085#1080#1090#1100
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
    OnClick = SBEditzakClick
  end
  object SBCanZak: TSpeedButton
    Left = 520
    Top = 400
    Width = 150
    Height = 35
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
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
    OnClick = SBCanZakClick
  end
  object SGZ: TStringGrid
    Left = 8
    Top = 8
    Width = 673
    Height = 377
    FixedCols = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    TabOrder = 0
    OnSelectCell = SGZSelectCell
  end
end