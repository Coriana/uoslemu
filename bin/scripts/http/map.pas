// Name: map
// Description: map script
// Version: r1y2006
// Creator: Maximilian Scherr
// Date: 17 April 2005

const
  URLTOMAP = 'http://www.cip.ifi.lmu.de/~scherr/projects/uoana/files/map.jpg';

var
  HTTPConnection, I, Layer: Cardinal;
  HTML: String;
  Objects: TObjectArray;

begin
  // Main parameter conversion.
  HTTPConnection := StrToCard(Parameter1);
  
  // Main code.
  HTML := '<html><head><title>Map</title>'+
          '<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">'+
          '</head><body bgcolor="#FFFFFF">'+
          '<div id="Layer1" style="position:relative; left:0px; top:0px; width:132px; height:110px; z-index:1">'+
          '<p><img src="'+ URLTOMAP +'" width="1024" height="1024"></p>'+
          '<p><font color="#00FFFF">Online players</font><br>'+
          '<font color="#FFFF00">NPCs</font><br>'+
          '<font color="#00FF00">Items</font></p>';          
  Layer := 2;
  Objects := ListObjects(OTITEM);
  if GetArrayLength(Objects) > 0 then
    for I := 0 to GetArrayLength(Objects) - 1 do
      if (GetObjectType(GetMainContainer(Objects[I])) = OTNONE) and
         (GetObjectType(IsEquippedBy(Objects[I])) = OTNONE) then
        begin
          HTML := HTML +'<div id="Layer'+ IntToStr(Layer) +'" style="position:absolute; '+
                        'left:'+ IntToStr(GetObjectX(Objects[I])) +'px; top:'+ IntToStr(GetObjectY(Objects[I])) +
                        'px; width:1px; height:1px; z-index:'+ IntToStr(Layer) +'">'+
                        '<table width="1" border="0" cellspacing="0" cellpadding="0" height="1" bgcolor="#00FF00">'+
                        '<tr><td></td></tr>'+
                        '</table>'+
                        '</div>';
          Layer := Layer + 1;
        
        end;
      
  Objects := ListObjects(OTNPC);
  if GetArrayLength(Objects) > 0 then
    for I := 0 to GetArrayLength(Objects) - 1 do
      begin
        HTML := HTML +'<div id="Layer'+ IntToStr(Layer) +'" style="position:absolute; '+
                      'left:'+ IntToStr(GetObjectX(Objects[I])) +'px; top:'+ IntToStr(GetObjectY(Objects[I])) +
                      'px; width:1px; height:1px; z-index:'+ IntToStr(Layer) +'">'+
                      '<table width="1" border="0" cellspacing="0" cellpadding="0" height="1" bgcolor="#FFFF00">'+
                      '<tr><td></td></tr>'+
                      '</table>'+
                      '</div>';
        Layer := Layer + 1;
        
      end;
      
  Objects := ListOnlinePlayers;
  if GetArrayLength(Objects) > 0 then
    for I := 0 to GetArrayLength(Objects) - 1 do
      begin
        HTML := HTML +'<div id="Layer'+ IntToStr(Layer) +'" style="position:absolute; '+
                      'left:'+ IntToStr(GetObjectX(Objects[I])) +'px; top:'+ IntToStr(GetObjectY(Objects[I])) +
                      'px; width:1px; height:1px; z-index:'+ IntToStr(Layer) +'">'+
                      '<table width="1" border="0" cellspacing="0" cellpadding="0" height="1" bgcolor="#00FFFF">'+
                      '<tr><td></td></tr>'+
                      '</table>'+
                      '</div>';
        Layer := Layer + 1;
        
      end;
        
  HTML := HTML +'</div></html>';
  WriteHTML(HTTPConnection, HTML);
  
end.                                         