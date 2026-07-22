// Name: onsclick
// Description: on single click script
// Version: r1y2006
// Creator: Maximilian Scherr
// Date: 16 April 2006

var
  ClickedType: Integer;
  Clicker, Clicked: TObjectReference;
  Red, Green, Blue: Byte;

begin
  // Main parameter conversion.
  Clicker := GetObjectReference(OTPLAYER, StrToCard(Parameter1));
  ClickedType := StrToInt(Parameter2);
  Clicked := GetObjectReference(ClickedType, StrToCard(Parameter3));
  
  // Main code
  Red := 0;
  Green := 0;
  Blue := 0;
  if IsCriminal(Clicked) then
    Red := 255

  else
    Blue := 255;
    
  SendText(TTTEXTABOVEPRIVATE, Clicked, Clicker, GetName(Clicked), Red, Green, Blue);
  if not IsUnhidden(Clicked) then
    SendText(TTTEXTABOVEPRIVATE, Clicked, Clicker, '[hidden]', Red, Green, Blue);
          
  if not IsAlive(Clicked) then
    SendText(TTTEXTABOVEPRIVATE, Clicked, Clicker, '[dead]', Red, Green, Blue);
        
  if IsPrivileged(Clicked) then
    SendText(TTTEXTABOVEPRIVATE, Clicked, Clicker, '[priviliged]', Red, Green, Blue);
    
end.             