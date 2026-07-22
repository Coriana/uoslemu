// Name: global
// Description: global "script"
// Version: r1y2006
// Creator: Maximilian Scherr
// Date: 16 April 2005

var
  EMPTYOR: TObjectReference;
  
function GetDirectionToObject(FromObject, ToObject: TObjectReference): Byte;
begin
  Result := GetDirectionTo(GetObjectXMain(FromObject), GetObjectYMain(FromObject),
                           GetObjectXMain(ToObject), GetObjectYMain(ToObject));
    
end;

// Example for overriding.
// procedure Walk(NPC: TObjectReference; Direction: Byte);
//   begin
//
//   end;

// This is a very simple CheckSkill function.
function CheckSkill(ObjectReference: TObjectReference; Skill: Integer; ChanceModifier: Extended): Boolean;
var
  SkillValue, Chance: Byte;
  Advancement: Boolean;
  
begin
  SkillValue := GetSkill(ObjectReference, Skill)
  Chance := Round((SkillValue + 10) * ChanceModifier);
  if Chance > 100 then
    Chance := 100;
    
  Advancement := False;
  if Chance >= RandomInteger(100) then
    begin
      if Round(Abs(Chance - 100)) >= RandomInteger(500) then
        Advancement := True;
        
      Result := True
      
    end
    
  else
    begin  
      if Round(Abs(Chance - 100)) >= RandomInteger(250) then
        Advancement := True;
        
      Result := False;
    
    end;
    
  if Advancement then
    begin
      SetSkill(ObjectReference, Skill, SkillValue + 1);
      case Skill of
        SKIDMAGICDEFENSE:
          begin
            if GetObjectType(ObjectReference) = OTPLAYER then
              SendText(TTSYSTEMMESSAGE, EMPTYOR, ObjectReference, 'Your Magic Defense skill advanced.', 0, 255, 0);
                    
          end
        
        SKIDBATTLEDEFENSE:
          begin
            if GetObjectType(ObjectReference) = OTPLAYER then
              SendText(TTSYSTEMMESSAGE, EMPTYOR, ObjectReference, 'Your Battle Defense skill advanced.', 0, 255, 0);
                             
          end
        
        SKIDSTEALING:
          begin
            if GetObjectType(ObjectReference) = OTPLAYER then
              SendText(TTSYSTEMMESSAGE, EMPTYOR, ObjectReference, 'Your Stealing skill advanced.', 0, 255, 0);
  
          end
        
        SKIDHIDING:
          begin
            if GetObjectType(ObjectReference) = OTPLAYER then
              SendText(TTSYSTEMMESSAGE, EMPTYOR, ObjectReference, 'Your Hiding skill advanced.', 0, 255, 0);
  
          end
            
        SKIDFIRSTAID:
          begin
            if GetObjectType(ObjectReference) = OTPLAYER then
              SendText(TTSYSTEMMESSAGE, EMPTYOR, ObjectReference, 'Your First Aid skill advanced.', 0, 255, 0);
  
          end
        
        SKIDDETECTTRAP:
          begin
            if GetObjectType(ObjectReference) = OTPLAYER then
              SendText(TTSYSTEMMESSAGE, EMPTYOR, ObjectReference, 'Your Detect Trap skill advanced.', 0, 255, 0);
  
          end
        
        SKIDPEEK:
          begin
            if GetObjectType(ObjectReference) = OTPLAYER then
              SendText(TTSYSTEMMESSAGE, EMPTYOR, ObjectReference, 'Your Peek skill advanced.', 0, 255, 0);
  
          end
        
        SKIDMAGIC:
          begin
            if GetObjectType(ObjectReference) = OTPLAYER then
              SendText(TTSYSTEMMESSAGE, EMPTYOR, ObjectReference, 'Your Magic skill advanced.', 0, 255, 0);
          end
        
        SKIDMELEE:
          begin
            if GetObjectType(ObjectReference) = OTPLAYER then
              SendText(TTSYSTEMMESSAGE, EMPTYOR, ObjectReference, 'Your Melee skill advanced.', 0, 255, 0);
  
          end
        
        SKIDRANGEDWEAPONS:
          begin
            if GetObjectType(ObjectReference) = OTPLAYER then
              SendText(TTSYSTEMMESSAGE, EMPTYOR, ObjectReference, 'Your Ranged Weapons skill advanced.', 0, 255, 0);
  
          end;
                
      end;
      
    end;
  
