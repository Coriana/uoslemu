// Name: onres
// Description: on resurrection script
// Version: r1y2006
// Creator: Maximilian Scherr
// Date: 16 April 2005
// Attention: Don't call SetAlive() or start this script from here at least not with the same object attached.

var
  Player, Backpack, Corpse: TObjectReference;
  NearbyItems, CorpseItems: TObjectArray;
  CorpseID, I: Cardinal;

begin
  // Main parameter conversion.
  Player := GetObjectReference(OTPLAYER, StrToCard(Parameter1));
  
  // Main code.
  case GetSex(Player) of
    SMALE: SetGraphic(Player, 0);
    SFEMALE: SetGraphic(Player, 1);
          
  end;
  SendText(TTSYSTEMMESSAGE, EMPTYOR, Player, 'You are alive again.', 255, 255, 255);
  Backpack := GetEquipmentByLayer(Player, LBACKPACK);
  if ObjectExists(Backpack) then
    begin
      SetVisible(Backpack);
      CorpseID := GetCPropCardinalValue(Player, 'Corpse ID');
      NearbyItems := ListObjectsNearLocation(OTITEM, GetObjectX(Player), GetObjectY(Player), 1);
      if GetArrayLength(NearbyItems) > 0 then
        for I := 0 to GetArrayLength(NearbyItems) - 1 do
          if GetObjectID(NearbyItems[I]) = CorpseID then
            begin
              Corpse := NearbyItems[I];
              CorpseItems := ListItemsInContainer(Corpse);
	      if GetArrayLength(CorpseItems) > 0 then
	        for I := 0 to GetArrayLength(CorpseItems) - 1 do
	          InsertItem(CorpseItems[I], Backpack, DEFINSPOS, DEFINSPOS, GetAmount(CorpseItems[I]));
	                
	      DeleteObject(Corpse);
	      EraseCProp(Player, 'Corpse ID');
              SendText(TTSYSTEMMESSAGE, EMPTYOR, Player, 'You looted your own corpse empty.', 255, 255, 255);
              Break;
          
            end;
          
    end;

end.                             