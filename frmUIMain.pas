unit frmUIMain;

interface

uses
  untSysWebComponent,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls;

type
  TUIMain = class(TForm)
    btnGetScreenshot: TButton;
    btnStartWorking: TButton;
    btnStopWorking: TButton;
    pnlClock: TPanel;
    pnlOneHost: TPanel;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure btnGetScreenshotClick(Sender: TObject);
    procedure btnStartWorkingClick(Sender: TObject);
    procedure btnStopWorkingClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    FWebComponent: TWebComponent;
  public
    { Public declarations }
  end;

var
  UIMain: TUIMain;

implementation

uses
  System.IOUtils
, VirtualUI_SDK
, System.JSON

  ;

{$R *.dfm}

procedure TUIMain.btnGetScreenshotClick(Sender: TObject);
begin
  if Assigned(FWebComponent) then FWebComponent.GetScreenShot;
end;

procedure TUIMain.btnStartWorkingClick(Sender: TObject);
var
  jo: TJSonObject;
begin
  jo := TJsonObject.Create;
  try
    jo.AddPair('Action','orion-working-start');
    jo.AddPair('Type','text/plain');
    jo.AddPair('Title', 'Please wait');
    jo.AddPair('Msg', 'Hello World');
    VirtualUI.SendMessage(jo.ToJson);
  finally
    jo.Free;
  end;
end;

procedure TUIMain.btnStopWorkingClick(Sender: TObject);
var
  jo: TJSonObject;
begin
  jo := TJsonObject.Create;
  try
    jo.AddPair('Action','orion-working-stop');
    jo.AddPair('Type','text/plain');
    VirtualUI.SendMessage(jo.ToJson);
  finally
    jo.Free;
  end;
end;

procedure TUIMain.FormCreate(Sender: TObject);
begin
  self.top := 0;
  self.Left := 0;
  FWebComponent := TWebComponent.Create(pnlOneHost);
  FWebComponent.CreateWebComponent(pnlOneHost);
end;

procedure TUIMain.Timer1Timer(Sender: TObject);
begin
  pnlClock.Caption := 'Current Time is ' + formatdatetime('dd/mm/yyyy hh:nn:ss', now);
end;

end.
