// Name: oncreate
// Description: on create script
// Version: r1y2005
// Creator: Maximilian Scherr
// Date: 20 March 2005

var
  Player, Item, Container: TObjectReference;
  Sex: Integer;
  HairStyle, HairColor: Byte;

begin
  // Main parameter conversion.
  Player := GetObjectReference(OTPLAYER, StrToCard(Parameter1));
  HairStyle := StrToInt(Parameter2);
  HairColor := StrToInt(Parameter3);
  
  // Main code.
  Sex := GetSex(Player);
  if Sex = SMALE then
    case HairStyle of
      0: Item := CreateObject(OTITEM, 7, GetObjectX(Player), GetObjectX(Player), GetObjectX(Player));
      1: Item := CreateObject(OTITEM, 8, GetObjectX(Player), GetObjectX(Player), GetObjectX(Player)); 

    end

  else if Sex = SFEMALE then
    case HairStyle of
      0: Item := CreateObject(OTITEM, 9, GetObjectX(Player), GetObjectX(Player), GetObjectX(Player));
      1: Item := CreateObject(OTITEM, 10, GetObjectX(Player), GetObjectX(Player), GetObjectX(Player)); 
      2: Item := CreateObject(OTITEM, 11, GetObjectX(Player), GetObjectX(Player), GetObjectX(Player));

    end;

  if (Sex = SFEMALE) or ((Sex = SMALE) and (HairStyle <> 2)) then
    begin
      case HairColor of
        0: SetColor(Item, 9);
        1: SetColor(Item, 10);
        2: SetColor(Item, 11);
        3: SetColor(Item, 12);
        4: SetColor(Item, 13);
        5: SetColor(Item, 14);
        6: SetColor(Item, 15);
        7: SetColor(Item, 16);

      end;
      EquipItem(Player, Item);

    end;

  Item := CreateObject(OTITEM, 1, GetObjectX(Player), GetObjectX(Player), GetObjectX(Player));
  EquipItem(Player, Item);
  if Sex = SMALE then
    Item := CreateObject(OTITEM, 4, GetObjectX(Player), GetObjectX(Player), GetObjectX(Player))

  else if Sex = SFEMALE then
    Item := CreateObject(OTITEM, 5, GetObjectX(Player), GetObjectX(Player), GetObjectX(Player));

  EquipItem(Player, Item);
  Container := CreateObject(OTITEM, 2, GetObjectX(Player), GetObjectX(Player), GetObjectX(Player));
  EquipItem(Player, Container);
  Item := CreateObject(OTITEM, 3, GetObjectX(Player), GetObjectX(Player), GetObjectX(Player));
  SetAmount(Item, 60);
  InsertItem(Item, Container, DEFINSPOS, DEFINSPOS, 60);
  Item := CreateObject(OTITEM, 6, GetObjectX(Player), GetObjectX(Player), GetObjectX(Player));
  InsertItem(Item, Container, DEFINSPOS, DEFINSPOS, 0);

end.