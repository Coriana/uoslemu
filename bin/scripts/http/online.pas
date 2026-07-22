// Name: online
// Description: online script
// Version: r1y2005
// Creator: Maximilian Scherr
// Date: 25 April 2005

var
  HTTPConnection, I: Cardinal;
  HTML: String;
  OnlinePlayers: TObjectArray;

begin
  // Main parameter conversion.
  HTTPConnection := StrToCard(Parameter1);
  
  // Main code.
  OnlinePlayers := ListOnlinePlayers;
  HTML := '<html><head><title>Online players</title>'+
          '<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">'+
          '</head><body bgcolor="#FFFFFF"><p>Online players:</p>'+
          '<p>';
  if GetArrayLength(OnlinePlayers) > 0 then
    for I := 0 to GetArrayLength(OnlinePlayers) - 1 do
      HTML := HTML + GetName(OnlinePlayers[I]) +'<br>'
    
  else
    HTML := HTML +'No players online!<br>';
    
  HTML := HTML +'</p></body></html>';
  WriteHTML(HTTPConnection, HTML);
  
end.  