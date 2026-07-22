// Name: rabbit
// Description: rabbit script
// Version: r1y2005
// Creator: Maximilian Scherr
// Date: 21 March 2005

var
  NPC: TObjectReference;
  NPCID: Cardinal;
  Event: TEvent;

begin
  // Main parameter conversion.
  NPC := GetObjectReference(OTNPC, StrToCard(Parameter1));
  
  // Main code.
  NPCID := GetObjectID(NPC);
  while IsServerActive and ObjectExists(NPC) do
    begin
      Event := GetEvent(NPC);
      if GetEventType(Event) = ETNONE then
        Walk(NPC, RandomInteger(7));
      
      ScriptSleep(1000);
      
    end;

end.     