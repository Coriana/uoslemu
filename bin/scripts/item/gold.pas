// Name: gold
// Description: gold script
// Version: r1y2005
// Creator: Maximilian Scherr
// Date: 20 March 2005

var
  EventType, EventIntegerValue: Integer;
  EventStringValue: String;
  EventCardinalValue: Cardinal;
  Item, UnstackedItem: TObjectReference;
  StackedAmount: Word;

begin
  // Main parameter conversion.
  Item := GetObjectReference(OTITEM, StrToCard(Parameter1));
  EventType := StrToInt(Parameter2);
  EventIntegerValue := StrToInt(Parameter3);
  EventStringValue := Parameter4;
  EventCardinalValue := StrToCard(Parameter5);
  
  // Main code.
  if (EventType = ETMOVED) or (EventType = ETINSERTED) or (EventType = ETREMOVED) then
    if GetAmount(Item) = 1 then
      PlaySoundEffect(GetObjectXMain(Item), GetObjectYMain(Item), 10)

    else if (GetAmount(Item) > 1) and (GetAmount(Item) < 6) then
      PlaySoundEffect(GetObjectXMain(Item), GetObjectYMain(Item), 11)

    else if GetAmount(Item) > 5 then
      PlaySoundEffect(GetObjectXMain(Item), GetObjectYMain(Item), 12);

  if EventType = ETSTACKED then
    begin
      StackedAmount := EventCardinalValue;
      if StackedAmount = 1 then
        PlaySoundEffect(GetObjectXMain(Item), GetObjectYMain(Item), 10)

      else if (StackedAmount > 1) and (StackedAmount < 6) then
        PlaySoundEffect(GetObjectXMain(Item), GetObjectYMain(Item), 11)

      else if StackedAmount > 5 then
        PlaySoundEffect(GetObjectXMain(Item), GetObjectYMain(Item), 12);

    end;

  if EventType = ETUNSTACKED then
    begin
      UnstackedItem := GetObjectReference(OTITEM, EventCardinalValue);
      if GetAmount(UnstackedItem) = 1 then
        PlaySoundEffect(GetObjectXMain(UnstackedItem), GetObjectYMain(UnstackedItem), 10)

      else if (GetAmount(UnstackedItem) > 1) and (GetAmount(UnstackedItem) < 6) then
        PlaySoundEffect(GetObjectXMain(UnstackedItem), GetObjectYMain(UnstackedItem), 11)

      else if GetAmount(UnstackedItem) > 5 then
        PlaySoundEffect(GetObjectXMain(UnstackedItem), GetObjectYMain(UnstackedItem), 12);

    end;

end.