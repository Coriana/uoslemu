// Name: combat
// Description: combat script
// Version: r1y2006
// Creator: Maximilian Scherr
// Date: 16 April 2006

const
  MAXDISTANCE = 30;
  MINDAMAGE = 1;
  MAXDAMAGE = 25;
  MINDELAY = 1;
  MAXDELAY = 4;
  DELAYUNIT = 1000;

var
  AttackerType, DefenderType: Integer;
  Attacker, Defender, Weapon: TObjectReference;
  WeaponSpeed, WeaponDamage, SubtractHits: Byte;
  NextAttack: Cardinal;
  DefenderName: String;

begin
  // Main parameter conversion.
  AttackerType := StrToInt(Parameter1);
  Attacker := GetObjectReference(AttackerType, StrToCard(Parameter2));
  DefenderType := StrToInt(Parameter3);
  Defender := GetObjectReference(DefenderType, StrToCard(Parameter4));
  // We don't want to let non-existent NPCs or Players fight.
  if not ObjectExists(Attacker) or not ObjectExists(Defender) then
    Exit;
    
  // Main code.
  SendText(TTTEXTABOVEPRIVATE, Attacker, Attacker, '*You are starting combat with '+ GetName(Defender) +'*', 255, 0, 0);
  SendText(TTTEXTABOVEPRIVATE, Attacker, Defender, '*'+ GetName(Attacker) +' is starting combat with you*', 255, 0, 0);
  DefenderName := GetName(Defender);
  NextAttack := 0;
  while IsAtWar(Attacker) and (CheckObjectDistance(Attacker, Defender) <= MAXDISTANCE) and
        not CPropExists(Attacker, 'EndCombat') do
    begin
      if (AttackerType = OTPLAYER) and (not IsAlive(Attacker) or not IsOnline(Attacker)) then
        Break
      
      else if (AttackerType = OTNPC) and not ObjectExists(Attacker) then
        Break
       
      else if (DefenderType = OTPLAYER) and (not IsAlive(Defender) or not IsOnline(Defender)) then
        Break
          
      else if (DefenderType = OTNPC) and not ObjectExists(Defender) then
        Break;
    
      if (CheckObjectDistance(Attacker, Defender) = 1) and (NextAttack <= ScriptGetTickCount) then
        begin
          SetFacing(Attacker, GetDirectionTo(GetObjectX(Attacker), GetObjectY(Attacker), GetObjectX(Defender), GetObjectY(Defender)));
          if (GetGraphic(Attacker) < 50) then
            PlayAnimation(Attacker, AATTACK);
            
          if ObjectExists(Defender) then
            SetFacing(Defender, GetDirectionTo(GetObjectX(Defender), GetObjectY(Defender), GetObjectX(Attacker), GetObjectY(Attacker)))
            
          else
            Break;
            
          if (GetGraphic(Defender) < 50) then
            PlayAnimation(Defender, ADEFEND);
            
          Weapon := GetEquipmentByLayer(Attacker, LWEAPON)
	  if GetObjectType(Weapon) = OTNONE then
	    begin
	      WeaponSpeed := 30;
	      WeaponDamage := 10;
	          
	    end
		        
	  else
	    begin
	      WeaponSpeed := GetWeaponSpeed(Weapon);
	      WeaponDamage := GetWeaponSpeed(Weapon);
		          
	    end;
	  
          if CheckSkill(Attacker, SKIDMELEE, 1) then
            begin
              SubtractHits := RandomInteger(MAXDAMAGE * WeaponDamage / 100) + MINDAMAGE;
              if CheckSkill(Defender, SKIDBATTLEDEFENSE, 1) then
                SubtractHits := SubtractHits / 2;
                
  	      if Int(GetHits(Defender)) - Int(SubtractHits) < 0 then
                SetHits(Defender, 0)
               
              else
                SetHits(Defender, GetHits(Defender) - SubtractHits);
                
            end;
          
          NextAttack := ScriptGetTickCount + (MINDELAY + MAXDELAY - MAXDELAY * WeaponSpeed / 100) * DELAYUNIT;
        
        end
        
      else
        ScriptSleep(100);
        
    end;
    
  SendText(TTTEXTABOVEPRIVATE, Attacker, Attacker, '*You stopped combat with '+ DefenderName +'*', 0, 255, 0);
  SendText(TTTEXTABOVEPRIVATE, Attacker, Defender, '*'+ GetName(Attacker) +' stopped combat with you*', 0, 255, 0);
  EraseCprop(Attacker, 'EndCombat');
  EraseCProp(Attacker, 'InCombatWith');

end.                                                                                                                                     