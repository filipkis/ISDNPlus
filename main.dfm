object frMain: TfrMain
  Left = 313
  Top = 507
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  AutoScroll = False
  Caption = 'ISDN Plus'
  ClientHeight = 267
  ClientWidth = 393
  Color = clBtnFace
  Constraints.MaxWidth = 401
  Constraints.MinHeight = 200
  Constraints.MinWidth = 401
  DefaultMonitor = dmDesktop
  Font.Charset = EASTEUROPE_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = Meni
  OldCreateOrder = False
  Position = poDesktopCenter
  ScreenSnap = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    393
    267)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 408
    Top = 8
    Width = 26
    Height = 13
    Caption = 'Tra'#382'i:'
  end
  object Shape4: TShape
    Left = 393
    Top = -1
    Width = 1
    Height = 260
    Anchors = [akLeft, akTop, akBottom]
    Pen.Color = 13003057
  end
  object lbMsn: TLabel
    Left = 224
    Top = 10
    Width = 81
    Height = 13
    AutoSize = False
  end
  object edTko: TEdit
    Left = 8
    Top = 4
    Width = 209
    Height = 21
    Ctl3D = True
    ParentCtl3D = False
    ReadOnly = True
    TabOrder = 0
  end
  object btImenik: TButton
    Left = 232
    Top = 32
    Width = 82
    Height = 17
    Caption = 'Online Imenik...'
    TabOrder = 1
    OnClick = btImenikClick
  end
  object btContact: TButton
    Left = 320
    Top = 32
    Width = 67
    Height = 17
    Caption = 'Kontakti ->'
    TabOrder = 2
    OnClick = btContactClick
  end
  object edFind: TEdit
    Left = 441
    Top = 5
    Width = 121
    Height = 21
    TabOrder = 3
    OnChange = edFindChange
    OnEnter = edFindEnter
    OnKeyPress = edFindKeyPress
  end
  object btObrPoz: TButton
    Left = 128
    Top = 32
    Width = 91
    Height = 17
    Caption = 'Obri'#353'i poziv'
    TabOrder = 4
    OnClick = Obriipoziv1Click
  end
  object btObrSve: TButton
    Left = 128
    Top = 52
    Width = 91
    Height = 17
    Caption = 'Obri'#353'i sve pozive'
    TabOrder = 5
    OnClick = Obriisvepozive1Click
  end
  object btEdit: TButton
    Left = 6
    Top = 32
    Width = 113
    Height = 17
    Caption = 'Promjeni/Ubaci...'
    TabOrder = 6
    OnClick = btEditClick
  end
  object btObrisi: TButton
    Left = 491
    Top = 32
    Width = 81
    Height = 17
    Caption = 'Obri'#353'i kontakt'
    TabOrder = 7
    OnClick = Obrii1Click
  end
  object btNew: TButton
    Left = 403
    Top = 32
    Width = 81
    Height = 17
    Caption = 'Novi kontakt...'
    TabOrder = 8
    OnClick = Novi1Click
  end
  object btCopy: TButton
    Left = 232
    Top = 52
    Width = 155
    Height = 17
    Caption = 'Ubaci telefon kontaktu ->'
    TabOrder = 9
    Visible = False
    OnClick = btCopyClick
  end
  object sgPozivi: TStringGrid
    Left = 8
    Top = 78
    Width = 377
    Height = 182
    Anchors = [akLeft, akTop, akBottom]
    ColCount = 3
    Ctl3D = True
    DefaultRowHeight = 18
    FixedCols = 0
    RowCount = 9
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goRowSelect, goThumbTracking]
    ParentCtl3D = False
    ScrollBars = ssVertical
    TabOrder = 10
    OnDblClick = btEditClick
    ColWidths = (
      114
      133
      129)
  end
  object sgKontakti: TStringGrid
    Left = 402
    Top = 56
    Width = 373
    Height = 204
    Hint = 'xxx'
    Anchors = [akLeft, akTop, akBottom]
    Color = clCaptionText
    ColCount = 3
    Ctl3D = True
    DefaultColWidth = 122
    DefaultRowHeight = 18
    FixedCols = 0
    Options = [goFixedHorzLine, goVertLine, goRowSelect]
    ParentCtl3D = False
    ParentShowHint = False
    ScrollBars = ssVertical
    ShowHint = True
    TabOrder = 11
    OnDblClick = sgKontaktiDblClick
    OnKeyPress = sgKontaktiKeyPress
    OnMouseDown = sgKontaktiMouseDown
  end
  object btDisconect: TButton
    Left = 315
    Top = 8
    Width = 71
    Height = 17
    Caption = 'Prekini poziv'
    Enabled = False
    TabOrder = 12
    OnClick = btDisconectClick
  end
  object Isdn: TCapiMonitor
    OnIncomingCall = IsdnIncomingCall
    OnDisconnectInfo = IsdnDisconnectInfo
    Left = 112
    Top = 176
  end
  object Tray: TCoolTrayIcon
    CycleInterval = 0
    Hint = 'ISDN Plus'
    Icon.Data = {
      0000010001001010100000000000280100001600000028000000100000002000
      00000100040000000000C0000000000000000000000000000000000000000000
      000000008000008000000080800080000000800080008080000080808000C0C0
      C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
      000000000000000000BBB000000000000BBBBB00000000000BBBBB0000000000
      0BBBBB00000000000BBBBB0000000BBBBBBBBBBBBB00BBBBBBBBBBBBBBB0BBBB
      BBBBBBBBBBB0BBBBBBBBBBBBBBB00BBBBBBBBBBBBB0000000BBBBB0000000000
      0BBBBB00000000000BBBBB00000000000BBBBB000000000000BBB0000000FFFF
      0000FC7F0000F83F0000F83F0000F83F0000F83F000080030000000100000001
      00000001000080030000F83F0000F83F0000F83F0000F83F0000FC7F0000}
    IconIndex = 0
    PopupMenu = trayMenu
    StartMinimized = True
    MinimizeToTray = True
    OnClick = TrayClick
    OnDblClick = TrayClick
    Left = 80
    Top = 176
  end
  object trayMenu: TPopupMenu
    MenuAnimation = [maBottomToTop]
    Left = 144
    Top = 176
    object Prikai1: TMenuItem
      Caption = 'Prika'#382'i'
      OnClick = Prikai1Click
    end
    object Zatvori1: TMenuItem
      Caption = 'Zatvori'
      OnClick = Zatvori1Click
    end
  end
  object Meni: TMainMenu
    Left = 176
    Top = 176
    object Program1: TMenuItem
      Caption = '&Program'
      object Opcije1: TMenuItem
        Caption = '&Opcije...'
        ShortCut = 16463
        OnClick = Opcije1Click
      end
      object Smanjiutray1: TMenuItem
        Caption = '&Smanji u tray'
        ShortCut = 16461
        OnClick = Smanjiutray1Click
      end
      object Zatvori2: TMenuItem
        Caption = '&Zatvori'
        ShortCut = 16465
        OnClick = Zatvori2Click
      end
    end
    object Pozivi1: TMenuItem
      Caption = 'Poziv'
      object HTImenik1: TMenuItem
        Caption = 'Online &Imenik...'
        ShortCut = 16456
        OnClick = btImenikClick
      end
      object Obriipoziv1: TMenuItem
        Caption = '&Obri'#353'i poziv'
        ShortCut = 16430
        OnClick = Obriipoziv1Click
      end
      object Obriisvepozive1: TMenuItem
        Caption = 'Obri'#353'i &sve pozive'
        ShortCut = 8238
        OnClick = Obriisvepozive1Click
      end
      object btUbaci: TMenuItem
        Caption = 'Ubaci telefon kontaktu...'
        GroupIndex = 1
        Visible = False
        OnClick = btCopyClick
      end
    end
    object Kontakit1: TMenuItem
      Caption = 'Kontakti'
      Visible = False
      object Novi1: TMenuItem
        Caption = 'Novi...'
        ShortCut = 16462
        OnClick = Novi1Click
      end
      object Obrii1: TMenuItem
        Caption = 'Obri'#353'i'
        OnClick = Obrii1Click
      end
    end
  end
  object XPManifest1: TXPManifest
    Left = 48
    Top = 176
  end
  object ApplicationEvents1: TApplicationEvents
    OnShowHint = ApplicationEvents1ShowHint
    Left = 208
    Top = 176
  end
end
