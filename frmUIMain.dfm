object UIMain: TUIMain
  Left = 0
  Top = 0
  Caption = 'x-tag sample'
  ClientHeight = 290
  ClientWidth = 419
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btnGetScreenshot: TButton
    Left = 8
    Top = 8
    Width = 137
    Height = 25
    Caption = 'Get Screenshot'
    TabOrder = 0
    OnClick = btnGetScreenshotClick
  end
  object btnStartWorking: TButton
    Left = 151
    Top = 8
    Width = 122
    Height = 25
    Caption = 'Start Working'
    TabOrder = 1
    OnClick = btnStartWorkingClick
  end
  object btnStopWorking: TButton
    Left = 279
    Top = 8
    Width = 122
    Height = 25
    Caption = 'Stop Working'
    TabOrder = 2
    OnClick = btnStopWorkingClick
  end
  object pnlClock: TPanel
    Left = 0
    Top = 249
    Width = 419
    Height = 41
    Align = alBottom
    Caption = 'pnlClock'
    TabOrder = 3
  end
  object pnlOneHost: TPanel
    Left = 0
    Top = 48
    Width = 419
    Height = 201
    Align = alBottom
    Caption = 'pnlOneHost'
    TabOrder = 4
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 368
    Top = 56
  end
end
