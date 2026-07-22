// Name: doorw
// Description: door facing west when closed script
// Version: r1y2005
// Creator: Maximilian Scherr
// Date: 21 March 2005

var
  EventType, EventIntegerValue: Integer;
  EventStringValue: String;
  EventCardinalValue: Cardinal;
  Item: TObjectReference;

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
      if GetGraphic(Item) = 276 then
        if CPropExists(Item, 'outward') then
          OpenOrCloseDoor(Item, 277, 0, 1)
          
        else
          OpenOrCloseDoor(Item, 278, 0, 0)
          
      else if GetGraphic(Item) = 277 then
        OpenOrCloseDoor(Item, 276, 0, -1)
        
      else if GetGraphic(Item) = 278 then
        OpenOrCloseDoor(Item, 276, 0, 0)

      else if GetGraphic(Item) = 280 then
        if CPropExists(Item, 'outward') then
          OpenOrCloseDoor(Item, 281, 0, 1)
          
        else
          OpenOrCloseDoor(Item, 282, 0, 0)
          
      else if GetGraphic(Item) = 281 then
        OpenOrCloseDoor(Item, 280, 0, -1)
        
      else if GetGraphic(Item) = 282 then
        OpenOrCloseDoor(Item, 280, 0, 0);

      if CPropExists(Item, 'open') then
        begin
          SetWalkable(Item, DFNONE);
          PlaySoundEffect(GetObjectXMain(Item), GetObjectYMain(Item), 72);
          EraseCProp(Item, 'open');
           
        end
           
       else
         begin
           SetWalkable(Item, DFALL);
           PlaySoundEffect(GetObjectXMain(Item), GetObjectYMain(Item), 66);
           SetCProp(Item, 'open', '', 0, 0);
           
        end;

    end;

end.
             