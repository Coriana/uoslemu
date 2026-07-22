// Name: onlogout
// Description: on logout script
// Version: r1y2005
// Creator: Maximilian Scherr
// Date: 20 March 2005

var
  Player: TObjectReference;

begin
  // Main parameter conversion.
  Player := GetObjectReference(OTPLAYER, StrToCard(Parameter1));
  
  // Main code.
  // We remove all the temporary CProps.
  EraseCProp(Player, 'EndCombat');
  EraseCProp(Player, 'InCombatWith');

end.