// Name: onadclick
// Description: on ALT double click script
// Version: r1y2005
// Creator: Maximilian Scherr
// Date: 27 March 2005

var
  Clicker, Clicked: TObjectReference;
  ClickedObjectType: Integer;

begin
  // Main parameter conversion.
  Clicker := GetObjectReference(OTPLAYER, StrToCard(Parameter1));
  ClickedObjectType := StrToInt(Parameter2);
  Clicked := GetObjectReference(ClickedObjectType, StrToCard(Parameter3));
  
  // Main code.

end.                