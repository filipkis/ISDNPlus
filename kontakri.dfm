object frKontakti: TfrKontakti
  Left = 344
  Top = 526
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Kontakti'
  ClientHeight = 271
  ClientWidth = 545
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 12
    Width = 93
    Height = 13
    Caption = 'Ime za prikazivanje:'
  end
  object Label2: TLabel
    Left = 40
    Top = 51
    Width = 34
    Height = 13
    Caption = 'Tvrtka:'
  end
  object Label3: TLabel
    Left = 33
    Top = 91
    Width = 40
    Height = 13
    Caption = 'Prezime:'
  end
  object Label4: TLabel
    Left = 53
    Top = 115
    Width = 20
    Height = 13
    Caption = 'Ime:'
  end
  object Label5: TLabel
    Left = 48
    Top = 156
    Width = 27
    Height = 13
    Caption = 'Ulica:'
  end
  object Label6: TLabel
    Left = 48
    Top = 181
    Width = 26
    Height = 13
    Caption = 'Grad:'
  end
  object Label7: TLabel
    Left = 37
    Top = 205
    Width = 37
    Height = 13
    Caption = 'Dr'#382'ava:'
  end
  object Label8: TLabel
    Left = 272
    Top = 12
    Width = 31
    Height = 13
    Caption = 'E mail:'
  end
  object btSend: TButton
    Left = 464
    Top = 8
    Width = 73
    Height = 17
    Caption = 'Po'#353'alji e-mail'
    TabOrder = 0
    OnClick = btSendClick
  end
  object btClose: TButton
    Left = 464
    Top = 240
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Zatvori'
    Default = True
    TabOrder = 4
    OnClick = btCloseClick
  end
  object btSpremi: TButton
    Left = 384
    Top = 240
    Width = 75
    Height = 25
    Caption = 'Spremi'
    TabOrder = 3
    OnClick = btSpremiClick
  end
  object btVrati: TButton
    Left = 304
    Top = 240
    Width = 75
    Height = 25
    Caption = 'Vrati'
    TabOrder = 2
    OnClick = btVratiClick
  end
  object btDelete: TButton
    Left = 224
    Top = 240
    Width = 75
    Height = 25
    Caption = 'Obri'#353'i'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    TabStop = False
    OnClick = btDeleteClick
  end
  object edTvrtka: TEdit
    Left = 80
    Top = 48
    Width = 121
    Height = 21
    TabOrder = 5
    OnChange = cbNickChange
  end
  object edPrezime: TEdit
    Left = 80
    Top = 88
    Width = 121
    Height = 21
    TabOrder = 6
    OnChange = cbNickChange
  end
  object edIme: TEdit
    Left = 80
    Top = 112
    Width = 121
    Height = 21
    TabOrder = 7
    OnChange = cbNickChange
  end
  object edUlica: TEdit
    Left = 80
    Top = 152
    Width = 121
    Height = 21
    TabOrder = 8
    OnChange = cbNickChange
  end
  object edGrad: TEdit
    Left = 80
    Top = 176
    Width = 121
    Height = 21
    TabOrder = 9
    OnChange = cbNickChange
  end
  object edDrzava: TEdit
    Left = 80
    Top = 200
    Width = 121
    Height = 21
    TabOrder = 10
    OnChange = cbNickChange
  end
  object edEmail: TEdit
    Left = 312
    Top = 8
    Width = 137
    Height = 21
    TabOrder = 11
    OnChange = cbNickChange
  end
  object GroupBox1: TGroupBox
    Left = 224
    Top = 40
    Width = 313
    Height = 113
    Caption = 'Telefoni:'
    TabOrder = 12
    object Label9: TLabel
      Left = 14
      Top = 14
      Width = 21
      Height = 13
      Caption = 'Broj:'
    end
    object Label10: TLabel
      Left = 98
      Top = 14
      Width = 24
      Height = 13
      Caption = 'Opis:'
    end
    inline frTelefoni: TfTelefoni
      Left = 5
      Top = 29
      Width = 244
      Height = 78
      VertScrollBar.Increment = 26
      VertScrollBar.Tracking = True
      TabOrder = 0
    end
    object btImenik: TButton
      Left = 256
      Top = 80
      Width = 49
      Height = 17
      Caption = 'Imenik...'
      TabOrder = 1
      OnClick = btImenikClick
    end
    object btDodaj: TButton
      Left = 256
      Top = 56
      Width = 49
      Height = 17
      Caption = 'Dodaj'
      TabOrder = 2
      OnClick = btDodajClick
    end
    object btObrisi: TButton
      Left = 256
      Top = 32
      Width = 49
      Height = 17
      Caption = 'Obri'#353'i'
      TabOrder = 3
      TabStop = False
      OnClick = btObrisiClick
    end
  end
  object cbNick: TComboBox
    Left = 120
    Top = 8
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 13
    OnChange = cbNickChange
    OnEnter = cbNickEnter
  end
end
