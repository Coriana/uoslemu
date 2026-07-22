// Name: testgettime
// Description: test get time script
// Version: r1y2005
// Creator: Maximilian Scherr
// Date: 31 March 2005

var
  Player: TObjectReference;
  
begin
  // Main parameter conversion.
  Player := GetObjectReference(OTPLAYER, StrToCard(Parameter1));
  
  // Privilege check.
  if not IsPrivileged(Player) then
    begin
      SendText(TTSYSTEMMESSAGE, EMPTYOR, Player, 'You are not privileged to use this command!', 255, 0, 0);
      Exit;
        
    end;
  
  // Main code.
  PrintServerMessage('Date: '+ IntToStr(GetDate));
  PrintServerMessage('Time of day: '+ IntToStr(GetTimeOfDay));

end.                  