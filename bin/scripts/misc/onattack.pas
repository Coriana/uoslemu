// Name: onattack
// Description: on attack script
// Version: r1y2005
// Creator: Maximilian Scherr
// Date: 20 March 2005

var
  AttackerType, DefenderType: Integer;
  Attacker, Defender, Weapon: TObjectReference;

begin
  // Main parameter conversion.
  AttackerType := StrToInt(Parameter1);
  Attacker := GetObjectReference(AttackerType, StrToCard(Parameter2));
  DefenderType := StrToInt(Parameter3);
  Defender := GetObjectReference(DefenderType, StrToCard(Parameter4));
  
  // Main code.
  if GetCPropCardinalValue(Attacker, 'InCombatWith') <> GetObjectID(Defender) then
    begin
      if CPropExists(Attacker, 'InCombatWith') then
        SetCProp(Attacker, 'EndCombat','', 0, 0);
        
      while CPropExists(Attacker, 'InCombatWith') do
        ScriptSleep(10);
        
      SetCProp(Attacker, 'InCombatWith','', GetObjectID(Defender), 0);
      StartScript(STMISC, 'combat', Parameter1, Parameter2, Parameter3, Parameter4, '');
      
    end;

end.                                                                