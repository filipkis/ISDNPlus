object fTelefon: TfTelefon
  Left = 0
  Top = 0
  Width = 222
  Height = 26
  TabOrder = 0
  OnClick = FrameClick
  OnEnter = FrameEnter
  object shSel: TShape
    Left = 3
    Top = 0
    Width = 216
    Height = 26
    Brush.Style = bsClear
    Pen.Color = 13003057
    Visible = False
  end
  object edOpis: TEdit
    Left = 93
    Top = 3
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object edBroj: TEdit
    Left = 8
    Top = 3
    Width = 79
    Height = 21
    MaxLength = 13
    TabOrder = 0
  end
end
