// Name: stealing
// Description: stealing script
// Version: r1y2005
// Creator: Maximilian Scherr
// Date: 20 March 2005

var
  Thief, Item, FromContainer: TObjectReference;
  ThiefObectType: Integer;
  Amount: Word;

begin
  // Main parameter conversion.
  Thief := GetObjectReference(OTPLAYER, StrToCard(Parameter1));
  Item := GetObjectReference(OTITEM, StrToCard(Parameter2));
  FromContainer := GetObjectReference(OTITEM, StrToCard(Parameter3));
  Amount := StrToInt(Parameter4);
  
  // Main code.
  SendText(TTTEXTABOVE, Thief, EMPTYOR, 'You are a bad boy ;-)', 255, 255, 255);
  
end.
