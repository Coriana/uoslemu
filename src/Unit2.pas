unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, psvPas;

type
  TForm2 = class(TForm)
    RichEdit1: TRichEdit;
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RichEdit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  erscriptfn: String;
  erscripterpos: Cardinal;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
var
  scriptfile: TextFile;

begin
  AssignFile(scriptfile, erscriptfn);
  Rewrite(scriptfile);
  Write(scriptfile, RichEdit1.Text);
  CloseFile(scriptfile);
  erscriptfn := '';
  erscripterpos := 0;
  Edit1.Clear;
  RichEdit1.Clear;
  Hide;
  Form1.Button1.Enabled := True;
  Form1.Button2.Enabled := True;
  Form1.Button3.Enabled := True;
  Form1.Button4.Enabled := True;
  Form1.Button5.Enabled := True;
  Form1.Button6.Enabled := True;
  Form1.Button7.Enabled := True;
  Form1.Button8.Enabled := True;
  Form1.Button9.Enabled := True;

end;

procedure TForm2.FormActivate(Sender: TObject);
begin
  Form1.Button1.Enabled := False;
  Form1.Button2.Enabled := False;
  Form1.Button3.Enabled := False;
  Form1.Button4.Enabled := False;
  Form1.Button5.Enabled := False;
  Form1.Button6.Enabled := False;
  Form1.Button7.Enabled := False;
  Form1.Button8.Enabled := False;
  Form1.Button9.Enabled := False;
  Edit1.Text := erscriptfn;
  RichEdit1.Lines.LoadFromFile(erscriptfn);
  Richedit1.SetFocus;
  RichEdit1.SelStart := erscripterpos;
  RichEdit1.SelLength := 1;
  
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  erscriptfn := '';
  erscripterpos := 0;
  RichEdit1.SelStart := 0;
  RichEdit1.SelLength := 0;
  RichEdit1.Clear;
  Edit1.Clear;
  Form1.Button1.Enabled := True;
  Form1.Button2.Enabled := True;
  Form1.Button3.Enabled := True;
  Form1.Button4.Enabled := True;
  Form1.Button5.Enabled := True;
  Form1.Button6.Enabled := True;
  Form1.Button7.Enabled := True;
  Form1.Button8.Enabled := True;
  Form1.Button9.Enabled := True;

end;

procedure TForm2.RichEdit1Change(Sender: TObject);
var
  tempms: TMemoryStream;
  fsyntax: TpsvPasRTF;
  pos, top: Integer;
  onchange: TNotifyEvent;

begin
  if Length(RichEdit1.Text) < 1 then
    Exit;

  pos := RichEdit1.SelStart;
  top := SendMessage(RichEdit1.Handle, EM_GETFIRSTVISIBLELINE, 0, 0);
  onchange := RichEdit1.OnChange;
  tempms := TMemoryStream.Create;
  RichEdit1.OnChange := nil;
  try
    fsyntax := TpsvpasRTF.Create;
    try
      try
        fsyntax.SetText(RichEdit1.Text);
        fsyntax.ConvertToRTFStream(tempms);
        tempms.Position := 0;
        RichEdit1.PlainText := False;
        RichEdit1.Lines.BeginUpdate;
        RichEdit1.Lines.LoadFromStream(tempms);
        SendMessage(RichEdit1.Handle, EM_LINESCROLL, 0, top);
        RichEdit1.Lines.EndUpdate;

      finally
        fsyntax.Free;

      end;

    except
      RichEdit1.SelAttributes := RichEdit1.DefAttributes;

    end;

  finally
    RichEdit1.PlainText := True;
    RichEdit1.SelStart := pos;
    tempms.Free;
    RichEdit1.OnChange := onchange;

  end;

end;

end.
