program SimpleXtag;

uses
  VirtualUI_Autorun,
  Vcl.Forms,
  frmUIMain in 'frmUIMain.pas' {UIMain},
  untSysWebComponent in 'untSysWebComponent.pas';

{$R *.res}

begin
  {$IFDEF DEBUG}ReportMemoryLeaksOnShutdown := True;{$ENDIF}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TUIMain, UIMain);
  Application.Run;
end.
