unit untSysWebComponent;

interface

uses
  Winapi.Windows
, Winapi.Messages
, System.SysUtils
, System.Variants
, System.Classes
, Vcl.Graphics
, VirtualUI_SDK
, Soap.EncdDecd
, Vcl.Imaging.pngimage
, Vcl.Imaging.jpeg
, Vcl.Controls
  ;

type
  TWebComponent = class(TObject)
  private
    FRemoteObj: TJSObject;
    FFilename : string;
    FXtagDir: string;
    FOnSignatureChanged: TNotifyEvent;
    function GetXTagDir: string;
    function GetHtmlDir: string;
    procedure Base64ToImageFile(aBase64Str: string; aFileName: string);
  public
    constructor Create(aControl: TWinControl);
    destructor Destroy; override;
    procedure CreateWebComponent(aControl: TWinControl);
    procedure GetScreenShot;
    property  XTagDir: string read FXtagDir write FXTagDir;
  end;

implementation

uses
  System.IOUtils
, System.NetEncoding
  ;


{ TWebComponent }

procedure TWebComponent.Base64ToImageFile(aBase64Str, aFileName: string);
var
  Input: TStringStream;
  Output: TBytesStream;
  Idx : Integer;
  Mime : string;
begin
  Idx := Pos(',',aBase64Str);
  if Idx > 0 then
    begin
      Mime := Copy(aBase64Str,1,idx-1);
      aBase64Str := Copy(aBase64Str,Idx+1,Length(aBase64Str));
      Input := TStringStream.Create(aBase64Str, TEncoding.ASCII);
      Output := TBytesStream.Create;
      try
        DecodeStream(Input, Output);
        Output.Position := 0;
        Output.SaveToFile(aFileName);
      finally
        Input.Free;
        Output.Free;
      end;
    end;
end;

constructor TWebComponent.Create(aControl: TWinControl);
var
  lXtagDir: string;
  lHtmlDir: string;
begin
  lXtagDir := GetXTagDir;
  if lXtagDir <> '' then
    VirtualUI.HTMLDoc.CreateSessionURL('x-tag',lXtagDir);

  lHtmlDir := GetHtmlDir;
  if lHtmlDir <> '' then
    VirtualUI.HTMLDoc.CreateSessionURL('HtmlToAdd', lHtmlDir);
end;

procedure TWebComponent.CreateWebComponent(aControl: TWinControl);
begin
  if VirtualUI.Enabled then
    begin

      FRemoteObj := TJSObject.Create('ro');
      FRemoteObj.Properties.Add('data')
        .OnSet(TJSBinding.Create(
          procedure(const Parent: IJSObject; const Prop: IJSProperty)
          var
            lData: string;
            lFileName: string;
          begin
            lData := Prop.AsString;
            {2021-12-22 Property is coming in with spaces. Need to replace them with plus symbol.}
            lData := StringReplace(lData, ' ', '+', [rfReplaceAll]);
            {---}
            lFileName := 'ScreenShot-' + formatdatetime('yyyymmddhhnnss',now) + '.png';
            Base64ToImageFile(lData, lFileName);
            VirtualUI.DownloadFile(lFileName);
          end))
        .AsString := '';
      FRemoteObj.Events.Add('dohtml2canvasop');
      FRemoteObj.ApplyModel;

      VirtualUI.HTMLDoc.LoadScript('/x-tag/x-tag-core.min.js','');
      VirtualUI.HTMLDoc.LoadScript('/HtmlToAdd/html2canvas.min.js','');
      VirtualUI.HTMLDoc.ImportHTML('/HtmlToAdd/orion-code.html','');
      VirtualUI.HTMLDoc.CreateComponent(AControl.Name, 'x-simple-ponent', AControl.Handle);
    end;
end;

destructor TWebComponent.Destroy;
begin
  FRemoteObj := nil;
  inherited;
end;

function TWebComponent.GetHtmlDir: string;
var
  lBaseDir : string;
  lHtmlDirTest: string;
begin
  result := '';
  lBaseDir := ExtractFilePath(ParamStr(0));
  while (lBaseDir <> '') and (length(lBaseDir) > 2) do
    begin
      lHtmlDirTest := lBaseDir + 'html\';
      if DirectoryExists(lHtmlDirTest) then
        begin
          result := lHtmlDirTest;
          break;
        end;
      lBaseDir := ExtractFilePath(ExcludeTrailingBackSlash(lBaseDir));
    end;
end;

procedure TWebComponent.GetScreenShot;
begin
  FRemoteObj.Events['dohtml2canvasop'].Fire;
end;

function TWebComponent.GetXTagDir: string;
var
  lBaseDir : string;
  lXtagDirTest: string;
begin
  result := '';
  lBaseDir := ExtractFilePath(ParamStr(0));
  while (lBaseDir <> '') and (length(lBaseDir) > 2) do
    begin
      lXtagDirTest := lBaseDir + 'x-tag\';
      if DirectoryExists(lXtagDirTest) then
        begin
          result := lXtagDirTest;
          break;
        end;
      lBaseDir := ExtractFilePath(ExcludeTrailingBackSlash(lBaseDir));
    end;
end;


end.
