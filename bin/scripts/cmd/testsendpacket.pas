// Name: testsendpacket
// Description: test send packet script
// Version: r1y2005
// Creator: Maximilian Scherr
// Date: 20 March 2005

var
  Player: TObjectReference;
  Packet: TArrayOfByte;
  Number: Byte;
  SubString: String;

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
  SetArrayLength(Packet, 0);
  Number := 1;
  SubString := LowerCase(GetSubString(Parameter2, Number));
  while SubString <> '' do
    begin
      printservermessage(SubString);
      if Pos('b', SubString) = 1 then
        begin
          Delete(SubString, 1, 1);
          AddByte(Packet, StrToInt(SubString));
          
        end
         
      else if Pos('w', SubString) = 1 then
        begin
          Delete(SubString, 1, 1);
          AddWord(Packet, StrToInt(SubString));
	          
        end
        
      else if Pos('dw', SubString) = 1 then
        begin
	  Delete(SubString, 1, 2);
          AddDWord(Packet, StrToCard(SubString));
		          
        end;

      Number := Number + 1;
      SubString := LowerCase(GetSubString(Parameter2, Number));
        
    end;
    
  if GetArrayLength(Packet) > 0 then
    SendPacket(Packet, Player);

end.            