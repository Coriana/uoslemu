// Name: corpse
// Description: corpse script
// Version: r1y2006
// Creator: Maximilian Scherr
// Date: 16 April 2006

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
      PlaySoundEffect(GetObjectXMain(Item), GetObjectYMain(Item), 25);
      OpenContainer(Player, Item);

    end;

end.
     