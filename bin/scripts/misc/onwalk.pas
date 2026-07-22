// Name: onwalk
// Description: on walk script
// Version: r1y2005
// Creator: Maximilian Scherr
// Date: 20 March 2005

var
  Player: TObjectReference;
  OldX, OldY: Word;
  OldZ: ShortInt;

begin
  // Main parameter conversion.
  Player := GetObjectReference(OTPLAYER, StrToCard(Parameter1));
  OldX := StrToInt(Parameter2);
  OldY := StrToInt(Parameter3);
  OldZ := StrToInt(Parameter4);
  
  // Main code.
  // SendText(TTSYSTEMMESSAGE, EMPTYOR, Player,
  //          IntToStr(GetTileGraphic(GetObjectX(Player), GetObjectY(Player))), 255, 255, 255);

end.