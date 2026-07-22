// Name: onspecact
// Description: on special action script
// Version: r1y2005
// Creator: Maximilian Scherr
// Date: 31 March 2005

var
  Player, Item, Target: TObjectReference;
  TargetObjectType: Integer;
  TargetX, TargetY: Word;
  TargetZ: ShortInt;
  ItemType: Cardinal;
  Input: String;

begin
  // Main parameter conversion and main code (no separation in this script).
  Player := GetObjectReference(OTPLAYER, StrToCard(Parameter1));
  Item := GetObjectReference(OTITEM, StrToCard(Parameter2));
  ItemType := GetItemType(Item);
  if Parameter3 = '' then
    begin
    
    end
    
  else if Parameter5 = '' then
    begin
      TargetObjectType := StrToInt(Parameter3);
      Target := GetObjectReference(TargetObjectType, StrToCard(Parameter4));
            
    end
    
  else
    begin
      TargetX := StrToInt(Parameter3);
      TargetY := StrToInt(Parameter4);
      TargetZ := StrToInt(Parameter5);
      if ItemType = 32 then
        begin
          SendText(TTSYSTEMMESSAGE, EMPTYOR, Player, 'What kind of item do you want to create?', 255, 255, 255);
          SendText(TTSYSTEMMESSAGE, EMPTYOR, Player, '1: tunic', 255, 255, 255);
          SendText(TTSYSTEMMESSAGE, EMPTYOR, Player, '2: backpack', 255, 255, 255);
          SendText(TTSYSTEMMESSAGE, EMPTYOR, Player, '3: gold coin', 255, 255, 255);
          SendText(TTSYSTEMMESSAGE, EMPTYOR, Player, '4: pants', 255, 255, 255);
          SendText(TTSYSTEMMESSAGE, EMPTYOR, Player, '5: skirt', 255, 255, 255);
          SendText(TTSYSTEMMESSAGE, EMPTYOR, Player, '6: dagger', 255, 255, 255);
          SendText(TTSYSTEMMESSAGE, EMPTYOR, Player, '13: spellbook', 255, 255, 255);
          Input := RequestInput(Player);
          if Input <> '' then
            CreateObject(OTITEM, StrToCard(Input), TargetX, TargetY, TargetZ);
          
        end;
              
    end;
  
end.