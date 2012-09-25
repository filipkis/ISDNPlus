object frOpcije: TfrOpcije
  Left = 352
  Top = 377
  BorderStyle = bsDialog
  Caption = 'Opcije'
  ClientHeight = 288
  ClientWidth = 331
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 32
    Width = 313
    Height = 113
    Caption = 'MSN (Multi Subsriber Numbers)'
    TabOrder = 0
    object btDelete: TButton
      Left = 256
      Top = 24
      Width = 49
      Height = 17
      Caption = 'Obri'#353'i'
      TabOrder = 0
      OnClick = btDeleteClick
    end
    object btAdd: TButton
      Left = 256
      Top = 48
      Width = 49
      Height = 17
      Caption = 'Dodaj'
      TabOrder = 1
      OnClick = btAddClick
    end
    inline fTel: TfTelefoni
      Left = 8
      Top = 24
      Width = 244
      Height = 78
      VertScrollBar.Increment = 26
      VertScrollBar.Tracking = True
      TabOrder = 2
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 160
    Width = 313
    Height = 81
    Caption = 'Dojava poziva'
    TabOrder = 1
    object cbBalon: TCheckBox
      Left = 16
      Top = 25
      Width = 169
      Height = 17
      Caption = 'Tray Info Balon (samo Win XP) '
      TabOrder = 0
    end
    object cbProg: TCheckBox
      Left = 16
      Top = 50
      Width = 177
      Height = 17
      Caption = 'Pojavljivanje glavnog prozora'
      TabOrder = 1
    end
  end
  object Prihvati: TButton
    Left = 244
    Top = 256
    Width = 75
    Height = 25
    Caption = 'Prihvati'
    TabOrder = 2
    OnClick = PrihvatiClick
  end
  object btCancel: TButton
    Left = 157
    Top = 256
    Width = 75
    Height = 25
    Caption = 'Prekini'
    TabOrder = 3
    OnClick = btCancelClick
  end
  object cbStartUp: TCheckBox
    Left = 24
    Top = 8
    Width = 265
    Height = 17
    Caption = 'Pokreni program zajedno s Windowsima'
    TabOrder = 4
  end
end