end;

function GetRandomName(ObjectReference: TObjectReference): String;
begin
  if GetSex(ObjectReference) = SMALE then
    case (RandomInteger(50)) of
      0: Result := 'Abbott';
      1: Result := 'Adon';
      2: Result := 'Alaric';
      3: Result := 'Baran';
      4: Result := 'Baldwin';
      5: Result := 'Ben';
      6: Result := 'Caleb';
      7: Result := 'Cassius';
      8: Result := 'Cole';
      9: Result := 'Dominic';
      10: Result := 'Devin';
      11: Result := 'Doyle';
      12: Result := 'Elliot';
      13: Result := 'Elston';
      14: Result := 'Ethan';
      15: Result := 'Finn';
      16: Result := 'Frank';
      17: Result := 'Foster';
      18: Result := 'Garrett';
      19: Result := 'George';
      20: Result := 'Griffith';
      21: Result := 'Hamlin';
      22: Result := 'Harry';
      23: Result := 'Hogan';
      24: Result := 'Isaac';
      25: Result := 'Ian';
      26: Result := 'Jacob';
      27: Result := 'Jared';
      28: Result := 'Kane';
      29: Result := 'Killian';
      30: Result := 'Kirk';
      31: Result := 'Leonard';
      32: Result := 'Lysander';
      33: Result := 'Malcolm';
      34: Result := 'Morgan';
      35: Result := 'Myron';
      36: Result := 'Nathan';
      37: Result := 'Oscar';
      38: Result := 'Patton';
      39: Result := 'Raleigh';
      40: Result := 'Sandor';
      41: Result := 'Tyler';
      42: Result := 'Virgil';
      43: Result := 'Vaughn';
      44: Result := 'Waylon';
      45: Result := 'Yves';
      46: Result := 'Yardley';
      47: Result := 'Zared';
      48: Result := 'Zenon';
      49: Result := 'Zachariah';
      50: Result := 'Zorn';
      
    end
    
  else
    case (RandomInteger(50)) of
          0: Result := 'Adalia';
          1: Result := 'Airlia';
          2: Result := 'Amanda';
          3: Result := 'Anastasia';
          4: Result := 'Beatrice';
          5: Result := 'Basia';
          6: Result := 'Brynn';
          7: Result := 'Caimile';
          8: Result := 'Carolyn';
          9: Result := 'Cora';
          10: Result := 'Daphne';
          11: Result := 'Deirdre';
          12: Result := 'Etania';
          13: Result := 'Eyota';
          14: Result := 'Fayina';
          15: Result := 'Felicity';
          16: Result := 'Freya';
          17: Result := 'Galya';
          18: Result := 'Gillian';
          19: Result := 'Gretchen';
          20: Result := 'Haya';
          21: Result := 'Hannah';
          22: Result := 'Hesper';
          23: Result := 'Indra';
          24: Result := 'Iris';
          25: Result := 'Isabel';
          26: Result := 'Jayne';
          27: Result := 'June';
          28: Result := 'Kaiya';
          29: Result := 'Karisa';
          30: Result := 'Kaye';
          31: Result := 'Leslie';
          32: Result := 'Leila';
          33: Result := 'Maren';
          34: Result := 'Maude';
          35: Result := 'Natalie';
          36: Result := 'Nori';
          37: Result := 'Odelia';
          38: Result := 'Patricia';
          39: Result := 'Pearl';
          40: Result := 'Rose';
          41: Result := 'Sheila';
          42: Result := 'Serafina';
          43: Result := 'Tammy';
          44: Result := 'Uma';
          45: Result := 'Violet';
          46: Result := 'Wilona';
          47: Result := 'Xylia';
          48: Result := 'Yolanda';
          49: Result := 'Zalika';
          50: Result := 'Zara';
      
    end;
  
end;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   