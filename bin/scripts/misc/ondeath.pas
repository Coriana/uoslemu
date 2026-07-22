// Name: ondeath
// Description: on death script
// Version: r1y2006
// Creator: Maximilian Scherr
// Date: 16 April 2005
// Attention: Don't call SetDead() or start this script from here at least not with the same object attached.

var
  ObjectType: Integer;
  ObjectReference, Corpse: TObjectReference;
  Graphic, CorpseGraphic: Word;
  EquippedItems, BackpackItems: TObjectArray;
  I: Cardinal;

begin
  // Main parameter conversion.
  ObjectType := StrToInt(Parameter1);
  ObjectReference := GetObjectReference(ObjectType, StrToCard(Parameter2));
  
  // Main code.
  Graphic := GetGraphic(ObjectReference);
  case Graphic of
    0: CorpseGraphic := 15719;
    1: CorpseGraphic := 15720;
    40: CorpseGraphic := 15717;
    41: CorpseGraphic := 15716;
    42: CorpseGraphic := 15718;
    43: CorpseGraphic := 15718;
    50: CorpseGraphic := 15722;
    52: CorpseGraphic := 15721;
    53: CorpseGraphic := 15723;
    else
      CorpseGraphic := 15719;
    
  end;
  Corpse := CreateObject(OTITEM, ITIDCORPSE, GetObjectX(ObjectReference), GetObjectY(ObjectReference), GetObjectZ(ObjectReference));
  SetGraphic(Corpse, CorpseGraphic);
  EquippedItems := ListEquippedItems(ObjectReference);
  if GetArrayLength(EquippedItems) > 0 then
    for I := 0 to GetArrayLength(EquippedItems) - 1 do
      if IsMoveable(EquippedItems[I]) and (GetObjectID(EquippedItems[I]) <> GetObjectID(GetEquipmentByLayer(ObjectReference, LBACKPACK))) then
        InsertItem(EquippedItems[I], Corpse, DEFINSPOS, DEFINSPOS, GetAmount(EquippedItems[I]));
  
  BackpackItems := ListItemsInContainer(GetEquipmentByLayer(ObjectReference, LBACKPACK));
  if GetArrayLength(BackpackItems) > 0 then
    for I := 0 to GetArrayLength(BackpackItems) - 1 do
      if IsMoveable(BackpackItems[I]) then
        InsertItem(BackpackItems[I], Corpse, DEFINSPOS, DEFINSPOS, GetAmount(BackpackItems[I]));
        
  SetInvisible(GetEquipmentByLayer(ObjectReference, LBACKPACK));
  if ObjectType = OTNPC then
    DeleteObject(ObjectReference)
    
  else if ObjectType = OTPLAYER then
    begin
      case GetSex(ObjectReference) of
        SMALE: SetGraphic(ObjectReference, 2);
        SFEMALE: SetGraphic(ObjectReference, 3);
        
      end;
      SetCProp(ObjectReference, 'Corpse ID', '', GetObjectID(Corpse), 0);
      SendText(TTSYSTEMMESSAGE, EMPTYOR, ObjectReference, 'You just died.', 255, 255, 255);
          
    end;

end.                                                                     