// Name: magic
// Description: magic script
// Version: r1y2005
// Creator: Maximilian Scherr
// Date: 20 March 2005

var
  Caster: TObjectReference;
  SpellID: Word;

begin
  // Main parameter conversion.
  Caster := GetObjectReference(OTPLAYER, StrToCard(Parameter1));
  SpellID := StrToInt(Parameter2);
  
  // Main code.
  
end.
       