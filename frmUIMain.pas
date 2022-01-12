unit frmUIMain;

interface

uses
  untSysWebComponent,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls;

type
  TUIMain = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    pnlClock: TPanel;
    pnlOneHost: TPanel;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
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

procedure TUIMain.Button1Click(Sender: TObject);
begin
  if Assigned(FWebComponent) then FWebComponent.GetScreenShot;
end;

procedure TUIMain.Button2Click(Sender: TObject);
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

procedure TUIMain.Button3Click(Sender: TObject);
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
