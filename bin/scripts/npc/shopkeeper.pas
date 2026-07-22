// Name: shopkeeper
// Description: shopkeeper script
// Version: r1y2005
// Creator: Maximilian Scherr
// Date: 21 March 2005

var
  NPC, Speaker: TObjectReference;
  Event: TEvent;
  SpeechString: String;
  SpeakerType: Integer;

begin
  // Main parameter conversion.
  NPC := GetObjectReference(OTNPC, StrToCard(Parameter1));
  
  // Main code.
  if GetName(NPC) = 'a shopkeeper' then
    SetName(NPC, GetRandomName(NPC));
    
  while IsServerActive and ObjectExists(NPC) do
    begin
      Event := GetEvent(NPC);
      if GetEventType(Event) = ETTALKED then
        begin
          SpeechString := LowerCase(GetEventStringValue(Event));
          SpeakerType := GetEventIntegerValue(Event);
          Speaker := GetObjectReference(SpeakerType, GetEventCardinalValue(Event));
          if Pos(LowerCase(GetName(NPC)), SpeechString) > 0 then
            begin
              if (Pos('hello', SpeechString) > 0) or
                 (Pos('hi', SpeechString) > 0) or
                 (Pos('greetings', SpeechString) > 0) then
                begin
                  SetFacing(NPC, GetDirectionToObject(NPC, Speaker));
                  SendText(TTSPEECH, NPC, EMPTYOR, 'Greetings. May I help thee?', 255, 255, 255);
                  
                end
                
              else if Pos('buy', SpeechString) > 0 then
                begin
                  SetFacing(NPC, GetDirectionToObject(NPC, Speaker));
                  SendText(TTSPEECH, NPC, EMPTYOR, 'Sorry.', 255, 255, 255);
            
                end
                
              else if (Pos('goodbye', SpeechString) > 0) or
	              (Pos('bye', SpeechString) > 0) or
	              (Pos('farewell', SpeechString) > 0) then
	        begin
	          SetFacing(NPC, GetDirectionToObject(NPC, Speaker));
	          SendText(TTSPEECH, NPC, EMPTYOR, 'Fare thee well '+ GetName(Speaker) +'.', 255, 255, 255);
	                        
                end
                
            end
            
        end;
      
      ScriptSleep(100);
      
    end;

end.       