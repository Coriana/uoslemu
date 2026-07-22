// Name: createitem
// Description: create item script
// Version: r1y2005
// Creator: Maximilian Scherr
// Date: 20 March 2005

var
  Player: TObjectReference;
  ItemType: Integer;

begin
  // Main parameter conversion.
  Player := GetObjectReference(OTPLAYER, StrToCard(Parameter1));
  
  // Privilege check.
  if not IsPrivileged(Player) then
    begin
      SendText(TTSYSTEMMESSAGE, EMPTYOR, Player, 'You are not privileged to use this command!', 255, 0, 0);
      Exit;
          
    end;
  
  // No command parameter given.
  if Parameter2 = '' then
    begin
      SendText(TTSYSTEMMESSAGE, EMPTYOR, Player, 'You need to supply a parameter to this command.', 255, 0, 0);
      Exit;
          
    end;
    
  // Main code.
  ItemType := StrToInt(Parameter2);
  CreateObject(OTITEM, ItemType, GetObjectX(Player), GetObjectY(Player), GetObjectZ(Player));

end.
