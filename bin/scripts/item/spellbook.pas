// Name: spellbook
// Description: spellbook script
// Version: r1y2005
// Creator: Maximilian Scherr
// Date: 20 March 2005

var
  EventType, EventIntegerValue: Integer;
  EventStringValue: String;
  EventCardinalValue: Cardinal;
  Item, Player: TObjectReference;

begin
  // Main parameter conversion.
  Item := GetObjectReference(OTITEM, StrToCard(Parameter1));
  EventType := StrToInt(Parameter2);
  EventIntegerValue := StrToInt(Parameter3);
  EventStringValue := Parameter4;
  EventCardinalValue := StrToCard(Parameter5);
  
  // Main code.
  if EventType = ETDOUBLECLICKED then
    begin
      Player := GetObjectReference(OTPLAYER, EventCardinalValue);
      OpenContainer(Player, Item);

    end;

end.
