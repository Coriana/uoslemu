unit Unit1;

interface

uses
  Windows, Messages, SysUtils, SyncObjs, Dialogs, WSocket, WSocketS,
  StdCtrls, ExtCtrls, Controls, ComCtrls, Classes, Variants, Graphics, Forms,
  IniFiles, ifpscomp, ifps3, oldifps3utl, Hashes, Unit2, HttpSrv;

type
  TForm1 = class(TForm)
    RichEdit1: TRichEdit;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    Button1: TButton;
    Button2: TButton;
    Button4: TButton;
    Button5: TButton;
    Label1: TLabel;
    WSocketServer1: TWSocketServer;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    OpenDialog1: TOpenDialog;
    Button3: TButton;
    LabeledEdit4: TLabeledEdit;
    Button9: TButton;
    HttpServer1: THttpServer;
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure WSocketServer1ClientConnect(Sender: TObject;
      Client: TWSocketClient; Error: Word);
    procedure clientsessionclosed(sender: TObject; error: Word);
    procedure clientdataav(sender: TObject; error: Word);
    procedure WSocketServer1ClientCreate(Sender: TObject;
      Client: TWSocketClient);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure HttpServer1GetDocument(Sender, Client: TObject;
      var Flags: THttpGetFlag);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  ttile = record
    graphic: Word;
    z: ShortInt;

  end;
  tcell = record
    id: DWord;
    tiles: Array[0..63] of ttile;

  end;
  tstatic = record
    serial: DWord;
    graphic: Word;
    x: Byte;
    y: Byte;
    z: ShortInt;
    color: Word;

  end;
  tstaidx = record
    start, length, padding: DWord;

  end;
  tlandtile = record
    flags: DWord;
    textureid: Word;
    namearray: Array[0..19] of Char;

  end;
  tlandgroup = record
    id: DWord;
    landtiles: Array[0..31] of tlandtile;

  end;
  tstatictile = record
    flags: DWord;
    weight: Byte;
    layer: Byte;
    unknown1: Word;
    unused1: Byte;
    unused2: Byte;
    animid: Word;
    unknown2: Byte;
    unused3: Byte;
    unknown3: Word;
    height: Byte;
    namearray: Array[0..19] of Char;

  end;
  tstaticgroup = record
    id: DWord;
    statictiles: Array[0..31] of tstatictile;

  end;
  tcprop = record
    name: String;
    strval: String;
    intval: Integer;
    cardval: Cardinal;

  end;
  tclientthread = class(TThread)
  private
    wsocket: TWSocket;
    threadattached: Boolean;

  public
    procedure Execute; override;

  end;
  tclient = class(TWSocketClient)
  public
    clientthread: tclientthread;
    player: Cardinal;

  end;
  TPrimitiveObjectArray = Array of Cardinal;
  TArrayOfCardinal = Array of Cardinal;
  tcproparray = Array of tcprop;
  tplayer = class
    private
      lock: TCriticalSection;
      pid, pdragitem, pexp: Cardinal;
      pname, ppassw, prealname, phomepage, pemailaddr, ppcinfo: String;
      ponline, pdragging: Boolean;
      pclient: TWSocketClient;
      psex, pdead, pstr, pdex, pint, phits, pmana, pfat, pmagicdef, pbattledef,
      pstealing, phiding, pfirstaid, pdetecttr, ppeek, pmagic, pmelee, prangedweap, plevel,
      pprivileged, phidden, pwar, pfacing, pcriminal: Byte;
      px, py, pgraphic, pdragamt: Word;
      pz: ShortInt;
      pequitems: TArrayOfCardinal;
      popenconts: TPrimitiveObjectArray;
      pcprops: tcproparray;
      peioc, pcpoc, pnouenpcsoc, pnoueplayersoc, pnouitemsoc, pococ: Boolean;
      pinreq: Boolean;
      pinreqres: String;
      pnouenpcs, pnoueplayers, pnouitems: TPrimitiveObjectArray;
      pinaccessible: Boolean;
      function getid: Cardinal;
      procedure setid(card: Cardinal);
      function getdragitem: Cardinal;
      procedure setdragitem(card: Cardinal);
      function getexp: Cardinal;
      procedure setexp(card: Cardinal);
      function getname: String;
      procedure setname(str: String);
      function getpassw: String;
      procedure setpassw(str: String);
      function getrealname: String;
      procedure setrealname(str: String);
      function gethomepage: String;
      procedure sethomepage(str: String);
      function getemailaddr: String;
      procedure setemailaddr(str: String);
      function getpcinfo: String;
      procedure setpcinfo(str: String);
      function getonline: Boolean;
      procedure setonline(bool: Boolean);
      function getdragging: Boolean;
      procedure setdragging(bool: Boolean);
      function getclient: TWSocketClient;
      procedure setclient(twsc: TWSocketClient);
      function getsex: Byte;
      procedure setsex(by: Byte);
      function getdead: Byte;
      procedure setdead(by: Byte);
      function getstr: Byte;
      procedure setstr(by: Byte);
      function getdex: Byte;
      procedure setdex(by: Byte);
      function getint: Byte;
      procedure setint(by: Byte);
      function gethits: Byte;
      procedure sethits(by: Byte);
      function getmana: Byte;
      procedure setmana(by: Byte);
      function getfat: Byte;
      procedure setfat(by: Byte);
      function getmagicdef: Byte;
      procedure setmagicdef(by: Byte);
      function getbattledef: Byte;
      procedure setbattledef(by: Byte);
      function getstealing: Byte;
      procedure setstealing(by: Byte);
      function gethiding: Byte;
      procedure sethiding(by: Byte);
      function getfirstaid: Byte;
      procedure setfirstaid(by: Byte);
      function getdetecttr: Byte;
      procedure setdetecttr(by: Byte);
      function getpeek: Byte;
      procedure setpeek(by: Byte);
      function getmagic: Byte;
      procedure setmagic(by: Byte);
      function getmelee: Byte;
      procedure setmelee(by: Byte);
      function getrangedweap: Byte;
      procedure setrangedweap(by: Byte);
      function getlevel: Byte;
      procedure setlevel(by: Byte);
      function getprivileged: Byte;
      procedure setprivileged(by: Byte);
      function gethidden: Byte;
      procedure sethidden(by: Byte);
      function getwar: Byte;
      procedure setwar(by: Byte);
      function getfacing: Byte;
      procedure setfacing(by: Byte);
      function getcriminal: Byte;
      procedure setcriminal(by: Byte);
      function getx: Word;
      procedure setx(wo: Word);
      function gety: Word;
      procedure sety(wo: Word);
      function getgraphic: Word;
      procedure setgraphic(wo: Word);
      function getdragamt: Word;
      procedure setdragamt(wo: Word);
      function getz: ShortInt;
      procedure setz(shint: ShortInt);
      function getequitems: TArrayOfCardinal;
      procedure setequitems(cardarray: TArrayOfCardinal);
      function getopenconts: TPrimitiveObjectArray;
      procedure setopenconts(objarray: TPrimitiveObjectArray);
      function getcprops: tcproparray;
      procedure setcprops(cproparray: tcproparray);
      function geteioc: Boolean;
      procedure seteioc(bool: Boolean);
      function getcpoc: Boolean;
      procedure setcpoc(bool: Boolean);
      function getnouenpcsoc: Boolean;
      procedure setnouenpcsoc(bool: Boolean);
      function getnoueplayersoc: Boolean;
      procedure setnoueplayersoc(bool: Boolean);
      function getnouitemsoc: Boolean;
      procedure setnouitemsoc(bool: Boolean);
      function getococ: Boolean;
      procedure setococ(bool: Boolean);
      function getinreq: Boolean;
      procedure setinreq(bool: Boolean);
      function getinreqres: String;
      procedure setinreqres(str: String);
      function getnouenpcs: TPrimitiveObjectArray;
      procedure setnouenpcs(objarray: TPrimitiveObjectArray);
      function getnoueplayers: TPrimitiveObjectArray;
      procedure setnoueplayers(objarray: TPrimitiveObjectArray);
      function getnouitems: TPrimitiveObjectArray;
      procedure setnouitems(objarray: TPrimitiveObjectArray);
      function getinaccessible: Boolean;
      procedure setinaccessible(bool: Boolean);

    public
      property inaccessible: Boolean
        read getinaccessible
        write setinaccessible;

      property id: Cardinal
        read getid
        write setid;

      property dragitem: Cardinal
        read getdragitem
        write setdragitem;

      property exp: Cardinal
        read getexp
        write setexp;

      property name: String
        read getname
        write setname;

      property passw: String
        read getpassw
        write setpassw;

      property realname: String
        read getrealname
        write setrealname;

      property homepage: String
        read gethomepage
        write sethomepage;

      property emailaddr: String
        read getemailaddr
        write setemailaddr;

      property pcinfo: String
        read getpcinfo
        write setpcinfo;

      property online: Boolean
        read getonline
        write setonline;

      property dragging: Boolean
        read getdragging
        write setdragging;

      property client: TWSocketClient
        read getclient
        write setclient;

      property sex: Byte
        read getsex
        write setsex;

      property dead: Byte
        read getdead
        write setdead;

      property str: Byte
        read getstr
        write setstr;

      property dex: Byte
        read getdex
        write setdex;

      property int: Byte
        read getint
        write setint;

      property hits: Byte
        read gethits
        write sethits;

      property mana: Byte
        read getmana
        write setmana;

      property fat: Byte
        read getfat
        write setfat;

      property magicdef: Byte
        read getmagicdef
        write setmagicdef;

      property battledef: Byte
        read getbattledef
        write setbattledef;

      property stealing: Byte
        read getstealing
        write setstealing;

      property hiding: Byte
        read gethiding
        write sethiding;

      property firstaid: Byte
        read getfirstaid
        write setfirstaid;

      property detecttr: Byte
        read getdetecttr
        write setdetecttr;

      property peek: Byte
        read getpeek
        write setpeek;

      property magic: Byte
        read getmagic
        write setmagic;

      property melee: Byte
        read getmelee
        write setmelee;

      property rangedweap: Byte
        read getrangedweap
        write setrangedweap;

      property level: Byte
        read getlevel
        write setlevel;

      property privileged: Byte
        read getprivileged
        write setprivileged;

      property hidden: Byte
        read gethidden
        write sethidden;

      property war: Byte
        read getwar
        write setwar;

      property facing: Byte
        read getfacing
        write setfacing;

      property criminal: Byte
        read getcriminal
        write setcriminal;

      property x: Word
        read getx
        write setx;

      property y: Word
        read gety
        write sety;

      property graphic: Word
        read getgraphic
        write setgraphic;

      property dragamt: Word
        read getdragamt
        write setdragamt;

      property z: ShortInt
        read getz
        write setz;

      property equitems: TArrayOfCardinal
        read getequitems
        write setequitems;

      property openconts: TPrimitiveObjectArray
        read getopenconts
        write setopenconts;

      property cprops: tcproparray
        read getcprops
        write setcprops;

      property eioc: Boolean
        read geteioc
        write seteioc;

      property cpoc: Boolean
        read getcpoc
        write setcpoc;

      property nouenpcsoc: Boolean
        read getnouenpcsoc
        write setnouenpcsoc;

      property noueplayersoc: Boolean
        read getnoueplayersoc
        write setnoueplayersoc;

      property nouitemsoc: Boolean
        read getnouitemsoc
        write setnouitemsoc;

      property ococ: Boolean
        read getococ
        write setococ;

      property inreq: Boolean
        read getinreq
        write setinreq;

      property inreqres: String
        read getinreqres
        write setinreqres;

      property nouenpcs: TPrimitiveObjectArray
        read getnouenpcs
        write setnouenpcs;

      property noueplayers: TPrimitiveObjectArray
        read getnoueplayers
        write setnoueplayers;

      property nouitems: TPrimitiveObjectArray
        read getnouitems
        write setnouitems;

      constructor Create;
      destructor Destroy; override;
      procedure setequitemslen(len: Cardinal);
      procedure setcpropslen(len: Cardinal);
      procedure setnoueplayerslen(len: Cardinal);
      procedure setnouenpcslen(len: Cardinal);
      procedure setnouitemslen(len: Cardinal);
      procedure setopencontslen(len: Cardinal);

  end;
  TEvent = record
    evtype, intval: Integer;
    strval: String;
    cardval: Cardinal;

  end;
  teventarray = Array of TEvent;
  tnpc = class
    private
      lock: TCriticalSection;
      pid, pnpctype, pexp: Cardinal;
      pname: String;
      psex, pstr, pdex, pint, phits, pmana, pfat, pmagicdef, pbattledef, pstealing,
      phiding, pfirstaid, pdetecttr, ppeek, pmagic, pmelee, prangedweap, plevel,
      pprivileged, phidden, pwar, pfacing, pcriminal: Byte;
      px, py, pgraphic: Word;
      pz: ShortInt;
      pscriptname: String;
      pequitems: TArrayOfCardinal;
      pcprops: tcproparray;
      pevents: teventarray;
      peioc, pcpoc, peoc: Boolean;
      pinaccessible: Boolean;
      function getid: Cardinal;
      procedure setid(card: Cardinal);
      function getnpctype: Cardinal;
      procedure setnpctype(card: Cardinal);
      function getexp: Cardinal;
      procedure setexp(card: Cardinal);
      function getname: String;
      procedure setname(str: String);
      function getsex: Byte;
      procedure setsex(by: Byte);
      function getstr: Byte;
      procedure setstr(by: Byte);
      function getdex: Byte;
      procedure setdex(by: Byte);
      function getint: Byte;
      procedure setint(by: Byte);
      function gethits: Byte;
      procedure sethits(by: Byte);
      function getmana: Byte;
      procedure setmana(by: Byte);
      function getfat: Byte;
      procedure setfat(by: Byte);
      function getmagicdef: Byte;
      procedure setmagicdef(by: Byte);
      function getbattledef: Byte;
      procedure setbattledef(by: Byte);
      function getstealing: Byte;
      procedure setstealing(by: Byte);
      function gethiding: Byte;
      procedure sethiding(by: Byte);
      function getfirstaid: Byte;
      procedure setfirstaid(by: Byte);
      function getdetecttr: Byte;
      procedure setdetecttr(by: Byte);
      function getpeek: Byte;
      procedure setpeek(by: Byte);
      function getmagic: Byte;
      procedure setmagic(by: Byte);
      function getmelee: Byte;
      procedure setmelee(by: Byte);
      function getrangedweap: Byte;
      procedure setrangedweap(by: Byte);
      function getlevel: Byte;
      procedure setlevel(by: Byte);
      function getprivileged: Byte;
      procedure setprivileged(by: Byte);
      function gethidden: Byte;
      procedure sethidden(by: Byte);
      function getwar: Byte;
      procedure setwar(by: Byte);
      function getfacing: Byte;
      procedure setfacing(by: Byte);
      function getcriminal: Byte;
      procedure setcriminal(by: Byte);
      function getx: Word;
      procedure setx(wo: Word);
      function gety: Word;
      procedure sety(wo: Word);
      function getgraphic: Word;
      procedure setgraphic(wo: Word);
      function getz: ShortInt;
      procedure setz(shint: ShortInt);
      function getscriptname: String;
      procedure setscriptname(str: String);
      function getequitems: TArrayOfCardinal;
      procedure setequitems(cardarray: TArrayOfCardinal);
      function getcprops: tcproparray;
      procedure setcprops(cproparray: tcproparray);
      function getevents: teventarray;
      procedure setevents(eventarray: teventarray);
      function geteioc: Boolean;
      procedure seteioc(bool: Boolean);
      function getcpoc: Boolean;
      procedure setcpoc(bool: Boolean);
      function geteoc: Boolean;
      procedure seteoc(bool: Boolean);
      function getinaccessible: Boolean;
      procedure setinaccessible(bool: Boolean);


    public
      property inaccessible: Boolean
        read getinaccessible
        write setinaccessible;
        
      property id: Cardinal
        read getid
        write setid;

      property npctype: Cardinal
        read getnpctype
        write setnpctype;

      property exp: Cardinal
        read getexp
        write setexp;

      property name: String
        read getname
        write setname;

      property sex: Byte
        read getsex
        write setsex;

      property str: Byte
        read getstr
        write setstr;

      property dex: Byte
        read getdex
        write setdex;

      property int: Byte
        read getint
        write setint;

      property hits: Byte
        read gethits
        write sethits;

      property mana: Byte
        read getmana
        write setmana;

      property fat: Byte
        read getfat
        write setfat;

      property magicdef: Byte
        read getmagicdef
        write setmagicdef;

      property battledef: Byte
        read getbattledef
        write setbattledef;

      property stealing: Byte
        read getstealing
        write setstealing;

      property hiding: Byte
        read gethiding
        write sethiding;

      property firstaid: Byte
        read getfirstaid
        write setfirstaid;

      property detecttr: Byte
        read getdetecttr
        write setdetecttr;

      property peek: Byte
        read getpeek
        write setpeek;

      property magic: Byte
        read getmagic
        write setmagic;

      property melee: Byte
        read getmelee
        write setmelee;

      property rangedweap: Byte
        read getrangedweap
        write setrangedweap;

      property level: Byte
        read getlevel
        write setlevel;

      property privileged: Byte
        read getprivileged
        write setprivileged;

      property hidden: Byte
        read gethidden
        write sethidden;

      property war: Byte
        read getwar
        write setwar;

      property facing: Byte
        read getfacing
        write setfacing;

      property criminal: Byte
        read getcriminal
        write setcriminal;

      property x: Word
        read getx
        write setx;

      property y: Word
        read gety
        write sety;

      property graphic: Word
        read getgraphic
        write setgraphic;

      property z: ShortInt
        read getz
        write setz;

      property scriptname: String
        read getscriptname
        write setscriptname;

      property equitems: TArrayOfCardinal
        read getequitems
        write setequitems;

      property cprops: tcproparray
        read getcprops
        write setcprops;

       property events: teventarray
        read getevents
        write setevents;

      property eioc: Boolean
        read geteioc
        write seteioc;

      property cpoc: Boolean
        read getcpoc
        write setcpoc;

      property eoc: Boolean
        read geteoc
        write seteoc;

      constructor Create;
      destructor Destroy; override;
      procedure setequitemslen(len: Cardinal);
      procedure setcpropslen(len: Cardinal);
      procedure seteventslen(len: Cardinal);

  end;
  titem = class
    private
      lock: TCriticalSection;
      pid, pitemtype, pcontained, pequipped, pdragger: Cardinal;
      px, py, pweight, pgraphic, pcolor, pgump, pdefinsposx, pdefinsposy, pamount: Word;
      pz: ShortInt;
      pscriptname: String;
      pcontainer, pweapon, pweapspeed, pweapdamage, parmor, parmorstr,
      pinvisible, pstackable, pwalkable, pmoveable, plighting: Byte;
      pcontitems: TArrayOfCardinal;
      pcprops: tcproparray;
      poccupied, pcioc, pcpoc: Boolean;
      pinaccessible: Boolean;
      function getid: Cardinal;
      procedure setid(card: Cardinal);
      function getitemtype: Cardinal;
      procedure setitemtype(card: Cardinal);
      function getcontained: Cardinal;
      procedure setcontained(card: Cardinal);
      function getequipped: Cardinal;
      procedure setequipped(card: Cardinal);
      function getdragger: Cardinal;
      procedure setdragger(card: Cardinal);
      function getx: Word;
      procedure setx(wo: Word);
      function gety: Word;
      procedure sety(wo: Word);
      function getweight: Word;
      procedure setweight(wo: Word);
      function getgraphic: Word;
      procedure setgraphic(wo: Word);
      function getcolor: Word;
      procedure setcolor(wo: Word);
      function getgump: Word;
      procedure setgump(wo: Word);
      function getdefinsposx: Word;
      procedure setdefinsposx(wo: Word);
      function getdefinsposy: Word;
      procedure setdefinsposy(wo: Word);
      function getamount: Word;
      procedure setamount(wo: Word);
      function getz: ShortInt;
      procedure setz(shint: ShortInt);
      function getscriptname: String;
      procedure setscriptname(str: String);
      function getcontainer: Byte;
      procedure setcontainer(by: Byte);
      function getweapon: Byte;
      procedure setweapon(by: Byte);
      function getweapspeed: Byte;
      procedure setweapspeed(by: Byte);
      function getweapdamage: Byte;
      procedure setweapdamage(by: Byte);
      function getarmor: Byte;
      procedure setarmor(by: Byte);
      function getarmorstr: Byte;
      procedure setarmorstr(by: Byte);
      function getinvisible: Byte;
      procedure setinvisible(by: Byte);
      function getstackable: Byte;
      procedure setstackable(by: Byte);
      function getwalkable: Byte;
      procedure setwalkable(by: Byte);
      function getmoveable: Byte;
      procedure setmoveable(by: Byte);
      function getlighting: Byte;
      procedure setlighting(by: Byte);
      function getcontitems: TArrayOfCardinal;
      procedure setcontitems(cardarray: TArrayOfCardinal);
      function getcprops: tcproparray;
      procedure setcprops(cproparray: tcproparray);
      function getoccupied: Boolean;
      procedure setoccupied(bool: Boolean);
      function getcioc: Boolean;
      procedure setcioc(bool: Boolean);
      function getcpoc: Boolean;
      procedure setcpoc(bool: Boolean);
      function getinaccessible: Boolean;
      procedure setinaccessible(bool: Boolean);


    public
      property inaccessible: Boolean
        read getinaccessible
        write setinaccessible;

      property id: Cardinal
        read getid
        write setid;

      property itemtype: Cardinal
        read getitemtype
        write setitemtype;

      property contained: Cardinal
        read getcontained
        write setcontained;

      property equipped: Cardinal
        read getequipped
        write setequipped;

      property dragger: Cardinal
        read getdragger
        write setdragger;

      property x: Word
        read getx
        write setx;

      property y: Word
        read gety
        write sety;

      property weight: Word
        read getweight
        write setweight;

      property graphic: Word
        read getgraphic
        write setgraphic;

      property color: Word
        read getcolor
        write setcolor;

      property gump: Word
        read getgump
        write setgump;

      property definsposx: Word
        read getdefinsposx
        write setdefinsposx;

      property definsposy: Word
        read getdefinsposy
        write setdefinsposy;

      property amount: Word
        read getamount
        write setamount;

      property z: ShortInt
        read getz
        write setz;

      property scriptname: String
        read getscriptname
        write setscriptname;

      property container: Byte
        read getcontainer
        write setcontainer;

      property weapon: Byte
        read getweapon
        write setweapon;

      property weapspeed: Byte
        read getweapspeed
        write setweapspeed;

      property weapdamage: Byte
        read getweapdamage
        write setweapdamage;

      property armor: Byte
        read getarmor
        write setarmor;

      property armorstr: Byte
        read getarmorstr
        write setarmorstr;

      property invisible: Byte
        read getinvisible
        write setinvisible;

      property stackable: Byte
        read getstackable
        write setstackable;

      property walkable: Byte
        read getwalkable
        write setwalkable;

      property moveable: Byte
        read getmoveable
        write setmoveable;

      property lighting: Byte
        read getlighting
        write setlighting;

      property contitems: TArrayOfCardinal
        read getcontitems
        write setcontitems;

      property cprops: tcproparray
        read getcprops
        write setcprops;

      property occupied: Boolean
        read getoccupied
        write setoccupied;

      property cioc: Boolean
        read getcioc
        write setcioc;

      property cpoc: Boolean
        read getcpoc
        write setcpoc;

      constructor Create;
      destructor Destroy; override;
      procedure setcontitemslen(len: Cardinal);
      procedure setcpropslen(len: Cardinal);
      function clone: titem;

  end;
  tnpctype = record
    id, exp: Cardinal;
    name: String;
    sex, str, dex, int, hits, mana, fat, magicdef, battledef, stealing,
    hiding, firstaid, detecttr, peek, magic, melee, rangedweap, level,
    privileged, hidden, war, criminal, facing: Byte;
    graphic: Word;
    scriptname: String;
    equitemtypes: TArrayOfCardinal;
    cprops: tcproparray;

  end;
  titemtype = record
    id: Cardinal;
    weight, graphic, color, gump, definsposx, definsposy, amount: Word;
    scriptname: String;
    container, weapon, weapspeed, weapdamage, armor, armorstr,
    invisible, stackable, walkable, moveable, lighting: Byte;
    contitemtypes: TArrayOfCardinal;
    cprops: tcproparray;

  end;
  tscript = record
    name, compstr: String;

  end;
  tscriptthread = class(TThread)
  private
    compstr, scriptname, param1, param2, param3, param4, param5: String;
    sthreadindex: Integer;

  public
    constructor Create(ccompstr, cscriptname, cparam1, cparam2, cparam3, cparam4,
                       cparam5: String);

  protected
    procedure Execute; override;

  end;
  tbgthread = class(TThread)
  public
    printsmstrs, printatlsmstrs: TStrings;
    filelock, psmstrslock, patlsmstrslock: TCriticalSection;

  protected
    procedure printsm;
    procedure printatlsm;
    function isprinting: Boolean;
    procedure showscripted;
    procedure Execute; override;

  end;
  tbbpost = record
    subj, text: String;

  end;
  TObjectReference = record
    pobjref: Cardinal;
    objtype: Integer;

  end;
  TObjectArray = Array of TObjectReference;
  TArrayOfByte = Array of Byte;
  TArrayOfWord = Array of Word;
  TArrayOfInteger = Array of Integer;
  TArrayOfExtended = Array of Extended;
  TArrayOfString = Array of String;
  tdatah = class
    private
      function getplayerslen: Cardinal;
      function getplayer(i: Cardinal): tplayer;
      procedure setplayer(i: Cardinal; player: tplayer);
      function getnpcslen: Cardinal;
      function getnpc(i: Cardinal): tnpc;
      procedure setnpc(i: Cardinal; npc: tnpc);
      function getitemslen: Cardinal;
      function getitem(i: Cardinal): titem;
      procedure setitem(i: Cardinal; item: titem);

    public
      property players[i: Cardinal]: tplayer
        read getplayer
        write setplayer;

      property npcs[i: Cardinal]: tnpc
        read getnpc
        write setnpc;

      property items[i: Cardinal]: titem
        read getitem
        write setitem;

  end;
  type thttpconn = class(THttpConnection)
    public
      lock: TCriticalSection;
      str: String;

  end;

const
  MAPWIDTH = 1024;
  MAPHEIGHT = 1024;
  NUMCELLS = (MAPWIDTH div 8) * (MAPHEIGHT div 8);
  NUMLANDGROUPS = 512;
  NUMLANDTILES = NUMLANDGROUPS * 32;
  NOSTATICS = $FFFFFFFF;
  UPPERZ = 10;
  MAXHEIGHT = 5;
  FLAGIMPASSIBLE = $00000040;
  FLAGWEARABLE = $00400000;
  OTNONE = 0;
  OTALL = 1;
  OTPLAYER = 2;
  OTNPC = 3;
  OTITEM = 4;
  DFNORTH = 0;
  DFNORTHEAST = 1;
  DFEAST = 2;
  DFSOUTHEAST = 3;
  DFSOUTH = 4;
  DFSOUTHWEST = 5;
  DFWEST = 6;
  DFNORTHWEST = 7;
  DFNONE = 8;
  DFALL = 9;
  ETNONE = 0;
  ETDOUBLECLICKED = 1;
  ETITEMGIVEN = 2;
  ETATTACKED = 3;
  ETTALKED = 4;
  ETMOVED = 5;
  ETEQUIPPED = 6;
  ETUNEQUIPPED = 7;
  ETITEMINSERTED = 8;
  ETITEMREMOVED = 9;
  ETSTACKED = 10;
  ETUNSTACKED = 11;
  SMALE = 0;
  SFEMALE = 1;
  ETINSERTED = 12;
  ETREMOVED = 13;
  ETWALKEDON = 14;
  AATTACK = 0;
  ADEFEND = 1;
  SIDLIGHTSOURCE = 0;
  SIDDARKSOURCE = 1;
  SIDGREATLIGHT = 2;
  SIDLIGHT = 3;
  SIDHEALING = 4;
  SIDFIREBALL = 5;
  SIDCREATEFOOD = 6;
  ITIDCORPSE = 12;
  ITIDSPELLBOOK = 13;
  TTSYSTEMMESSAGE = 0;
  TTSPEECHPRIVATE = 1;
  TTSPEECH = 2;
  TTTEXTABOVEPRIVATE = 3;
  TTTEXTABOVE = 4;
  LWEAPON = 1;
  LSHIELD = 2;
  LPANTS = 4;
  LSHIRT = 5;
  LBACKPACK = 9;
  LHAIR = 11;
  SKIDMAGICDEFENSE = 0;
  SKIDBATTLEDEFENSE = 1;
  SKIDSTEALING = 2;
  SKIDHIDING = 3;
  SKIDFIRSTAID = 4;
  SKIDDETECTTRAP = 5;
  SKIDPEEK = 6;
  SKIDMAGIC = 7;
  SKIDMELEE = 8;
  SKIDRANGEDWEAPONS = 9;
  STMISC = 0;
  STNPC = 1;
  STITEM = 2;
  STCMD = 3;
  STSKILL = 4;
  DEFINSPOS = 65535;
  ITIDSOLIGHTSOURCE = 14;
  ITIDSODARKSOURCE = 15;
  ITIDSOGREATLIGHT = 16;
  ITIDSOLIGHT = 17;
  ITIDSOHEALING = 18;
  ITIDSOFIREBALL = 19;
  ITIDSOCREATEFOOD = 20;

var
  Form1: TForm1;
  serveractivelock, startinglock, savinglock, shuttingdownlock, kickingoplock,
  listingoplock, sdscriptdonelock: TCriticalSection;
  serveractive, starting, saving, shuttingdown, kickingop, listingop,
  sdscriptdone: Boolean;
  cells: Array of tcell;
  statics: Array of tstatic;
  staticcount: Cardinal;
  staidxs: Array of tstaidx;
  staidxcount: Cardinal;
  landtiles: Array of tlandgroup;
  statictiles: Array of tstaticgroup;
  statictilecount: Cardinal;
  highestid: Cardinal;
  players: Array of tplayer;
  npcs: Array of tnpc;
  items: Array of titem;
  gprops: Array of tcprop;
  npctypes: Array of tnpctype;
  itemtypes: Array of titemtype;
  npcscripts: Array of tscript;
  itemscripts: Array of tscript;
  miscscripts: Array of tscript;
  skillscripts: Array of tscript;
  httpscripts: Array of tscript;
  cmdscripts: Array of tscript;
  playerslock: TCriticalSection;
  npcslock: TCriticalSection;
  itemslock: TCriticalSection;
  hidlock: TCriticalSection;
  gpropslock: TCriticalSection;
  playerhash: TIntegerHash;
  phashlock: TCriticalSection;
  npchash: TIntegerHash;
  nhashlock: TCriticalSection;
  itemhash: TIntegerHash;
  ihashlock: TCriticalSection;
  objtypehash: TIntegerHash;
  othashlock: TCriticalSection;
  playersat2dpos: Array[0..MAPWIDTH - 1, 0..MAPHEIGHT - 1] of TPrimitiveObjectArray;
  playersat2dposlock: TCriticalSection;
  npcsat2dpos: Array[0..MAPWIDTH - 1, 0..MAPHEIGHT - 1] of TPrimitiveObjectArray;
  npcsat2dposlock: TCriticalSection;
  itemsat2dpos: Array[0..MAPWIDTH - 1, 0..MAPHEIGHT - 1] of TPrimitiveObjectArray;
  itemsat2dposlock: TCriticalSection;
  bbposts: Array of tbbpost;
  bbpostslock: TCriticalSection;
  sthreads: Array of Integer;
  sthreadslock: TCriticalSection;
  showsed: Boolean;
  sseerscriptfn: String;
  sseerscripterpos: Cardinal;
  datah: tdatah;
  bgthread: tbgthread;
  httpconns: Array of thttpconn;
  httpconnslock: TCriticalSection;
  httpservlog: Boolean;

function loadmulfiles: Boolean;
procedure startserver;
function gettile(x, y: Word): ttile;
function getworldheight(x, y: Word): ShortInt;
function getcellnum(x, y: Word): Word;
function getstatic(index: DWord): tstatic;
function getlandtile(tileid: Word): tlandtile;
function getstatictile(tileid: Word): tstatictile;
function getlandtilename(tileid: Word): String;
function getstatictilename(tileid: Word): String;
function getstandingheight(x, y: Word; startz: ShortInt): ShortInt;
function loaddata: Boolean;
function loadtypes: Boolean;
function loadandcompscripts: Boolean;
function startnpcscripts: Boolean;
procedure shutdownserver;
function savedata: Boolean;
procedure startmiscscript(scriptname: String; param1: String = ''; param2: String = '';
                          param3: String = ''; param4: String = ''; param5: String = '');
procedure startnpcscript(scriptname: String; param1: String = ''; param2: String = '';
                         param3: String = ''; param4: String = ''; param5: String = '');
procedure startitemscript(scriptname: String; param1: String = ''; param2: String = '';
                          param3: String = ''; param4: String = ''; param5: String = '');
procedure starthttpscript(scriptname: String; param1: String = ''; param2: String = '';
                          param3: String = ''; param4: String = ''; param5: String = '');
procedure startcmdscript(scriptname: String; param1: String = ''; param2: String = '';
                         param3: String = ''; param4: String = ''; param5: String = '');
procedure startskillscript(scriptname: String; param1: String = ''; param2: String = '';
                           param3: String = ''; param4: String = ''; param5: String = '');
function padstr(str: String; len: Integer): String;
function unpadstr(str: String): String;
function swapword(w: Word): Word; register;
function swapdword(dw: DWord): DWord; register;
procedure initplayer(player: Cardinal);
procedure updateplayer(player: Cardinal);
procedure delobj(objtype: Integer; player, obj: Cardinal);
procedure updateobj(objtype: Integer; player, obj: Cardinal);
procedure playerwalk(player: Cardinal; dir: Integer; seq: Byte);
procedure dclick(player, objid: Cardinal);
procedure printtxtabv(txt: String; R, G, B: Byte; objtype: Integer; player,
                      obj: Cardinal);
procedure sendsysmsg(msg: String; R, G, B: Byte; player: Cardinal);
procedure drag(player, itemid: Cardinal; amt: Word);
procedure drop(player, itemid: Cardinal; x, y, z: Word);
procedure sclick(player, objid: Cardinal);
procedure showpd(player, obj: Cardinal; objtype: Integer);
procedure sendspeech(speechstr: String; R, G, B: Byte; objtype: Integer;
                     player, obj: Cardinal);
procedure showstatus(player, objid: Cardinal);
procedure showskills(player, objid: Cardinal);
procedure equitem(player, objid, item: Cardinal);
procedure updateequ(objtype: Integer; player, obj: Cardinal);
procedure updatecontitems(player, container: Cardinal);
procedure insitem(player, itemid: Cardinal);
procedure stack(player, item1, item2: Cardinal);
function getplayersat2dpos(x, y: Word): TPrimitiveObjectArray;
procedure addplayerto2dpos(player: Cardinal; x, y: Word);
procedure remplayerfrom2dpos(player: Cardinal; x, y: Word);
function getnpcsat2dpos(x, y: Word): TPrimitiveObjectArray;
procedure addnpcto2dpos(npc: Cardinal; x, y: Word);
procedure remnpcfrom2dpos(npc: Cardinal; x, y: Word);
function getitemsat2dpos(x, y: Word): TPrimitiveObjectArray;
procedure additemto2dpos(item: Cardinal; x, y: Word);
procedure remitemfrom2dpos(item: Cardinal; x, y: Word);
procedure denydropping(player, item: Cardinal);
procedure denydragging(player: Cardinal);
procedure denywalking(player: Cardinal; denseq: Byte; oldx, oldy: Word; oldz: ShortInt);
procedure addbbpost(subj, text: String);
procedure sendbbpostlistsubj(player, bbpost: Cardinal);
procedure sendbbpost(player, bbpost: Cardinal);
procedure updateobjao(objtype: Integer; obj: Cardinal; updself: Boolean = True);
procedure updatestatusao(objtype: Integer; obj: Cardinal);
procedure delobjao(objtype: Integer; obj: Cardinal);
function gettype(objtype: Integer; typeid: Cardinal): Cardinal;
procedure addnouenpc(nouenpc, player: Cardinal);
procedure remnouenpc(nouenpc, player: Cardinal);
function isnouenpc(npciq, player: Cardinal): Boolean;
procedure addnoueplayer(noueplayer, player: Cardinal);
procedure remnoueplayer(noueplayer, player: Cardinal);
function isnoueplayer(playeriq, player: Cardinal): Boolean;
procedure addnouitem(nouitem, player: Cardinal);
procedure remnouitem(nouitem, player: Cardinal);
function isnouitem(itemiq, player: Cardinal): Boolean;
procedure finishlogout(player: Cardinal);
procedure printsm(ms: Cardinal; smstr: String);
procedure printatlsm(ms: Cardinal; atlsmstr: String);
procedure kickop;
procedure listop;
function addsthread(handle: Integer): Integer;
procedure remsthread(index: Integer);
procedure terminatesthreads;
function addglobalstr(globalstr: String; var sstr: String): Cardinal;
function getrealmsgpos(msgpos, globalstrinspos: Cardinal; globalstr: String): Integer;
procedure showscripted(erscriptfn: String; erscripterpos: Cardinal);
procedure equchanged(objid, player: Cardinal);
function isstarting: Boolean;
function issaving: Boolean;
function isshuttingdown: Boolean;
function iskickingop: Boolean;
function islistingop: Boolean;
function issdscriptdone: Boolean;
procedure freelockdelayed(lock: TCriticalSection);
procedure writehtmlerr(HTTPConnection: Cardinal; HTML: String);
function queryparamerr(HTTPConnection: Cardinal; Name: String): String;
function queryiperr(HTTPConnection: Cardinal): String;
function scriptonuses(sender: TIFPSPascalCompiler; const name: string): Boolean;
function PrimitiveGetObject(ObjectType: Integer; ID: Cardinal): Cardinal;
function PrimitiveListObjects(ObjectType: Integer): TPrimitiveObjectArray;
function PrimitiveListObjectsNearLocation(ObjectType: Integer; X, Y: Word; Distance: Cardinal): TPrimitiveObjectArray;
function PrimitiveListObjectsNearLocationAccurate(ObjectType: Integer; X, Y: Word; Z: ShortInt;
                                                  Distance: Cardinal): TPrimitiveObjectArray;
function PrimitiveGetObjectX(ObjectType: Integer; ObjectReference: Cardinal): Word;
function PrimitiveGetObjectY(ObjectType: Integer; ObjectReference: Cardinal): Word;
function PrimitiveGetObjectZ(ObjectType: Integer; ObjectReference: Cardinal): ShortInt;
function PrimitiveGetEvent(NPC: Cardinal): TEvent;
procedure PrimitiveSetEvent(NPC: Cardinal; EventType: Integer; IntegerValue: Integer;
                            StringValue: String; CardinalValue: Cardinal);
procedure PrimitiveEquipItem(ObjectType: Integer; ObjectReference, Item: Cardinal);
procedure PrimitiveUnequipItem(ObjectType: Integer; ObjectReference, Item: Cardinal;
                               X, Y: Word; Z: ShortInt);
function PrimitiveCreateObject(ObjectType: Integer; TypeID: Cardinal; X, Y: Word;
                               Z: ShortInt): Cardinal;
procedure PrimitiveDeleteObject(ObjectType: Integer; ObjectReference: Cardinal);
procedure PrimitiveInsertItem(Item, Container: Cardinal; X, Y, Amount: Word);
procedure PrimitiveOpenContainer(Player, Container: Cardinal);
procedure PrimitiveRemoveItem(Item, Container: Cardinal; X, Y: Word; Z: ShortInt;
                              Amount: Word);
function PrimitiveGetMainContainer(Item: Cardinal): Cardinal;
procedure PrimitiveSetAmount(Item: Cardinal; Amount: Word);
function PrimitiveGetSex(ObjectType: Integer; ObjectReference: Cardinal): Integer;
procedure PrimitiveSetColor(Item: Cardinal; Color: Word);
procedure PrimitivePlayAnimationPrivate(Player: Cardinal; ObjectType: Integer;
                                       ObjectReference: Cardinal; Animation: Integer);
procedure PrimitivePlayAnimation(ObjectType: Integer; ObjectReference: Cardinal;
                                 Animation: Integer);
function PrimitiveCheckObjectDistance(ObjectType1: Integer; ObjectReference1: Cardinal;
                                      ObjectType2: Integer; ObjectReference2: Cardinal): Cardinal;
function PrimitiveCheckObjectToCoordinatesDistance(ObjectType: Integer; ObjectReference: Cardinal;
                                                   X, Y: Word; Z: ShortInt): Cardinal;
function PrimitiveGetObjectXMain(ObjectType: Integer; ObjectReference: Cardinal): Word;
function PrimitiveGetObjectYMain(ObjectType: Integer; ObjectReference: Cardinal): Word;
function PrimitiveGetObjectZMain(ObjectType: Integer; ObjectReference: Cardinal): ShortInt;
procedure PrimitivePlaySoundEffectPrivate(Player: Cardinal; SoundEffect: Word);
procedure PrimitiveSetLightLevelPrivate(Player: Cardinal; LightLevel: Byte);
function PrimitiveGetAmount(Item: Cardinal): Word;
function PrimitiveGetItemType(Item: Cardinal): Cardinal;
function PrimitiveListItemsInContainer(Container: Cardinal): TPrimitiveObjectArray;
procedure PrimitiveSendText(TextType, ObjectType: Integer; ObjectReference,
                            Player: Cardinal; Text: String; R, G, B: Byte);
function PrimitiveListEquippedItems(ObjectType: Integer; ObjectReference: Cardinal): TPrimitiveObjectArray;
procedure PrimitiveSetSex(ObjectType: Integer; ObjectReference: Cardinal; Sex: Integer);
function PrimitiveGetGraphic(ObjectType: Integer; ObjectReference: Cardinal): Word;
procedure PrimitiveSetGraphic(ObjectType: Integer; ObjectReference: Cardinal; Graphic: Word);
function PrimitiveGetName(ObjectType: Integer; ObjectReference: Cardinal): String;
procedure PrimitiveSetName(ObjectType: Integer; ObjectReference: Cardinal; Name: String);
function PrimitiveGetFacing(ObjectType: Integer; ObjectReference: Cardinal): Byte;
procedure PrimitiveSetFacing(ObjectType: Integer; ObjectReference: Cardinal; Facing: Byte);
function PrimitiveGetStrength(ObjectType: Integer; ObjectReference: Cardinal): Byte;
procedure PrimitiveSetStrength(ObjectType: Integer; ObjectReference: Cardinal; Strength: Byte);
function PrimitiveGetDexterity(ObjectType: Integer; ObjectReference: Cardinal): Byte;
procedure PrimitiveSetDexterity(ObjectType: Integer; ObjectReference: Cardinal; Dexterity: Byte);
function PrimitiveGetIntelligence(ObjectType: Integer; ObjectReference: Cardinal): Byte;
procedure PrimitiveSetIntelligence(ObjectType: Integer; ObjectReference: Cardinal; Intelligence: Byte);
procedure PrimitiveSetCProp(ObjectType: Integer; ObjectReference: Cardinal; Name, StringValue: String;
                            CardinalValue: Cardinal; IntegerValue: Integer);
function PrimitiveGetCPropStringValue(ObjectType: Integer; ObjectReference: Cardinal;
                                      Name: String): String;
function PrimitiveGetCPropCardinalValue(ObjectType: Integer; ObjectReference: Cardinal;
                                        Name: String): Cardinal;
function PrimitiveGetCPropIntegerValue(ObjectType: Integer; ObjectReference: Cardinal;
                                       Name: String): Integer;
function PrimitiveCPropExists(ObjectType: Integer; ObjectReference: Cardinal;
                              Name: String): Boolean;
procedure PrimitiveEraseCProp(ObjectType: Integer; ObjectReference: Cardinal;
                              Name: String);
function PrimitiveRequestInput(Player: Cardinal): String;
procedure PrimitiveSetExperience(ObjectType: Integer; ObjectReference: Cardinal; Experience: Cardinal);
procedure PrimitiveSetLevel(ObjectType: Integer; ObjectReference: Cardinal; Level: Byte);
procedure PrimitiveSetSkill(ObjectType: Integer; ObjectReference: Cardinal; Skill: Integer;
                            SkillValue: Byte);
procedure PrimitiveSetHits(ObjectType: Integer; ObjectReference: Cardinal; Hits: Byte);
procedure PrimitiveSetMana(ObjectType: Integer; ObjectReference: Cardinal; Mana: Byte);
procedure PrimitiveSetFatigue(ObjectType: Integer; ObjectReference: Cardinal; Fatigue: Byte);
procedure PrimitiveSetWeight(Item: Cardinal; Weight: Word);
procedure PrimitiveMoveObject(ObjectType: Integer; ObjectReference: Cardinal; X, Y: Word; Z: ShortInt);
procedure PrimitiveSetWeaponSpeed(Weapon: Cardinal; WeaponSpeed: Integer);
procedure PrimitiveSetWeaponDamage(Weapon: Cardinal; WeaponDamage: Integer);
procedure PrimitiveSetArmorStrength(Armor: Cardinal; ArmorStrength: Integer);
procedure PrimitiveSetMoveable(Item: Cardinal);
procedure PrimitiveSetUnmoveable(Item: Cardinal);
procedure PrimitiveSetVisible(Item: Cardinal);
procedure PrimitiveSetInvisible(Item: Cardinal);
procedure PrimitiveSetPrivileged(ObjectType: Integer; ObjectReference: Cardinal);
procedure PrimitiveSetUnprivileged(ObjectType: Integer; ObjectReference: Cardinal);
procedure PrimitiveSetUnhidden(ObjectType: Integer; ObjectReference: Cardinal);
procedure PrimitiveSetHidden(ObjectType: Integer; ObjectReference: Cardinal);
procedure PrimitiveSetItemLighting(Item: Cardinal; Lighting: Byte);
procedure PrimitiveKick(Player: Cardinal);
procedure PrimitiveSetPlayerRealName(Player: Cardinal; RealName: String);
procedure PrimitiveSetPlayerHomepage(Player: Cardinal; Homepage: String);
procedure PrimitiveSetPlayerEMailAddress(Player: Cardinal; EMailAddress: String);
procedure PrimitiveSetPlayerPCInfo(Player: Cardinal; PCInfo: String);
procedure PrimitiveWalk(NPC: Cardinal; Direction: Byte);
procedure PrimitiveAttack(NPC: Cardinal; ObjectType: Integer; ObjectReference: Cardinal);
procedure PrimitiveSetDead(Player: Cardinal);
procedure PrimitiveSetAlive(Player: Cardinal);
function PrimitiveGetNPCType(NPC: Cardinal): Cardinal;
function PrimitiveGetExperience(ObjectType: Integer; ObjectReference: Cardinal): Cardinal;
function PrimitiveGetLevel(ObjectType: Integer; ObjectReference: Cardinal): Cardinal;
function PrimitiveGetSkill(ObjectType: Integer; ObjectReference: Cardinal; Skill: Integer): Byte;
function PrimitiveIsOnline(Player: Cardinal): Boolean;
function PrimitiveIsAlive(Player: Cardinal): Boolean;
function PrimitiveGetHits(ObjectType: Integer; ObjectReference: Cardinal): Byte;
function PrimitiveGetMana(ObjectType: Integer; ObjectReference: Cardinal): Byte;
function PrimitiveGetFatigue(ObjectType: Integer; ObjectReference: Cardinal): Byte;
function PrimitiveIsCriminal(ObjectType: Integer; ObjectReference: Cardinal): Boolean;
function PrimitiveIsAtWar(Player: Cardinal): Boolean;
function PrimitiveIsContainedIn(Item: Cardinal): Cardinal;
function PrimitiveIsEquippedBy(Item: Cardinal): Cardinal;
function PrimitiveGetWeight(Item: Cardinal): Word;
function PrimitiveIsWeapon(Item: Cardinal): Boolean;
function PrimitiveIsArmor(Item: Cardinal): Boolean;
function PrimitiveGetWeaponSpeed(Weapon: Cardinal): Byte;
function PrimitiveGetWeaponDamage(Weapon: Cardinal): Byte;
function PrimitiveGetArmorStrength(Armor: Cardinal): Byte;
function PrimitiveIsMoveable(Item: Cardinal): Boolean;
function PrimitiveIsVisible(Item: Cardinal): Boolean;
function PrimitiveIsPrivileged(ObjectType: Integer; ObjectReference: Cardinal): Boolean;
function PrimitiveIsUnhidden(ObjectType: Integer; ObjectReference: Cardinal): Boolean;
function PrimitiveIsStackable(Item: Cardinal): Boolean;
function PrimitiveGetItemLighting(Item: Cardinal): Byte;
function PrimitiveGetPlayerRealName(Player: Cardinal): String;
function PrimitiveGetPlayerHomepage(Player: Cardinal): String;
function PrimitiveGetPlayerEMailAddress(Player: Cardinal): String;
function PrimitiveGetPlayerPCInfo(Player: Cardinal): String;
function PrimitiveGetScriptName(ObjectType: Integer; ObjectReference: Cardinal): String;
function PrimitiveIsWalkable(Item: Cardinal): Byte;
procedure PrimitiveSetWalkable(Item: Cardinal; Direction: Byte);
procedure PrimitiveOpenOrCloseDoor(Door: Cardinal; Graphic: Word; XRelative, YRelative: ShortInt);
function PrimitiveGetObjectID(ObjectType: Integer; ObjectReference: Cardinal): Cardinal;
function PrimitiveListOnlinePlayers: TPrimitiveObjectArray;
function PrimitiveGetColor(Item: Cardinal): Word;
function IsEquippedByObjectType(Item: Cardinal): Integer;
function PrimitiveGetEquipmentByLayer(ObjectType: Integer; ObjectReference: Cardinal; Layer: Byte): Cardinal;
function GetObject(ObjectType: Integer; ID: Cardinal): TObjectReference;
function ListObjects(ObjectType: Integer): TObjectArray;
function ListObjectsNearLocation(ObjectType: Integer; X, Y: Word; Distance: Cardinal): TObjectArray;
function ListObjectsNearLocationAccurate(ObjectType: Integer; X, Y: Word; Z: ShortInt;
                                         Distance: Cardinal): TObjectArray;
function GetObjectX(ObjectReference: TObjectReference): Word;
function GetObjectY(ObjectReference: TObjectReference): Word;
function GetObjectZ(ObjectReference: TObjectReference): ShortInt;
function GetEvent(NPC: TObjectReference): TEvent;
procedure SetEvent(NPC: TObjectReference; EventType: Integer; IntegerValue: Integer;
                   StringValue: String; CardinalValue: Cardinal);
procedure EquipItem(ObjectReference, Item: TObjectReference);
procedure UnequipItem(ObjectReference, Item: TObjectReference;
                      X, Y: Word; Z: ShortInt);
function CreateObject(ObjectType: Integer; TypeID: Cardinal; X, Y: Word;
                      Z: ShortInt): TObjectReference;
procedure DeleteObject(ObjectReference: TObjectReference);
procedure InsertItem(Item, Container: TObjectReference; X, Y, Amount: Word);
procedure OpenContainer(Player, Container: TObjectReference);
procedure RemoveItem(Item, Container: TObjectReference; X, Y: Word; Z: ShortInt;
                     Amount: Word);
function GetMainContainer(Item: TObjectReference): TObjectReference;
procedure SetAmount(Item: TObjectReference; Amount: Word);
function GetSex(ObjectReference: TObjectReference): Integer;
procedure SetColor(Item: TObjectReference; Color: Word);
procedure PlayAnimationPrivate(Player: TObjectReference;
                               ObjectReference: TObjectReference; Animation: Integer);
procedure PlayAnimation(ObjectReference: TObjectReference;
                        Animation: Integer);
function CheckObjectDistance(ObjectReference1, ObjectReference2: TObjectReference): Cardinal;
function CheckObjectToCoordinatesDistance(ObjectReference:  TObjectReference;
                                          X, Y: Word; Z: ShortInt): Cardinal;
function GetObjectXMain(ObjectReference: TObjectReference): Word;
function GetObjectYMain(ObjectReference: TObjectReference): Word;
function GetObjectZMain(ObjectReference: TObjectReference): ShortInt;
procedure PlaySoundEffectPrivate(Player: TObjectReference; SoundEffect: Word);
procedure SetLightLevelPrivate(Player: TObjectReference; LightLevel: Byte);
function GetAmount(Item: TObjectReference): Word;
function GetItemType(Item: TObjectReference): Cardinal;
function ListItemsInContainer(Container: TObjectReference): TObjectArray;
procedure SendText(TextType: Integer; ObjectReference,
                   Player: TObjectReference; Text: String; R, G, B: Byte);
function ListEquippedItems(ObjectReference: TObjectReference): TObjectArray;
procedure SetSex(ObjectReference: TObjectReference; Sex: Integer);
function GetGraphic(ObjectReference: TObjectReference): Word;
procedure SetGraphic(ObjectReference: TObjectReference; Graphic: Word);
function GetName(ObjectReference: TObjectReference): String;
procedure SetName(ObjectReference: TObjectReference; Name: String);
function GetFacing(ObjectReference: TObjectReference): Byte;
procedure SetFacing(ObjectReference: TObjectReference; Facing: Byte);
function GetStrength(ObjectReference: TObjectReference): Byte;
procedure SetStrength(ObjectReference: TObjectReference; Strength: Byte);
function GetDexterity(ObjectReference: TObjectReference): Byte;
procedure SetDexterity(ObjectReference: TObjectReference; Dexterity: Byte);
function GetIntelligence(ObjectReference: TObjectReference): Byte;
procedure SetIntelligence(ObjectReference: TObjectReference; Intelligence: Byte);
procedure SetCProp(ObjectReference: TObjectReference; Name, StringValue: String;
                   CardinalValue: Cardinal; IntegerValue: Integer);
function GetCPropStringValue(ObjectReference: TObjectReference;
                             Name: String): String;
function GetCPropCardinalValue(ObjectReference: TObjectReference;
                               Name: String): Cardinal;
function GetCPropIntegerValue(ObjectReference: TObjectReference;
                              Name: String): Integer;
function CPropExists(ObjectReference: TObjectReference;
                     Name: String): Boolean;
procedure EraseCProp(ObjectReference: TObjectReference;
                     Name: String);
function RequestInput(Player: TObjectReference): String;
procedure SetExperience(ObjectReference: TObjectReference; Experience: Cardinal);
procedure SetLevel(ObjectReference: TObjectReference; Level: Byte);
procedure SetSkill(ObjectReference: TObjectReference; Skill: Integer;
                   SkillValue: Byte);
procedure SetHits(ObjectReference: TObjectReference; Hits: Byte);
procedure SetMana(ObjectReference: TObjectReference; Mana: Byte);
procedure SetFatigue(ObjectReference: TObjectReference; Fatigue: Byte);
procedure SetWeight(Item: TObjectReference; Weight: Word);
procedure MoveObject(ObjectReference: TObjectReference; X, Y: Word; Z: ShortInt);
procedure SetWeaponSpeed(Weapon: TObjectReference; WeaponSpeed: Integer);
procedure SetWeaponDamage(Weapon: TObjectReference; WeaponDamage: Integer);
procedure SetArmorStrength(Armor: TObjectReference; ArmorStrength: Integer);
procedure SetMoveable(Item: TObjectReference);
procedure SetUnmoveable(Item: TObjectReference);
procedure SetVisible(Item: TObjectReference);
procedure SetInvisible(Item: TObjectReference);
procedure SetPrivileged(ObjectReference: TObjectReference);
procedure SetUnprivileged(ObjectReference: TObjectReference);
procedure SetUnhidden(ObjectReference: TObjectReference);
procedure SetHidden(ObjectReference: TObjectReference);
procedure SetItemLighting(Item: TObjectReference; Lighting: Byte);
procedure Kick(Player: TObjectReference);
procedure SetPlayerRealName(Player: TObjectReference; RealName: String);
procedure SetPlayerHomepage(Player: TObjectReference; Homepage: String);
procedure SetPlayerEMailAddress(Player: TObjectReference; EMailAddress: String);
procedure SetPlayerPCInfo(Player: TObjectReference; PCInfo: String);
procedure Walk(NPC: TObjectReference; Direction: Byte);
procedure Attack(NPC, ObjectReference: TObjectReference);
procedure SetDead(Player: TObjectReference);
procedure SetAlive(Player: TObjectReference);
function GetNPCType(NPC: TObjectReference): Cardinal;
function GetExperience(ObjectReference: TObjectReference): Cardinal;
function GetLevel(ObjectReference: TObjectReference): Cardinal;
function GetSkill(ObjectReference: TObjectReference; Skill: Integer): Byte;
function IsOnline(Player: TObjectReference): Boolean;
function IsAlive(Player: TObjectReference): Boolean;
function GetHits(ObjectReference: TObjectReference): Byte;
function GetMana(ObjectReference: TObjectReference): Byte;
function GetFatigue(ObjectReference: TObjectReference): Byte;
function IsCriminal(ObjectReference: TObjectReference): Boolean;
function IsAtWar(Player: TObjectReference): Boolean;
function IsContainedIn(Item: TObjectReference): TObjectReference;
function IsEquippedBy(Item: TObjectReference): TObjectReference;
function GetWeight(Item: TObjectReference): Word;
function IsWeapon(Item: TObjectReference): Boolean;
function IsArmor(Item: TObjectReference): Boolean;
function GetWeaponSpeed(Weapon: TObjectReference): Byte;
function GetWeaponDamage(Weapon: TObjectReference): Byte;
function GetArmorStrength(Armor: TObjectReference): Byte;
function IsMoveable(Item: TObjectReference): Boolean;
function IsVisible(Item: TObjectReference): Boolean;
function IsPrivileged(ObjectReference: TObjectReference): Boolean;
function IsUnhidden(ObjectReference: TObjectReference): Boolean;
function IsStackable(Item: TObjectReference): Boolean;
function GetItemLighting(Item: TObjectReference): Byte;
function GetPlayerRealName(Player: TObjectReference): String;
function GetPlayerHomepage(Player: TObjectReference): String;
function GetPlayerEMailAddress(Player: TObjectReference): String;
function GetPlayerPCInfo(Player: TObjectReference): String;
function GetScriptName(ObjectReference: TObjectReference): String;
function IsWalkable(Item: TObjectReference): Byte;
procedure SetWalkable(Item: TObjectReference; Direction: Byte);
procedure OpenOrCloseDoor(Door: TObjectReference; Graphic: Word; XRelative, YRelative: ShortInt);
function GetObjectID(ObjectReference: TObjectReference): Cardinal;
function ListOnlinePlayers: TObjectArray;
function GetColor(Item: TObjectReference): Word;
function GetEquipmentByLayer(ObjectReference: TObjectReference; Layer: Byte): TObjectReference;
procedure PrintServerMessage(ServerMessage: String);
procedure ScriptSleep(Milliseconds: Cardinal);
function ObjectExistsByID(ObjectType: Integer; ID: Cardinal): Boolean;
function CheckObjectType(ID: Cardinal): Integer;
function CheckDistance(X1, X2, Y1, Y2: Word; Z1, Z2: ShortInt): Cardinal;
function GetEventType(Event: TEvent): Integer;
function GetEventIntegerValue(Event: TEvent): Integer;
function GetEventStringValue(Event: TEvent): String;
function GetEventCardinalValue(Event: TEvent): Cardinal;
procedure PlaySoundEffect(X, Y: Word; SoundEffect: Word);
procedure SetLightLevel(LightLevel: Byte);
function CheckLOS(X1, X2, Y1, Y2: Word; Z1, Z2: ShortInt): Boolean;
function GetSubString(MainString: String; SubStringNumber: Integer): String;
procedure StartScript(ScriptType: Integer; ScriptName, Parameter1, Parameter2, Parameter3, Parameter4, Parameter5: String);
procedure SetGProp(Name, StringValue: String; CardinalValue: Cardinal; IntegerValue: Integer);
function GetGPropStringValue(Name: String): String;
function GetGPropCardinalValue(Name: String): Cardinal;
function GetGPropIntegerValue(Name: String): Integer;
function GPropExists(Name: String): Boolean;
procedure EraseGProp(Name: String);
function IsServerActive: Boolean;
procedure SaveWorldState;
procedure ShutDown;
function RandomInteger(Limit: Integer): Integer;
function CardToStr(Card: Cardinal): String;
function StrToCard(Str: String): Cardinal;
function PrimitiveIsContainer(Item: Cardinal): Boolean;
function IsContainer(Item: TObjectReference): Boolean;
function GetPrimitiveObjectReference(ObjectReference: TObjectReference): Cardinal;
function GetObjectType(ObjectReference: TObjectReference): Integer;
function GetObjectReference(ObjectType: Integer; PrimitiveObjectReference: Cardinal): TObjectReference;
function GetTileGraphic(X, Y: Word): Word;
function GetStaticsGraphics(X, Y: Word; Z: ShortInt): TArrayOfWord;
function GetDirectionTo(FromX, FromY, ToX, ToY: Word): Byte;
function PrimitiveFindItemInContainer(Container, TypeID: Cardinal; DeepSearch: Boolean): Cardinal;
procedure PrimitiveUnstack(Item: Cardinal; X, Y: Word; Z: ShortInt; Amount: Word);
function FindItemInContainer(Container: TObjectReference; TypeID: Cardinal; DeepSearch: Boolean): TObjectReference;
procedure Unstack(Item: TObjectReference; X, Y: Word; Z: ShortInt; Amount: Word);
function GetDate: Cardinal;
function GetTimeOfDay: Integer;
procedure AddByte(var Packet: TArrayOfByte; Value: Byte);
procedure AddWord(var Packet: TArrayOfByte; Value: Word);
procedure AddDWord(var Packet: TArrayOfByte; Value: DWord);
procedure PrimitiveSendPacket(var Packet: TArrayOfByte; Player: Cardinal);
procedure SendPacket(var Packet: TArrayOfByte; Player: TObjectReference);
procedure PrimitiveSetCriminal(ObjectType: Integer; ObjectReference: Cardinal);
procedure SetCriminal(ObjectReference: TObjectReference);
procedure PrimitiveSetInnocent(ObjectType: Integer; ObjectReference: Cardinal);
procedure SetInnocent(ObjectReference: TObjectReference);
procedure WriteHTML(HTTPConnection: Cardinal; HTML: String);
function QueryParameter(HTTPConnection: Cardinal; Name: String): String;
function QueryIP(HTTPConnection: Cardinal): String;
function ScriptGetTickCount: Cardinal;
function PrimitiveGetIP(Player: Cardinal): String;
function GetIP(Player: TObjectReference): String;
function PrimitiveObjectExists(ObjectType: Integer; ObjectReference: Cardinal): Boolean;
function ObjectExists(ObjectReference: TObjectReference): Boolean;
procedure PrimitiveSetScriptName(ObjectType: Integer; ObjectReference: Cardinal; ScriptName: String);
procedure SetScriptName(ObjectReference: TObjectReference; ScriptName: String);
procedure PrimitiveSetPassword(Player: Cardinal; Password: String);
procedure SetPassword(Player: TObjectReference; Password: String);
function PrimitiveGetPassword(Player: Cardinal): String;
function GetPassword(Player: TObjectReference): String;

implementation

{$R *.dfm}

destructor tplayer.Destroy;
var
  threadid: LongWord;

begin
  BeginThread(nil, 0, Addr(freelockdelayed), lock, 0, threadid);
  inherited;

end;

destructor tnpc.Destroy;
var
  threadid: LongWord;

begin
  BeginThread(nil, 0, Addr(freelockdelayed), lock, 0, threadid);
  inherited;

end;

destructor titem.Destroy;
var
  threadid: LongWord;

begin
  BeginThread(nil, 0, Addr(freelockdelayed), lock, 0, threadid);
  inherited;

end;

function tplayer.getinaccessible: Boolean;
begin
  try
    Result := pinaccessible;

  except
    Result := True;

  end;

end;

procedure tplayer.setinaccessible(bool: Boolean);
begin
  if not inaccessible then
    try
      pinaccessible := bool;

    except
    end;

end;

function tnpc.getinaccessible: Boolean;
begin
  lock.Acquire;
  Result := pinaccessible;
  lock.Release;

end;

procedure tnpc.setinaccessible(bool: Boolean);
begin
  lock.Acquire;
  pinaccessible := bool;
  lock.Release;

end;

function titem.getinaccessible: Boolean;
begin
  lock.Acquire;
  Result := pinaccessible;
  lock.Release;

end;

procedure titem.setinaccessible(bool: Boolean);
begin
  lock.Acquire;
  pinaccessible := bool;
  lock.Release;

end;

function titem.getid: Cardinal;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;

    end;

  lock.Acquire;
  Result := pid;
  lock.Release;

end;

procedure titem.setid(card: Cardinal);
begin
  if inaccessible then
    Exit;
 
  lock.Acquire;
  pid := card;
  lock.Release;

end;

function titem.getitemtype: Cardinal;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pitemtype;
  lock.Release;

end;

procedure titem.setitemtype(card: Cardinal);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pitemtype := card;
  lock.Release;

end;

function titem.getcontained: Cardinal;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pcontained;
  lock.Release;

end;

procedure titem.setcontained(card: Cardinal);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pcontained := card;
  lock.Release;

end;

function titem.getequipped: Cardinal;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pequipped;
  lock.Release;

end;

procedure titem.setequipped(card: Cardinal);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pequipped := card;
  lock.Release;

end;

function titem.getdragger: Cardinal;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pdragger;
  lock.Release;

end;

procedure titem.setdragger(card: Cardinal);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pdragger := card;
  lock.Release;

end;

function titem.getx: Word;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := px;
  lock.Release;

end;

procedure titem.setx(wo: Word);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  px := wo;
  lock.Release;

end;

function titem.gety: Word;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := py;
  lock.Release;

end;

procedure titem.sety(wo: Word);
begin
  if inaccessible then
    Exit;
 
  lock.Acquire;
  py := wo;
  lock.Release;

end;

function titem.getweight: Word;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pweight;
  lock.Release;

end;

procedure titem.setweight(wo: Word);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pweight := wo;
  lock.Release;

end;

function titem.getgraphic: Word;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pgraphic;
  lock.Release;

end;

procedure titem.setgraphic(wo: Word);
begin
  if inaccessible then
    Exit;
 
  lock.Acquire;
  pgraphic := wo;
  lock.Release;

end;

function titem.getcolor: Word;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pcolor;
  lock.Release;

end;

procedure titem.setcolor(wo: Word);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pcolor := wo;
  lock.Release;

end;

function titem.getgump: Word;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pgump;
  lock.Release;

end;

procedure titem.setgump(wo: Word);
begin
  if inaccessible then
    Exit;
 
  lock.Acquire;
  pgump := wo;
  lock.Release;

end;

function titem.getdefinsposx: Word;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pdefinsposx;
  lock.Release;

end;

procedure titem.setdefinsposx(wo: Word);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pdefinsposx := wo;
  lock.Release;

end;

function titem.getdefinsposy: Word;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pdefinsposy;
  lock.Release;

end;

procedure titem.setdefinsposy(wo: Word);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pdefinsposy := wo;
  lock.Release;

end;

function titem.getamount: Word;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pamount;
  lock.Release;

end;

procedure titem.setamount(wo: Word);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pamount := wo;
  lock.Release;

end;

function titem.getz: ShortInt;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pz;
  lock.Release;

end;

procedure titem.setz(shint: ShortInt);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pz := shint;
  lock.Release;

end;

function titem.getscriptname: String;
begin
  if inaccessible then
    begin
      Result := '';
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pscriptname;
  lock.Release;

end;

procedure titem.setscriptname(str: String);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pscriptname := str;
  lock.Release;

end;

function titem.getcontainer: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pcontainer;
  lock.Release;

end;

procedure titem.setcontainer(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pcontainer := by;
  lock.Release;

end;

function titem.getweapon: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pweapon;
  lock.Release;

end;

procedure titem.setweapon(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pweapon := by;
  lock.Release;

end;

function titem.getweapspeed: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pweapspeed;
  lock.Release;

end;

procedure titem.setweapspeed(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pweapspeed := by;
  lock.Release;

end;

function titem.getweapdamage: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pweapdamage;
  lock.Release;

end;

procedure titem.setweapdamage(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pweapdamage := by;
  lock.Release;

end;

function titem.getarmor: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := parmor;
  lock.Release;

end;

procedure titem.setarmor(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  parmor := by;
  lock.Release;

end;

function titem.getarmorstr: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := parmorstr;
  lock.Release;

end;

procedure titem.setarmorstr(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  parmorstr := by;
  lock.Release;

end;

function titem.getinvisible: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pinvisible;
  lock.Release;

end;

procedure titem.setinvisible(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pinvisible := by;
  lock.Release;

end;

function titem.getstackable: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pstackable;
  lock.Release;

end;

procedure titem.setstackable(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pstackable := by;
  lock.Release;

end;

function titem.getwalkable: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pwalkable;
  lock.Release;

end;

procedure titem.setwalkable(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pwalkable := by;
  lock.Release;

end;

function titem.getmoveable: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pmoveable;
  lock.Release;

end;

procedure titem.setmoveable(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pmoveable := by;
  lock.Release;

end;

function titem.getlighting: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := plighting;
  lock.Release;

end;

procedure titem.setlighting(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  plighting := by;
  lock.Release;

end;

function titem.getcontitems: TArrayOfCardinal;
begin
  if inaccessible then
    begin
      Result := nil;
      Exit;

    end;
 
  lock.Acquire;
  Result := pcontitems;
  lock.Release;

end;

procedure titem.setcontitems(cardarray: TArrayOfCardinal);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pcontitems := cardarray;
  lock.Release;

end;

function titem.getcprops: tcproparray;
begin
  if inaccessible then
    begin
      Result := nil;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pcprops;
  lock.Release;

end;

procedure titem.setcprops(cproparray: tcproparray);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pcprops := cproparray;
  lock.Release;

end;

function titem.getoccupied: Boolean;
begin
  if inaccessible then
    begin
      Result := True;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := poccupied;
  lock.Release;

end;

procedure titem.setoccupied(bool: Boolean);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  poccupied := bool;
  lock.Release;

end;

function titem.getcioc: Boolean;
begin
  if inaccessible then
    begin
      Result := True;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pcioc;
  lock.Release;

end;

procedure titem.setcioc(bool: Boolean);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pcioc := bool;
  lock.Release;

end;

function titem.getcpoc: Boolean;
begin
  if inaccessible then
    begin
      Result := True;
      Exit;

    end;

  lock.Acquire;
  Result := pcpoc;
  lock.Release;

end;

procedure titem.setcpoc(bool: Boolean);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pcpoc := bool;
  lock.Release;

end;

constructor titem.Create;
begin
  inherited;
  lock := TCriticalSection.Create;

end;

procedure titem.setcontitemslen(len: Cardinal);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  SetLength(pcontitems, len);
  lock.Release;

end;

procedure titem.setcpropslen(len: Cardinal);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  SetLength(pcprops, len);
  lock.Release;

end;

function titem.clone: titem;
var
  tempitem: titem;

begin
  if inaccessible then
    begin
      Result := nil;
      Exit;

    end;

  tempitem := titem.Create;
  tempitem.id := id;
  tempitem.amount := amount;
  tempitem.armor := armor;
  tempitem.armorstr := armorstr;
  tempitem.contained := contained;
  tempitem.color := color;
  tempitem.container := container;
  tempitem.contitems := contitems;
  tempitem.cprops := cprops;
  tempitem.cioc := cioc;
  tempitem.cpoc := cpoc;
  tempitem.dragger := dragger;
  tempitem.definsposx := definsposx;
  tempitem.definsposy := definsposy;
  tempitem.equipped := equipped;
  tempitem.graphic := graphic;
  tempitem.gump := gump;
  tempitem.id := id;
  tempitem.itemtype := itemtype;
  tempitem.invisible := invisible;
  tempitem.lighting := lighting;
  tempitem.moveable := moveable;
  tempitem.occupied := occupied;
  tempitem.scriptname := scriptname;
  tempitem.stackable := stackable;
  tempitem.weight := weight;
  tempitem.weapon := weapon;
  tempitem.weapspeed := weapspeed;
  tempitem.weapdamage := weapdamage;
  tempitem.walkable := walkable;
  tempitem.x := x;
  tempitem.y := y;
  tempitem.z := z;
  Result := tempitem;

end;

function tnpc.getid: Cardinal;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;

    end;

  lock.Acquire;
  Result := pid;
  lock.Release;

end;

procedure tnpc.setid(card: Cardinal);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pid := card;
  lock.Release;

end;

function tnpc.getnpctype: Cardinal;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pnpctype;
  lock.Release;

end;

procedure tnpc.setnpctype(card: Cardinal);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pnpctype := card;
  lock.Release;

end;

function tnpc.getexp: Cardinal;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pexp;
  lock.Release;

end;

procedure tnpc.setexp(card: Cardinal);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pexp := card;
  lock.Release;

end;

function tnpc.getname: String;
begin
  if inaccessible then
    begin
      Result := '';
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pname;
  lock.Release;

end;

procedure tnpc.setname(str: String);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pname := str;
  lock.Release;

end;

function tnpc.getsex: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := psex;
  lock.Release;

end;

procedure tnpc.setsex(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  psex := by;
  lock.Release;

end;

function tnpc.getstr: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pstr;
  lock.Release;

end;

procedure tnpc.setstr(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pstr := by;
  lock.Release;

end;

function tnpc.getdex: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pdex;
  lock.Release;

end;

procedure tnpc.setdex(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pdex := by;
  lock.Release;

end;

function tnpc.getint: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pint;
  lock.Release;

end;

procedure tnpc.setint(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pint := by;
  lock.Release;

end;

function tnpc.gethits: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := phits;
  lock.Release;

end;

procedure tnpc.sethits(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  phits := by;
  lock.Release;

end;

function tnpc.getmana: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pmana;
  lock.Release;

end;

procedure tnpc.setmana(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pmana := by;
  lock.Release;

end;

function tnpc.getfat: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pfat;
  lock.Release;

end;

procedure tnpc.setfat(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pfat := by;
  lock.Release;

end;

function tnpc.getmagicdef: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pmagicdef;
  lock.Release;

end;

procedure tnpc.setmagicdef(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pmagicdef := by;
  lock.Release;

end;

function tnpc.getbattledef: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pbattledef;
  lock.Release;

end;

procedure tnpc.setbattledef(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pbattledef := by;
  lock.Release;

end;

function tnpc.getstealing: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pstealing;
  lock.Release;
  
end;

procedure tnpc.setstealing(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pstealing := by;
  lock.Release;

end;

function tnpc.gethiding: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := phiding;
  lock.Release;

end;

procedure tnpc.sethiding(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  phiding := by;
  lock.Release;

end;

function tnpc.getfirstaid: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pfirstaid;
  lock.Release;

end;

procedure tnpc.setfirstaid(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pfirstaid := by;
  lock.Release;

end;

function tnpc.getdetecttr: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pdetecttr;
  lock.Release;

end;

procedure tnpc.setdetecttr(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pdetecttr := by;
  lock.Release;

end;

function tnpc.getpeek: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := ppeek;
  lock.Release;

end;

procedure tnpc.setpeek(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  ppeek := by;
  lock.Release;

end;

function tnpc.getmagic: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pmagic;
  lock.Release;

end;

procedure tnpc.setmagic(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pmagic := by;
  lock.Release;

end;

function tnpc.getmelee: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pmelee;
  lock.Release;

end;

procedure tnpc.setmelee(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pmelee := by;
  lock.Release;

end;

function tnpc.getrangedweap: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := prangedweap;
  lock.Release;

end;

procedure tnpc.setrangedweap(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  prangedweap := by;
  lock.Release;

end;

function tnpc.getlevel: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := plevel;
  lock.Release;

end;

procedure tnpc.setlevel(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  plevel := by;
  lock.Release;

end;

function tnpc.getprivileged: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pprivileged;
  lock.Release;

end;

procedure tnpc.setprivileged(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pprivileged := by;
  lock.Release;

end;

function tnpc.gethidden: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := phidden;
  lock.Release;

end;

procedure tnpc.sethidden(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  phidden := by;
  lock.Release;

end;

function tnpc.getwar: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pwar;
  lock.Release;

end;

procedure tnpc.setwar(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pwar := by;
  lock.Release;

end;

function tnpc.getfacing: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pfacing;
  lock.Release;

end;

procedure tnpc.setfacing(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pfacing := by;
  lock.Release;

end;

function tnpc.getcriminal: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pcriminal;
  lock.Release;

end;

procedure tnpc.setcriminal(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pcriminal := by;
  lock.Release;

end;

function tnpc.getx: Word;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := px;
  lock.Release;

end;

procedure tnpc.setx(wo: Word);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  px := wo;
  lock.Release;

end;

function tnpc.gety: Word;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := py;
  lock.Release;

end;

procedure tnpc.sety(wo: Word);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  py := wo;
  lock.Release;

end;

function tnpc.getgraphic: Word;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pgraphic;
  lock.Release;

end;

procedure tnpc.setgraphic(wo: Word);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pgraphic := wo;
  lock.Release;

end;

function tnpc.getz: ShortInt;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pz;
  lock.Release;

end;

procedure tnpc.setz(shint: ShortInt);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pz := shint;
  lock.Release;

end;

function tnpc.getscriptname: String;
begin
  if inaccessible then
    begin
      Result := '';
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pscriptname;
  lock.Release;

end;

procedure tnpc.setscriptname(str: String);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pscriptname := str;
  lock.Release;

end;

function tnpc.getequitems: TArrayOfCardinal;
begin
  if inaccessible then
    begin
      Result := nil;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pequitems;
  lock.Release;

end;

procedure tnpc.setequitems(cardarray: TArrayOfCardinal);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pequitems := cardarray;
  lock.Release;

end;

function tnpc.getcprops: tcproparray;
begin
  if inaccessible then
    begin
      Result := nil;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pcprops;
  lock.Release;

end;

procedure tnpc.setcprops(cproparray: tcproparray);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pcprops := cproparray;
  lock.Release;

end;

function tnpc.getevents: teventarray;
begin
  if inaccessible then
    begin
      Result := nil;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pevents;
  lock.Release;

end;

procedure tnpc.setevents(eventarray: teventarray);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pevents := eventarray;
  lock.Release;

end;

function tnpc.geteioc: Boolean;
begin
  if inaccessible then
    begin
      Result := True;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := peioc;
  lock.Release;

end;

procedure tnpc.seteioc(bool: Boolean);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  peioc := bool;
  lock.Release;

end;

function tnpc.getcpoc: Boolean;
begin
  if inaccessible then
    begin
      Result := True;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pcpoc;
  lock.Release;

end;

procedure tnpc.setcpoc(bool: Boolean);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pcpoc := bool;
  lock.Release;

end;

function tnpc.geteoc: Boolean;
begin
  if inaccessible then
    begin
      Result := True;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := peoc;
  lock.Release;

end;

procedure tnpc.seteoc(bool: Boolean);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  peoc := bool;
  lock.Release;

end;

constructor tnpc.Create;
begin
  inherited;
  lock := TCriticalSection.Create;

end;

procedure tnpc.setequitemslen(len: Cardinal);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  SetLength(pequitems, len);
  lock.Release;

end;

procedure tnpc.setcpropslen(len: Cardinal);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  SetLength(pcprops, len);
  lock.Release;

end;

procedure tnpc.seteventslen(len: Cardinal);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  SetLength(pevents, len);
  lock.Release;

end;

function tplayer.getid: Cardinal;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pid;
  lock.Release;

end;

procedure tplayer.setid(card: Cardinal);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pid := card;
  lock.Release;

end;

function tplayer.getdragitem: Cardinal;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pdragitem;
  lock.Release;

end;

procedure tplayer.setdragitem(card: Cardinal);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pdragitem := card;
  lock.Release;

end;

function tplayer.getexp: Cardinal;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pexp;
  lock.Release;

end;

procedure tplayer.setexp(card: Cardinal);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pexp := card;
  lock.Release;

end;

function tplayer.getname: String;
begin
  if inaccessible then
    begin
      Result := '';
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pname;
  lock.Release;

end;

procedure tplayer.setname(str: String);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pname := str;
  lock.Release;

end;

function tplayer.getpassw: String;
begin
  if inaccessible then
    begin
      Result := '';
      Exit;
      
    end;
 
  lock.Acquire;
  Result := ppassw;
  lock.Release;

end;

procedure tplayer.setpassw(str: String);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  ppassw := str;
  lock.Release;

end;

function tplayer.getrealname: String;
begin
  if inaccessible then
    begin
      Result := '';
      Exit;
      
    end;
 
  lock.Acquire;
  Result := prealname;
  lock.Release;

end;

procedure tplayer.setrealname(str: String);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  prealname := str;
  lock.Release;

end;

function tplayer.gethomepage: String;
begin
  if inaccessible then
    begin
      Result := '';
      Exit;
      
    end;
 
  lock.Acquire;
  Result := phomepage;
  lock.Release;
  
end;

procedure tplayer.sethomepage(str: String);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  phomepage := str;
  lock.Release;

end;

function tplayer.getemailaddr: String;
begin
  if inaccessible then
    begin
      Result := '';
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pemailaddr;
  lock.Release;

end;

procedure tplayer.setemailaddr(str: String);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pemailaddr := str;
  lock.Release;

end;

function tplayer.getpcinfo: String;
begin
  if inaccessible then
    begin
      Result := '';
      Exit;
      
    end;
 
  lock.Acquire;
  Result := ppcinfo;
  lock.Release;

end;

procedure tplayer.setpcinfo(str: String);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  ppcinfo := str;
  lock.Release;

end;

function tplayer.getonline: Boolean;
begin
  if inaccessible then
    begin
      Result := False;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := ponline;
  lock.Release;

end;

procedure tplayer.setonline(bool: Boolean);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  ponline := bool;
  lock.Release;

end;

function tplayer.getdragging: Boolean;
begin
  if inaccessible then
    begin
      Result := False;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pdragging;
  lock.Release;

end;

procedure tplayer.setdragging(bool: Boolean);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pdragging := bool;
  lock.Release;

end;

function tplayer.getclient: TWSocketClient;
begin
  if inaccessible then
    begin
      Result := nil;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pclient;
  lock.Release;

end;

procedure tplayer.setclient(twsc: TWSocketClient);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pclient := twsc;
  lock.Release;

end;

function tplayer.getsex: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := psex;
  lock.Release;

end;

procedure tplayer.setsex(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  psex := by;
  lock.Release;

end;

function tplayer.getdead: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pdead;
  lock.Release;

end;

procedure tplayer.setdead(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pdead := by;
  lock.Release;

end;

function tplayer.getstr: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pstr;
  lock.Release;

end;

procedure tplayer.setstr(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pstr := by;
  lock.Release;

end;

function tplayer.getdex: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pdex;
  lock.Release;

end;

procedure tplayer.setdex(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pdex := by;
  lock.Release;

end;

function tplayer.getint: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pint;
  lock.Release;

end;

procedure tplayer.setint(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pint := by;
  lock.Release;

end;

function tplayer.gethits: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := phits;
  lock.Release;

end;

procedure tplayer.sethits(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  phits := by;
  lock.Release;

end;

function tplayer.getmana: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pmana;
  lock.Release;

end;

procedure tplayer.setmana(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pmana := by;
  lock.Release;

end;

function tplayer.getfat: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pfat;
  lock.Release;

end;

procedure tplayer.setfat(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pfat := by;
  lock.Release;

end;

function tplayer.getmagicdef: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pmagicdef;
  lock.Release;

end;

procedure tplayer.setmagicdef(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pmagicdef := by;
  lock.Release;

end;

function tplayer.getbattledef: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pbattledef;
  lock.Release;

end;

procedure tplayer.setbattledef(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pbattledef := by;
  lock.Release;

end;

function tplayer.getstealing: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pstealing;
  lock.Release;
  
end;

procedure tplayer.setstealing(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pstealing := by;
  lock.Release;

end;

function tplayer.gethiding: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := phiding;
  lock.Release;

end;

procedure tplayer.sethiding(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  phiding := by;
  lock.Release;

end;

function tplayer.getfirstaid: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pfirstaid;
  lock.Release;

end;

procedure tplayer.setfirstaid(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pfirstaid := by;
  lock.Release;

end;

function tplayer.getdetecttr: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pdetecttr;
  lock.Release;

end;

procedure tplayer.setdetecttr(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pdetecttr := by;
  lock.Release;

end;

function tplayer.getpeek: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := ppeek;
  lock.Release;

end;

procedure tplayer.setpeek(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  ppeek := by;
  lock.Release;

end;

function tplayer.getmagic: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pmagic;
  lock.Release;

end;

procedure tplayer.setmagic(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pmagic := by;
  lock.Release;

end;

function tplayer.getmelee: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pmelee;
  lock.Release;

end;

procedure tplayer.setmelee(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pmelee := by;
  lock.Release;

end;

function tplayer.getrangedweap: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := prangedweap;
  lock.Release;

end;

procedure tplayer.setrangedweap(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  prangedweap := by;
  lock.Release;

end;

function tplayer.getlevel: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := plevel;
  lock.Release;

end;

procedure tplayer.setlevel(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  plevel := by;
  lock.Release;

end;

function tplayer.getprivileged: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pprivileged;
  lock.Release;

end;

procedure tplayer.setprivileged(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pprivileged := by;
  lock.Release;

end;

function tplayer.gethidden: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := phidden;
  lock.Release;

end;

procedure tplayer.sethidden(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  phidden := by;
  lock.Release;

end;

function tplayer.getwar: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pwar;
  lock.Release;

end;

procedure tplayer.setwar(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pwar := by;
  lock.Release;

end;

function tplayer.getfacing: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pfacing;
  lock.Release;

end;

procedure tplayer.setfacing(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pfacing := by;
  lock.Release;

end;

function tplayer.getcriminal: Byte;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pcriminal;
  lock.Release;

end;

procedure tplayer.setcriminal(by: Byte);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pcriminal := by;
  lock.Release;

end;

function tplayer.getx: Word;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := px;
  lock.Release;

end;

procedure tplayer.setx(wo: Word);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  px := wo;
  lock.Release;

end;

function tplayer.gety: Word;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := py;
  lock.Release;

end;

procedure tplayer.sety(wo: Word);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  py := wo;
  lock.Release;

end;

function tplayer.getgraphic: Word;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pgraphic;
  lock.Release;

end;

procedure tplayer.setgraphic(wo: Word);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pgraphic := wo;
  lock.Release;

end;

function tplayer.getdragamt: Word;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pdragamt;
  lock.Release;

end;

procedure tplayer.setdragamt(wo: Word);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pdragamt := wo;
  lock.Release;

end;

function tplayer.getz: ShortInt;
begin
  if inaccessible then
    begin
      Result := 0;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pz;
  lock.Release;

end;

procedure tplayer.setz(shint: ShortInt);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pz := shint;
  lock.Release;

end;

function tplayer.getequitems: TArrayOfCardinal;
begin
  if inaccessible then
    begin
      Result := nil;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pequitems;
  lock.Release;

end;

procedure tplayer.setequitems(cardarray: TArrayOfCardinal);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pequitems := cardarray;
  lock.Release;

end;

function tplayer.getopenconts: TPrimitiveObjectArray;
begin
  if inaccessible then
    begin
      Result := nil;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := popenconts;
  lock.Release;

end;

procedure tplayer.setopenconts(objarray: TPrimitiveObjectArray);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  popenconts := objarray;
  lock.Release;

end;

function tplayer.getcprops: tcproparray;
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  Result := pcprops;
  lock.Release;

end;

procedure tplayer.setcprops(cproparray: tcproparray);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pcprops := cproparray;
  lock.Release;

end;

function tplayer.geteioc: Boolean;
begin
  if inaccessible then
    begin
      Result := True;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := peioc;
  lock.Release;

end;

procedure tplayer.seteioc(bool: Boolean);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  peioc := bool;
  lock.Release;

end;

function tplayer.getcpoc: Boolean;
begin
  if inaccessible then
    begin
      Result := True;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pcpoc;
  lock.Release;

end;

procedure tplayer.setcpoc(bool: Boolean);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pcpoc := bool;
  lock.Release;

end;

function tplayer.getnouenpcsoc: Boolean;
begin
  if inaccessible then
    begin
      Result := True;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pnouenpcsoc;
  lock.Release;

end;

procedure tplayer.setnouenpcsoc(bool: Boolean);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pnouenpcsoc := bool;
  lock.Release;

end;

function tplayer.getnoueplayersoc: Boolean;
begin
  if inaccessible then
    begin
      Result := True;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pnoueplayersoc;
  lock.Release;

end;

procedure tplayer.setnoueplayersoc(bool: Boolean);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pnoueplayersoc := bool;
  lock.Release;

end;

function tplayer.getnouitemsoc: Boolean;
begin
  if inaccessible then
    begin
      Result := True;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pnouitemsoc;
  lock.Release;

end;

procedure tplayer.setnouitemsoc(bool: Boolean);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pnouitemsoc := bool;
  lock.Release;

end;

function tplayer.getococ: Boolean;
begin
  if inaccessible then
    begin
      Result := True;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pococ;
  lock.Release;

end;

procedure tplayer.setococ(bool: Boolean);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pococ := bool;
  lock.Release;

end;

function tplayer.getinreq: Boolean;
begin
  if inaccessible then
    begin
      Result := True;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pinreq;
  lock.Release;

end;

procedure tplayer.setinreq(bool: Boolean);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pinreq := bool;
  lock.Release;

end;

function tplayer.getinreqres: String;
begin
  if inaccessible then
    begin
      Result := '';
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pinreqres;
  lock.Release;

end;

procedure tplayer.setinreqres(str: String);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pinreqres := str;
  lock.Release;

end;

function tplayer.getnouenpcs: TPrimitiveObjectArray;
begin
  if inaccessible then
    begin
      Result := nil;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pnouenpcs;
  lock.Release;

end;

procedure tplayer.setnouenpcs(objarray: TPrimitiveObjectArray);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pnouenpcs := objarray;
  lock.Release;

end;

function tplayer.getnoueplayers: TPrimitiveObjectArray;
begin
  if inaccessible then
    begin
      Result := nil;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pnoueplayers;
  lock.Release;

end;

procedure tplayer.setnoueplayers(objarray: TPrimitiveObjectArray);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pnoueplayers := objarray;
  lock.Release;

end;

function tplayer.getnouitems: TPrimitiveObjectArray;
begin
  if inaccessible then
    begin
      Result := nil;
      Exit;
      
    end;
 
  lock.Acquire;
  Result := pnouitems;
  lock.Release;

end;

procedure tplayer.setnouitems(objarray: TPrimitiveObjectArray);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  pnouitems := objarray;
  lock.Release;

end;

constructor tplayer.Create;
begin
  inherited;
  lock := TCriticalSection.Create;

end;

procedure tplayer.setequitemslen(len: Cardinal);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  SetLength(pequitems, len);
  lock.Release;

end;

procedure tplayer.setcpropslen(len: Cardinal);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  SetLength(pcprops, len);
  lock.Release;

end;

procedure tplayer.setnoueplayerslen(len: Cardinal);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  SetLength(pnoueplayers, len);
  lock.Release;

end;

procedure tplayer.setnouenpcslen(len: Cardinal);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  SetLength(pnouenpcs, len);
  lock.Release;

end;

procedure tplayer.setnouitemslen(len: Cardinal);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  SetLength(pnouitems, len);
  lock.Release;

end;

procedure tplayer.setopencontslen(len: Cardinal);
begin
  if inaccessible then
    Exit;

  lock.Acquire;
  SetLength(popenconts, len);
  lock.Release;

end;

function tdatah.getplayerslen: Cardinal;
begin
  playerslock.Acquire;
  Result := Length(Unit1.players);
  playerslock.Release;

end;

function tdatah.getplayer(i: Cardinal): tplayer;
begin
  playerslock.Acquire;
  if Unit1.players[i] = nil then
    Result := Unit1.players[0]

  else
    Result := Unit1.players[i];

  playerslock.Release;

end;

procedure tdatah.setplayer(i: Cardinal; player: tplayer);
begin
  playerslock.Acquire;
  Unit1.players[i] := player;
  playerslock.Release;

end;

function tdatah.getnpcslen: Cardinal;
begin
  npcslock.Acquire;
  Result := Length(Unit1.npcs);
  npcslock.Release;

end;

function tdatah.getnpc(i: Cardinal): tnpc;
begin
  npcslock.Acquire;
  if Unit1.npcs[i] = nil then
    Result := Unit1.npcs[0]

  else
    Result := Unit1.npcs[i];

  npcslock.Release;

end;

procedure tdatah.setnpc(i: Cardinal; npc: tnpc);
begin
  npcslock.Acquire;
  Unit1.npcs[i] := npc;
  npcslock.Release;

end;

function tdatah.getitemslen: Cardinal;
begin
  itemslock.Acquire;
  Result := Length(Unit1.items);
  itemslock.Release;

end;

function tdatah.getitem(i: Cardinal): titem;
begin
  itemslock.Acquire;
  if Unit1.items[i] = nil then
    Result := Unit1.items[0]

  else
    Result := Unit1.items[i];

  itemslock.Release;

end;

procedure tdatah.setitem(i: Cardinal; item: titem);
begin
  itemslock.Acquire;
  Unit1.items[i] := item;
  itemslock.Release;

end;

procedure TForm1.Button6Click(Sender: TObject);
var
  fnstr, tempstr: String;

begin
  if IsServerActive then
    ShowMessage('Not possible while server is active.')

  else
    begin
      SetLength(tempstr, 8);
      OpenDialog1.FileName := 'map0.mul';
      if OpenDialog1.Execute then
        begin
          fnstr := OpenDialog1.FileName;
          try
            Move(fnstr[Length(fnstr) - 7], tempstr[1], 8);
            if StrLower(PChar(tempstr)) = 'map0.mul' then
              LabeledEdit1.Text := fnstr

            else
              ShowMessage('Invalid Path to map0.mul.');

          except
            ShowMessage('Invalid Path to map0.mul.');

          end;

        end;

    end;

end;

procedure TForm1.Button7Click(Sender: TObject);
var
  fnstr, tempstr: String;

begin
  if IsServerActive then
    ShowMessage('Not possible while server is active.')

  else
    begin
      SetLength(tempstr, 12);
      OpenDialog1.FileName := 'statics0.mul';
      if OpenDialog1.Execute then
        begin
          fnstr := OpenDialog1.FileName;
          try
            Move(fnstr[Length(fnstr) - 11], tempstr[1], 12);
            if StrLower(PChar(tempstr)) = 'statics0.mul' then
              LabeledEdit2.Text := fnstr

            else
              ShowMessage('Invalid Path to statics0.mul.');

          except
            ShowMessage('Invalid Path to statics0.mul.');

          end;

        end;

    end;

end;

procedure TForm1.Button8Click(Sender: TObject);
var
  fnstr, tempstr: String;

begin
  if IsServerActive then
    ShowMessage('Not possible while server is active.')

  else
    begin
      SetLength(tempstr, 12);
      OpenDialog1.FileName := 'tiledata.mul';
      if OpenDialog1.Execute then
        begin
          fnstr := OpenDialog1.FileName;
          try
            Move(fnstr[Length(fnstr) - 11], tempstr[1], 12);
            if StrLower(PChar(tempstr)) = 'tiledata.mul' then
              LabeledEdit3.Text := fnstr

            else
              ShowMessage('Invalid Path to tiledata.mul.');

          except
            ShowMessage('Invalid Path to tiledata.mul.');

          end;

        end;

    end;

end;

procedure TForm1.FormCreate(Sender: TObject);
var
  configini: TIniFile;

begin
  serveractive := False;
  starting := False;
  shuttingdown := False;
  saving := False;
  kickingop := False;
  listingop := False;
  sdscriptdone := False;
  serveractivelock := TCriticalSection.Create;
  startinglock := TCriticalSection.Create;
  savinglock := TCriticalSection.Create;
  shuttingdownlock := TCriticalSection.Create;
  kickingoplock := TCriticalSection.Create;
  listingoplock := TCriticalSection.Create;
  sdscriptdonelock := TCriticalSection.Create;
  configini := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');
  try
    LabeledEdit1.Text := configini.ReadString('Paths', 'Path to map0.mul', '');
    LabeledEdit2.Text := configini.ReadString('Paths', 'Path to statics0.mul', '');
    LabeledEdit3.Text := configini.ReadString('Paths', 'Path to tiledata.mul', '');
    LabeledEdit4.Text := configini.ReadString('Paths', 'Path to staidx0.mul', '');

  finally
    configini.Free;

  end;
  bgthread := tbgthread.Create(False);

end;

procedure TForm1.Button1Click(Sender: TObject);
var
  fnstr, tempstr: String;
  configini: TIniFile;
  threadid: Longword;

begin
  if IsServerActive then
    ShowMessage('Server is already active.')

  else if isshuttingdown then
    ShowMessage('Server is shutting down.')

  else if issaving then
    ShowMessage('Server is saving world state.')

  else if isstarting then
    ShowMessage('Server is already starting.')

  else
    begin
      fnstr := LabeledEdit1.Text;
      try
        SetLength(tempstr, 8);
        Move(fnstr[Length(fnstr) - 7], tempstr[1], 8);
        if StrLower(PChar(tempstr)) = 'map0.mul' then
          if FileExists(LabeledEdit1.Text) then
            begin
              fnstr := LabeledEdit2.Text;
              try
                SetLength(tempstr, 12);
                Move(fnstr[Length(fnstr) - 11], tempstr[1], 12);
                if StrLower(PChar(tempstr)) = 'statics0.mul' then
                  if FileExists(LabeledEdit2.Text) then
                    begin
                      fnstr := LabeledEdit3.Text;
                      try
                        SetLength(tempstr, 12);
                        Move(fnstr[Length(fnstr) - 11], tempstr[1], 12);
                        if StrLower(PChar(tempstr)) = 'tiledata.mul' then
                          if FileExists(LabeledEdit3.Text) then
                            begin
                              fnstr := LabeledEdit4.Text;
                              try
                                SetLength(tempstr, 11);
                                Move(fnstr[Length(fnstr) - 10], tempstr[1], 11);
                                if StrLower(PChar(tempstr)) = 'staidx0.mul' then
                                  if FileExists(LabeledEdit4.Text) then
                                    begin
                                      configini := TIniFile.Create(ExtractFilePath(Application.ExeName) +
                                                                   'config.ini');
                                      try
                                        configini.WriteString('Paths', 'Path to map0.mul',
                                                              LabeledEdit1.Text);
                                        configini.WriteString('Paths', 'Path to statics0.mul',
                                                              LabeledEdit2.Text);
                                        configini.WriteString('Paths', 'Path to tiledata.mul',
                                                              LabeledEdit3.Text);
                                        configini.WriteString('Paths', 'Path to staidx0.mul',
                                                              LabeledEdit4.Text);

                                      finally
                                        configini.Free;

                                      end;
                                      RichEdit1.Clear;
                                      BeginThread(nil, 0, Addr(startserver), nil, 0, threadid);

                                    end

                                  else
                                    ShowMessage('Could not find staidx0.mul.')

                                else
                                  ShowMessage('Invalid Path to staidx0.mul.');

                              except
                                ShowMessage('Invalid Path to staidx0.mul.');

                              end;

                            end

                          else
                            ShowMessage('Could not find tiledata.mul.')

                        else
                          ShowMessage('Invalid Path to tiledata.mul.');

                      except
                        ShowMessage('Invalid Path to tiledata.mul.');

                      end;

                    end

                  else
                    ShowMessage('Could not find statics0.mul.')

                else
                  ShowMessage('Invalid Path to statics0.mul.');

              except
                ShowMessage('Invalid Path to statics0.mul.');

              end;

            end

          else
            ShowMessage('Could not find map0.mul.')

        else
          ShowMessage('Invalid Path to map0.mul.');

      except
        ShowMessage('Invalid Path to map0.mul.');

      end;

    end;

end;

procedure TForm1.Button9Click(Sender: TObject);
var
  fnstr, tempstr: String;

begin
  if IsServerActive then
    ShowMessage('Not possible while server is active.')

  else
    begin
      SetLength(tempstr, 11);
      OpenDialog1.FileName := 'staidx0.mul';
      if OpenDialog1.Execute then
        begin
          fnstr := OpenDialog1.FileName;
          try
            Move(fnstr[Length(fnstr) - 10], tempstr[1], 11);
            if StrLower(PChar(tempstr)) = 'staidx0.mul' then
              LabeledEdit4.Text := fnstr

            else
              ShowMessage('Invalid Path to staidx0.mul.');

          except
            ShowMessage('Invalid Path to staidx0.mul.');

          end;

        end;

    end;

end;

function loadmulfiles: Boolean;
var
  tempfile: File;

begin
  printsm(10, 'Loading '+ Form1.LabeledEdit1.Text +'...');
  AssignFile(tempfile, Form1.LabeledEdit1.Text);
  Reset(tempfile, 1);
  if FileSize(tempfile) div SizeOf(tcell) = NUMCELLS then
    begin
      SetLength(cells, NUMCELLS);
      BlockRead(tempfile, cells[0], FileSize(tempfile));
      CloseFile(tempfile);
      printatlsm(10, 'done.');

    end

  else
    begin
      CloseFile(tempfile);
      printatlsm(10, 'failed.');
      Result := False;
      Exit;

    end;

  printsm(10, 'Loading '+ Form1.LabeledEdit2.Text +'...');
  AssignFile(tempfile, Form1.LabeledEdit2.Text);
  Reset(tempfile, 1);
  staticcount := FileSize(tempfile) div SizeOf(tstatic);
  if FileSize(tempfile) mod SizeOf(tstatic) = 0 then
    begin
      SetLength(statics, staticcount);
      BlockRead(tempfile, statics[0], FileSize(tempfile));
      CloseFile(tempfile);
      printatlsm(10, 'done.');

    end

  else
    begin
      CloseFile(tempfile);
      printatlsm(10, 'failed.');
      Result := False;
      Exit;

    end;

  printsm(10, 'Loading '+ Form1.LabeledEdit3.Text +'...');
  AssignFile(tempfile, Form1.LabeledEdit3.Text);
  Reset(tempfile, 1);
  statictilecount := ((FileSize(tempfile) - SizeOf(tlandgroup) * NUMLANDGROUPS)
                     div SizeOf(tstaticgroup)) * 32;
  if FileSize(tempfile) >= SizeOf(tlandgroup) * NUMLANDGROUPS then
    begin
      SetLength(landtiles, NUMLANDGROUPS);
      BlockRead(tempfile, landtiles[0], NUMLANDGROUPS * SizeOf(tlandgroup));
      SetLength(statictiles, statictilecount);
      BlockRead(tempfile, statictiles[0], (statictilecount div 32) * SizeOf(tstaticgroup));
      CloseFile(tempfile);
      printatlsm(10, 'done.');

    end

  else
    begin
      CloseFile(tempfile);
      printatlsm(10, 'failed.');
      Result := False;
      Exit;

    end;

  printsm(10, 'Loading '+ Form1.LabeledEdit4.Text +'...');
  AssignFile(tempfile, Form1.LabeledEdit4.Text);
  Reset(tempfile, 1);
  staidxcount := FileSize(tempfile) div SizeOf(tstaidx);
  if FileSize(tempfile) mod SizeOf(tstaidx) = 0 then
    begin
      SetLength(staidxs, staidxcount);
      BlockRead(tempfile, staidxs[0], FileSize(tempfile));
      CloseFile(tempfile);
      printatlsm(10, 'done.');

    end

  else
    begin
      CloseFile(tempfile);
      printatlsm(10, 'failed.');
      Result := False;
      Exit;

    end;

  Result := True;

end;

procedure startserver;
var
  configini: TIniFile;

begin
  Form1.WSocketServer1.Pause;
  startinglock.Acquire;
  starting := True;
  startinglock.Release;
  try
    if not DirectoryExists(ExtractFilePath(Application.ExeName) +'\data') then
      CreateDirectory(PChar(ExtractFilePath(Application.ExeName) +'\data'), nil);

    if not DirectoryExists(ExtractFilePath(Application.ExeName) +'\docs') then
      CreateDirectory(PChar(ExtractFilePath(Application.ExeName) +'\docs'), nil);

    if not DirectoryExists(ExtractFilePath(Application.ExeName) +'\logs') then
      CreateDirectory(PChar(ExtractFilePath(Application.ExeName) +'\logs'), nil);

    if not DirectoryExists(ExtractFilePath(Application.ExeName) +'\scripts') then
      CreateDirectory(PChar(ExtractFilePath(Application.ExeName) +'\scripts'), nil);

    if not DirectoryExists(ExtractFilePath(Application.ExeName) +'\scripts\cmd') then
      CreateDirectory(PChar(ExtractFilePath(Application.ExeName) +'\scripts\cmd'), nil);

    if not DirectoryExists(ExtractFilePath(Application.ExeName) +'\scripts\http') then
      CreateDirectory(PChar(ExtractFilePath(Application.ExeName) +'\scripts\http'), nil);

    if not DirectoryExists(ExtractFilePath(Application.ExeName) +'\scripts\item') then
      CreateDirectory(PChar(ExtractFilePath(Application.ExeName) +'\scripts\item'), nil);

    if not DirectoryExists(ExtractFilePath(Application.ExeName) +'\scripts\misc') then
      CreateDirectory(PChar(ExtractFilePath(Application.ExeName) +'\scripts\misc'), nil);

    if not DirectoryExists(ExtractFilePath(Application.ExeName) +'\scripts\npc') then
      CreateDirectory(PChar(ExtractFilePath(Application.ExeName) +'\scripts\npc'), nil);

    if not DirectoryExists(ExtractFilePath(Application.ExeName) +'\scripts\skill') then
      CreateDirectory(PChar(ExtractFilePath(Application.ExeName) +'\scripts\skill'), nil);

    if not DirectoryExists(ExtractFilePath(Application.ExeName) +'\types') then
      CreateDirectory(PChar(ExtractFilePath(Application.ExeName) +'\types'), nil);

  except
  end;
  printsm(10, 'Starting...');
  try
    datah := tdatah.Create;
    gpropslock := TCriticalSection.Create;
    hidlock := TCriticalSection.Create;
    playerslock := TCriticalSection.Create;
    npcslock := TCriticalSection.Create;
    itemslock := TCriticalSection.Create;
    playerhash := TIntegerHash.Create;
    npchash := TIntegerHash.Create;
    itemhash := TIntegerHash.Create;
    objtypehash := TIntegerHash.Create;
    phashlock := TCriticalSection.Create;
    nhashlock := TCriticalSection.Create;
    ihashlock := TCriticalSection.Create;
    othashlock := TCriticalSection.Create;
    bbpostslock := TCriticalSection.Create;
    SetLength(sthreads, 0);
    sthreadslock := TCriticalSection.Create;
    playersat2dposlock := TCriticalSection.Create;
    npcsat2dposlock := TCriticalSection.Create;
    itemsat2dposlock := TCriticalSection.Create;
    serveractivelock.Acquire;
    serveractive := True;
    serveractivelock.Release;
    if loadmulfiles and loaddata and loadtypes and loadandcompscripts and
       startnpcscripts then
      begin
        Form1.WSocketServer1.Banner := '';
        Form1.WSocketServer1.BannerTooBusy := '';
        Form1.WSocketServer1.Addr := '0.0.0.0';
        Form1.WSocketServer1.Port := '12346';
        Form1.WSocketServer1.ClientClass := tclient;
        Form1.WSocketServer1.Listen;
        configini := TIniFile.Create(ExtractFilePath(Application.ExeName) +
                                     'config.ini');
        if configini.ReadInteger('HTTP Service', 'Use', 0) = 1 then
          begin
            printsm(10, 'Starting HTTP Service...');
            Form1.HttpServer1.Port := configini.ReadString('HTTP Service', 'Port', '80');
            if configini.ReadInteger('HTTP Service', 'Log', 0) = 0 then
              httpservlog := False

            else
              httpservlog := True;

            Form1.HttpServer1.ClientClass := thttpconn;
            SetLength(httpconns, 0);
            try
              httpconnslock := TCriticalSection.Create;
              Form1.HttpServer1.Start;
              printatlsm(10, 'done.');

            except
              httpservlog := False;
              httpconnslock.Free;
              printatlsm(10, 'failed.');

            end;

          end;

        configini.Free;
        printsm(10, '...done.');
        startinglock.Acquire;
        starting := False;
        startinglock.Release;
        Form1.WSocketServer1.Resume;
        Randomize;
        startmiscscript('onstart');

      end

    else
      begin
        printsm(10, '...failed.');
        serveractivelock.Acquire;
        serveractive := False;
        serveractivelock.Release;
        startinglock.Acquire;
        starting := False;
        startinglock.Release;

      end;

  except
    printsm(10, '...failed.');
    datah.Free;
    gpropslock.Free;
    hidlock.Free;
    playerslock.Free;
    npcslock.Free;
    itemslock.Free;
    playerhash.Free;
    npchash.Free;
    itemhash.Free;
    objtypehash.Free;
    phashlock.Free;
    nhashlock.Free;
    ihashlock.Free;
    othashlock.Free;
    bbpostslock.Free;
    sthreadslock.Free;
    playersat2dposlock.Free;
    npcsat2dposlock.Free;
    itemsat2dposlock.Free;
    serveractivelock.Acquire;
    serveractive := False;
    serveractivelock.Release;
    startinglock.Acquire;
    starting := False;
    startinglock.Release;

  end;

end;

function gettile(x, y: Word): ttile;
begin
  if (x >= MAPWIDTH) or (y >= MAPHEIGHT) then
    raise ERangeError.Create('The given coordinates are out of range!')

  else
    Result := cells[(x div 8) * (MAPWIDTH div 8) + (y div 8)].tiles[(x mod 8)
                    + (y mod 8) * 8];

end;

function getworldheight(x, y: Word): ShortInt;
begin
  try
    Result := gettile(x, y).z;

  except
    raise ERangeError.Create('The given coordinates are out of range!')

  end;

end;

function getcellnum(x, y: Word): Word;
begin
  Result := (x div 8) * (MAPWIDTH div 8) + (y div 8);

end;

function getstatic(index: DWord): tstatic;
begin
  if index >= staticcount then
    raise ERangeError.Create('The given index is out of range!')

  else
    Result := statics[index];

end;

function getstaidx(x, y: Word): tstaidx;
begin
  if (x >= MAPWIDTH) or (y >= MAPHEIGHT) then
    raise ERangeError.Create('The given coordinates are out of range!')

  else
    Result := staidxs[getcellnum(x, y)];
    
end;

function getlandtile(tileid: Word): tlandtile;
begin
  Result := landtiles[tileid div 32].landtiles[tileid mod 32];

end;

function getstatictile(tileid: Word): tstatictile;
begin
  Result := statictiles[tileid div 32].statictiles[tileid mod 32];

end;

function getstatictilename(tileid: Word): String;
var
  i: Integer;
  statictile: tstatictile;
  tempstr: String;

begin
  statictile := getstatictile(tileid);
  SetLength(tempstr, 20);
  for i := 0 to 19 do
    tempstr[i + 1] := statictile.namearray[i];

  Result := tempstr;

end;

function getlandtilename(tileid: Word): String;
var
  i: Cardinal;
  landtile: tlandtile;
  tempstr: String;

begin
  landtile := getlandtile(tileid);
  SetLength(tempstr, 20);
  for i := 0 to 19 do
    tempstr[i + 1] := landtile.namearray[i];

  Result := tempstr;

end;

function getstandingheight(x, y: Word; startz: ShortInt): ShortInt;
var
  staidxstart, staidxend, i: Cardinal;
  diff: Integer;
  finalz: ShortInt;
  static: tstatic;
  statictile: tstatictile;

begin
  finalz := getworldheight(x, y);
  if getstaidx(x, y).start <> NOSTATICS then
    begin
       staidxstart := getstaidx(x, y).start div SizeOf(tstatic);
       staidxend := getstaidx(x, y).length div SizeOf(tstatic) + staidxstart;
       for i := staidxstart to staidxend - 1 do
         begin
           static := getstatic(i);
           statictile := getstatictile(static.graphic);
           if (static.x = x mod 8) and (static.y = y mod 8) then
             begin
               diff := static.z + statictile.height - startz;
               if diff >= UPPERZ then
                 Continue;

               if static.z + statictile.height > finalz then
                 finalz := static.z + statictile.height;

             end;

         end;

    end;

  Result := finalz;

end;

function loaddata: Boolean;
var
  tempini: TMemIniFile;
  tempsections: TStringList;
  id, i, cpropcount, contitemcount, gpropcount, j, equitemcount, bbpostcount: Cardinal;

begin
  hidlock.Acquire;
  highestid := 0;
  hidlock.Release;
  printsm(10, 'Loading '+ ExtractFilePath(Application.ExeName) +
          'data\players.ini...');
  tempini := TMemIniFile.Create(ExtractFilePath(Application.ExeName) +'data\players.ini');
  tempsections := TStringList.Create;
  tempini.ReadSections(tempsections);
  playerslock.Acquire;
  SetLength(players, 1);
  playerslock.Release;
  datah.players[0] := tplayer.Create;
  datah.players[0].inaccessible := True;
  if tempsections.Count > 0 then
    begin
      try
        playerslock.Acquire;
        SetLength(players, tempsections.Count + 1);
        playerslock.Release;
        for i := 0 to tempsections.Count - 1 do
          begin
            id := StrToCard(GetSubString(tempsections.Strings[i], 2));
            if tempini.SectionExists('Player '+ CardToStr(id)) then
              begin
                if (id and $0FFFFFFF) <> id then
                  begin
                    printsm(10, 'Maximum ID capacity reached!');
                    tempini.Free;
                    tempsections.Free;
                    printsm(10, '...failed.');
                    Result := False;
                    Exit;

                  end;

                hidlock.Acquire;
                if id > highestid then
                  highestid := id;

                hidlock.Release;
                datah.players[i + 1] := tplayer.Create;
                datah.players[i + 1].id := id;
                datah.players[i + 1].eioc := False;
                datah.players[i + 1].cpoc := False;
                datah.players[i + 1].nouenpcsoc := False;
                datah.players[i + 1].noueplayersoc := False;
                datah.players[i + 1].nouitemsoc := False;
                datah.players[i + 1].ococ := False;
                phashlock.Acquire;
                playerhash[CardToStr(id)] := i + 1;
                phashlock.Release;
                othashlock.Acquire;
                objtypehash[CardToStr(id)] := OTPLAYER;
                othashlock.Release;
                datah.players[i + 1].name := tempini.ReadString('Player '+ CardToStr(id), 'Name',
                                                          '');
                datah.players[i + 1].passw := tempini.ReadString('Player '+ CardToStr(id), 'Password',
                                                           '');
                datah.players[i + 1].realname := tempini.ReadString('Player '+ CardToStr(id), 'Real Name',
                                                              '');
                datah.players[i + 1].homepage := tempini.ReadString('Player '+ CardToStr(id), 'Homepage',
                                                              '');
                datah.players[i + 1].emailaddr := tempini.ReadString('Player '+ CardToStr(id), 'E-Mail Address',
                                                               '');
                datah.players[i + 1].pcinfo := tempini.ReadString('Player '+ CardToStr(id), 'PC Information',
                                                            '');
                datah.players[i + 1].x := tempini.ReadInteger('Player '+ CardToStr(id), 'X', 0);
                datah.players[i + 1].y := tempini.ReadInteger('Player '+ CardToStr(id), 'Y', 0);
                addplayerto2dpos(i + 1, datah.players[i + 1].x, datah.players[i + 1].y);
                datah.players[i + 1].z := tempini.ReadInteger('Player '+ CardToStr(id), 'Z', 0);
                datah.players[i + 1].facing := tempini.ReadInteger('Player '+ CardToStr(id), 'Facing', 0);
                if datah.players[i + 1].facing > 7 then
                  datah.players[i + 1].facing := 0;

                datah.players[i + 1].graphic := tempini.ReadInteger('Player '+ CardToStr(id), 'Graphic', 0);
                datah.players[i + 1].criminal := tempini.ReadInteger('Player '+ CardToStr(id), 'Criminal', 0);
                datah.players[i + 1].sex := tempini.ReadInteger('Player '+ CardToStr(id), 'Sex', 0);
                datah.players[i + 1].dead := tempini.ReadInteger('Player '+ CardToStr(id), 'Dead',
                                                           0);
                datah.players[i + 1].privileged := tempini.ReadInteger('Player '+ CardToStr(id), 'Privileged',
                                                                 0);
                datah.players[i + 1].hidden := tempini.ReadInteger('Player '+ CardToStr(id), 'Hidden',
                                                             0);
                datah.players[i + 1].war := tempini.ReadInteger('Player '+ CardToStr(id), 'War',
                                                          0);
                datah.players[i + 1].str := tempini.ReadInteger('Player '+ CardToStr(id), 'Strength',
                                                          0);
                datah.players[i + 1].dex := tempini.ReadInteger('Player '+ CardToStr(id), 'Dexterity',
                                                          0);
                datah.players[i + 1].int := tempini.ReadInteger('Player '+ CardToStr(id), 'Intelligence',
                                                          0);
                datah.players[i + 1].hits := tempini.ReadInteger('Player '+ CardToStr(id), 'Hits',
                                                           0);
                datah.players[i + 1].mana := tempini.ReadInteger('Player '+ CardToStr(id), 'Mana',
                                                           0);
                datah.players[i + 1].fat := tempini.ReadInteger('Player '+ CardToStr(id), 'Fatigue',
                                                          0);
                datah.players[i + 1].magicdef := tempini.ReadInteger('Player '+ CardToStr(id), 'Magic Defense',
                                                               0);
                datah.players[i + 1].battledef := tempini.ReadInteger('Player '+ CardToStr(id), 'Battle Defense',
                                                                0);
                datah.players[i + 1].stealing := tempini.ReadInteger('Player '+ CardToStr(id), 'Stealing',
                                                               0);
                datah.players[i + 1].hiding := tempini.ReadInteger('Player '+ CardToStr(id), 'Hiding',
                                                             0);
                datah.players[i + 1].firstaid := tempini.ReadInteger('Player '+ CardToStr(id), 'First Aid',
                                                               0);
                datah.players[i + 1].detecttr := tempini.ReadInteger('Player '+ CardToStr(id), 'Detect Trap',
                                                               0);
                datah.players[i + 1].peek := tempini.ReadInteger('Player '+ CardToStr(id), 'Peek',
                                                           0);
                datah.players[i + 1].magic := tempini.ReadInteger('Player '+ CardToStr(id), 'Magic',
                                                            0);
                datah.players[i + 1].melee := tempini.ReadInteger('Player '+ CardToStr(id), 'Melee',
                                                            0);
                datah.players[i + 1].rangedweap := tempini.ReadInteger('Player '+ CardToStr(id), 'Ranged Weapons',
                                                                 0);
                datah.players[i + 1].level := tempini.ReadInteger('Player '+ CardToStr(id), 'Level',
                                                            0);
                datah.players[i + 1].exp := tempini.ReadInteger('Player '+ CardToStr(id), 'Experience',
                                                          0);
                equitemcount := tempini.ReadInteger('Player '+ CardToStr(id), 'Equipped item count', 0);
                if equitemcount > 0 then
                  begin
                    datah.players[i + 1].setequitemslen(equitemcount);
                    for j := 0 to equitemcount - 1 do
                      begin
                        datah.players[i + 1].equitems[j] := tempini.ReadInteger('Player '+ CardToStr(id),
                                                                          'Equipped item '+ CardToStr(j),
                                                                          0);

                      end;

                  end;

                cpropcount := tempini.ReadInteger('Player '+ CardToStr(id), 'CProp count',
                                                  0);
                if cpropcount > 0 then
                  begin
                    datah.players[i + 1].setcpropslen(cpropcount);
                    for j := 0 to cpropcount - 1 do
                      begin
                        datah.players[i + 1].cprops[j].name := tempini.ReadString('Player '+ CardToStr(id),
                                                                            'CProp '+ CardToStr(j)
                                                                            +' name', '');
                        datah.players[i + 1].cprops[j].strval := tempini.ReadString('Player '+ CardToStr(id),
                                                                              'CProp '+ CardToStr(j)
                                                                              +' string value', '');
                        datah.players[i + 1].cprops[j].intval := tempini.ReadInteger('Player '+ CardToStr(id),
                                                                               'CProp '+ CardToStr(j)
                                                                               +' integer value', 0);
                        datah.players[i + 1].cprops[j].cardval := tempini.ReadInteger('Player '+ CardToStr(id),
                                                                                'CProp '+ CardToStr(j)
                                                                                +' cardinal value', 0);

                      end;

                  end;

              end;

          end;

      except
        tempini.Free;
        tempsections.Free;
        printatlsm(10, 'failed.');
        Result := False;
        Exit;

      end;
      tempini.Free;
      tempsections.Free;

    end;

  printatlsm(10, 'done.');
  printsm(10, 'Loading '+ ExtractFilePath(Application.ExeName) +
          'data\npcs.ini...');
  tempini := TMemIniFile.Create(ExtractFilePath(Application.ExeName) +'data\npcs.ini');
  tempsections := TStringList.Create;
  tempini.ReadSections(tempsections);
  npcslock.Acquire;
  SetLength(npcs, 1);
  npcslock.Release;
  datah.npcs[0] := tnpc.Create;
  datah.npcs[0].inaccessible := True;
  if tempsections.Count > 0 then
    begin
      try
        npcslock.Acquire;
        SetLength(npcs, tempsections.Count + 1);
        npcslock.Release;
        for i := 0 to tempsections.Count - 1 do
          begin
            id := StrToCard(GetSubString(tempsections.Strings[i], 2));
            if tempini.SectionExists('NPC '+ CardToStr(id)) then
              begin
                if (id and $0FFFFFFF) <> id then
                  begin
                    printsm(10, 'Maximum ID capacity reached!');
                    tempini.Free;
                    tempsections.Free;
                    printsm(10, '...failed.');
                    Result := False;
                    Exit;

                  end;

                hidlock.Acquire;
                if id > highestid then
                  highestid := id;

                hidlock.Release;
                datah.npcs[i + 1] := tnpc.Create;
                datah.npcs[i + 1].id := id;
                datah.npcs[i + 1].eioc := False;
                datah.npcs[i + 1].cpoc := False;
                datah.npcs[i + 1].eoc := False;
                nhashlock.Acquire;
                npchash[CardToStr(id)] := i + 1;
                nhashlock.Release;
                othashlock.Acquire;
                objtypehash[CardToStr(id)] := OTNPC;
                othashlock.Release;
                datah.npcs[i + 1].name := tempini.ReadString('NPC '+ CardToStr(id), 'Name',
                                                       '');
                datah.npcs[i + 1].scriptname := tempini.ReadString('NPC '+ CardToStr(id), 'Script name',
                                                             '');
                datah.npcs[i + 1].npctype := tempini.ReadInteger('NPC '+ CardToStr(id), 'NPC type', 0);
                datah.npcs[i + 1].sex := tempini.ReadInteger('NPC '+ CardToStr(id), 'Sex', 0);
                datah.npcs[i + 1].x := tempini.ReadInteger('NPC '+ CardToStr(id), 'X', 0);
                datah.npcs[i + 1].y := tempini.ReadInteger('NPC '+ CardToStr(id), 'Y', 0);
                addnpcto2dpos(i + 1, datah.npcs[i + 1].x, datah.npcs[i + 1].y);
                datah.npcs[i + 1].z := tempini.ReadInteger('NPC '+ CardToStr(id), 'Z', 0);
                datah.npcs[i + 1].facing := tempini.ReadInteger('NPC '+ CardToStr(id), 'Facing', 0);
                if datah.npcs[i + 1].facing > 7 then
                  datah.npcs[i + 1].facing := 0;

                datah.npcs[i + 1].graphic := tempini.ReadInteger('NPC '+ CardToStr(id), 'Graphic', 0);
                datah.npcs[i + 1].criminal := tempini.ReadInteger('NPC '+ CardToStr(id), 'Criminal', 0);
                datah.npcs[i + 1].privileged := tempini.ReadInteger('NPC '+ CardToStr(id), 'Privileged',
                                                              0);
                datah.npcs[i + 1].hidden := tempini.ReadInteger('NPC '+ CardToStr(id), 'Hidden',
                                                          0);
                datah.npcs[i + 1].war := tempini.ReadInteger('NPC '+ CardToStr(id), 'War',
                                                       0);
                datah.npcs[i + 1].str := tempini.ReadInteger('NPC '+ CardToStr(id), 'Strength',
                                                       0);
                datah.npcs[i + 1].dex := tempini.ReadInteger('NPC '+ CardToStr(id), 'Dexterity',
                                                       0);
                datah.npcs[i + 1].int := tempini.ReadInteger('NPC '+ CardToStr(id), 'Intelligence',
                                                       0);
                datah.npcs[i + 1].hits := tempini.ReadInteger('NPC '+ CardToStr(id), 'Hits',
                                                        0);
                datah.npcs[i + 1].mana := tempini.ReadInteger('NPC '+ CardToStr(id), 'Mana',
                                                        0);
                datah.npcs[i + 1].fat := tempini.ReadInteger('NPC '+ CardToStr(id), 'Fatigue',
                                                       0);
                datah.npcs[i + 1].magicdef := tempini.ReadInteger('NPC '+ CardToStr(id), 'Magic Defense',
                                                            0);
                datah.npcs[i + 1].battledef := tempini.ReadInteger('NPC '+ CardToStr(id), 'Battle Defense',
                                                             0);
                datah.npcs[i + 1].stealing := tempini.ReadInteger('NPC '+ CardToStr(id), 'Stealing',
                                                            0);
                datah.npcs[i + 1].hiding := tempini.ReadInteger('NPC '+ CardToStr(id), 'Hiding',
                                                          0);
                datah.npcs[i + 1].firstaid := tempini.ReadInteger('NPC '+ CardToStr(id), 'First Aid',
                                                            0);
                datah.npcs[i + 1].detecttr := tempini.ReadInteger('NPC '+ CardToStr(id), 'Detect Trap',
                                                            0);
                datah.npcs[i + 1].peek := tempini.ReadInteger('NPC '+ CardToStr(id), 'Peek',
                                                        0);
                datah.npcs[i + 1].magic := tempini.ReadInteger('NPC '+ CardToStr(id), 'Magic',
                                                         0);
                datah.npcs[i + 1].melee := tempini.ReadInteger('NPC '+ CardToStr(id), 'Melee',
                                                         0);
                datah.npcs[i + 1].rangedweap := tempini.ReadInteger('NPC '+ CardToStr(id), 'Ranged Weapons',
                                                              0);
                datah.npcs[i + 1].level := tempini.ReadInteger('NPC '+ CardToStr(id), 'Level',
                                                         0);
                datah.npcs[i + 1].exp := tempini.ReadInteger('NPC '+ CardToStr(id), 'Experience',
                                                       0);
                equitemcount := tempini.ReadInteger('NPC '+ CardToStr(id), 'Equipped item count', 0);
                if equitemcount > 0 then
                  begin
                    datah.npcs[i + 1].setequitemslen(equitemcount);
                    for j := 0 to equitemcount - 1 do
                      begin
                        datah.npcs[i + 1].equitems[j] := tempini.ReadInteger('NPC '+ CardToStr(id),
                                                                       'Equipped item '+ CardToStr(j),
                                                                       0);

                      end;

                  end;

                cpropcount := tempini.ReadInteger('NPC '+ CardToStr(id), 'CProp count',
                                                  0);
                if cpropcount > 0 then
                  begin
                    datah.npcs[i + 1].setcpropslen(cpropcount);
                    for j := 0 to cpropcount - 1 do
                      begin
                        datah.npcs[i + 1].cprops[j].name := tempini.ReadString('NPC '+ CardToStr(id),
                                                                         'CProp '+ CardToStr(j)
                                                                         +' name', '');
                        datah.npcs[i + 1].cprops[j].strval := tempini.ReadString('NPC '+ CardToStr(id),
                                                                           'CProp '+ CardToStr(j)
                                                                           +' string value', '');
                        datah.npcs[i + 1].cprops[j].intval := tempini.ReadInteger('NPC '+ CardToStr(id),
                                                                            'CProp '+ CardToStr(j)
                                                                            +' integer value', 0);
                        datah.npcs[i + 1].cprops[j].cardval := tempini.ReadInteger('NPC '+ CardToStr(id),
                                                                             'CProp '+ CardToStr(j)
                                                                             +' cardinal value', 0);

                      end;

                  end;

              end;

          end;

      except
        tempini.Free;
        tempsections.Free;
        printatlsm(10, 'failed.');
        Result := False;
        Exit;

      end;
      tempini.Free;
      tempsections.Free;

    end;

  printatlsm(10, 'done.');
  printsm(10, 'Loading '+ ExtractFilePath(Application.ExeName) +
          'data\items.ini...');
  tempini := TMemIniFile.Create(ExtractFilePath(Application.ExeName) +'data\items.ini');
  tempsections := TStringList.Create;
  tempini.ReadSections(tempsections);
  itemslock.Acquire;
  SetLength(items, 1);
  itemslock.Release;
  datah.items[0] := titem.Create;
  datah.items[0].inaccessible := True;
  if tempsections.Count > 0 then
    begin
      try
        itemslock.Acquire;
        SetLength(items, tempsections.Count + 1);
        itemslock.Release;
        for i := 0 to tempsections.Count - 1 do
          begin
            id := StrToCard(GetSubString(tempsections.Strings[i], 2));
            if tempini.SectionExists('Item '+ CardToStr(id)) then
              begin
                if (id and $0FFFFFFF) <> id then
                  begin
                    printsm(10, 'Maximum ID capacity reached!');
                    tempini.Free;
                    tempsections.Free;
                    printsm(10, '...failed.');
                    Result := False;
                    Exit;

                  end;

                hidlock.Acquire;
                if id > highestid then
                  highestid := id;

                hidlock.Release;
                datah.items[i + 1] := titem.Create;
                datah.items[i + 1].id := id;
                datah.items[i + 1].cioc := False;
                datah.items[i + 1].cpoc := False;
                ihashlock.Acquire;
                itemhash[CardToStr(id)] := i + 1;
                ihashlock.Release;
                othashlock.Acquire;
                objtypehash[CardToStr(id)] := OTITEM;
                othashlock.Release;
                datah.items[i + 1].scriptname := tempini.ReadString('Item '+ CardToStr(id), 'Script name',
                                                              '');
                datah.items[i + 1].itemtype := tempini.ReadInteger('Item '+ CardToStr(id), 'Item type', 0);
                datah.items[i + 1].x := tempini.ReadInteger('Item '+ CardToStr(id), 'X', 0);
                datah.items[i + 1].y := tempini.ReadInteger('Item '+ CardToStr(id), 'Y', 0);
                datah.items[i + 1].z := tempini.ReadInteger('Item '+ CardToStr(id), 'Z', 0);
                datah.items[i + 1].dragger := 0;
                datah.items[i + 1].graphic := tempini.ReadInteger('Item '+ CardToStr(id), 'Graphic', 0);
                datah.items[i + 1].definsposx := tempini.ReadInteger('Item '+ CardToStr(id), 'Default insert position X', 0);
                datah.items[i + 1].definsposy := tempini.ReadInteger('Item '+ CardToStr(id), 'Default insert position Y', 0);
                datah.items[i + 1].invisible := tempini.ReadInteger('Item '+ CardToStr(id), 'Invisible', 0);
                datah.items[i + 1].stackable := tempini.ReadInteger('Item '+ CardToStr(id), 'Stackable', 0);
                datah.items[i + 1].moveable := tempini.ReadInteger('Item '+ CardToStr(id), 'Moveable', 1);
                datah.items[i + 1].walkable := tempini.ReadInteger('Item '+ CardToStr(id), 'Walkable', 9);
                datah.items[i + 1].amount := tempini.ReadInteger('Item '+ CardToStr(id), 'Amount', 0);
                datah.items[i + 1].lighting := tempini.ReadInteger('Item '+ CardToStr(id), 'Lighting', 0);
                datah.items[i + 1].color := tempini.ReadInteger('Item '+ CardToStr(id), 'Color', 0);
                datah.items[i + 1].weight := tempini.ReadInteger('Item '+ CardToStr(id), 'Weight', 0);
                datah.items[i + 1].gump := tempini.ReadInteger('Item '+ CardToStr(id), 'Gump', 0);
                datah.items[i + 1].weapon := tempini.ReadInteger('Item '+ CardToStr(id), 'Weapon', 0);
                datah.items[i + 1].weapspeed := tempini.ReadInteger('Item '+ CardToStr(id), 'Weapon speed', 0);
                datah.items[i + 1].weapdamage := tempini.ReadInteger('Item '+ CardToStr(id), 'Weapon damage', 0);
                datah.items[i + 1].armor := tempini.ReadInteger('Item '+ CardToStr(id), 'Armor', 0);
                datah.items[i + 1].armorstr := tempini.ReadInteger('Item '+ CardToStr(id), 'Armor strength', 0);
                datah.items[i + 1].contained := tempini.ReadInteger('Item '+ CardToStr(id), 'Contained', 0);
                datah.items[i + 1].equipped := tempini.ReadInteger('Item '+ CardToStr(id), 'Equipped', 0);
                if (datah.items[i + 1].contained = 0) and (datah.items[i + 1].equipped = 0) then
                  additemto2dpos(i + 1, datah.items[i + 1].x, datah.items[i + 1].y);

                datah.items[i + 1].container := tempini.ReadInteger('Item '+ CardToStr(id), 'Container', 0);
                contitemcount := tempini.ReadInteger('Item '+ CardToStr(id), 'Contained item count', 0);
                if contitemcount > 0 then
                  begin
                    datah.items[i + 1].setcontitemslen(contitemcount);
                    for j := 0 to contitemcount - 1 do
                      begin
                        datah.items[i + 1].contitems[j] := tempini.ReadInteger('Item '+ CardToStr(id),
                                                                         'Contained item '+ CardToStr(j),
                                                                         0);

                      end;

                  end;

                cpropcount := tempini.ReadInteger('Item '+ CardToStr(id), 'CProp count',
                                                  0);
                if cpropcount > 0 then
                  begin
                    datah.items[i + 1].setcpropslen(cpropcount);
                    for j := 0 to cpropcount - 1 do
                      begin
                        datah.items[i + 1].cprops[j].name := tempini.ReadString('Item '+ CardToStr(id),
                                                                          'CProp '+ CardToStr(j)
                                                                          +' name', '');
                        datah.items[i + 1].cprops[j].strval := tempini.ReadString('Item '+ CardToStr(id),
                                                                            'CProp '+ CardToStr(j)
                                                                            +' string value', '');
                        datah.items[i + 1].cprops[j].intval := tempini.ReadInteger('Item '+ CardToStr(id),
                                                                             'CProp '+ CardToStr(j)
                                                                             +' integer value', 0);
                        datah.items[i + 1].cprops[j].cardval := tempini.ReadInteger('Item '+ CardToStr(id),
                                                                              'CProp '+ CardToStr(j)
                                                                              +' cardinal value', 0);

                      end;

                  end;

              end;

          end;

      except
        tempini.Free;
        tempsections.Free;
        printatlsm(10, 'failed.');
        Result := False;
        Exit;

      end;
      tempini.Free;
      tempsections.Free;

    end;

  printatlsm(10, 'done.');
  printsm(10, 'Loading '+ ExtractFilePath(Application.ExeName) +
          'data\gprops.ini...');
  tempini := TMemIniFile.Create(ExtractFilePath(Application.ExeName) +'data\gprops.ini');
  try
    gpropcount := tempini.ReadInteger('GProp count', 'GProp count', 0);
    if gpropcount > 0 then
      begin
        SetLength(gprops, gpropcount);
        for i := 0 to gpropcount - 1 do
          begin
            gprops[i].name := tempini.ReadString('GProp '+ CardToStr(i), 'Name', '');
            gprops[i].strval := tempini.ReadString('GProp '+ CardToStr(i), 'String value',
                                                   '');
            gprops[i].intval := tempini.ReadInteger('GProp '+ CardToStr(i), 'Integer value',
                                                    0);
            gprops[i].cardval := tempini.ReadInteger('GProp '+ CardToStr(i), 'Cardinal value',
                                                     0);

          end;

      end;

    tempini.Free;
    printatlsm(10, 'done.');

  except
    tempini.Free;
    printatlsm(10, 'failed.');
    Result := False;
    Exit;

  end;
  printsm(10, 'Loading '+ ExtractFilePath(Application.ExeName) +
          'data\bbposts.ini...');
  tempini := TMemIniFile.Create(ExtractFilePath(Application.ExeName) +'data\bbposts.ini');
  try
    bbpostcount := tempini.ReadInteger('BB post count', 'BB post count', 0);
    if bbpostcount > 0 then
      begin
        SetLength(bbposts, bbpostcount);
        for i := 0 to bbpostcount - 1 do
          begin
            bbposts[i].subj := tempini.ReadString('BB post '+ CardToStr(i), 'Subject', '');
            bbposts[i].text := tempini.ReadString('BB post '+ CardToStr(i), 'Text', '');

          end;

      end;

    tempini.Free;
    printatlsm(10, 'done.');

  except
    tempini.Free;
    printatlsm(10, 'failed.');
    Result := False;
    Exit;

  end;
  Result := True;

end;

function loadtypes: Boolean;
var
  tempini: TMemIniFile;
  tempsections: TStringList;
  id, i, cpropcount, contitemtypecount, equitemtypecount, j: Cardinal;

begin
  printsm(10, 'Loading '+ ExtractFilePath(Application.ExeName) +
          'types\npcs.ini...');
  tempini := TMemIniFile.Create(ExtractFilePath(Application.ExeName) +'types\npcs.ini');
  tempsections := TStringList.Create;
  tempini.ReadSections(tempsections);
  SetLength(npctypes, 1);
  if tempsections.Count > 0 then
    begin
      try
        SetLength(npctypes, tempsections.Count + 1);
        for i := 0 to tempsections.Count - 1 do
          begin
            id := StrToCard(GetSubString(tempsections.Strings[i], 2));
            if tempini.SectionExists('NPC '+ CardToStr(id)) then
              begin
                if (id and $0FFFFFFF) <> id then
                  begin
                    printsm(10, 'Maximum type ID capacity reached!');
                    tempini.Free;
                    tempsections.Free;
                    printsm(10, '...failed.');
                    Result := False;
                    Exit;

                  end;

                npctypes[i + 1].id := id;
                npctypes[i + 1].name := tempini.ReadString('NPC '+ CardToStr(id), 'Name',
                                                           '');
                npctypes[i + 1].scriptname := tempini.ReadString('NPC '+ CardToStr(id), 'Script name',
                                                                 '');
                npctypes[i + 1].sex := tempini.ReadInteger('NPC '+ CardToStr(id), 'Sex', 0);
                npctypes[i + 1].graphic := tempini.ReadInteger('NPC '+ CardToStr(id), 'Graphic', 0);
                npctypes[i + 1].facing := tempini.ReadInteger('NPC '+ CardToStr(id), 'Facing', 0);
                if npctypes[i + 1].facing > 7 then
                  npctypes[i + 1].facing := 0;

                npctypes[i + 1].criminal := tempini.ReadInteger('NPC '+ CardToStr(id), 'Criminal', 0);
                npctypes[i + 1].privileged := tempini.ReadInteger('NPC '+ CardToStr(id), 'Privileged',
                                                                  0);
                npctypes[i + 1].hidden := tempini.ReadInteger('NPC '+ CardToStr(id), 'Hidden',
                                                              0);
                npctypes[i + 1].war := tempini.ReadInteger('NPC '+ CardToStr(id), 'War',
                                                           0);
                npctypes[i + 1].str := tempini.ReadInteger('NPC '+ CardToStr(id), 'Strength',
                                                           0);
                npctypes[i + 1].dex := tempini.ReadInteger('NPC '+ CardToStr(id), 'Dexterity',
                                                           0);
                npctypes[i + 1].int := tempini.ReadInteger('NPC '+ CardToStr(id), 'Intelligence',
                                                           0);
                npctypes[i + 1].hits := tempini.ReadInteger('NPC '+ CardToStr(id), 'Hits',
                                                            0);
                npctypes[i + 1].mana := tempini.ReadInteger('NPC '+ CardToStr(id), 'Mana',
                                                            0);
                npctypes[i + 1].fat := tempini.ReadInteger('NPC '+ CardToStr(id), 'Fatigue',
                                                           0);
                npctypes[i + 1].magicdef := tempini.ReadInteger('NPC '+ CardToStr(id), 'Magic Defense',
                                                                0);
                npctypes[i + 1].battledef := tempini.ReadInteger('NPC '+ CardToStr(id), 'Battle Defense',
                                                                 0);
                npctypes[i + 1].stealing := tempini.ReadInteger('NPC '+ CardToStr(id), 'Stealing',
                                                                0);
                npctypes[i + 1].hiding := tempini.ReadInteger('NPC '+ CardToStr(id), 'Hiding',
                                                              0);
                npctypes[i + 1].firstaid := tempini.ReadInteger('NPC '+ CardToStr(id), 'First Aid',
                                                                0);
                npctypes[i + 1].detecttr := tempini.ReadInteger('NPC '+ CardToStr(id), 'Detect Trap',
                                                                0);
                npctypes[i + 1].peek := tempini.ReadInteger('NPC '+ CardToStr(id), 'Peek',
                                                            0);
                npctypes[i + 1].magic := tempini.ReadInteger('NPC '+ CardToStr(id), 'Magic',
                                                             0);
                npctypes[i + 1].melee := tempini.ReadInteger('NPC '+ CardToStr(id), 'Melee',
                                                             0);
                npctypes[i + 1].rangedweap := tempini.ReadInteger('NPC '+ CardToStr(id), 'Ranged Weapons',
                                                                  0);
                npctypes[i + 1].level := tempini.ReadInteger('NPC '+ CardToStr(id), 'Level',
                                                             0);
                npctypes[i + 1].exp := tempini.ReadInteger('NPC '+ CardToStr(id), 'Experience',
                                                           0);
                equitemtypecount := tempini.ReadInteger('NPC '+ CardToStr(id), 'Equipped item type count', 0);
                if equitemtypecount > 0 then
                  begin
                    SetLength(npctypes[i + 1].equitemtypes, equitemtypecount);
                    for j := 0 to equitemtypecount - 1 do
                      begin
                        npctypes[i + 1].equitemtypes[j] := tempini.ReadInteger('NPC '+ CardToStr(id),
                                                                               'Equipped item type '+ CardToStr(j),
                                                                               0);

                      end;

                  end;

                cpropcount := tempini.ReadInteger('NPC '+ CardToStr(id), 'CProp count',
                                                  0);
                if cpropcount > 0 then
                  begin
                    SetLength(npctypes[i + 1].cprops, cpropcount);
                    for j := 0 to cpropcount - 1 do
                      begin
                        npctypes[i + 1].cprops[j].name := tempini.ReadString('NPC '+ CardToStr(id),
                                                                             'CProp '+ CardToStr(j)
                                                                             +' name', '');
                        npctypes[i + 1].cprops[j].strval := tempini.ReadString('NPC '+ CardToStr(id),
                                                                               'CProp '+ CardToStr(j)
                                                                               +' string value', '');
                        npctypes[i + 1].cprops[j].intval := tempini.ReadInteger('NPC '+ CardToStr(id),
                                                                                'CProp '+ CardToStr(j)
                                                                                +' integer value', 0);
                        npctypes[i + 1].cprops[j].cardval := tempini.ReadInteger('NPC '+ CardToStr(id),
                                                                                 'CProp '+ CardToStr(j)
                                                                                 +' cardinal value', 0);

                      end;

                  end;

              end;

          end;

      except
        tempini.Free;
        tempsections.Free;
        printatlsm(10, 'failed.');
        Result := False;
        Exit;

      end;
      tempini.Free;
      tempsections.Free;

    end;

  printatlsm(10, 'done.');
  printsm(10, 'Loading '+ ExtractFilePath(Application.ExeName) +
          'types\items.ini...');
  tempini := TMemIniFile.Create(ExtractFilePath(Application.ExeName) +'types\items.ini');
  tempsections := TStringList.Create;
  tempini.ReadSections(tempsections);
  SetLength(itemtypes, 1);
  if tempsections.Count > 0 then
    begin
      try
        SetLength(itemtypes, tempsections.Count + 1);
        for i := 0 to tempsections.Count - 1 do
          begin
            id := StrToCard(GetSubString(tempsections.Strings[i], 2));
            if tempini.SectionExists('Item '+ CardToStr(id)) then
              begin
                if (id and $0FFFFFFF) <> id then
                  begin
                    printsm(10, 'Maximum type ID capacity reached!');
                    tempini.Free;
                    tempsections.Free;
                    printsm(10, '...failed.');
                    Result := False;
                    Exit;

                  end;
                  
                itemtypes[i + 1].id := id;
                itemtypes[i + 1].scriptname := tempini.ReadString('Item '+ CardToStr(id), 'Script name',
                                                                  '');
                itemtypes[i + 1].graphic := tempini.ReadInteger('Item '+ CardToStr(id), 'Graphic', 0);
                itemtypes[i + 1].definsposx := tempini.ReadInteger('Item '+ CardToStr(id), 'Default insert position X', 0);
                itemtypes[i + 1].definsposy := tempini.ReadInteger('Item '+ CardToStr(id), 'Default insert position Y', 0);
                itemtypes[i + 1].invisible := tempini.ReadInteger('Item '+ CardToStr(id), 'Invisible', 0);
                itemtypes[i + 1].stackable := tempini.ReadInteger('Item '+ CardToStr(id), 'Stackable', 0);
                itemtypes[i + 1].moveable := tempini.ReadInteger('Item '+ CardToStr(id), 'Moveable', 1);
                itemtypes[i + 1].walkable := tempini.ReadInteger('Item '+ CardToStr(id), 'Walkable', 9);
                itemtypes[i + 1].amount := tempini.ReadInteger('Item '+ CardToStr(id), 'Amount', 0);
                itemtypes[i + 1].lighting := tempini.ReadInteger('Item '+ CardToStr(id), 'Lighting', 0);
                itemtypes[i + 1].color := tempini.ReadInteger('Item '+ CardToStr(id), 'Color', 0);
                itemtypes[i + 1].weight := tempini.ReadInteger('Item '+ CardToStr(id), 'Weight', 0);
                itemtypes[i + 1].gump := tempini.ReadInteger('Item '+ CardToStr(id), 'Gump', 0);
                itemtypes[i + 1].weapon := tempini.ReadInteger('Item '+ CardToStr(id), 'Weapon', 0);
                itemtypes[i + 1].weapspeed := tempini.ReadInteger('Item '+ CardToStr(id), 'Weapon speed', 0);
                itemtypes[i + 1].weapdamage := tempini.ReadInteger('Item '+ CardToStr(id), 'Weapon damage', 0);
                itemtypes[i + 1].armor := tempini.ReadInteger('Item '+ CardToStr(id), 'Armor', 0);
                itemtypes[i + 1].armorstr := tempini.ReadInteger('Item '+ CardToStr(id), 'Armor strength', 0);
                itemtypes[i + 1].container := tempini.ReadInteger('Item '+ CardToStr(id), 'Container', 0);
                contitemtypecount := tempini.ReadInteger('Item '+ CardToStr(id), 'Contained item type count', 0);
                if contitemtypecount > 0 then
                  begin
                    SetLength(itemtypes[i + 1].contitemtypes, contitemtypecount);
                    for j := 0 to contitemtypecount - 1 do
                      begin
                        itemtypes[i + 1].contitemtypes[j] := tempini.ReadInteger('Item '+ CardToStr(id),
                                                                                 'Contained item type '+ CardToStr(j),
                                                                                 0);

                      end;

                  end;

                cpropcount := tempini.ReadInteger('Item '+ CardToStr(id), 'CProp count',
                                                  0);
                if cpropcount > 0 then
                  begin
                    SetLength(itemtypes[i + 1].cprops, cpropcount);
                    for j := 0 to cpropcount - 1 do
                      begin
                        itemtypes[i + 1].cprops[j].name := tempini.ReadString('Item '+ CardToStr(id),
                                                                              'CProp '+ CardToStr(j)
                                                                              +' name', '');
                        itemtypes[i + 1].cprops[j].strval := tempini.ReadString('Item '+ CardToStr(id),
                                                                                'CProp '+ CardToStr(j)
                                                                                +' string value', '');
                        itemtypes[i + 1].cprops[j].intval := tempini.ReadInteger('Item '+ CardToStr(id),
                                                                                 'CProp '+ CardToStr(j)
                                                                                 +' integer value', 0);
                        itemtypes[i + 1].cprops[j].cardval := tempini.ReadInteger('Item '+ CardToStr(id),
                                                                                  'CProp '+ CardToStr(j)
                                                                                  +' cardinal value', 0);

                      end;

                  end;

              end;

          end;

      except
        tempini.Free;
        tempsections.Free;
        printatlsm(10, 'failed.');
        Result := False;
        Exit;

      end;
      tempini.Free;
      tempsections.Free;

    end;

  printatlsm(10, 'done.');
  Result := True;

end;

function loadandcompscripts: Boolean;
var
  searchrec: TSearchRec;
  searchres: Integer;
  tempstrs: TStrings;
  globalstr, sstr, tempstr, tempname: String;
  globalstrinspos, i, j, scriptcount: Cardinal;
  compiler: TIFPSPascalCompiler;

begin
  compiler := TIFPSPascalCompiler.Create;
  compiler.OnUses := scriptonuses;
  tempstrs := TStringList.Create;
  if FileExists(ExtractFilePath(Application.ExeName) +'scripts\global.pas') then
    begin
      printsm(10, 'Loading '+ ExtractFilePath(Application.ExeName) +
              'scripts\global.pas...');
      tempstrs.LoadFromFile(ExtractFilePath(Application.ExeName) +
                            'scripts\global.pas');
      globalstr := tempstrs.Text +' ';
      printatlsm(10, 'done.');
      printsm(10, 'Checking '+ ExtractFilePath(Application.ExeName) +
              'scripts\global.pas...');
      if compiler.Compile('uses Basic, UOSL, PrimitiveUOSL, HTTP; '+ globalstr +'begin end.') then
        begin
          globalstr := 'uses Basic, UOSL, PrimitiveUOSL, HTTP; '+ globalstr;
          printatlsm(10, 'done.');
        end

      else
        begin
          if compiler.MsgCount > 0 then
            for j := 0 to compiler.MsgCount - 1 do
              begin
                showscripted(ExtractFilePath(Application.ExeName) +
                             'scripts\global.pas', compiler.Msg[j].Pos - 39);
                printsm(10, 'An error occured: '+ compiler.Msg[j].MessageToString
                        +' ('+ CardToStr(compiler.Msg[j].Pos - 39)
                        +').');
                Break;

              end;

          compiler.Free;
          tempstrs.Free;
          printsm(10, '...failed.');
          Result := False;
          Exit;

        end;

    end;

  searchres := FindFirst(ExtractFilePath(Application.ExeName) +'scripts\npc\*.pas',
                         faAnyFile, searchrec);
  if searchres = 0 then
    begin
      scriptcount := 1;
      while searchres = 0 do
        begin
          searchres := FindNext(searchrec);
          if searchres = 0 then
            Inc(scriptcount);

        end;

      SetLength(npcscripts, scriptcount);
      FindFirst(ExtractFilePath(Application.ExeName) +'scripts\npc\*.pas',
                                faAnyFile, searchrec);
      tempstr := searchrec.Name;
      SetLength(tempname, Length(tempstr) - 4);
      Move(tempstr[1], tempname[1], Length(tempstr) - 4);
      npcscripts[0].name := tempname;
      printsm(10, 'Loading '+ ExtractFilePath(Application.ExeName) +
              'scripts\npc\'+ searchrec.Name +'...');
      tempstrs.LoadFromFile(ExtractFilePath(Application.ExeName) +
                            'scripts\npc\'+ searchrec.Name);
      printatlsm(10, 'done.');
      printsm(10, 'Compiling '+ ExtractFilePath(Application.ExeName) +
              'scripts\npc\'+ searchrec.Name +'...');

      sstr := tempstrs.Text;
      globalstrinspos := addglobalstr(globalstr, sstr);
      if compiler.Compile(sstr) then
        begin
          compiler.GetOutput(tempstr);
          npcscripts[0].compstr := tempstr;
          printatlsm(10, 'done.');

        end

      else
        begin
          if compiler.MsgCount > 0 then
            for j := 0 to compiler.MsgCount - 1 do
              begin
                if getrealmsgpos(compiler.Msg[j].Pos, globalstrinspos, globalstr) < 0 then
                  Break;

                showscripted(ExtractFilePath(Application.ExeName) +
                             'scripts\npc\'+ searchrec.Name,
                             getrealmsgpos(compiler.Msg[j].Pos, globalstrinspos, globalstr));
                printsm(10, 'A script compilation error occured: '+ compiler.Msg[j].MessageToString
                        +' ('+ tempname +' (NPC), ' + IntToStr(getrealmsgpos(compiler.Msg[j].Pos, globalstrinspos, globalstr))
                        +').');
                Break;

              end;

          if compiler.MsgCount = 0 then
            begin
              showscripted(ExtractFilePath(Application.ExeName) +
                           'scripts\npc\'+ searchrec.Name, 0);
              printsm(10, 'A script compilation error occured in script: ' + tempname + ' (NPC)!');

            end;

          compiler.Free;
          tempstrs.Free;
          printsm(10, '...failed.');
          Result := False;
          Exit;

        end;

      for i := 1 to scriptcount - 1 do
        begin
          FindNext(searchrec);
          tempstr := searchrec.Name;
          SetLength(tempname, Length(tempstr) - 4);
          Move(tempstr[1], tempname[1], Length(tempstr) - 4);
          npcscripts[i].name := tempname;
          printsm(10, 'Loading '+ ExtractFilePath(Application.ExeName) +
                  'scripts\npc\'+ searchrec.Name +'...');
          tempstrs.LoadFromFile(ExtractFilePath(Application.ExeName)
                                + 'scripts\npc\'+ searchrec.Name);
          printatlsm(10, 'done.');
          printsm(10, 'Compiling '+ ExtractFilePath(Application.ExeName) +
                  'scripts\npc\'+ searchrec.Name +'...');
          sstr := tempstrs.Text;
          globalstrinspos := addglobalstr(globalstr, sstr);
          if compiler.Compile(sstr) then
            begin
              compiler.GetOutput(tempstr);
              npcscripts[i].compstr := tempstr;
              printatlsm(10, 'done.');

            end

          else
            begin
              if compiler.MsgCount > 0 then
                for j := 0 to compiler.MsgCount - 1 do
                  begin
                    if getrealmsgpos(compiler.Msg[j].Pos, globalstrinspos, globalstr) < 0 then
                      Break;

                    showscripted(ExtractFilePath(Application.ExeName) +
                                 'scripts\npc\'+ searchrec.Name,
                                 getrealmsgpos(compiler.Msg[j].Pos, globalstrinspos, globalstr));
                    printsm(10, 'A script compilation error occured: '+ compiler.Msg[j].MessageToString
                            +' ('+ tempname +' (NPC), ' + IntToStr(getrealmsgpos(compiler.Msg[j].Pos, globalstrinspos, globalstr))
                            +').');
                    Break;

                  end;

              if compiler.MsgCount = 0 then
                begin
                  showscripted(ExtractFilePath(Application.ExeName) +
                               'scripts\npc\'+ searchrec.Name, 0);
                  printsm(10, 'A script compilation error occured in script: ' + tempname + ' (NPC)!');

                end;

              compiler.Free;
              tempstrs.Free;
              printsm(10, '...failed.');
              Result := False;
              Exit;

            end;

        end;

    end;

  searchres := FindFirst(ExtractFilePath(Application.ExeName) +'scripts\item\*.pas',
                         faAnyFile, searchrec);
  if searchres = 0 then
    begin
      scriptcount := 1;
      while searchres = 0 do
        begin
          searchres := FindNext(searchrec);
          if searchres = 0 then
            Inc(scriptcount);

        end;

      SetLength(itemscripts, scriptcount);
      FindFirst(ExtractFilePath(Application.ExeName) +'scripts\item\*.pas',
                                faAnyFile, searchrec);
      tempstr := searchrec.Name;
      SetLength(tempname, Length(tempstr) - 4);
      Move(tempstr[1], tempname[1], Length(tempstr) - 4);
      itemscripts[0].name := tempname;
      printsm(10, 'Loading '+ ExtractFilePath(Application.ExeName) +
              'scripts\item\'+ searchrec.Name +'...');
      tempstrs.LoadFromFile(ExtractFilePath(Application.ExeName) +
                            'scripts\item\'+ searchrec.Name);
      printatlsm(10, 'done.');
      printsm(10, 'Compiling '+ ExtractFilePath(Application.ExeName) +
              'scripts\item\'+ searchrec.Name +'...');
      sstr := tempstrs.Text;
      globalstrinspos := addglobalstr(globalstr, sstr);
      if compiler.Compile(sstr) then
        begin
          compiler.GetOutput(tempstr);
          itemscripts[0].compstr := tempstr;
          printatlsm(10, 'done.');

        end

      else
        begin
          if compiler.MsgCount > 0 then
            for j := 0 to compiler.MsgCount - 1 do
              begin
                if getrealmsgpos(compiler.Msg[j].Pos, globalstrinspos, globalstr) < 0 then
                  Break;

                showscripted(ExtractFilePath(Application.ExeName) +
                             'scripts\item\'+ searchrec.Name,
                             getrealmsgpos(compiler.Msg[j].Pos, globalstrinspos, globalstr));
                printsm(10, 'A script compilation error occured: '+ compiler.Msg[j].MessageToString
                        +' ('+ tempname +' (Item), ' + IntToStr(getrealmsgpos(compiler.Msg[j].Pos, globalstrinspos, globalstr))
                        +').');
                Break;

              end;

          if compiler.MsgCount = 0 then
            begin
              showscripted(ExtractFilePath(Application.ExeName) +
                           'scripts\item\'+ searchrec.Name, 0);
              printsm(10, 'A script compilation error occured in script: ' + tempname + ' (Item)!');

            end;

          compiler.Free;
          tempstrs.Free;
          printsm(10, '...failed.');
          Result := False;
          Exit;

        end;

      for i := 1 to scriptcount - 1 do
        begin
          FindNext(searchrec);
          tempstr := searchrec.Name;
          SetLength(tempname, Length(tempstr) - 4);
          Move(tempstr[1], tempname[1], Length(tempstr) - 4);
          itemscripts[i].name := tempname;
          printsm(10, 'Loading '+ ExtractFilePath(Application.ExeName) +
                  'scripts\item\'+ searchrec.Name +'...');
          tempstrs.LoadFromFile(ExtractFilePath(Application.ExeName)
                                + 'scripts\item\'+ searchrec.Name);
          printatlsm(10, 'done.');
          printsm(10, 'Compiling '+ ExtractFilePath(Application.ExeName) +
                  'scripts\item\'+ searchrec.Name +'...');
          sstr := tempstrs.Text;
          globalstrinspos := addglobalstr(globalstr, sstr);
          if compiler.Compile(sstr) then
            begin
              compiler.GetOutput(tempstr);
              itemscripts[i].compstr := tempstr;
              printatlsm(10, 'done.');

            end

          else
            begin
              if compiler.MsgCount > 0 then
                for j := 0 to compiler.MsgCount - 1 do
                  begin
                    if getrealmsgpos(compiler.Msg[j].Pos, globalstrinspos, globalstr) < 0 then
                      Break;

                    showscripted(ExtractFilePath(Application.ExeName) +
                                 'scripts\item\'+ searchrec.Name,
                                 getrealmsgpos(compiler.Msg[j].Pos, globalstrinspos, globalstr));
                    printsm(10, 'A script compilation error occured: '+ compiler.Msg[j].MessageToString
                            +' ('+ tempname +' (Item), ' + IntToStr(getrealmsgpos(compiler.Msg[j].Pos, globalstrinspos, globalstr))
                            +').');
                    Break;

                  end;

              if compiler.MsgCount = 0 then
                begin
                  showscripted(ExtractFilePath(Application.ExeName) +
                               'scripts\item\'+ searchrec.Name, 0);
                  printsm(10, 'A script compilation error occured in script: ' + tempname + ' (Item)!');

                end;


              compiler.Free;
              tempstrs.Free;
              printsm(10, '...failed.');
              Result := False;
              Exit;

            end;

        end;

    end;

  searchres := FindFirst(ExtractFilePath(Application.ExeName) +'scripts\misc\*.pas',
                         faAnyFile, searchrec);
  if searchres = 0 then
    begin
      scriptcount := 1;
      while searchres = 0 do
        begin
          searchres := FindNext(searchrec);
          if searchres = 0 then
            Inc(scriptcount);

        end;

      SetLength(miscscripts, scriptcount);
      FindFirst(ExtractFilePath(Application.ExeName) +'scripts\misc\*.pas',
                                faAnyFile, searchrec);
      tempstr := searchrec.Name;
      SetLength(tempname, Length(tempstr) - 4);
      Move(tempstr[1], tempname[1], Length(tempstr) - 4);
      miscscripts[0].name := tempname;
      printsm(10, 'Loading '+ ExtractFilePath(Application.ExeName) +
              'scripts\misc\'+ searchrec.Name +'...');
      tempstrs.LoadFromFile(ExtractFilePath(Application.ExeName) +
                            'scripts\misc\'+ searchrec.Name);
      printatlsm(10, 'done.');
      printsm(10, 'Compiling '+ ExtractFilePath(Application.ExeName) +
              'scripts\misc\'+ searchrec.Name +'...');
      sstr := tempstrs.Text;
      globalstrinspos := addglobalstr(globalstr, sstr);
      if compiler.Compile(sstr) then
        begin
          compiler.GetOutput(tempstr);
          miscscripts[0].compstr := tempstr;
          printatlsm(10, 'done.');

        end

      else
        begin
          if compiler.MsgCount > 0 then
            for j := 0 to compiler.MsgCount - 1 do
              begin
                if getrealmsgpos(compiler.Msg[j].Pos, globalstrinspos, globalstr) < 0 then
                  Break;

                showscripted(ExtractFilePath(Application.ExeName) +
                             'scripts\misc\'+ searchrec.Name,
                             getrealmsgpos(compiler.Msg[j].Pos, globalstrinspos, globalstr));
                printsm(10, 'A script compilation error occured: '+ compiler.Msg[j].MessageToString
                        +' ('+ tempname +' (Miscellaneous), ' + IntToStr(getrealmsgpos(compiler.Msg[j].Pos, globalstrinspos, globalstr))
                        +').');
                Break;

              end;

          if compiler.MsgCount = 0 then
            begin
              showscripted(ExtractFilePath(Application.ExeName) +
                           'scripts\misc\'+ searchrec.Name, 0);
              printsm(10, 'A script compilation error occured in script: ' + tempname + ' (Miscellaneous)!');

            end;

          compiler.Free;
          tempstrs.Free;
          printsm(10, '...failed.');
          Result := False;
          Exit;

        end;

      for i := 1 to scriptcount - 1 do
        begin
          FindNext(searchrec);
          tempstr := searchrec.Name;
          SetLength(tempname, Length(tempstr) - 4);
          Move(tempstr[1], tempname[1], Length(tempstr) - 4);
          miscscripts[i].name := tempname;
          printsm(10, 'Loading '+ ExtractFilePath(Application.ExeName) +
                  'scripts\misc\'+ searchrec.Name +'...');
          tempstrs.LoadFromFile(ExtractFilePath(Application.ExeName)
                                + 'scripts\misc\'+ searchrec.Name);
          printatlsm(10, 'done.');
          printsm(10, 'Compiling '+ ExtractFilePath(Application.ExeName) +
                  'scripts\misc\'+ searchrec.Name +'...');
          sstr := tempstrs.Text;
          globalstrinspos := addglobalstr(globalstr, sstr);
          if compiler.Compile(sstr) then
            begin
              compiler.GetOutput(tempstr);
              miscscripts[i].compstr := tempstr;
              printatlsm(10, 'done.');

            end

          else
            begin
              if compiler.MsgCount > 0 then
                for j := 0 to compiler.MsgCount - 1 do
                  begin
                    if getrealmsgpos(compiler.Msg[j].Pos, globalstrinspos, globalstr) < 0 then
                      Break;

                    showscripted(ExtractFilePath(Application.ExeName) +
                                 'scripts\misc\'+ searchrec.Name,
                                 getrealmsgpos(compiler.Msg[j].Pos, globalstrinspos, globalstr));
                    printsm(10, 'A script compilation error occured: '+ compiler.Msg[j].MessageToString
                            +' ('+ tempname +' (Miscellaneous), ' + IntToStr(getrealmsgpos(compiler.Msg[j].Pos, globalstrinspos, globalstr))
                            +').');
                    Break;

                  end;

              if compiler.MsgCount = 0 then
                begin
                  showscripted(ExtractFilePath(Application.ExeName) +
                               'scripts\misc\'+ searchrec.Name, 0);
                  printsm(10, 'A script compilation error occured in script: ' + tempname + ' (Miscellaneous)!');

                end;

              compiler.Free;
              tempstrs.Free;
              printsm(10, '...failed.');
              Result := False;
              Exit;

            end;

        end;

    end;

  searchres := FindFirst(ExtractFilePath(Application.ExeName) +'scripts\skill\*.pas',
                         faAnyFile, searchrec);
  if searchres = 0 then
    begin
      scriptcount := 1;
      while searchres = 0 do
        begin
          searchres := FindNext(searchrec);
          if searchres = 0 then
            Inc(scriptcount);

        end;

      SetLength(skillscripts, scriptcount);
      FindFirst(ExtractFilePath(Application.ExeName) +'scripts\skill\*.pas',
                                faAnyFile, searchrec);
      tempstr := searchrec.Name;
      SetLength(tempname, Length(tempstr) - 4);
      Move(tempstr[1], tempname[1], Length(tempstr) - 4);
      skillscripts[0].name := tempname;
      printsm(10, 'Loading '+ ExtractFilePath(Application.ExeName) +
              'scripts\skill\'+ searchrec.Name +'...');
      tempstrs.LoadFromFile(ExtractFilePath(Application.ExeName) +
                            'scripts\skill\'+ searchrec.Name);
      printatlsm(10, 'done.');
      printsm(10, 'Compiling '+ ExtractFilePath(Application.ExeName) +
              'scripts\skill\'+ searchrec.Name +'...');
      sstr := tempstrs.Text;
      globalstrinspos := addglobalstr(globalstr, sstr);
      if compiler.Compile(sstr) then
        begin
          compiler.GetOutput(tempstr);
          skillscripts[0].compstr := tempstr;
          printatlsm(10, 'done.');

        end

      else
        begin
          if compiler.MsgCount > 0 then
            for j := 0 to compiler.MsgCount - 1 do
              begin
                if getrealmsgpos(compiler.Msg[j].Pos, globalstrinspos, globalstr) < 0 then
                  Break;

                showscripted(ExtractFilePath(Application.ExeName) +
                             'scripts\skill\'+ searchrec.Name,
                             getrealmsgpos(compiler.Msg[j].Pos, globalstrinspos, globalstr));
                printsm(10, 'A script compilation error occured: '+ compiler.Msg[j].MessageToString
                        +' ('+ tempname +' (Skill), ' + IntToStr(getrealmsgpos(compiler.Msg[j].Pos, globalstrinspos, globalstr))
                        +').');
                Break;

              end;

          if compiler.MsgCount = 0 then
            begin
              showscripted(ExtractFilePath(Application.ExeName) +
                           'scripts\skill\'+ searchrec.Name, 0);
              printsm(10, 'A script compilation error occured in script: ' + tempname + ' (Skill)!');

            end;

          compiler.Free;
          tempstrs.Free;
          printsm(10, '...failed.');
          Result := False;
          Exit;

        end;

      for i := 1 to scriptcount - 1 do
        begin
          FindNext(searchrec);
          tempstr := searchrec.Name;
          SetLength(tempname, Length(tempstr) - 4);
          Move(tempstr[1], tempname[1], Length(tempstr) - 4);
          skillscripts[i].name := tempname;
          printsm(10, 'Loading '+ ExtractFilePath(Application.ExeName) +
                  'scripts\skill\'+ searchrec.Name +'...');
          tempstrs.LoadFromFile(ExtractFilePath(Application.ExeName)
                                + 'scripts\skill\'+ searchrec.Name);
          printatlsm(10, 'done.');
          printsm(10, 'Compiling '+ ExtractFilePath(Application.ExeName) +
                  'scripts\skill\'+ searchrec.Name +'...');
          sstr := tempstrs.Text;
          globalstrinspos := addglobalstr(globalstr, sstr);
          if compiler.Compile(sstr) then
            begin
              compiler.GetOutput(tempstr);
              skillscripts[i].compstr := tempstr;
              printatlsm(10, 'done.');

            end

          else
            begin
              if compiler.MsgCount > 0 then
                for j := 0 to compiler.MsgCount - 1 do
                  begin
                    if getrealmsgpos(compiler.Msg[j].Pos, globalstrinspos, globalstr) < 0 then
                      Break;

                    showscripted(ExtractFilePath(Application.ExeName) +
                                 'scripts\skill\'+ searchrec.Name,
                                 getrealmsgpos(compiler.Msg[j].Pos, globalstrinspos, globalstr));
                    printsm(10, 'A script compilation error occured: '+ compiler.Msg[j].MessageToString
                            +' ('+ tempname +' (Skill), ' + IntToStr(getrealmsgpos(compiler.Msg[j].Pos, globalstrinspos, globalstr))
                            +').');
                    Break;

                  end;

              if compiler.MsgCount = 0 then
                begin
                  showscripted(ExtractFilePath(Application.ExeName) +
                               'scripts\skill\'+ searchrec.Name, 0);
                  printsm(10, 'A script compilation error occured in script: ' + tempname + ' (Skill)!');

                end;

              compiler.Free;
              tempstrs.Free;
              printsm(10, '...failed.');
              Result := False;
              Exit;

            end;

        end;

    end;

  searchres := FindFirst(ExtractFilePath(Application.ExeName) +'scripts\http\*.pas',
                         faAnyFile, searchrec);
  if searchres = 0 then
    begin
      scriptcount := 1;
      while searchres = 0 do
        begin
          searchres := FindNext(searchrec);
          if searchres = 0 then
            Inc(scriptcount);

        end;

      SetLength(httpscripts, scriptcount);
      FindFirst(ExtractFilePath(Application.ExeName) +'scripts\http\*.pas',
                                faAnyFile, searchrec);
      tempstr := searchrec.Name;
      SetLength(tempname, Length(tempstr) - 4);
      Move(tempstr[1], tempname[1], Length(tempstr) - 4);
      httpscripts[0].name := tempname;
      printsm(10, 'Loading '+ ExtractFilePath(Application.ExeName) +
              'scripts\http\'+ searchrec.Name +'...');
      tempstrs.LoadFromFile(ExtractFilePath(Application.ExeName) +
                                         'scripts\http\'+ searchrec.Name);
      printatlsm(10, 'done.');
      printsm(10, 'Compiling '+ ExtractFilePath(Application.ExeName) +
              'scripts\http\'+ searchrec.Name +'...');
      sstr := tempstrs.Text;
      globalstrinspos := addglobalstr(globalstr, sstr);
      if compiler.Compile(sstr) then
        begin
          compiler.GetOutput(tempstr);
          httpscripts[0].compstr := tempstr;
          printatlsm(10, 'done.');

        end

      else
        begin
          if compiler.MsgCount > 0 then
            for j := 0 to compiler.MsgCount - 1 do
              begin
                if getrealmsgpos(compiler.Msg[j].Pos, globalstrinspos, globalstr) < 0 then
                  Break;

                showscripted(ExtractFilePath(Application.ExeName) +
                             'scripts\http\'+ searchrec.Name,
                             getrealmsgpos(compiler.Msg[j].Pos, globalstrinspos, globalstr));
                printsm(10, 'A script compilation error occured: '+ compiler.Msg[j].MessageToString
                        +' ('+ tempname +' (HTTP), ' + IntToStr(getrealmsgpos(compiler.Msg[j].Pos, globalstrinspos, globalstr))
                        +').');

              end;

          if compiler.MsgCount = 0 then
            begin
              showscripted(ExtractFilePath(Application.ExeName) +
                           'scripts\http\'+ searchrec.Name, 0);
              printsm(10, 'A script compilation error occured in script: ' + tempname + ' (HTTP)!');

            end;

          compiler.Free;
          tempstrs.Free;
          printsm(10, '...failed.');
          Result := False;
          Exit;

        end;

      for i := 1 to scriptcount - 1 do
        begin
          FindNext(searchrec);
          tempstr := searchrec.Name;
          SetLength(tempname, Length(tempstr) - 4);
          Move(tempstr[1], tempname[1], Length(tempstr) - 4);
          httpscripts[i].name := tempname;
          printsm(10, 'Loading '+ ExtractFilePath(Application.ExeName) +
                  'scripts\http\'+ searchrec.Name +'...');
          tempstrs.LoadFromFile(ExtractFilePath(Application.ExeName)
                                + 'scripts\http\'+ searchrec.Name);
          printatlsm(10, 'done.');
          printsm(10, 'Compiling '+ ExtractFilePath(Application.ExeName) +
                  'scripts\http\'+ searchrec.Name +'...');
          sstr := tempstrs.Text;
          globalstrinspos := addglobalstr(globalstr, sstr);
          if compiler.Compile(sstr) then
            begin
              compiler.GetOutput(tempstr);
              httpscripts[i].compstr := tempstr;
              printatlsm(10, 'done.');

            end

          else
            begin
              if compiler.MsgCount > 0 then
                for j := 0 to compiler.MsgCount - 1 do
                  begin
                    if getrealmsgpos(compiler.Msg[j].Pos, globalstrinspos, globalstr) < 0 then
                      Break;

                    showscripted(ExtractFilePath(Application.ExeName) +
                                 'scripts\http\'+ searchrec.Name,
                                 getrealmsgpos(compiler.Msg[j].Pos, globalstrinspos, globalstr));
                    printsm(10, 'A script compilation error occured: '+ compiler.Msg[j].MessageToString
                            +' ('+ tempname +' (HTTP), ' + IntToStr(getrealmsgpos(compiler.Msg[j].Pos, globalstrinspos, globalstr))
                            +').');

                  end;

              if compiler.MsgCount = 0 then
                begin
                  showscripted(ExtractFilePath(Application.ExeName) +
                               'scripts\http\'+ searchrec.Name, 0);
                  printsm(10, 'A script compilation error occured in script: ' + tempname + ' (HTTP)!');

                end;

              compiler.Free;
              tempstrs.Free;
              printsm(10, '...failed.');
              Result := False;
              Exit;

            end;

        end;

    end;

  searchres := FindFirst(ExtractFilePath(Application.ExeName) +'scripts\cmd\*.pas',
                         faAnyFile, searchrec);
  if searchres = 0 then
    begin
      scriptcount := 1;
      while searchres = 0 do
        begin
          searchres := FindNext(searchrec);
          if searchres = 0 then
            Inc(scriptcount);

        end;

      SetLength(cmdscripts, scriptcount);
      FindFirst(ExtractFilePath(Application.ExeName) +'scripts\cmd\*.pas',
                                faAnyFile, searchrec);
      tempstr := searchrec.Name;
      SetLength(tempname, Length(tempstr) - 4);
      Move(tempstr[1], tempname[1], Length(tempstr) - 4);
      cmdscripts[0].name := tempname;
      printsm(10, 'Loading '+ ExtractFilePath(Application.ExeName) +
              'scripts\cmd\'+ searchrec.Name +'...');
      tempstrs.LoadFromFile(ExtractFilePath(Application.ExeName) +
                            'scripts\cmd\'+ searchrec.Name);
      printatlsm(10, 'done.');
      printsm(10, 'Compiling '+ ExtractFilePath(Application.ExeName) +
              'scripts\cmd\'+ searchrec.Name +'...');
      sstr := tempstrs.Text;
      globalstrinspos := addglobalstr(globalstr, sstr);
      if compiler.Compile(sstr) then
        begin
          compiler.GetOutput(tempstr);
          cmdscripts[0].compstr := tempstr;
          printatlsm(10, 'done.');

        end

      else
        begin
          if compiler.MsgCount > 0 then
            for j := 0 to compiler.MsgCount - 1 do
              begin
                if getrealmsgpos(compiler.Msg[j].Pos, globalstrinspos, globalstr) < 0 then
                  Break;

                showscripted(ExtractFilePath(Application.ExeName) +
                             'scripts\cmd\'+ searchrec.Name,
                             getrealmsgpos(compiler.Msg[j].Pos, globalstrinspos, globalstr));
                printsm(10, 'A script compilation error occured: '+ compiler.Msg[j].MessageToString
                        +' ('+ tempname +' (Command), ' + IntToStr(getrealmsgpos(compiler.Msg[j].Pos, globalstrinspos, globalstr))
                        +').');

              end;

          if compiler.MsgCount = 0 then
            begin
              showscripted(ExtractFilePath(Application.ExeName) +
                           'scripts\cmd\'+ searchrec.Name, 0);
              printsm(10, 'A script compilation error occured in script: ' + tempname + ' (Command)!');

            end;

          compiler.Free;
          tempstrs.Free;
          printsm(10, '...failed.');
          Result := False;
          Exit;

        end;

      for i := 1 to scriptcount - 1 do
        begin
          FindNext(searchrec);
          tempstr := searchrec.Name;
          SetLength(tempname, Length(tempstr) - 4);
          Move(tempstr[1], tempname[1], Length(tempstr) - 4);
          cmdscripts[i].name := tempname;
          printsm(10, 'Loading '+ ExtractFilePath(Application.ExeName) +
                  'scripts\cmd\'+ searchrec.Name +'...');
          tempstrs.LoadFromFile(ExtractFilePath(Application.ExeName)
                                + 'scripts\cmd\'+ searchrec.Name);
          printatlsm(10, 'done.');
          printsm(10, 'Compiling '+ ExtractFilePath(Application.ExeName) +
                  'scripts\cmd\'+ searchrec.Name +'...');
          sstr := tempstrs.Text;
          globalstrinspos := addglobalstr(globalstr, sstr);
          if compiler.Compile(sstr) then
            begin
              compiler.GetOutput(tempstr);
              cmdscripts[i].compstr := tempstr;
              printatlsm(10, 'done.');

            end

          else
            begin
              if compiler.MsgCount > 0 then
                for j := 0 to compiler.MsgCount - 1 do
                  begin
                    if getrealmsgpos(compiler.Msg[j].Pos, globalstrinspos, globalstr) < 0 then
                      Break;

                    showscripted(ExtractFilePath(Application.ExeName) +
                                 'scripts\cmd\'+ searchrec.Name,
                                 getrealmsgpos(compiler.Msg[j].Pos, globalstrinspos, globalstr));
                    printsm(10, 'A script compilation error occured: '+ compiler.Msg[j].MessageToString
                            +' ('+ tempname +' (Command), ' + IntToStr(getrealmsgpos(compiler.Msg[j].Pos, globalstrinspos, globalstr))
                            +').');

                  end;

              if compiler.MsgCount = 0 then
                begin
                  showscripted(ExtractFilePath(Application.ExeName) +
                               'scripts\cmd\'+ searchrec.Name, 0);
                  printsm(10, 'A script compilation error occured in script: ' + tempname + ' (Command)!');

                end;

              compiler.Free;
              tempstrs.Free;
              printsm(10, '...failed.');
              Result := False;
              Exit;

            end;

        end;

    end;

  compiler.Free;
  tempstrs.Free;
  Result := True;

end;

function startnpcscripts: Boolean;
var
  i: Cardinal;

begin
  npcslock.Acquire;
  if (Length(npcs) > 1) and (Length(npcscripts) > 0) then
    try
      printsm(10, 'Starting NPC Scripts...');
      for i := 1 to Length(npcs) - 1 do
        startnpcscript(datah.npcs[i].scriptname, CardToStr(i));

      printatlsm(10, 'done.');

    except
      printatlsm(10, 'failed.');
      Result := False;
      Exit;

    end;

  npcslock.Release;
  Result := True;

end;

function savedata: Boolean;
var
  tempini: TMemIniFile;
  i, j: Cardinal;

begin
  Form1.WSocketServer1.Pause;
  savinglock.Acquire;
  saving := True;
  savinglock.Release;
  printsm(10, 'Saving world state...');
  hidlock.Acquire;
  playerslock.Acquire;
  npcslock.Acquire;
  itemslock.Acquire;
  gpropslock.Acquire;
  bbpostslock.Acquire;
  printsm(10, 'Saving '+ ExtractFilePath(Application.ExeName) +
          'data\players.ini...');
  DeleteFile(ExtractFilePath(Application.ExeName) +'data\players.ini');
  tempini := TMemIniFile.Create(ExtractFilePath(Application.ExeName) +'data\players.ini');
  if Length(players) > 1 then
    begin
      try
        for i := 1 to Length(players) - 1 do
          begin
            if datah.players[i].id = 0 then
              Continue;

            while datah.players[i].eioc = True do
              Sleep(1);

            datah.players[i].eioc := True;
            while datah.players[i].cpoc = True do
              Sleep(1);

            datah.players[i].cpoc := True;
            tempini.WriteString('Player '+ CardToStr(datah.players[i].id), 'Name', datah.players[i].name);
            tempini.WriteString('Player '+ CardToStr(datah.players[i].id), 'Password', datah.players[i].passw);
            tempini.WriteString('Player '+ CardToStr(datah.players[i].id), 'Real Name', datah.players[i].realname);
            tempini.WriteString('Player '+ CardToStr(datah.players[i].id), 'Homepage', datah.players[i].homepage);
            tempini.WriteString('Player '+ CardToStr(datah.players[i].id), 'E-Mail Address', datah.players[i].emailaddr);
            tempini.WriteString('Player '+ CardToStr(datah.players[i].id), 'PC Information', datah.players[i].pcinfo);
            tempini.WriteInteger('Player '+ CardToStr(datah.players[i].id), 'X', datah.players[i].x);
            tempini.WriteInteger('Player '+ CardToStr(datah.players[i].id), 'Y', datah.players[i].y);
            tempini.WriteInteger('Player '+ CardToStr(datah.players[i].id), 'Z', datah.players[i].z);
            tempini.WriteInteger('Player '+ CardToStr(datah.players[i].id), 'Facing', datah.players[i].facing);
            tempini.WriteInteger('Player '+ CardToStr(datah.players[i].id), 'Graphic', datah.players[i].graphic);
            tempini.WriteInteger('Player '+ CardToStr(datah.players[i].id), 'Criminal', datah.players[i].criminal);
            tempini.WriteInteger('Player '+ CardToStr(datah.players[i].id), 'Sex', datah.players[i].sex);
            tempini.WriteInteger('Player '+ CardToStr(datah.players[i].id), 'Dead', datah.players[i].dead);
            tempini.WriteInteger('Player '+ CardToStr(datah.players[i].id), 'Privileged', datah.players[i].privileged);
            tempini.WriteInteger('Player '+ CardToStr(datah.players[i].id), 'Hidden', datah.players[i].hidden);
            tempini.WriteInteger('Player '+ CardToStr(datah.players[i].id), 'War', datah.players[i].war);
            tempini.WriteInteger('Player '+ CardToStr(datah.players[i].id), 'Strength', datah.players[i].str);
            tempini.WriteInteger('Player '+ CardToStr(datah.players[i].id), 'Dexterity', datah.players[i].dex);
            tempini.WriteInteger('Player '+ CardToStr(datah.players[i].id), 'Intelligence', datah.players[i].int);
            tempini.WriteInteger('Player '+ CardToStr(datah.players[i].id), 'Hits', datah.players[i].hits);
            tempini.WriteInteger('Player '+ CardToStr(datah.players[i].id), 'Mana', datah.players[i].mana);
            tempini.WriteInteger('Player '+ CardToStr(datah.players[i].id), 'Fatigue', datah.players[i].fat);
            tempini.WriteInteger('Player '+ CardToStr(datah.players[i].id), 'Magic Defense', datah.players[i].magicdef);
            tempini.WriteInteger('Player '+ CardToStr(datah.players[i].id), 'Battle Defense', datah.players[i].battledef);
            tempini.WriteInteger('Player '+ CardToStr(datah.players[i].id), 'Stealing', datah.players[i].stealing);
            tempini.WriteInteger('Player '+ CardToStr(datah.players[i].id), 'Hiding', datah.players[i].hiding);
            tempini.WriteInteger('Player '+ CardToStr(datah.players[i].id), 'First Aid', datah.players[i].firstaid);
            tempini.WriteInteger('Player '+ CardToStr(datah.players[i].id), 'Detect Trap', datah.players[i].detecttr);
            tempini.WriteInteger('Player '+ CardToStr(datah.players[i].id), 'Peek', datah.players[i].peek);
            tempini.WriteInteger('Player '+ CardToStr(datah.players[i].id), 'Magic', datah.players[i].magic);
            tempini.WriteInteger('Player '+ CardToStr(datah.players[i].id), 'Melee', datah.players[i].melee);
            tempini.WriteInteger('Player '+ CardToStr(datah.players[i].id), 'Ranged Weapons', datah.players[i].rangedweap);
            tempini.WriteInteger('Player '+ CardToStr(datah.players[i].id), 'Level', datah.players[i].level);
            tempini.WriteInteger('Player '+ CardToStr(datah.players[i].id), 'Experience', datah.players[i].exp);
            tempini.WriteInteger('Player '+ CardToStr(datah.players[i].id), 'Equipped item count', Length(datah.players[i].equitems));
            if Length(datah.players[i].equitems) > 0 then
              for j := 0 to Length(datah.players[i].equitems) - 1 do
                begin
                  tempini.WriteInteger('Player '+ CardToStr(datah.players[i].id), 'Equipped item '+ CardToStr(j),
                                       datah.players[i].equitems[j]);

                end;

            tempini.WriteInteger('Player '+ CardToStr(datah.players[i].id), 'CProp count', Length(datah.players[i].cprops));
            if Length(datah.players[i].cprops) > 0 then
              for j := 0 to Length(datah.players[i].cprops) - 1 do
                begin
                  tempini.WriteString('Player '+ CardToStr(datah.players[i].id), 'CProp '+ CardToStr(j) +' name',
                                      datah.players[i].cprops[j].name);
                  tempini.WriteString('Player '+ CardToStr(datah.players[i].id), 'CProp '+ CardToStr(j) +' string value',
                                      datah.players[i].cprops[j].strval);
                  tempini.WriteInteger('Player '+ CardToStr(datah.players[i].id), 'CProp '+ CardToStr(j) +' integer value',
                                       datah.players[i].cprops[j].intval);
                  tempini.WriteInteger('Player '+ CardToStr(datah.players[i].id), 'CProp '+ CardToStr(j) +' cardinal value',
                                       datah.players[i].cprops[j].cardval);

                end;

            datah.players[i].eioc := False;
            datah.players[i].cpoc := False;

          end;

      except
        tempini.Free;
        hidlock.Release;
        playerslock.Release;
        npcslock.Release;
        itemslock.Release;
        gpropslock.Release;
        bbpostslock.Release;
        printatlsm(10, 'failed.');
        printsm(10, '...failed.');
        savinglock.Acquire;
        saving := False;
        savinglock.Release;
        Result := False;
        Exit;

      end;

    end;

  tempini.UpdateFile;
  tempini.Free;
  printatlsm(10, 'done.');
  DeleteFile(ExtractFilePath(Application.ExeName) +'data\npcs.ini');
  printsm(10, 'Saving '+ ExtractFilePath(Application.ExeName) +
          'data\npcs.ini...');
  tempini := TMemIniFile.Create(ExtractFilePath(Application.ExeName) +'data\npcs.ini');
  if Length(npcs) > 1 then
    begin
      try
        for i := 1 to Length(npcs) - 1 do
          begin
            if datah.npcs[i].id = 0 then
              Continue;

            while datah.npcs[i].eioc = True do
              Sleep(1);

            datah.npcs[i].eioc := True;
            while datah.npcs[i].cpoc = True do
              Sleep(1);

            datah.npcs[i].cpoc := True;
            tempini.WriteString('NPC '+ CardToStr(datah.npcs[i].id), 'Name', datah.npcs[i].name);
            tempini.WriteString('NPC '+ CardToStr(datah.npcs[i].id), 'Script name', datah.npcs[i].scriptname);
            tempini.WriteInteger('NPC '+ CardToStr(datah.npcs[i].id), 'NPC type', datah.npcs[i].npctype);
            tempini.WriteInteger('NPC '+ CardToStr(datah.npcs[i].id), 'Sex', datah.npcs[i].sex);
            tempini.WriteInteger('NPC '+ CardToStr(datah.npcs[i].id), 'X', datah.npcs[i].x);
            tempini.WriteInteger('NPC '+ CardToStr(datah.npcs[i].id), 'Y', datah.npcs[i].y);
            tempini.WriteInteger('NPC '+ CardToStr(datah.npcs[i].id), 'Z', datah.npcs[i].z);
            tempini.WriteInteger('NPC '+ CardToStr(datah.npcs[i].id), 'Facing', datah.npcs[i].facing);
            tempini.WriteInteger('NPC '+ CardToStr(datah.npcs[i].id), 'Graphic', datah.npcs[i].graphic);
            tempini.WriteInteger('NPC '+ CardToStr(datah.npcs[i].id), 'Criminal', datah.npcs[i].criminal);
            tempini.WriteInteger('NPC '+ CardToStr(datah.npcs[i].id), 'Privileged', datah.npcs[i].privileged);
            tempini.WriteInteger('NPC '+ CardToStr(datah.npcs[i].id), 'Hidden', datah.npcs[i].hidden);
            tempini.WriteInteger('NPC '+ CardToStr(datah.npcs[i].id), 'War', datah.npcs[i].war);
            tempini.WriteInteger('NPC '+ CardToStr(datah.npcs[i].id), 'Strength', datah.npcs[i].str);
            tempini.WriteInteger('NPC '+ CardToStr(datah.npcs[i].id), 'Dexterity', datah.npcs[i].dex);
            tempini.WriteInteger('NPC '+ CardToStr(datah.npcs[i].id), 'Intelligence', datah.npcs[i].int);
            tempini.WriteInteger('NPC '+ CardToStr(datah.npcs[i].id), 'Hits', datah.npcs[i].hits);
            tempini.WriteInteger('NPC '+ CardToStr(datah.npcs[i].id), 'Mana', datah.npcs[i].mana);
            tempini.WriteInteger('NPC '+ CardToStr(datah.npcs[i].id), 'Fatigue', datah.npcs[i].fat);
            tempini.WriteInteger('NPC '+ CardToStr(datah.npcs[i].id), 'Magic Defense', datah.npcs[i].magicdef);
            tempini.WriteInteger('NPC '+ CardToStr(datah.npcs[i].id), 'Battle Defense', datah.npcs[i].battledef);
            tempini.WriteInteger('NPC '+ CardToStr(datah.npcs[i].id), 'Stealing', datah.npcs[i].stealing);
            tempini.WriteInteger('NPC '+ CardToStr(datah.npcs[i].id), 'Hiding', datah.npcs[i].hiding);
            tempini.WriteInteger('NPC '+ CardToStr(datah.npcs[i].id), 'First Aid', datah.npcs[i].firstaid);
            tempini.WriteInteger('NPC '+ CardToStr(datah.npcs[i].id), 'Detect Trap', datah.npcs[i].detecttr);
            tempini.WriteInteger('NPC '+ CardToStr(datah.npcs[i].id), 'Peek', datah.npcs[i].peek);
            tempini.WriteInteger('NPC '+ CardToStr(datah.npcs[i].id), 'Magic', datah.npcs[i].magic);
            tempini.WriteInteger('NPC '+ CardToStr(datah.npcs[i].id), 'Melee', datah.npcs[i].melee);
            tempini.WriteInteger('NPC '+ CardToStr(datah.npcs[i].id), 'Ranged Weapons', datah.npcs[i].rangedweap);
            tempini.WriteInteger('NPC '+ CardToStr(datah.npcs[i].id), 'Level', datah.npcs[i].level);
            tempini.WriteInteger('NPC '+ CardToStr(datah.npcs[i].id), 'Experience', datah.npcs[i].exp);
            tempini.WriteInteger('NPC '+ CardToStr(datah.npcs[i].id), 'Equipped item count', Length(datah.npcs[i].equitems));
            if Length(datah.npcs[i].equitems) > 0 then
              for j := 0 to Length(datah.npcs[i].equitems) - 1 do
                begin
                  tempini.WriteInteger('NPC '+ CardToStr(datah.npcs[i].id), 'Equipped item '+ CardToStr(j),
                                       datah.npcs[i].equitems[j]);

                end;

            tempini.WriteInteger('NPC '+ CardToStr(datah.npcs[i].id), 'CProp count', Length(datah.npcs[i].cprops));
            if Length(datah.npcs[i].cprops) > 0 then
              for j := 0 to Length(datah.npcs[i].cprops) - 1 do
                begin
                  tempini.WriteString('NPC '+ CardToStr(datah.npcs[i].id), 'CProp '+ CardToStr(j) +' name',
                                      datah.npcs[i].cprops[j].name);
                  tempini.WriteString('NPC '+ CardToStr(datah.npcs[i].id), 'CProp '+ CardToStr(j) +' string value',
                                      datah.npcs[i].cprops[j].strval);
                  tempini.WriteInteger('NPC '+ CardToStr(datah.npcs[i].id), 'CProp '+ CardToStr(j) +' integer value',
                                       datah.npcs[i].cprops[j].intval);
                  tempini.WriteInteger('NPC '+ CardToStr(datah.npcs[i].id), 'CProp '+ CardToStr(j) +' cardinal value',
                                       datah.npcs[i].cprops[j].cardval);

                end;

            datah.npcs[i].eioc := False;
            datah.npcs[i].cpoc := False;

          end;

      except
        tempini.Free;
        hidlock.Release;
        playerslock.Release;
        npcslock.Release;
        itemslock.Release;
        gpropslock.Release;
        bbpostslock.Release;
        printatlsm(10, 'failed.');
        printsm(10, '...failed.');
        savinglock.Acquire;
        saving := False;
        savinglock.Release;
        Result := False;
        Exit;

      end;

    end;

  tempini.UpdateFile;
  tempini.Free;
  printatlsm(10, 'done.');
  DeleteFile(ExtractFilePath(Application.ExeName) +'data\items.ini');
  printsm(10, 'Saving '+ ExtractFilePath(Application.ExeName) +
          'data\items.ini...');
  tempini := TMemIniFile.Create(ExtractFilePath(Application.ExeName) +'data\items.ini');
  if Length(items) > 1 then
    begin
      try
        for i := 1 to Length(items) - 1 do
          begin
            if datah.items[i].id = 0 then
              Continue;

            while datah.items[i].cioc = True do
              Sleep(1);

            datah.items[i].cioc := True;
            while datah.items[i].cpoc = True do
              Sleep(1);

            datah.items[i].cpoc := True;
            tempini.WriteString('Item '+ CardToStr(datah.items[i].id), 'Script name', datah.items[i].scriptname);
            tempini.WriteInteger('Item '+ CardToStr(datah.items[i].id), 'Item type', datah.items[i].itemtype);
            tempini.WriteInteger('Item '+ CardToStr(datah.items[i].id), 'X', datah.items[i].x);
            tempini.WriteInteger('Item '+ CardToStr(datah.items[i].id), 'Y', datah.items[i].y);
            tempini.WriteInteger('Item '+ CardToStr(datah.items[i].id), 'Z', datah.items[i].z);
            tempini.WriteInteger('Item '+ CardToStr(datah.items[i].id), 'Graphic', datah.items[i].graphic);
            tempini.WriteInteger('Item '+ CardToStr(datah.items[i].id), 'Default insert position X', datah.items[i].definsposx);
            tempini.WriteInteger('Item '+ CardToStr(datah.items[i].id), 'Default insert position Y', datah.items[i].definsposy);
            tempini.WriteInteger('Item '+ CardToStr(datah.items[i].id), 'Invisible', datah.items[i].invisible);
            tempini.WriteInteger('Item '+ CardToStr(datah.items[i].id), 'Stackable', datah.items[i].stackable);
            tempini.WriteInteger('Item '+ CardToStr(datah.items[i].id), 'Moveable', datah.items[i].moveable);
            tempini.WriteInteger('Item '+ CardToStr(datah.items[i].id), 'Walkable', datah.items[i].walkable);
            tempini.WriteInteger('Item '+ CardToStr(datah.items[i].id), 'Amount', datah.items[i].amount);
            tempini.WriteInteger('Item '+ CardToStr(datah.items[i].id), 'Lighting', datah.items[i].lighting);
            tempini.WriteInteger('Item '+ CardToStr(datah.items[i].id), 'Color', datah.items[i].color);
            tempini.WriteInteger('Item '+ CardToStr(datah.items[i].id), 'Weight', datah.items[i].weight);
            tempini.WriteInteger('Item '+ CardToStr(datah.items[i].id), 'Gump', datah.items[i].gump);
            tempini.WriteInteger('Item '+ CardToStr(datah.items[i].id), 'Weapon', datah.items[i].weapon);
            tempini.WriteInteger('Item '+ CardToStr(datah.items[i].id), 'Weapon speed', datah.items[i].weapspeed);
            tempini.WriteInteger('Item '+ CardToStr(datah.items[i].id), 'Weapon damage', datah.items[i].weapdamage);
            tempini.WriteInteger('Item '+ CardToStr(datah.items[i].id), 'Armor', datah.items[i].armor);
            tempini.WriteInteger('Item '+ CardToStr(datah.items[i].id), 'Armor strength', datah.items[i].armorstr);
            tempini.WriteInteger('Item '+ CardToStr(datah.items[i].id), 'Equipped', datah.items[i].equipped);
            tempini.WriteInteger('Item '+ CardToStr(datah.items[i].id), 'Contained', datah.items[i].contained);
            tempini.WriteInteger('Item '+ CardToStr(datah.items[i].id), 'Container', datah.items[i].container);
            tempini.WriteInteger('Item '+ CardToStr(datah.items[i].id), 'Contained item count', Length(datah.items[i].contitems));
            if Length(datah.items[i].contitems) > 0 then
              for j := 0 to Length(datah.items[i].contitems) - 1 do
                begin
                  tempini.WriteInteger('Item '+ CardToStr(datah.items[i].id), 'Contained item '+ CardToStr(j),
                                       datah.items[i].contitems[j]);

                end;

            tempini.WriteInteger('Item '+ CardToStr(datah.items[i].id), 'CProp count', Length(datah.items[i].cprops));
            if Length(datah.items[i].cprops) > 0 then
              for j := 0 to Length(datah.items[i].cprops) - 1 do
                begin
                  tempini.WriteString('Item '+ CardToStr(datah.items[i].id), 'CProp '+ CardToStr(j) +' name',
                                      datah.items[i].cprops[j].name);
                  tempini.WriteString('Item '+ CardToStr(datah.items[i].id), 'CProp '+ CardToStr(j) +' string value',
                                      datah.items[i].cprops[j].strval);
                  tempini.WriteInteger('Item '+ CardToStr(datah.items[i].id), 'CProp '+ CardToStr(j) +' integer value',
                                       datah.items[i].cprops[j].intval);
                  tempini.WriteInteger('Item '+ CardToStr(datah.items[i].id), 'CProp '+ CardToStr(j) +' cardinal value',
                                       datah.items[i].cprops[j].cardval);

                end;

            datah.items[i].cioc := False;
            datah.items[i].cpoc := False;

          end;

      except
        hidlock.Release;
        playerslock.Release;
        npcslock.Release;
        itemslock.Release;
        gpropslock.Release;
        bbpostslock.Release;
        printatlsm(10, 'failed.');
        printsm(10, '...failed.');
        savinglock.Acquire;
        saving := False;
        savinglock.Release;
        Result := False;
        Exit;

      end;

    end;

  tempini.UpdateFile;
  tempini.Free;
  printatlsm(10, 'done.');
  DeleteFile(ExtractFilePath(Application.ExeName) +'data\gprops.ini');
  printsm(10, 'Saving '+ ExtractFilePath(Application.ExeName) +
          'data\gprops.ini...');
  tempini := TMemIniFile.Create(ExtractFilePath(Application.ExeName) +'data\gprops.ini');
  try
    tempini.WriteInteger('GProp count', 'GProp count', Length(gprops));
    if Length(gprops) > 0 then
      for i := 0 to Length(gprops) - 1 do
        begin
          tempini.WriteString('GProp '+ CardToStr(i), 'Name', gprops[i].name);
          tempini.WriteString('GProp '+ CardToStr(i), 'String value', gprops[i].strval);
          tempini.WriteInteger('GProp '+ CardToStr(i), 'Integer value', gprops[i].intval);
          tempini.WriteInteger('GProp '+ CardToStr(i), 'Cardinal value', gprops[i].cardval);

        end;

    tempini.UpdateFile;
    tempini.Free;
    printatlsm(10, 'done.');

  except
    tempini.Free;
    printatlsm(10, 'failed.');
    printsm(10, '...failed.');
    savinglock.Acquire;
    saving := False;
    savinglock.Release;
    Result := False;
    Exit;

  end;
  DeleteFile(ExtractFilePath(Application.ExeName) +'data\bbposts.ini');
  printsm(10, 'Saving '+ ExtractFilePath(Application.ExeName) +
          'data\bbposts.ini...');
  tempini := TMemIniFile.Create(ExtractFilePath(Application.ExeName) +'data\bbposts.ini');
  try
    tempini.WriteInteger('BB post count', 'BB post count', Length(bbposts));
    if Length(bbposts) > 0 then
      for i := 0 to Length(bbposts) - 1 do
        begin
          tempini.WriteString('BB post '+ CardToStr(i), 'Subject', bbposts[i].subj);
          tempini.WriteString('BB post '+ CardToStr(i), 'Text', bbposts[i].text);

        end;

    tempini.UpdateFile;
    tempini.Free;
    printatlsm(10, 'done.');

  except
    tempini.Free;
    printatlsm(10, 'failed.');
    printsm(10, '...failed.');
    savinglock.Acquire;
    saving := False;
    savinglock.Release;
    Result := False;
    Exit;

  end;
  hidlock.Release;
  playerslock.Release;
  npcslock.Release;
  itemslock.Release;
  gpropslock.Release;
  bbpostslock.Release;
  printsm(10, '...done.');
  savinglock.Acquire;
  saving := False;
  savinglock.Release;
  Form1.WSocketServer1.Resume;
  Result := True;

end;

procedure shutdownserver;
var
  x, y: Word;
  i: Cardinal;

begin
  Form1.WSocketServer1.Pause;
  shuttingdownlock.Acquire;
  shuttingdown := True;
  shuttingdownlock.Release;
  printsm(10, 'Shutting down...');
  sdscriptdonelock.Acquire;
  sdscriptdone := False;
  sdscriptdonelock.Release;
  startmiscscript('onshutdown');
  while not issdscriptdone do
    Sleep(1);

  while bgthread.isprinting do
    Sleep(20);

  printsm(10, 'Stopping HTTP Service...');
  try
    Form1.HttpServer1.Stop;
    httpconnslock.Free;
    httpconnslock := nil;
    httpservlog := False;
    SetLength(httpconns, 0);
    printatlsm(10, 'done.');

  except
    printatlsm(10, 'failed.');

  end;
  printsm(10, 'Stopping server activity...');
  try
    kickop;
    Form1.WSocketServer1.Shutdown(0);
    serveractivelock.Acquire;
    serveractive := False;
    serveractivelock.Release;
    printsm(10, '...done.');

  except
    printsm(10, '...failed.');
    printsm(10, '...failed.');
    shuttingdownlock.Acquire;
    shuttingdown := False;
    shuttingdownlock.Release;
    Exit;

  end;
  savedata;
  printsm(10, 'Erasing memory...');
  hidlock.Acquire;
  highestid := 0;
  playerslock.Acquire;
  for i := 0 to Length(players) - 1 do
    if players[i] <> nil then
      begin
        players[i].Destroy;
        players[i] := nil;

      end;

  SetLength(players, 0);
  npcslock.Acquire;
  for i := 0 to Length(npcs) - 1 do
    if npcs[i] <> nil then
      begin
        npcs[i].Destroy;
        npcs[i] := nil;

      end;

  SetLength(npcs, 0);
  itemslock.Acquire;
  for i := 0 to Length(items) - 1 do
    if items[i] <> nil then
      begin
        items[i].Destroy;
        items[i] := nil;

      end;

  SetLength(items, 0);
  SetLength(npctypes, 0);
  SetLength(itemtypes, 0);
  SetLength(miscscripts, 0);
  SetLength(cmdscripts, 0);
  SetLength(itemscripts, 0);
  SetLength(npcscripts, 0);
  SetLength(httpscripts, 0);
  SetLength(skillscripts, 0);
  terminatesthreads;
  sthreadslock.Acquire;
  SetLength(sthreads, 0);
  playersat2dposlock.Acquire;
  npcsat2dposlock.Acquire;
  itemsat2dposlock.Acquire;
  for x := 0 to MAPWIDTH - 1 do
    for y := 0 to MAPHEIGHT - 1 do
      begin
        SetLength(playersat2dpos[x, y], 0);
        SetLength(npcsat2dpos[x, y], 0);
        SetLength(itemsat2dpos[x, y], 0);

      end;

  playersat2dposlock.Free;
  npcsat2dposlock.Free;
  itemsat2dposlock.Free;
  gpropslock.Free;
  hidlock.Free;
  playerslock.Free;
  npcslock.Free;
  itemslock.Free;
  playerhash.Free;
  npchash.Free;
  itemhash.Free;
  objtypehash.Free;
  phashlock.Free;
  nhashlock.Free;
  ihashlock.Free;
  othashlock.Free;
  bbpostslock.Free;
  datah.Free;
  SetLength(sthreads, 0);
  sthreadslock.Free;
  printatlsm(10, 'done.');
  printsm(10, '...done.');
  shuttingdownlock.Acquire;
  shuttingdown := False;
  shuttingdownlock.Release;
  Form1.WSocketServer1.Resume;

end;

procedure TForm1.Button2Click(Sender: TObject);
var
  threadid: Cardinal;

begin
  if isshuttingdown then
    ShowMessage('Server is already shutting down.')

  else if issaving then
    ShowMessage('Server is saving world state.')

  else if isstarting then
    ShowMessage('Server is starting.')

  else
    if IsServerActive then
      BeginThread(nil, 0, Addr(shutdownserver), nil, 0, threadid)

    else
      ShowMessage('Server is not active.');

end;

procedure startmiscscript(scriptname: String; param1: String = ''; param2: String = '';
                          param3: String = ''; param4: String = ''; param5: String = '');
var
  i: Cardinal;
  screxists: Boolean;

begin
  if scriptname = '' then
    Exit;

  screxists := False;
  if Length(miscscripts) > 0 then
    for i := 0 to Length(miscscripts) - 1 do
      if miscscripts[i].name = scriptname then
        begin
          tscriptthread.Create(miscscripts[i].compstr, scriptname +' (Miscellaneous)',
                               param1, param2, param3, param4, param5);
          screxists := True;
          Break;

        end;

  if not screxists then
    begin
      printsm(10, 'The script "'+ scriptname +'" (Miscellaneous) does not exist!');
      if scriptname = 'onlogout' then
        finishlogout(StrToCard(param1));

      if scriptname = 'onshutdown' then
        begin
          sdscriptdonelock.Acquire;
          sdscriptdone := True;
          sdscriptdonelock.Release;

        end;

    end;

end;

procedure startnpcscript(scriptname: String; param1: String = ''; param2: String = '';
                         param3: String = ''; param4: String = ''; param5: String = '');
var
  i: Cardinal;
  screxists: Boolean;

begin
  if scriptname = '' then
    Exit;

  screxists := False;
  if Length(npcscripts) > 0 then
    for i := 0 to Length(npcscripts) - 1 do
      if npcscripts[i].name = scriptname then
        begin
          tscriptthread.Create(npcscripts[i].compstr, scriptname +' (NPC)',
                               param1, param2, param3, param4, param5);
          screxists := True;
          Break;

        end;

  if not screxists then
    printsm(10, 'The script "'+ scriptname +'" (NPC) does not exist!');

end;

procedure startitemscript(scriptname: String; param1: String = ''; param2: String = '';
                          param3: String = ''; param4: String = ''; param5: String = '');
var
  i: Cardinal;
  screxists: Boolean;

begin
  if scriptname = '' then
    Exit;

  screxists := False;
  if Length(itemscripts) > 0 then
    for i := 0 to Length(itemscripts) - 1 do
      if itemscripts[i].name = scriptname then
        begin
          tscriptthread.Create(itemscripts[i].compstr, scriptname +' (Item)',
                               param1, param2, param3, param4, param5);
          screxists := True;
          Break;

        end;

  if not screxists then
    printsm(10, 'The script "'+ scriptname +'" (Item) does not exist!');

end;

procedure starthttpscript(scriptname: String; param1: String = ''; param2: String = '';
                          param3: String = ''; param4: String = ''; param5: String = '');
var
  i: Cardinal;
  screxists: Boolean;

begin
  if scriptname = '' then
    Exit;

  screxists := False;
  if Length(httpscripts) > 0 then
    for i := 0 to Length(httpscripts) - 1 do
      if httpscripts[i].name = scriptname then
        begin
          tscriptthread.Create(httpscripts[i].compstr, scriptname +' (HTTP)',
                               param1, param2, param3, param4, param5);
          screxists := True;
          Break;

        end;

  if not screxists then
    printsm(10, 'The script "'+ scriptname +'" (HTTP) does not exist!');

end;

procedure startskillscript(scriptname: String; param1: String = ''; param2: String = '';
                           param3: String = ''; param4: String = ''; param5: String = '');
var
  i: Cardinal;
  screxists: Boolean;

begin
  if scriptname = '' then
    Exit;

  screxists := False;
  if Length(skillscripts) > 0 then
    for i := 0 to Length(skillscripts) - 1 do
      if skillscripts[i].name = scriptname then
        begin
          tscriptthread.Create(skillscripts[i].compstr, scriptname +' (Skill)',
                               param1, param2, param3, param4, param5);
          screxists := True;
          Break;

        end;

  if not screxists then
    printsm(10, 'The script "'+ scriptname +'" (Skill) does not exist!');

end;

procedure startcmdscript(scriptname: String; param1: String = ''; param2: String = '';
                          param3: String = ''; param4: String = ''; param5: String = '');
var
  i: Cardinal;
  screxists: Boolean;

begin
  if scriptname = '' then
    Exit;

  screxists := False;
  if Length(cmdscripts) > 0 then
    for i := 0 to Length(cmdscripts) - 1 do
      if cmdscripts[i].name = scriptname then
        begin
          tscriptthread.Create(cmdscripts[i].compstr, scriptname +' (Command)',
                               param1, param2, param3, param4, param5);
          screxists := True;
          Break;

        end;

  if not screxists then
    printsm(10, 'The script "'+ scriptname +'" (Command) does not exist!');

end;

procedure tbgthread.printsm;
var
  nowstr: String;
  logfile: TextFile;

begin
  psmstrslock.Acquire;
  if printsmstrs.Count > 0 then
    begin
      if Length(Form1.RichEdit1.Text) > 10000 then
        Form1.RichEdit1.Lines.Delete(0);

      if Form1.RichEdit1.Lines.Count = 0 then
        Form1.RichEdit1.Text := Form1.RichEdit1.Text + printsmstrs.Strings[0]

      else
        Form1.RichEdit1.Lines.Add(printsmstrs.Strings[0]);
        
      filelock.Acquire;
      nowstr := FormatDateTime('dd-mm-yyyy', Now);
      AssignFile(logfile, ExtractFilePath(Application.ExeName) +'logs\'+ nowstr +'.txt');
      try
        if FileExists(ExtractFilePath(Application.ExeName) +'logs\'+ nowstr +'.txt') then
          Append(logfile)

        else
          Rewrite(logfile);

        if Form1.RichEdit1.Lines.Count > 1 then
          WriteLn(logfile, '');
          
        Write(logfile, printsmstrs.Strings[0]);

      finally
        CloseFile(logfile);

      end;
      filelock.Release;
      printsmstrs.Delete(0);

    end;

  psmstrslock.Release;

end;

procedure tbgthread.printatlsm;
var
  nowstr: String;
  logfile: TextFile;

begin
  patlsmstrslock.Acquire;
  if printatlsmstrs.Count > 0 then
    begin
      if Length(Form1.RichEdit1.Text) > 10000 then
        Form1.RichEdit1.Lines.Delete(0);

      Form1.RichEdit1.Text := Form1.RichEdit1.Text + printatlsmstrs.Strings[0];
      filelock.Acquire;
      nowstr := FormatDateTime('dd-mm-yyyy', Now);
      AssignFile(logfile, ExtractFilePath(Application.ExeName) +'logs\'+ nowstr +'.txt');
      try
        Append(logfile);
        Write(logfile, printatlsmstrs.Strings[0]);

      finally
        CloseFile(logfile);

      end;
      filelock.Release;
      printatlsmstrs.Delete(0);

    end;

  patlsmstrslock.Release;

end;

function tbgthread.isprinting: Boolean;
begin
  psmstrslock.Acquire;
  patlsmstrslock.Acquire;
  if (printsmstrs.Count > 0) or (printatlsmstrs.Count > 0) then
    Result := True

  else
    Result := False;

  psmstrslock.Release;
  patlsmstrslock.Release;

end;

procedure tbgthread.showscripted;
begin
  if showsed then
    begin
      erscriptfn := sseerscriptfn;
      erscripterpos := sseerscripterpos;
      Form2.Show;
      showsed := False;
      sseerscriptfn := '';
      sseerscripterpos := 0;

    end;

end;

procedure tbgthread.Execute;
begin
  FreeOnTerminate := True;
  filelock := TCriticalSection.Create;
  psmstrslock := TCriticalSection.Create;
  printsmstrs := TStringList.Create;
  patlsmstrslock := TCriticalSection.Create;
  printatlsmstrs := TStringList.Create;
  while not Terminated do
    begin
      try
        Synchronize(printsm);
        Synchronize(printatlsm);
        Synchronize(showscripted);
        Sleep(1);

      except
      end;

    end;

  filelock.Free;
  psmstrslock.Free;
  printsmstrs.Free;
  patlsmstrslock.Acquire;
  patlsmstrslock.Free;
  printatlsmstrs.Free;

end;

function scriptonuses(sender: TIFPSPascalCompiler; const name: string): Boolean;
begin
  if name = 'SYSTEM' then
    Result := True

  else if name = 'BASIC' then
    begin
      sender.AddTypeS('DWORD', 'Cardinal;');
      sender.AddTypeS('TARRAYOFBYTE', 'Array of Byte;');
      sender.AddTypeS('TARRAYOFWORD', 'Array of Word;');
      sender.AddTypeS('TARRAYOFCARDINAL', 'Array of Cardinal;');
      sender.AddTypeS('TARRAYOFINTEGER', 'Array of Integer;');
      sender.AddTypeS('TARRAYOFEXTENDED', 'Array of Extended;');
      sender.AddTypeS('TARRAYOFSTRING', 'Array of String;');
      sender.AddDelphiFunction('function GetSubString(MainString: String; SubStringNumber: Integer): String;');
      sender.AddDelphiFunction('function RandomInteger(Limit: Integer): Integer;');
      sender.AddDelphiFunction('function CardToStr(Card: Cardinal): String;');
      sender.AddDelphiFunction('function StrToCard(Str: String): Cardinal;');
      sender.AddDelphiFunction('procedure ScriptSleep(Milliseconds: Cardinal);');
      sender.AddDelphiFunction('function GetDate: Cardinal;');
      sender.AddDelphiFunction('function GetTimeOfDay: Integer;');
      sender.AddDelphiFunction('function ScriptGetTickCount: Cardinal;');
      Result := True;

    end

  else if name = 'HTTP' then
    begin
      sender.AddDelphiFunction('procedure WriteHTML(HTTPConnection: Cardinal; HTML: String);');
      sender.AddDelphiFunction('function QueryParameter(HTTPConnection: Cardinal; Name: String): String;');
      sender.AddDelphiFunction('function QueryIP(HTTPConnection: Cardinal): String;');
      Result := True;

    end

  else if name = 'UOSL' then
    begin
      sender.AddTypeS('TOBJECTREFERENCE', 'record pobjref: Cardinal; objtype: Integer; end;');
      sender.AddTypeS('TOBJECTARRAY', 'Array of TObjectReference;');
      sender.AddTypeS('TEVENT', 'record evtype, intval: Integer; strval: String; cardval: Cardinal; end;');
      sender.AddDelphiFunction('function GetObject(ObjectType: Integer; ID: Cardinal): TObjectReference;');
      sender.AddDelphiFunction('function ListObjects(ObjectType: Integer): TObjectArray;');
      sender.AddDelphiFunction('function ListObjectsNearLocation(ObjectType: Integer; X, Y: Word; Distance: Cardinal): TObjectArray;');
      sender.AddDelphiFunction('function ListObjectsNearLocationAccurate(ObjectType: Integer; X, Y: Word; Z: ShortInt; Distance: Cardinal): TObjectArray;');
      sender.AddDelphiFunction('function GetObjectX(ObjectReference: TObjectReference): Word;');
      sender.AddDelphiFunction('function GetObjectY(ObjectReference: TObjectReference): Word;');
      sender.AddDelphiFunction('function GetObjectZ(ObjectReference: TObjectReference): ShortInt;');
      sender.AddDelphiFunction('function GetEvent(NPC: TObjectReference): TEvent;');
      sender.AddDelphiFunction('procedure SetEvent(NPC: TObjectReference; EventType: Integer; IntegerValue: Integer; StringValue: String; CardinalValue: Cardinal);');
      sender.AddDelphiFunction('procedure EquipItem(ObjectReference, Item: TObjectReference);');
      sender.AddDelphiFunction('procedure UnequipItem(ObjectReference, Item: TObjectReference; X, Y: Word; Z: ShortInt);');
      sender.AddDelphiFunction('function CreateObject(ObjectType: Integer; TypeID: Cardinal; X, Y: Word; Z: ShortInt): TObjectReference;');
      sender.AddDelphiFunction('procedure DeleteObject(ObjectReference: TObjectReference);');
      sender.AddDelphiFunction('procedure InsertItem(Item, Container: TObjectReference; X, Y, Amount: Word);');;
      sender.AddDelphiFunction('procedure OpenContainer(Player, Container: TObjectReference);');
      sender.AddDelphiFunction('procedure RemoveItem(Item, Container: TObjectReference; X, Y: Word; Z: ShortInt; Amount: Word);');
      sender.AddDelphiFunction('function GetMainContainer(Item: TObjectReference): TObjectReference;');
      sender.AddDelphiFunction('procedure SetAmount(Item: TObjectReference; Amount: Word);');
      sender.AddDelphiFunction('function GetSex(ObjectReference: TObjectReference): Integer;');
      sender.AddDelphiFunction('procedure SetColor(Item: TObjectReference; Color: Word);');
      sender.AddDelphiFunction('procedure PlayAnimationPrivate(Player: TObjectReference; ObjectReference: TObjectReference; Animation: Integer);');
      sender.AddDelphiFunction('procedure PlayAnimation(ObjectReference: TObjectReference; Animation: Integer);');
      sender.AddDelphiFunction('function CheckObjectDistance(ObjectReference1, ObjectReference2: TObjectReference): Cardinal;');
      sender.AddDelphiFunction('function CheckObjectToCoordinatesDistance(ObjectReference:  TObjectReference; X, Y: Word; Z: ShortInt): Cardinal;');
      sender.AddDelphiFunction('function GetObjectXMain(ObjectReference: TObjectReference): Word;');
      sender.AddDelphiFunction('function GetObjectYMain(ObjectReference: TObjectReference): Word;');
      sender.AddDelphiFunction('function GetObjectZMain(ObjectReference: TObjectReference): ShortInt;');
      sender.AddDelphiFunction('procedure PlaySoundEffectPrivate(Player: TObjectReference; SoundEffect: Word);');
      sender.AddDelphiFunction('procedure SetLightLevelPrivate(Player: TObjectReference; LightLevel: Byte);');
      sender.AddDelphiFunction('function GetAmount(Item: TObjectReference): Word;');
      sender.AddDelphiFunction('function GetItemType(Item: TObjectReference): Cardinal;');
      sender.AddDelphiFunction('function ListItemsInContainer(Container: TObjectReference): TObjectArray;');
      sender.AddDelphiFunction('procedure SendText(TextType: Integer; ObjectReference, Player: TObjectReference; Text: String; R, G, B: Byte);');
      sender.AddDelphiFunction('function ListEquippedItems(ObjectReference: TObjectReference): TObjectArray;');
      sender.AddDelphiFunction('procedure SetSex(ObjectReference: TObjectReference; Sex: Integer);');
      sender.AddDelphiFunction('function GetGraphic(ObjectReference: TObjectReference): Word;');
      sender.AddDelphiFunction('procedure SetGraphic(ObjectReference: TObjectReference; Graphic: Word);');
      sender.AddDelphiFunction('function GetName(ObjectReference: TObjectReference): String;');
      sender.AddDelphiFunction('procedure SetName(ObjectReference: TObjectReference; Name: String);');
      sender.AddDelphiFunction('function GetFacing(ObjectReference: TObjectReference): Byte;');
      sender.AddDelphiFunction('procedure SetFacing(ObjectReference: TObjectReference; Facing: Byte);');
      sender.AddDelphiFunction('function GetStrength(ObjectReference: TObjectReference): Byte;');
      sender.AddDelphiFunction('procedure SetStrength(ObjectReference: TObjectReference; Strength: Byte);');
      sender.AddDelphiFunction('function GetDexterity(ObjectReference: TObjectReference): Byte;');
      sender.AddDelphiFunction('procedure SetDexterity(ObjectReference: TObjectReference; Dexterity: Byte);');
      sender.AddDelphiFunction('function GetIntelligence(ObjectReference: TObjectReference): Byte;');
      sender.AddDelphiFunction('procedure SetIntelligence(ObjectReference: TObjectReference; Intelligence: Byte);');
      sender.AddDelphiFunction('procedure SetCProp(ObjectReference: TObjectReference; Name, StringValue: String; CardinalValue: Cardinal; IntegerValue: Integer);');
      sender.AddDelphiFunction('function GetCPropStringValue(ObjectReference: TObjectReference; Name: String): String;');
      sender.AddDelphiFunction('function GetCPropCardinalValue(ObjectReference: TObjectReference; Name: String): Cardinal;');
      sender.AddDelphiFunction('function GetCPropIntegerValue(ObjectReference: TObjectReference; Name: String): Integer;');
      sender.AddDelphiFunction('function CPropExists(ObjectReference: TObjectReference; Name: String): Boolean;');
      sender.AddDelphiFunction('procedure EraseCProp(ObjectReference: TObjectReference; Name: String);');
      sender.AddDelphiFunction('function RequestInput(Player: TObjectReference): String;');
      sender.AddDelphiFunction('procedure SetExperience(ObjectReference: TObjectReference; Experience: Cardinal);');
      sender.AddDelphiFunction('procedure SetLevel(ObjectReference: TObjectReference; Level: Byte);');
      sender.AddDelphiFunction('procedure SetSkill(ObjectReference: TObjectReference; Skill: Integer; SkillValue: Byte);');
      sender.AddDelphiFunction('procedure SetHits(ObjectReference: TObjectReference; Hits: Byte);');
      sender.AddDelphiFunction('procedure SetMana(ObjectReference: TObjectReference; Mana: Byte);');
      sender.AddDelphiFunction('procedure SetFatigue(ObjectReference: TObjectReference; Fatigue: Byte);');
      sender.AddDelphiFunction('procedure SetWeight(Item: TObjectReference; Weight: Word);');
      sender.AddDelphiFunction('procedure MoveObject(ObjectReference: TObjectReference; X, Y: Word; Z: ShortInt);');
      sender.AddDelphiFunction('procedure SetWeaponSpeed(Weapon: TObjectReference; WeaponSpeed: Integer);');
      sender.AddDelphiFunction('procedure SetWeaponDamage(Weapon: TObjectReference; WeaponDamage: Integer);');
      sender.AddDelphiFunction('procedure SetArmorStrength(Armor: TObjectReference; ArmorStrength: Integer);');
      sender.AddDelphiFunction('procedure SetMoveable(Item: TObjectReference);');
      sender.AddDelphiFunction('procedure SetUnmoveable(Item: TObjectReference);');
      sender.AddDelphiFunction('procedure SetVisible(Item: TObjectReference);');
      sender.AddDelphiFunction('procedure SetInvisible(Item: TObjectReference);');
      sender.AddDelphiFunction('procedure SetPrivileged(ObjectReference: TObjectReference);');
      sender.AddDelphiFunction('procedure SetUnprivileged(ObjectReference: TObjectReference);');
      sender.AddDelphiFunction('procedure SetUnhidden(ObjectReference: TObjectReference);');
      sender.AddDelphiFunction('procedure SetHidden(ObjectReference: TObjectReference);');
      sender.AddDelphiFunction('procedure SetItemLighting(Item: TObjectReference; Lighting: Byte);');
      sender.AddDelphiFunction('procedure Kick(Player: TObjectReference);');
      sender.AddDelphiFunction('procedure SetPlayerRealName(Player: TObjectReference; RealName: String);');
      sender.AddDelphiFunction('procedure SetPlayerHomepage(Player: TObjectReference; Homepage: String);');
      sender.AddDelphiFunction('procedure SetPlayerEMailAddress(Player: TObjectReference; EMailAddress: String);');
      sender.AddDelphiFunction('procedure SetPlayerPCInfo(Player: TObjectReference; PCInfo: String);');
      sender.AddDelphiFunction('procedure Walk(NPC: TObjectReference; Direction: Byte);');
      sender.AddDelphiFunction('procedure Attack(NPC, ObjectReference: TObjectReference);');
      sender.AddDelphiFunction('procedure SetDead(Player: TObjectReference);');
      sender.AddDelphiFunction('procedure SetAlive(Player: TObjectReference);');
      sender.AddDelphiFunction('function GetNPCType(NPC: TObjectReference): Cardinal;');
      sender.AddDelphiFunction('function GetExperience(ObjectReference: TObjectReference): Cardinal;');
      sender.AddDelphiFunction('function GetLevel(ObjectReference: TObjectReference): Cardinal;');
      sender.AddDelphiFunction('function GetSkill(ObjectReference: TObjectReference; Skill: Integer): Byte;');
      sender.AddDelphiFunction('function IsOnline(Player: TObjectReference): Boolean;');
      sender.AddDelphiFunction('function IsAlive(Player: TObjectReference): Boolean;');
      sender.AddDelphiFunction('function GetHits(ObjectReference: TObjectReference): Byte;');
      sender.AddDelphiFunction('function GetMana(ObjectReference: TObjectReference): Byte;');
      sender.AddDelphiFunction('function GetFatigue(ObjectReference: TObjectReference): Byte;');
      sender.AddDelphiFunction('function IsCriminal(ObjectReference: TObjectReference): Boolean;');
      sender.AddDelphiFunction('function IsAtWar(Player: TObjectReference): Boolean;');
      sender.AddDelphiFunction('function IsContainedIn(Item: TObjectReference): TObjectReference;');
      sender.AddDelphiFunction('function IsEquippedBy(Item: TObjectReference): TObjectReference;');
      sender.AddDelphiFunction('function GetWeight(Item: TObjectReference): Word;');
      sender.AddDelphiFunction('function IsWeapon(Item: TObjectReference): Boolean;');
      sender.AddDelphiFunction('function IsArmor(Item: TObjectReference): Boolean;');
      sender.AddDelphiFunction('function GetWeaponSpeed(Weapon: TObjectReference): Byte;');
      sender.AddDelphiFunction('function GetWeaponDamage(Weapon: TObjectReference): Byte;');
      sender.AddDelphiFunction('function GetArmorStrength(Armor: TObjectReference): Byte;');
      sender.AddDelphiFunction('function IsMoveable(Item: TObjectReference): Boolean;');
      sender.AddDelphiFunction('function IsVisible(Item: TObjectReference): Boolean;');
      sender.AddDelphiFunction('function IsPrivileged(ObjectReference: TObjectReference): Boolean;');
      sender.AddDelphiFunction('function IsUnhidden(ObjectReference: TObjectReference): Boolean;');
      sender.AddDelphiFunction('function IsStackable(Item: TObjectReference): Boolean;');
      sender.AddDelphiFunction('function GetItemLighting(Item: TObjectReference): Byte;');
      sender.AddDelphiFunction('function GetPlayerRealName(Player: TObjectReference): String;');
      sender.AddDelphiFunction('function GetPlayerHomepage(Player: TObjectReference): String;');
      sender.AddDelphiFunction('function GetPlayerEMailAddress(Player: TObjectReference): String;');
      sender.AddDelphiFunction('function GetPlayerPCInfo(Player: TObjectReference): String;');
      sender.AddDelphiFunction('function GetScriptName(ObjectReference: TObjectReference): String;');
      sender.AddDelphiFunction('function IsWalkable(Item: TObjectReference): Byte;');
      sender.AddDelphiFunction('procedure SetWalkable(Item: TObjectReference; Direction: Byte);');
      sender.AddDelphiFunction('procedure OpenOrCloseDoor(Door: TObjectReference; Graphic: Word; XRelative, YRelative: ShortInt);');
      sender.AddDelphiFunction('function GetObjectID(ObjectReference: TObjectReference): Cardinal;');
      sender.AddDelphiFunction('function ListOnlinePlayers: TObjectArray;');
      sender.AddDelphiFunction('function GetColor(Item: TObjectReference): Word;');
      sender.AddDelphiFunction('function GetEquipmentByLayer(ObjectReference: TObjectReference; Layer: Byte): TObjectReference;');
      sender.AddDelphiFunction('procedure PrintServerMessage(ServerMessage: String);');
      sender.AddDelphiFunction('function ObjectExistsByID(ObjectType: Integer; ID: Cardinal): Boolean;');
      sender.AddDelphiFunction('function CheckObjectType(ID: Cardinal): Integer;');
      sender.AddDelphiFunction('function CheckDistance(X1, X2, Y1, Y2: Word; Z1, Z2: ShortInt): Cardinal;');
      sender.AddDelphiFunction('function GetEventType(Event: TEvent): Integer;');
      sender.AddDelphiFunction('function GetEventIntegerValue(Event: TEvent): Integer;');
      sender.AddDelphiFunction('function GetEventStringValue(Event: TEvent): String;');
      sender.AddDelphiFunction('function GetEventCardinalValue(Event: TEvent): Cardinal;');
      sender.AddDelphiFunction('procedure SetLightLevel(LightLevel: Byte);');
      sender.AddDelphiFunction('function CheckLOS(X1, X2, Y1, Y2: Word; Z1, Z2: ShortInt): Boolean;');
      sender.AddDelphiFunction('procedure SetGProp(Name, StringValue: String; CardinalValue: Cardinal; IntegerValue: Integer);');
      sender.AddDelphiFunction('function GetGPropStringValue(Name: String): String;');
      sender.AddDelphiFunction('function GetGPropCardinalValue(Name: String): Cardinal;');
      sender.AddDelphiFunction('function GetGPropIntegerValue(Name: String): Integer;');
      sender.AddDelphiFunction('function GPropExists(Name: String): Boolean;');
      sender.AddDelphiFunction('procedure EraseGProp(Name: String);');
      sender.AddDelphiFunction('procedure SaveWorldState;');
      sender.AddDelphiFunction('procedure ShutDown;');
      sender.AddDelphiFunction('procedure StartScript(ScriptType: Integer; ScriptName, Parameter1, Parameter2, Parameter3, Parameter4, Parameter5: String);');
      sender.AddDelphiFunction('function IsServerActive: Boolean;');
      sender.AddDelphiFunction('function IsContainer(Item: TObjectReference): Boolean;');
      sender.AddDelphiFunction('function GetPrimitiveObjectReference(ObjectReference: TObjectReference): Cardinal;');
      sender.AddDelphiFunction('function GetObjectType(ObjectReference: TObjectReference): Integer;');
      sender.AddDelphiFunction('function GetObjectReference(ObjectType: Integer; PrimitiveObjectReference: Cardinal): TObjectReference;');
      sender.AddDelphiFunction('procedure PlaySoundEffect(X, Y: Word; SoundEffect: Word);');
      sender.AddDelphiFunction('function GetTileGraphic(X, Y: Word): Word;');
      sender.AddDelphiFunction('function GetStaticsGraphics(X, Y: Word; Z: ShortInt): TArrayOfWord;');
      sender.AddDelphiFunction('function GetDirectionTo(FromX, FromY, ToX, ToY: Word): Byte;');
      sender.AddDelphiFunction('function FindItemInContainer(Container: TObjectReference; TypeID: Cardinal; DeepSearch: Boolean): TObjectReference;');
      sender.AddDelphiFunction('procedure Unstack(Item: TObjectReference; X, Y: Word; Z: ShortInt; Amount: Word);');
      sender.AddDelphiFunction('procedure AddByte(var Packet: TArrayOfByte; Value: Byte);');
      sender.AddDelphiFunction('procedure AddWord(var Packet: TArrayOfByte; Value: Word);');
      sender.AddDelphiFunction('procedure AddDWord(var Packet: TArrayOfByte; Value: DWord);');
      sender.AddDelphiFunction('procedure SendPacket(var Packet: TArrayOfByte; Player: TObjectReference);');
      sender.AddDelphiFunction('procedure SetCriminal(ObjectReference: TObjectReference);');
      sender.AddDelphiFunction('procedure SetInnocent(ObjectReference: TObjectReference);');
      sender.AddDelphiFunction('function GetIP(Player: TObjectReference): String;');
      sender.AddDelphiFunction('function ObjectExists(ObjectReference: TObjectReference): Boolean;');
      sender.AddDelphiFunction('procedure PrimitiveSetScriptName(ObjectType: Integer; ObjectReference: Cardinal; ScriptName: String);');
      sender.AddDelphiFunction('procedure SetScriptName(ObjectReference: TObjectReference; ScriptName: String);');
      sender.AddDelphiFunction('procedure PrimitiveSetPassword(Player: Cardinal; Password: String);');
      sender.AddDelphiFunction('procedure SetPassword(Player: TObjectReference; Password: String);');
      sender.AddDelphiFunction('function PrimitiveGetPassword(Player: Cardinal): String;');
      sender.AddDelphiFunction('function GetPassword(Player: TObjectReference): String;');
      sender.AddVariableN('PARAMETER1', 'String');
      sender.AddVariableN('PARAMETER2', 'String');
      sender.AddVariableN('PARAMETER3', 'String');
      sender.AddVariableN('PARAMETER4', 'String');
      sender.AddVariableN('PARAMETER5', 'String');
      sender.AddVariableN('OTNONE', 'Integer');
      sender.AddVariableN('OTALL', 'Integer');
      sender.AddVariableN('OTPLAYER', 'Integer');
      sender.AddVariableN('OTNPC', 'Integer');
      sender.AddVariableN('OTITEM', 'Integer');
      sender.AddVariableN('DFNORTH', 'Integer');
      sender.AddVariableN('DFNORTHEAST', 'Integer');
      sender.AddVariableN('DFEAST', 'Integer');
      sender.AddVariableN('DFSOUTHEAST', 'Integer');
      sender.AddVariableN('DFSOUTH', 'Integer');
      sender.AddVariableN('DFSOUTHWEST', 'Integer');
      sender.AddVariableN('DFWEST', 'Integer');
      sender.AddVariableN('DFNORTHWEST', 'Integer');
      sender.AddVariableN('DFNONE', 'Integer');
      sender.AddVariableN('DFALL', 'Integer');
      sender.AddVariableN('ETNONE', 'Integer');
      sender.AddVariableN('ETDOUBLECLICKED', 'Integer');
      sender.AddVariableN('ETITEMGIVEN', 'Integer');
      sender.AddVariableN('ETATTACKED', 'Integer');
      sender.AddVariableN('ETTALKED', 'Integer');
      sender.AddVariableN('ETMOVED', 'Integer');
      sender.AddVariableN('ETEQUIPPED', 'Integer');
      sender.AddVariableN('ETUNEQUIPPED', 'Integer');
      sender.AddVariableN('ETITEMINSERTED', 'Integer');
      sender.AddVariableN('ETITEMREMOVED', 'Integer');
      sender.AddVariableN('SMALE', 'Integer');
      sender.AddVariableN('SFEMALE', 'Integer');
      sender.AddVariableN('ETSTACKED', 'Integer');
      sender.AddVariableN('ETUNSTACKED', 'Integer');
      sender.AddVariableN('ETINSERTED', 'Integer');
      sender.AddVariableN('ETREMOVED', 'Integer');
      sender.AddVariableN('AATTACK', 'Integer');
      sender.AddVariableN('ADEFEND', 'Integer');
      sender.AddVariableN('SIDLIGHTSOURCE', 'Integer');
      sender.AddVariableN('SIDDARKSOURCE', 'Integer');
      sender.AddVariableN('SIDGREATLIGHT', 'Integer');
      sender.AddVariableN('SIDLIGHT', 'Integer');
      sender.AddVariableN('SIDHEALING', 'Integer');
      sender.AddVariableN('SIDFIREBALL', 'Integer');
      sender.AddVariableN('SIDCREATEFOOD', 'Integer');
      sender.AddVariableN('ITIDCORPSE', 'Integer');
      sender.AddVariableN('ITIDSPELLBOOK', 'Integer');
      sender.AddVariableN('TTSYSTEMMESSAGE', 'Integer');
      sender.AddVariableN('TTSPEECHPRIVATE', 'Integer');
      sender.AddVariableN('TTSPEECH', 'Integer');
      sender.AddVariableN('TTTEXTABOVEPRIVATE', 'Integer');
      sender.AddVariableN('TTTEXTABOVE', 'Integer');
      sender.AddVariableN('ETWALKEDON', 'Integer');
      sender.AddVariableN('LWEAPON', 'Integer');
      sender.AddVariableN('LSHIELD', 'Integer');
      sender.AddVariableN('LPANTS', 'Integer');
      sender.AddVariableN('LSHIRT', 'Integer');
      sender.AddVariableN('LBACKPACK', 'Integer');
      sender.AddVariableN('LHAIR', 'Integer');
      sender.AddVariableN('SKIDMAGICDEFENSE', 'Integer');
      sender.AddVariableN('SKIDBATTLEDEFENSE', 'Integer');
      sender.AddVariableN('SKIDSTEALING', 'Integer');
      sender.AddVariableN('SKIDHIDING', 'Integer');
      sender.AddVariableN('SKIDFIRSTAID', 'Integer');
      sender.AddVariableN('SKIDDETECTTRAP', 'Integer');
      sender.AddVariableN('SKIDPEEK', 'Integer');
      sender.AddVariableN('SKIDMAGIC', 'Integer');
      sender.AddVariableN('SKIDMELEE', 'Integer');
      sender.AddVariableN('SKIDRANGEDWEAPONS', 'Integer');
      sender.AddVariableN('STMISC', 'Integer');
      sender.AddVariableN('STNPC', 'Integer');
      sender.AddVariableN('STITEM', 'Integer');
      sender.AddVariableN('STCMD', 'Integer');
      sender.AddVariableN('STSKILL', 'Integer');
      sender.AddVariableN('DEFINSPOS', 'Integer');
      sender.AddVariableN('ITIDSOLIGHTSOURCE', 'Integer');
      sender.AddVariableN('ITIDSODARKSOURCE', 'Integer');
      sender.AddVariableN('ITIDSOGREATLIGHT', 'Integer');
      sender.AddVariableN('ITIDSOLIGHT', 'Integer');
      sender.AddVariableN('ITIDSOHEALING', 'Integer');
      sender.AddVariableN('ITIDSOFIREBALL', 'Integer');
      sender.AddVariableN('ITIDSOCREATEFOOD', 'Integer');
      Result := True;

    end

  else if name = 'PRIMITIVEUOSL' then
    begin
      sender.AddTypeS('TPRIMITIVEOBJECTARRAY', 'Array of Cardinal;');
      sender.AddDelphiFunction('function PrimitiveGetObject(ObjectType: Integer; ID: Cardinal): Cardinal;');
      sender.AddDelphiFunction('function PrimitiveListObjects(ObjectType: Integer): TPrimitiveObjectArray;');
      sender.AddDelphiFunction('function PrimitiveListObjectsNearLocation(ObjectType: Integer; X, Y: Word; Distance: Cardinal): TPrimitiveObjectArray;');
      sender.AddDelphiFunction('function PrimitiveListObjectsNearLocationAccurate(ObjectType: Integer; X, Y: Word; Z: ShortInt; Distance: Cardinal): TPrimitiveObjectArray;');
      sender.AddDelphiFunction('function PrimitiveGetObjectX(ObjectType: Integer; ObjectReference: Cardinal): Word;');
      sender.AddDelphiFunction('function PrimitiveGetObjectY(ObjectType: Integer; ObjectReference: Cardinal): Word;');
      sender.AddDelphiFunction('function PrimitiveGetObjectZ(ObjectType: Integer; ObjectReference: Cardinal): ShortInt;');
      sender.AddDelphiFunction('function PrimitiveGetEvent(NPC: Cardinal): TEvent;');
      sender.AddDelphiFunction('procedure PrimitiveSetEvent(NPC: Cardinal; EventType: Integer; IntegerValue: Integer; StringValue: String; CardinalValue: Cardinal);');
      sender.AddDelphiFunction('procedure PrimitiveEquipItem(ObjectType: Integer; ObjectReference, Item: Cardinal);');
      sender.AddDelphiFunction('procedure PrimitiveUnequipItem(ObjectType: Integer; ObjectReference, Item: Cardinal; X, Y: Word; Z: ShortInt);');
      sender.AddDelphiFunction('function PrimitiveCreateObject(ObjectType: Integer; TypeID: Cardinal; X, Y: Word; Z: ShortInt): Cardinal;');
      sender.AddDelphiFunction('procedure PrimitiveDeleteObject(ObjectType: Integer; ObjectReference: Cardinal);');
      sender.AddDelphiFunction('procedure PrimitiveInsertItem(Item, Container: Cardinal; X, Y, Amount: Word);');
      sender.AddDelphiFunction('procedure PrimitiveOpenContainer(Player, Container: Cardinal);');
      sender.AddDelphiFunction('procedure PrimitiveRemoveItem(Item, Container: Cardinal; X, Y: Word; Z: ShortInt; Amount: Word);');
      sender.AddDelphiFunction('function PrimitiveGetMainContainer(Item: Cardinal): Cardinal;');
      sender.AddDelphiFunction('procedure PrimitiveSetAmount(Item: Cardinal; Amount: Word);');
      sender.AddDelphiFunction('function PrimitiveGetSex(ObjectType: Integer; ObjectReference: Cardinal): Integer;');
      sender.AddDelphiFunction('procedure PrimitiveSetColor(Item: Cardinal; Color: Word);');
      sender.AddDelphiFunction('procedure PrimitivePlayAnimationPrivate(Player: Cardinal; ObjectType: Integer; ObjectReference: Cardinal; Animation: Integer);');
      sender.AddDelphiFunction('procedure PrimitivePlayAnimation(ObjectType: Integer; ObjectReference: Cardinal; Animation: Integer);');
      sender.AddDelphiFunction('function PrimitiveCheckObjectDistance(ObjectType1: Integer; ObjectReference1: Cardinal; ObjectType2: Integer; ObjectReference2: Cardinal): Cardinal;');
      sender.AddDelphiFunction('function PrimitiveCheckObjectToCoordinatesDistance(ObjectType: Integer; ObjectReference: Cardinal; X, Y: Word; Z: ShortInt): Cardinal;');
      sender.AddDelphiFunction('function PrimitiveGetObjectXMain(ObjectType: Integer; ObjectReference: Cardinal): Word;');
      sender.AddDelphiFunction('function PrimitiveGetObjectYMain(ObjectType: Integer; ObjectReference: Cardinal): Word;');
      sender.AddDelphiFunction('function PrimitiveGetObjectZMain(ObjectType: Integer; ObjectReference: Cardinal): ShortInt;');
      sender.AddDelphiFunction('procedure PrimitivePlaySoundEffectPrivate(Player: Cardinal; SoundEffect: Word);');
      sender.AddDelphiFunction('procedure PrimitiveSetLightLevelPrivate(Player: Cardinal; LightLevel: Byte);');
      sender.AddDelphiFunction('function PrimitiveGetAmount(Item: Cardinal): Word;');
      sender.AddDelphiFunction('function PrimitiveGetItemType(Item: Cardinal): Cardinal;');
      sender.AddDelphiFunction('function PrimitiveListItemsInContainer(Container: Cardinal): TPrimitiveObjectArray;');
      sender.AddDelphiFunction('procedure PrimitiveSendText(TextType, ObjectType: Integer; ObjectReference, Player: Cardinal; Text: String; R, G, B: Byte);');
      sender.AddDelphiFunction('function PrimitiveListEquippedItems(ObjectType: Integer; ObjectReference: Cardinal): TPrimitiveObjectArray;');
      sender.AddDelphiFunction('procedure PrimitiveSetSex(ObjectType: Integer; ObjectReference: Cardinal; Sex: Integer);');
      sender.AddDelphiFunction('function PrimitiveGetGraphic(ObjectType: Integer; ObjectReference: Cardinal): Word;');
      sender.AddDelphiFunction('procedure PrimitiveSetGraphic(ObjectType: Integer; ObjectReference: Cardinal; Graphic: Word);');
      sender.AddDelphiFunction('function PrimitiveGetName(ObjectType: Integer; ObjectReference: Cardinal): String;');
      sender.AddDelphiFunction('procedure PrimitiveSetName(ObjectType: Integer; ObjectReference: Cardinal; Name: String);');
      sender.AddDelphiFunction('function PrimitiveGetFacing(ObjectType: Integer; ObjectReference: Cardinal): Byte;');
      sender.AddDelphiFunction('procedure PrimitiveSetFacing(ObjectType: Integer; ObjectReference: Cardinal; Facing: Byte);');
      sender.AddDelphiFunction('function PrimitiveGetStrength(ObjectType: Integer; ObjectReference: Cardinal): Byte;');
      sender.AddDelphiFunction('procedure PrimitiveSetStrength(ObjectType: Integer; ObjectReference: Cardinal; Strength: Byte);');
      sender.AddDelphiFunction('function PrimitiveGetDexterity(ObjectType: Integer; ObjectReference: Cardinal): Byte;');
      sender.AddDelphiFunction('procedure PrimitiveSetDexterity(ObjectType: Integer; ObjectReference: Cardinal; Dexterity: Byte);');
      sender.AddDelphiFunction('function PrimitiveGetIntelligence(ObjectType: Integer; ObjectReference: Cardinal): Byte;');
      sender.AddDelphiFunction('procedure PrimitiveSetIntelligence(ObjectType: Integer; ObjectReference: Cardinal; Intelligence: Byte);');
      sender.AddDelphiFunction('procedure PrimitiveSetCProp(ObjectType: Integer; ObjectReference: Cardinal; Name, StringValue: String; CardinalValue: Cardinal; IntegerValue: Integer);');
      sender.AddDelphiFunction('function PrimitiveGetCPropStringValue(ObjectType: Integer; ObjectReference: Cardinal; Name: String): String;');
      sender.AddDelphiFunction('function PrimitiveGetCPropCardinalValue(ObjectType: Integer; ObjectReference: Cardinal; Name: String): Cardinal;');
      sender.AddDelphiFunction('function PrimitiveGetCPropIntegerValue(ObjectType: Integer; ObjectReference: Cardinal; Name: String): Integer;');
      sender.AddDelphiFunction('function PrimitiveCPropExists(ObjectType: Integer; ObjectReference: Cardinal; Name: String): Boolean;');
      sender.AddDelphiFunction('procedure PrimitiveEraseCProp(ObjectType: Integer; ObjectReference: Cardinal; Name: String);');
      sender.AddDelphiFunction('function PrimitiveRequestInput(Player: Cardinal): String;');
      sender.AddDelphiFunction('procedure PrimitiveSetExperience(ObjectType: Integer; ObjectReference: Cardinal; Experience: Word);');
      sender.AddDelphiFunction('procedure PrimitiveSetLevel(ObjectType: Integer; ObjectReference: Cardinal; Level: Byte);');
      sender.AddDelphiFunction('procedure PrimitiveSetSkill(ObjectType: Integer; ObjectReference: Cardinal; Skill: Integer; SkillValue: Byte);');
      sender.AddDelphiFunction('procedure PrimitiveSetHits(ObjectType: Integer; ObjectReference: Cardinal; Hits: Byte);');
      sender.AddDelphiFunction('procedure PrimitiveSetMana(ObjectType: Integer; ObjectReference: Cardinal; Mana: Byte);');
      sender.AddDelphiFunction('procedure PrimitiveSetFatigue(ObjectType: Integer; ObjectReference: Cardinal; Fatigue: Byte);');
      sender.AddDelphiFunction('procedure PrimitiveSetWeight(Item: Cardinal; Weight: Word);');
      sender.AddDelphiFunction('procedure PrimitiveMoveObject(ObjectType: Integer; ObjectReference: Cardinal; X, Y: Word; Z: ShortInt);');
      sender.AddDelphiFunction('procedure PrimitiveSetWeaponSpeed(Weapon: Cardinal; WeaponSpeed: Integer);');
      sender.AddDelphiFunction('procedure PrimitiveSetWeaponDamage(Weapon: Cardinal; WeaponDamage: Integer);');
      sender.AddDelphiFunction('procedure PrimitiveSetArmorStrength(Armor: Cardinal; ArmorStrength: Integer);');
      sender.AddDelphiFunction('procedure PrimitiveSetMoveable(Item: Cardinal);');
      sender.AddDelphiFunction('procedure PrimitiveSetUnmoveable(Item: Cardinal);');
      sender.AddDelphiFunction('procedure PrimitiveSetVisible(Item: Cardinal);');
      sender.AddDelphiFunction('procedure PrimitiveSetInvisible(Item: Cardinal);');
      sender.AddDelphiFunction('procedure PrimitiveSetPrivileged(ObjectType: Integer; ObjectReference: Cardinal);');
      sender.AddDelphiFunction('procedure PrimitiveSetUnprivileged(ObjectType: Integer; ObjectReference: Cardinal);');
      sender.AddDelphiFunction('procedure PrimitiveSetUnhidden(ObjectType: Integer; ObjectReference: Cardinal);');
      sender.AddDelphiFunction('procedure PrimitiveSetHidden(ObjectType: Integer; ObjectReference: Cardinal);');
      sender.AddDelphiFunction('procedure PrimitiveSetItemLighting(Item: Cardinal; Lighting: Byte);');
      sender.AddDelphiFunction('procedure PrimitiveKick(Player: Cardinal);');
      sender.AddDelphiFunction('procedure PrimitiveSetPlayerRealName(Player: Cardinal; RealName: String);');
      sender.AddDelphiFunction('procedure PrimitiveSetPlayerHomepage(Player: Cardinal; Homepage: String);');
      sender.AddDelphiFunction('procedure PrimitiveSetPlayerEMailAddress(Player: Cardinal; EMailAddress: String);');
      sender.AddDelphiFunction('procedure PrimitiveSetPlayerPCInfo(Player: Cardinal; PCInfo: String);');
      sender.AddDelphiFunction('procedure PrimitiveWalk(NPC: Cardinal; Direction: Byte);');
      sender.AddDelphiFunction('procedure PrimitiveAttack(NPC: Cardinal; ObjectType: Integer; ObjectReference: Cardinal);');
      sender.AddDelphiFunction('procedure PrimitiveSetDead(Player: Cardinal);');
      sender.AddDelphiFunction('procedure PrimitiveSetAlive(Player: Cardinal);');
      sender.AddDelphiFunction('function PrimitiveGetNPCType(NPC: Cardinal): Cardinal;');
      sender.AddDelphiFunction('function PrimitiveGetExperience(ObjectType: Integer; ObjectReference: Cardinal): Cardinal;');
      sender.AddDelphiFunction('function PrimitiveGetLevel(ObjectType: Integer; ObjectReference: Cardinal): Cardinal;');
      sender.AddDelphiFunction('function PrimitiveGetSkill(ObjectType: Integer; ObjectReference: Cardinal; Skill: Integer): Byte;');
      sender.AddDelphiFunction('function PrimitiveIsOnline(Player: Cardinal): Boolean;');
      sender.AddDelphiFunction('function PrimitiveIsAlive(Player: Cardinal): Boolean;');
      sender.AddDelphiFunction('function PrimitiveGetHits(ObjectType: Integer; ObjectReference: Cardinal): Byte;');
      sender.AddDelphiFunction('function PrimitiveGetMana(ObjectType: Integer; ObjectReference: Cardinal): Byte;');
      sender.AddDelphiFunction('function PrimitiveGetFatigue(ObjectType: Integer; ObjectReference: Cardinal): Byte;');
      sender.AddDelphiFunction('function PrimitiveIsCriminal(ObjectType: Integer; ObjectReference: Cardinal): Boolean;');
      sender.AddDelphiFunction('function PrimitiveIsAtWar(Player: Cardinal): Boolean;');
      sender.AddDelphiFunction('function PrimitiveIsContainedIn(Item: Cardinal): Cardinal;');
      sender.AddDelphiFunction('function PrimitiveIsEquippedBy(Item: Cardinal): Cardinal;');
      sender.AddDelphiFunction('function PrimitiveGetWeight(Item: Cardinal): Word;');
      sender.AddDelphiFunction('function PrimitiveIsWeapon(Item: Cardinal): Boolean;');
      sender.AddDelphiFunction('function PrimitiveIsArmor(Item: Cardinal): Boolean;');
      sender.AddDelphiFunction('function PrimitiveGetWeaponSpeed(Weapon: Cardinal): Byte;');
      sender.AddDelphiFunction('function PrimitiveGetWeaponDamage(Weapon: Cardinal): Byte;');
      sender.AddDelphiFunction('function PrimitiveGetArmorStrength(Armor: Cardinal): Byte;');
      sender.AddDelphiFunction('function PrimitiveIsMoveable(Item: Cardinal): Boolean;');
      sender.AddDelphiFunction('function PrimitiveIsVisible(Item: Cardinal): Boolean;');
      sender.AddDelphiFunction('function PrimitiveIsPrivileged(ObjectType: Integer; ObjectReference: Cardinal): Boolean;');
      sender.AddDelphiFunction('function PrimitiveIsUnhidden(ObjectType: Integer; ObjectReference: Cardinal): Boolean;');
      sender.AddDelphiFunction('function PrimitiveIsStackable(Item: Cardinal): Boolean;');
      sender.AddDelphiFunction('function PrimitiveGetItemLighting(Item: Cardinal): Byte;');
      sender.AddDelphiFunction('function PrimitiveGetPlayerRealName(Player: Cardinal): String;');
      sender.AddDelphiFunction('function PrimitiveGetPlayerHomepage(Player: Cardinal): String;');
      sender.AddDelphiFunction('function PrimitiveGetPlayerEMailAddress(Player: Cardinal): String;');
      sender.AddDelphiFunction('function PrimitiveGetPlayerPCInfo(Player: Cardinal): String;');
      sender.AddDelphiFunction('function PrimitiveGetScriptName(ObjectType: Integer; ObjectReference: Cardinal): String;');
      sender.AddDelphiFunction('function PrimitiveIsWalkable(Item: Cardinal): Byte;');
      sender.AddDelphiFunction('procedure PrimitiveSetWalkable(Item: Cardinal; Direction: Byte);');
      sender.AddDelphiFunction('procedure PrimitiveOpenOrCloseDoor(Door: Cardinal; Graphic: Word; XRelative, YRelative: ShortInt);');
      sender.AddDelphiFunction('function PrimitiveGetObjectID(ObjectType: Integer; ObjectReference: Cardinal): Cardinal;');
      sender.AddDelphiFunction('function PrimitiveListOnlinePlayers: TPrimitiveObjectArray;');
      sender.AddDelphiFunction('function PrimitiveGetColor(Item: Cardinal): Word;');
      sender.AddDelphiFunction('function IsEquippedByObjectType(Item: Cardinal): Integer;');
      sender.AddDelphiFunction('function PrimitiveGetEquipmentByLayer(ObjectType: Integer; ObjectReference: Cardinal; Layer: Byte): Cardinal;');
      sender.AddDelphiFunction('function PrimitiveIsContainer(Item: Cardinal): Boolean;');
      sender.AddDelphiFunction('function PrimitiveFindItemInContainer(Container, TypeID: Cardinal; DeepSearch: Boolean): Cardinal;');
      sender.AddDelphiFunction('procedure PrimitiveUnstack(Item: Cardinal; X, Y: Word; Z: ShortInt; Amount: Word);');
      sender.AddDelphiFunction('procedure PrimitiveSendPacket(var Packet: TArrayOfByte; Player: Cardinal);');
      sender.AddDelphiFunction('procedure PrimitiveSetCriminal(ObjectType: Integer; ObjectReference: Cardinal);');
      sender.AddDelphiFunction('procedure PrimitiveSetInnocent(ObjectType: Integer; ObjectReference: Cardinal);');
      sender.AddDelphiFunction('function PrimitiveGetIP(Player: Cardinal): String;');
      sender.AddDelphiFunction('function PrimitiveObjectExists(ObjectType: Integer; ObjectReference: Cardinal): Boolean;');
      Result := True;

    end

  else
    Result := False;

end;

constructor tscriptthread.Create(ccompstr, cscriptname, cparam1, cparam2, cparam3, cparam4,
                                 cparam5: String);
begin
  compstr := ccompstr;
  scriptname := cscriptname;
  param1 := cparam1;
  param2 := cparam2;
  param3 := cparam3;
  param4 := cparam4;
  param5 := cparam5;
  inherited Create(False);

end;

procedure tscriptthread.Execute;
var
  exec: TIFPSExec;
  tempparamvar: PIFVariant;
  tempcard: Cardinal;
  ishttpscript: Boolean;
  tempstr: String;

begin
  FreeOnTerminate := True;
  if not IsServerActive then
    Exit;

  if Copy(scriptname, Length(scriptname) - 5, 6) = '(HTTP)' then
    ishttpscript := True

  else
    ishttpscript := False;

  exec := TIFPSExec.Create;
  sthreadindex := addsthread(Handle);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetObject), 'PRIMITIVEGETOBJECT', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveListObjects), 'PRIMITIVELISTOBJECTS', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveListObjectsNearLocation), 'PRIMITIVELISTOBJECTSNEARLOCATION', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveListObjectsNearLocationAccurate), 'PRIMITIVELISTOBJECTSNEARLOCATIONACCURATE', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetObjectX), 'PRIMITIVEGETOBJECTX', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetObjectY), 'PRIMITIVEGETOBJECTY', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetObjectZ), 'PRIMITIVEGETOBJECTZ', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetEvent), 'PRIMITIVEGETEVENT', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetEvent), 'PRIMITIVESETEVENT', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveEquipItem), 'PRIMITIVEEQUIPITEM', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveUnequipItem), 'PRIMITIVEUNEQUIPITEM', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveCreateObject), 'PRIMITIVECREATEOBJECT', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveDeleteObject), 'PRIMITIVEDELETEOBJECT', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveInsertItem), 'PRIMITIVEINSERTITEM', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveOpenContainer), 'PRIMITIVEOPENCONTAINER', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveRemoveItem), 'PRIMITIVEREMOVEITEM', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetMainContainer), 'PRIMITIVEGETMAINCONTAINER', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetAmount), 'PRIMITIVESETAMOUNT', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetSex), 'PRIMITIVEGETSEX', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetColor), 'PRIMITIVESETCOLOR', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitivePlayAnimationPrivate), 'PRIMITIVEPLAYANIMATIONPRIVATE', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitivePlayAnimation), 'PRIMITIVEPLAYANIMATION', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveCheckObjectDistance), 'PRIMITIVECHECKOBJECTDISTANCE', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveCheckObjectToCoordinatesDistance), 'PRIMITIVECHECKOBJECTTOCOORDINATESDISTANCE', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetObjectXMain), 'PRIMITIVEGETOBJECTXMAIN', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetObjectYMain), 'PRIMITIVEGETOBJECTYMAIN', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetObjectZMain), 'PRIMITIVEGETOBJECTZMAIN', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitivePlaySoundEffectPrivate), 'PRIMITIVEPLAYSOUNDEFFECTPRIVATE', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetLightLevelPrivate), 'PRIMITIVESETLIGHTLEVELPRIVATE', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetAmount), 'PRIMITIVEGETAMOUNT', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetItemType), 'PRIMITIVEGETITEMTYPE', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveListItemsInContainer), 'PRIMITIVELISTITEMSINCONTAINER', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSendText), 'PRIMITIVESENDTEXT', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveListEquippedItems), 'PRIMITIVELISTEQUIPPEDITEMS', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetSex), 'PRIMITIVESETSEX', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetGraphic), 'PRIMITIVEGETGRAPHIC', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetGraphic), 'PRIMITIVESETGRAPHIC', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetName), 'PRIMITIVEGETNAME', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetName), 'PRIMITIVESETNAME', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetFacing), 'PRIMITIVEGETFACING', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetFacing), 'PRIMITIVESETFACING', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetStrength), 'PRIMITIVEGETSTRENGTH', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetStrength), 'PRIMITIVESETSTRENGTH', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetDexterity), 'PRIMITIVEGETDEXTERITY', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetDexterity), 'PRIMITIVESETDEXTERITY', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetIntelligence), 'PRIMITIVEGETINTELLIGENCE', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetIntelligence), 'PRIMITIVESETINTELLIGENCE', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetCProp), 'PRIMITIVESETCPROP', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetCPropStringValue), 'PRIMITIVEGETCPROPSTRINGVALUE', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetCPropCardinalValue), 'PRIMITIVEGETCPROPCARDINALVALUE', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetCPropIntegerValue), 'PRIMITIVEGETCPROPINTEGERVALUE', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveCPropExists), 'PRIMITIVECPROPEXISTS', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveEraseCProp), 'PRIMITIVEERASECPROP', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveRequestInput), 'PRIMITIVEREQUESTINPUT', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetExperience), 'PRIMITIVESETEXPERIENCE', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetLevel), 'PRIMITIVESETLEVEL', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetSkill), 'PRIMITIVESETSKILL', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetHits), 'PRIMITIVESETHITS', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetMana), 'PRIMITIVESETMANA', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetFatigue), 'PRIMITIVESETFATIGUE', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetWeight), 'PRIMITIVESETWEIGHT', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveMoveObject), 'PRIMITIVEMOVEOBJECT', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetWeaponSpeed), 'PRIMITIVESETWEAPONSPEED', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetWeaponDamage), 'PRIMITIVESETWEAPONDAMAGE', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetArmorStrength), 'PRIMITIVESETARMORSTRENGTH', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetMoveable), 'PRIMITIVESETMOVEABLE', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetUnmoveable), 'PRIMITIVESETUNMOVEABLE', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetVisible), 'PRIMITIVESETVISIBLE', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetInvisible), 'PRIMITIVESETINVISIBLE', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetPrivileged), 'PRIMITIVESETPRIVILEGED', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetUnprivileged), 'PRIMITIVESETUNPRIVILEGED', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetUnhidden), 'PRIMITIVESETUNHIDDEN', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetHidden), 'PRIMITIVESETHIDDEN', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetItemLighting), 'PRIMITIVESETITEMLIGHTING', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveKick), 'PRIMITIVEKICK', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetPlayerRealName), 'PRIMITIVESETPLAYERREALNAME', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetPlayerHomepage), 'PRIMITIVESETPLAYERHOMEPAGE', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetPlayerEMailAddress), 'PRIMITIVESETPLAYEREMAILADDRESS', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetPlayerPCInfo), 'PRIMITIVESETPLAYERPCINFO', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveWalk), 'PRIMITIVEWALK', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveAttack), 'PRIMITIVEATTACK', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetDead), 'PRIMITIVESETDEAD', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetAlive), 'PRIMITIVESETALIVE', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetNPCType), 'PRIMITIVEGETNPCTYPE', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetExperience), 'PRIMITIVEGETEXPERIENCE', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetLevel), 'PRIMITIVEGETLEVEL', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetSkill), 'PRIMITIVEGETSKILL', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveIsOnline), 'PRIMITIVEISONLINE', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveIsAlive), 'PRIMITIVEISALIVE', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetHits), 'PRIMITIVEGETHITS', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetMana), 'PRIMITIVEGETMANA', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetFatigue), 'PRIMITIVEGETFATIGUE', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveIsCriminal), 'PRIMITIVEISCRIMINAL', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveIsAtWar), 'PRIMITIVEISATWAR', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveIsContainedIn), 'PRIMITIVEISCONTAINEDIN', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveIsEquippedBy), 'PRIMITIVEISEQUIPPEDBY', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetWeight), 'PRIMITIVEGETWEIGHT', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveIsWeapon), 'PRIMITIVEISWEAPON', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveIsArmor), 'PRIMITIVEISARMOR', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetWeaponSpeed), 'PRIMITIVEGETWEAPONSPEED', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetWeaponDamage), 'PRIMITIVEGETWEAPONSPEED', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetArmorStrength), 'PRIMITIVEGETARMORSTRENGTH', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveIsMoveable), 'PRIMITIVEISMOVEABLE', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveIsVisible), 'PRIMITIVEISVISIBLE', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveIsPrivileged), 'PRIMITIVEISPRIVILEGED', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveIsUnhidden), 'PRIMITIVEISUNHIDDEN', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveIsStackable), 'PRIMITIVEISSTACKABLE', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetItemLighting), 'PRIMITIVEGETITEMLIGHTING', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetPlayerRealName), 'PRIMITIVEGETPLAYERREALNAME', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetPlayerHomepage), 'PRIMITIVEGETPLAYERHOMEPAGE', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetPlayerEMailAddress), 'PRIMITIVEGETPLAYEREMAILADDRESS', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetPlayerPCInfo), 'PRIMITIVEGETPLAYERPCINFO', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetScriptName), 'PRIMITIVEGETSCRIPTNAME', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveIsWalkable), 'PRIMITIVEISWALKABLE', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetWalkable), 'PRIMITIVESETWALKABLE', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveOpenOrCloseDoor), 'PRIMITIVEOPENORCLOSEDOOR', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetObjectID), 'PRIMITIVEGETOBJECTID', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveListOnlinePlayers), 'PRIMITIVELISTONLINEPLAYERS', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetColor), 'PRIMITIVEGETCOLOR', cdRegister);
  exec.RegisterDelphiFunction(Addr(IsEquippedByObjectType), 'ISEQUIPPEDBYOBJECTTYPE', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetEquipmentByLayer), 'PRIMITIVEGETEQUIPMENTBYLAYER', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrintServerMessage), 'PRINTSERVERMESSAGE',
                              cdRegister);
  exec.RegisterDelphiFunction(Addr(ScriptSleep), 'SCRIPTSLEEP', cdRegister);
  exec.RegisterDelphiFunction(Addr(ObjectExistsByID), 'OBJECTEXISTSBYID', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetObject), 'GETOBJECT', cdRegister);
  exec.RegisterDelphiFunction(Addr(CheckObjectType), 'CHECKOBJECTTYPE', cdRegister);
  exec.RegisterDelphiFunction(Addr(ListObjects), 'LISTOBJECTS', cdRegister);
  exec.RegisterDelphiFunction(Addr(CheckDistance), 'CHECKDISTANCE', cdRegister);
  exec.RegisterDelphiFunction(Addr(ListObjectsNearLocation), 'LISTOBJECTSNEARLOCATION', cdRegister);
  exec.RegisterDelphiFunction(Addr(ListObjectsNearLocationAccurate), 'LISTOBJECTSNEARLOCATIONACCURATE', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetObjectX), 'GETOBJECTX', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetObjectY), 'GETOBJECTY', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetObjectZ), 'GETOBJECTZ', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetEvent), 'GETEVENT', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetEventType), 'GETEVENTTYPE', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetEventIntegerValue), 'GETEVENTINTEGERVALUE', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetEventStringValue), 'GETEVENTSTRINGVALUE', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetEventCardinalValue), 'GETEVENTCARDINALVALUE', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetEvent), 'SETEVENT', cdRegister);
  exec.RegisterDelphiFunction(Addr(EquipItem), 'EQUIPITEM', cdRegister);
  exec.RegisterDelphiFunction(Addr(UnequipItem), 'UNEQUIPITEM', cdRegister);
  exec.RegisterDelphiFunction(Addr(CreateObject), 'CREATEOBJECT', cdRegister);
  exec.RegisterDelphiFunction(Addr(DeleteObject), 'DELETEOBJECT', cdRegister);
  exec.RegisterDelphiFunction(Addr(InsertItem), 'INSERTITEM', cdRegister);
  exec.RegisterDelphiFunction(Addr(OpenContainer), 'OPENCONTAINER', cdRegister);
  exec.RegisterDelphiFunction(Addr(RemoveItem), 'REMOVEITEM', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetMainContainer), 'GETMAINCONTAINER', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetAmount), 'SETAMOUNT', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetSex), 'GETSEX', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetColor), 'SETCOLOR', cdRegister);
  exec.RegisterDelphiFunction(Addr(PlayAnimationPrivate), 'PLAYANIMATIONPRIVATE', cdRegister);
  exec.RegisterDelphiFunction(Addr(PlayAnimation), 'PLAYANIMATION', cdRegister);
  exec.RegisterDelphiFunction(Addr(CheckObjectDistance), 'CHECKOBJECTDISTANCE', cdRegister);
  exec.RegisterDelphiFunction(Addr(CheckObjectToCoordinatesDistance), 'CHECKOBJECTTOCOORDINATESDISTANCE', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetObjectXMain), 'GETOBJECTXMAIN', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetObjectYMain), 'GETOBJECTYMAIN', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetObjectZMain), 'GETOBJECTZMAIN', cdRegister);
  exec.RegisterDelphiFunction(Addr(PlaySoundEffectPrivate), 'PLAYSOUNDEFFECTPRIVATE', cdRegister);
  exec.RegisterDelphiFunction(Addr(PlaySoundEffect), 'PLAYSOUNDEFFECT', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetLightLevelPrivate), 'SETLIGHTLEVELPRIVATE', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetLightLevel), 'SETLIGHTLEVEL', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetAmount), 'GETAMOUNT', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetItemType), 'GETITEMTYPE', cdRegister);
  exec.RegisterDelphiFunction(Addr(ListItemsInContainer), 'LISTITEMSINCONTAINER', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetSubString), 'GETSUBSTRING', cdRegister);
  exec.RegisterDelphiFunction(Addr(SendText), 'SENDTEXT', cdRegister);
  exec.RegisterDelphiFunction(Addr(CheckLOS), 'CHECKLOS', cdRegister);
  exec.RegisterDelphiFunction(Addr(ListEquippedItems), 'LISTEQUIPPEDITEMS', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetSex), 'SETSEX', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetGraphic), 'GETGRAPHIC', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetGraphic), 'SETGRAPHIC', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetName), 'GETNAME', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetName), 'SETNAME', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetFacing), 'GETFACING', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetFacing), 'SETFACING', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetStrength), 'GETSTRENGTH', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetStrength), 'SETSTRENGTH', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetDexterity), 'GETDEXTERITY', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetDexterity), 'SETDEXTERITY', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetIntelligence), 'GETINTELLIGENCE', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetIntelligence), 'SETINTELLIGENCE', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetCProp), 'SETCPROP', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetCPropStringValue), 'GETCPROPSTRINGVALUE', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetCPropCardinalValue), 'GETCPROPCARDINALVALUE', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetCPropIntegerValue), 'GETCPROPINTEGERVALUE', cdRegister);
  exec.RegisterDelphiFunction(Addr(CPropExists), 'CPROPEXISTS', cdRegister);
  exec.RegisterDelphiFunction(Addr(EraseCProp), 'ERASECPROP', cdRegister);
  exec.RegisterDelphiFunction(Addr(RequestInput), 'REQUESTINPUT', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetGProp), 'SETGPROP', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetGPropStringValue), 'GETGPROPSTRINGVALUE', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetGPropCardinalValue), 'GETGPROPCARDINALVALUE', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetGPropIntegerValue), 'GETGPROPINTEGERVALUE', cdRegister);
  exec.RegisterDelphiFunction(Addr(GPropExists), 'GPROPEXISTS', cdRegister);
  exec.RegisterDelphiFunction(Addr(EraseGProp), 'ERASEGPROP', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetExperience), 'SETEXPERIENCE', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetLevel), 'SETLEVEL', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetSkill), 'SETSKILL', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetHits), 'SETHITS', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetMana), 'SETMANA', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetFatigue), 'SETFATIGUE', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetWeight), 'SETWEIGHT', cdRegister);
  exec.RegisterDelphiFunction(Addr(MoveObject), 'MOVEOBJECT', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetWeaponSpeed), 'SETWEAPONSPEED', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetWeaponDamage), 'SETWEAPONDAMAGE', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetArmorStrength), 'SETARMORSTRENGTH', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetMoveable), 'SETMOVEABLE', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetUnmoveable), 'SETUNMOVEABLE', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetVisible), 'SETVISIBLE', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetInvisible), 'SETINVISIBLE', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetPrivileged), 'SETPRIVILEGED', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetUnprivileged), 'SETUNPRIVILEGED', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetUnhidden), 'SETUNHIDDEN', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetHidden), 'SETHIDDEN', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetItemLighting), 'SETITEMLIGHTING', cdRegister);
  exec.RegisterDelphiFunction(Addr(SaveWorldState), 'SAVEWORLDSTATE', cdRegister);
  exec.RegisterDelphiFunction(Addr(ShutDown), 'SHUTDOWN', cdRegister);
  exec.RegisterDelphiFunction(Addr(Kick), 'KICK', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetPlayerRealName), 'SETPLAYERREALNAME', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetPlayerHomepage), 'SETPLAYERHOMEPAGE', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetPlayerEMailAddress), 'SETPLAYEREMAILADDRESS', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetPlayerPCInfo), 'SETPLAYERPCINFO', cdRegister);
  exec.RegisterDelphiFunction(Addr(Walk), 'WALK', cdRegister);
  exec.RegisterDelphiFunction(Addr(Attack), 'ATTACK', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetDead), 'SETDEAD', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetAlive), 'SETALIVE', cdRegister);
  exec.RegisterDelphiFunction(Addr(StartScript), 'STARTSCRIPT', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetNPCType), 'GETNPCTYPE', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetExperience), 'GETEXPERIENCE', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetLevel), 'GETLEVEL', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetSkill), 'GETSKILL', cdRegister);
  exec.RegisterDelphiFunction(Addr(IsOnline), 'ISONLINE', cdRegister);
  exec.RegisterDelphiFunction(Addr(IsAlive), 'ISALIVE', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetHits), 'GETHITS', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetMana), 'GETMANA', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetFatigue), 'GETFATIGUE', cdRegister);
  exec.RegisterDelphiFunction(Addr(IsCriminal), 'ISCRIMINAL', cdRegister);
  exec.RegisterDelphiFunction(Addr(IsAtWar), 'ISATWAR', cdRegister);
  exec.RegisterDelphiFunction(Addr(IsContainedIn), 'ISCONTAINEDIN', cdRegister);
  exec.RegisterDelphiFunction(Addr(IsEquippedBy), 'ISEQUIPPEDBY', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetWeight), 'GETWEIGHT', cdRegister);
  exec.RegisterDelphiFunction(Addr(IsWeapon), 'ISWEAPON', cdRegister);
  exec.RegisterDelphiFunction(Addr(IsArmor), 'ISARMOR', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetWeaponSpeed), 'GETWEAPONSPEED', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetWeaponDamage), 'GETWEAPONSPEED', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetArmorStrength), 'GETARMORSTRENGTH', cdRegister);
  exec.RegisterDelphiFunction(Addr(IsMoveable), 'ISMOVEABLE', cdRegister);
  exec.RegisterDelphiFunction(Addr(IsVisible), 'ISVISIBLE', cdRegister);
  exec.RegisterDelphiFunction(Addr(IsPrivileged), 'ISPRIVILEGED', cdRegister);
  exec.RegisterDelphiFunction(Addr(IsUnhidden), 'ISUNHIDDEN', cdRegister);
  exec.RegisterDelphiFunction(Addr(IsStackable), 'ISSTACKABLE', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetItemLighting), 'GETITEMLIGHTING', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetPlayerRealName), 'GETPLAYERREALNAME', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetPlayerHomepage), 'GETPLAYERHOMEPAGE', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetPlayerEMailAddress), 'GETPLAYEREMAILADDRESS', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetPlayerPCInfo), 'GETPLAYERPCINFO', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetScriptName), 'GETSCRIPTNAME', cdRegister);
  exec.RegisterDelphiFunction(Addr(IsWalkable), 'ISWALKABLE', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetWalkable), 'SETWALKABLE', cdRegister);
  exec.RegisterDelphiFunction(Addr(OpenOrCloseDoor), 'OPENORCLOSEDOOR', cdRegister);
  exec.RegisterDelphiFunction(Addr(RandomInteger), 'RANDOMINTEGER', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetObjectID), 'GETOBJECTID', cdRegister);
  exec.RegisterDelphiFunction(Addr(ListOnlinePlayers), 'LISTONLINEPLAYERS', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetColor), 'GETCOLOR', cdRegister);
  exec.RegisterDelphiFunction(Addr(IsServerActive), 'ISSERVERACTIVE', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetEquipmentByLayer), 'GETEQUIPMENTBYLAYER', cdRegister);
  exec.RegisterDelphiFunction(Addr(CardToStr), 'CARDTOSTR', cdRegister);
  exec.RegisterDelphiFunction(Addr(StrToCard), 'STRTOCARD', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveIsContainer), 'PRIMITIVEISCONTAINER', cdRegister);
  exec.RegisterDelphiFunction(Addr(IsContainer), 'ISCONTAINER', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetPrimitiveObjectReference), 'GETPRIMITIVEOBJECTREFERENCE', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetObjectType), 'GETOBJECTTYPE', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetObjectReference), 'GETOBJECTREFERENCE', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetTileGraphic), 'GETTILEGRAPHIC', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetStaticsGraphics), 'GETSTATICSGRAPHICS', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetDirectionTo), 'GETDIRECTIONTO', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveFindItemInContainer), 'PRIMITIVEFINDITEMINCONTAINER', cdRegister);
  exec.RegisterDelphiFunction(Addr(FindItemInContainer), 'FINDITEMINCONTAINER', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveUnstack), 'PRIMITIVEUNSTACK', cdRegister);
  exec.RegisterDelphiFunction(Addr(Unstack), 'UNSTACK', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetDate), 'GETDATE', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetTimeOfDay), 'GETTIMEOFDAY', cdRegister);
  exec.RegisterDelphiFunction(Addr(AddByte), 'ADDBYTE', cdRegister);
  exec.RegisterDelphiFunction(Addr(AddWord), 'ADDWORD', cdRegister);
  exec.RegisterDelphiFunction(Addr(AddDWord), 'ADDDWORD', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSendPacket), 'PRIMITIVESENDPACKET', cdRegister);
  exec.RegisterDelphiFunction(Addr(SendPacket), 'SENDPACKET', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetCriminal), 'PRIMITIVESETCRIMINAL', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetCriminal), 'SETCRIMINAL', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetInnocent), 'PRIMITIVESETINNOCENT', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetInnocent), 'SETINNOCENT', cdRegister);
  if ishttpscript then
    begin
      exec.RegisterDelphiFunction(Addr(WriteHTML), 'WRITEHTML', cdRegister);
      exec.RegisterDelphiFunction(Addr(QueryParameter), 'QUERYPARAMETER', cdRegister);
      exec.RegisterDelphiFunction(Addr(QueryIP), 'QUERYIP', cdRegister);

    end

  else
    begin
      exec.RegisterDelphiFunction(Addr(writehtmlerr), 'WRITEHTML', cdRegister);
      exec.RegisterDelphiFunction(Addr(queryparamerr), 'QUERYPARAMETER', cdRegister);
      exec.RegisterDelphiFunction(Addr(queryiperr), 'QUERYIP', cdRegister);
      
    end;

  exec.RegisterDelphiFunction(Addr(ScriptGetTickCount), 'SCRIPTGETTICKCOUNT', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetIP), 'PRIMITIVEGETIP', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetIP), 'GETIP', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveObjectExists), 'PRIMITIVEOBJECTEXISTS', cdRegister);
  exec.RegisterDelphiFunction(Addr(ObjectExists), 'OBJECTEXISTS', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetScriptName), 'PRIMITIVESETSCRIPTNAME', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetScriptName), 'SETSCRIPTNAME', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveSetPassword), 'PRIMITIVESETPASSWORD', cdRegister);
  exec.RegisterDelphiFunction(Addr(SetPassword), 'SETPASSWORD', cdRegister);
  exec.RegisterDelphiFunction(Addr(PrimitiveGetPassword), 'PRIMITIVEGETPASSWORD', cdRegister);
  exec.RegisterDelphiFunction(Addr(GetPassword), 'GETPASSWORD', cdRegister);
  if exec.LoadData(compstr) then
    begin
      tempparamvar := exec.GetVar2('PARAMETER1');
      VSetString(tempparamvar, param1);
      tempparamvar := exec.GetVar2('PARAMETER2');
      VSetString(tempparamvar, param2);
      tempparamvar := exec.GetVar2('PARAMETER3');
      VSetString(tempparamvar, param3);
      tempparamvar := exec.GetVar2('PARAMETER4');
      VSetString(tempparamvar, param4);
      tempparamvar := exec.GetVar2('PARAMETER5');
      VSetString(tempparamvar, param5);
      tempparamvar := exec.GetVar2('OTNONE');
      VSetInt(tempparamvar, OTNONE);
      tempparamvar := exec.GetVar2('OTALL');
      VSetInt(tempparamvar, OTALL);
      tempparamvar := exec.GetVar2('OTPLAYER');
      VSetInt(tempparamvar, OTPLAYER);
      tempparamvar := exec.GetVar2('OTNPC');
      VSetInt(tempparamvar, OTNPC);
      tempparamvar := exec.GetVar2('OTITEM');
      VSetInt(tempparamvar, OTITEM);
      tempparamvar := exec.GetVar2('DFNORTH');
      VSetInt(tempparamvar, DFNORTH);
      tempparamvar := exec.GetVar2('DFNORTHEAST');
      VSetInt(tempparamvar, DFNORTHEAST);
      tempparamvar := exec.GetVar2('DFEAST');
      VSetInt(tempparamvar, DFEAST);
      tempparamvar := exec.GetVar2('DFSOUTHEAST');
      VSetInt(tempparamvar, DFSOUTHEAST);
      tempparamvar := exec.GetVar2('DFSOUTH');
      VSetInt(tempparamvar, DFSOUTH);
      tempparamvar := exec.GetVar2('DFSOUTHWEST');
      VSetInt(tempparamvar, DFSOUTHWEST);
      tempparamvar := exec.GetVar2('DFWEST');
      VSetInt(tempparamvar, DFWEST);
      tempparamvar := exec.GetVar2('DFNORTHWEST');
      VSetInt(tempparamvar, DFNORTHWEST);
      tempparamvar := exec.GetVar2('DFNONE');
      VSetInt(tempparamvar, DFNONE);
      tempparamvar := exec.GetVar2('DFALL');
      VSetInt(tempparamvar, DFALL);
      tempparamvar := exec.GetVar2('ETNONE');
      VSetInt(tempparamvar, ETNONE);
      tempparamvar := exec.GetVar2('ETDOUBLECLICKED');
      VSetInt(tempparamvar, ETDOUBLECLICKED);
      tempparamvar := exec.GetVar2('ETITEMGIVEN');
      VSetInt(tempparamvar, ETITEMGIVEN);
      tempparamvar := exec.GetVar2('ETATTACKED');
      VSetInt(tempparamvar, ETATTACKED);
      tempparamvar := exec.GetVar2('ETTALKED');
      VSetInt(tempparamvar, ETTALKED);
      tempparamvar := exec.GetVar2('ETMOVED');
      VSetInt(tempparamvar, ETMOVED);
      tempparamvar := exec.GetVar2('ETEQUIPPED');
      VSetInt(tempparamvar, ETEQUIPPED);
      tempparamvar := exec.GetVar2('ETUNEQUIPPED');
      VSetInt(tempparamvar, ETUNEQUIPPED);
      tempparamvar := exec.GetVar2('ETITEMINSERTED');
      VSetInt(tempparamvar, ETITEMINSERTED);
      tempparamvar := exec.GetVar2('ETITEMREMOVED');
      VSetInt(tempparamvar, ETITEMREMOVED);
      tempparamvar := exec.GetVar2('SMALE');
      VSetInt(tempparamvar, SMALE);
      tempparamvar := exec.GetVar2('SFEMALE');
      VSetInt(tempparamvar, SFEMALE);
      tempparamvar := exec.GetVar2('ETSTACKED');
      VSetInt(tempparamvar, ETSTACKED);
      tempparamvar := exec.GetVar2('ETUNSTACKED');
      VSetInt(tempparamvar, ETUNSTACKED);
      tempparamvar := exec.GetVar2('ETINSERTED');
      VSetInt(tempparamvar, ETINSERTED);
      tempparamvar := exec.GetVar2('ETREMOVED');
      VSetInt(tempparamvar, ETREMOVED);
      tempparamvar := exec.GetVar2('AATTACK');
      VSetInt(tempparamvar, AATTACK);
      tempparamvar := exec.GetVar2('ADEFEND');
      VSetInt(tempparamvar, ADEFEND);
      tempparamvar := exec.GetVar2('SIDLIGHTSOURCE');
      VSetInt(tempparamvar, SIDLIGHTSOURCE);
      tempparamvar := exec.GetVar2('SIDDARKSOURCE');
      VSetInt(tempparamvar, SIDDARKSOURCE);
      tempparamvar := exec.GetVar2('SIDGREATLIGHT');
      VSetInt(tempparamvar, SIDGREATLIGHT);
      tempparamvar := exec.GetVar2('SIDLIGHT');
      VSetInt(tempparamvar, SIDLIGHT);
      tempparamvar := exec.GetVar2('SIDHEALING');
      VSetInt(tempparamvar, SIDHEALING);
      tempparamvar := exec.GetVar2('SIDFIREBALL');
      VSetInt(tempparamvar, SIDFIREBALL);
      tempparamvar := exec.GetVar2('SIDCREATEFOOD');
      VSetInt(tempparamvar, SIDCREATEFOOD);
      tempparamvar := exec.GetVar2('ITIDCORPSE');
      VSetInt(tempparamvar, ITIDCORPSE);
      tempparamvar := exec.GetVar2('ITIDSPELLBOOK');
      VSetInt(tempparamvar, ITIDSPELLBOOK);
      tempparamvar := exec.GetVar2('TTSYSTEMMESSAGE');
      VSetInt(tempparamvar, TTSYSTEMMESSAGE);
      tempparamvar := exec.GetVar2('TTSPEECHPRIVATE');
      VSetInt(tempparamvar, TTSPEECHPRIVATE);
      tempparamvar := exec.GetVar2('TTSPEECH');
      VSetInt(tempparamvar, TTSPEECH);
      tempparamvar := exec.GetVar2('TTTEXTABOVEPRIVATE');
      VSetInt(tempparamvar, TTTEXTABOVEPRIVATE);
      tempparamvar := exec.GetVar2('TTTEXTABOVE');
      VSetInt(tempparamvar, TTTEXTABOVE);
      tempparamvar := exec.GetVar2('ETWALKEDON');
      VSetInt(tempparamvar, ETWALKEDON);
      tempparamvar := exec.GetVar2('LWEAPON');
      VSetInt(tempparamvar, LWEAPON);
      tempparamvar := exec.GetVar2('LSHIELD');
      VSetInt(tempparamvar, LSHIELD);
      tempparamvar := exec.GetVar2('LPANTS');
      VSetInt(tempparamvar, LPANTS);
      tempparamvar := exec.GetVar2('LBACKPACK');
      VSetInt(tempparamvar, LBACKPACK);
      tempparamvar := exec.GetVar2('LHAIR');
      VSetInt(tempparamvar, LHAIR);
      tempparamvar := exec.GetVar2('SKIDMAGICDEFENSE');
      VSetInt(tempparamvar, SKIDMAGICDEFENSE);
      tempparamvar := exec.GetVar2('SKIDBATTLEDEFENSE');
      VSetInt(tempparamvar, SKIDBATTLEDEFENSE);
      tempparamvar := exec.GetVar2('SKIDSTEALING');
      VSetInt(tempparamvar, SKIDSTEALING);
      tempparamvar := exec.GetVar2('SKIDHIDING');
      VSetInt(tempparamvar, SKIDHIDING);
      tempparamvar := exec.GetVar2('SKIDFIRSTAID');
      VSetInt(tempparamvar, SKIDFIRSTAID);
      tempparamvar := exec.GetVar2('SKIDDETECTTRAP');
      VSetInt(tempparamvar, SKIDDETECTTRAP);
      tempparamvar := exec.GetVar2('SKIDPEEK');
      VSetInt(tempparamvar, SKIDPEEK);
      tempparamvar := exec.GetVar2('SKIDMAGIC');
      VSetInt(tempparamvar, SKIDMAGIC);
      tempparamvar := exec.GetVar2('SKIDMELEE');
      VSetInt(tempparamvar, SKIDMELEE);
      tempparamvar := exec.GetVar2('SKIDRANGEDWEAPONS');
      VSetInt(tempparamvar, SKIDRANGEDWEAPONS);
      tempparamvar := exec.GetVar2('STMISC');
      VSetInt(tempparamvar, STMISC);
      tempparamvar := exec.GetVar2('STNPC');
      VSetInt(tempparamvar, STNPC);
      tempparamvar := exec.GetVar2('STITEM');
      VSetInt(tempparamvar, STITEM);
      tempparamvar := exec.GetVar2('STCMD');
      VSetInt(tempparamvar, STCMD);
      tempparamvar := exec.GetVar2('STSKILL');
      VSetInt(tempparamvar, STSKILL);
      tempparamvar := exec.GetVar2('DEFINSPOS');
      VSetInt(tempparamvar, DEFINSPOS);
      tempparamvar := exec.GetVar2('ITIDSOLIGHTSOURCE');
      VSetInt(tempparamvar, ITIDSOLIGHTSOURCE);
      tempparamvar := exec.GetVar2('ITIDSODARKSOURCE');
      VSetInt(tempparamvar, ITIDSODARKSOURCE);
      tempparamvar := exec.GetVar2('ITIDSOGREATLIGHT');
      VSetInt(tempparamvar, ITIDSOGREATLIGHT);
      tempparamvar := exec.GetVar2('ITIDSOLIGHT');
      VSetInt(tempparamvar, ITIDSOLIGHT);
      tempparamvar := exec.GetVar2('ITIDSOHEALING');
      VSetInt(tempparamvar, ITIDSOHEALING);
      tempparamvar := exec.GetVar2('ITIDSOFIREBALL');
      VSetInt(tempparamvar, ITIDSOFIREBALL);
      tempparamvar := exec.GetVar2('ITIDSOCREATEFOOD');
      VSetInt(tempparamvar, ITIDSOCREATEFOOD);
      exec.RunScript;
      if exec.ExceptionCode <> ENoError then
        printsm(10, 'A script runtime error occured: '+ TIFErrorToString(exec.ExceptionCode,
                exec.ExceptionString) +' ('+ scriptname +').');

      exec.Free;

    end

  else
    begin
      printsm(10, 'Could not start script: '+ scriptname +'.');
      exec.Free;

    end;

  if scriptname = 'onlogout (Miscellaneous)' then
    finishlogout(StrToCard(param1));

  if scriptname = 'onshutdown (Miscellaneous)' then
    begin
      sdscriptdonelock.Acquire;
      sdscriptdone := True;
      sdscriptdonelock.Release;

    end;

  if ishttpscript then
    begin
      tempcard := StrToCard(param1);
      httpconnslock.Acquire;
      try
        httpconns[tempcard].lock.Acquire;
        tempstr := httpconns[tempcard].Version +' 200 OK' + #13#10 +
                   'Content-Type: text/html'+ #13#10 +
                   'Content-Length: '+ CardToStr(Length(httpconns[tempcard].str)) +
                   #13#10#13#10 + httpconns[tempcard].str;
        httpconns[tempcard].BufSize := Length(tempstr);
        httpconns[tempcard].SendText(tempstr);
        httpconns[tempcard].Flush;

      finally
        try
          httpconns[tempcard].Shutdown(0);
          httpconns[tempcard].WaitForClose;

        finally
          httpconns[tempcard].BufSize := 0;
          httpconns[tempcard] := nil;

        end;

      end;
      httpconnslock.Release;

    end;

  remsthread(sthreadindex);

end;

procedure PrintServerMessage(ServerMessage: String);
begin
  if not IsServerActive then
    Exit;

  printsm(10, ServerMessage);

end;

procedure ScriptSleep(Milliseconds: Cardinal);
var
  i, rem: Cardinal;

begin
  if not IsServerActive then
    Exit;
    
  if Milliseconds >= 1000 then
    begin
      i := 1;
      rem := Milliseconds mod 100;
      while IsServerActive and (i * 100 <= Milliseconds - rem) do
        begin
          Sleep(100);
          Inc(i);

        end;

      if IsServerActive and (rem > 0) then
        Sleep(rem);

    end

  else
    Sleep(Milliseconds);

end;

function ObjectExistsByID(ObjectType: Integer; ID: Cardinal): Boolean;
begin
  if not IsServerActive then
    begin
      Result := False;
      Exit;

    end;


  if (ObjectType = OTALL) then
    begin
      phashlock.Acquire;
      nhashlock.Acquire;
      ihashlock.Acquire;
      if (playerhash.Exists(CardToStr(ID)) or
          npchash.Exists(CardToStr(ID)) or itemhash.Exists(CardToStr(ID))) then
        begin
          phashlock.Release;
          nhashlock.Release;
          ihashlock.Release;
          Result := True;
          Exit;

        end;

      phashlock.Release;
      nhashlock.Release;
      ihashlock.Release;

    end;

  if ObjectType = OTPLAYER then
    begin
      phashlock.Acquire;
      Result := playerhash.Exists(CardToStr(ID));
      phashlock.Release;
      Exit;

    end;

  if ObjectType = OTNPC then
    begin
      nhashlock.Acquire;
      Result := npchash.Exists(CardToStr(ID));
      nhashlock.Release;
      Exit;

    end;

  if ObjectType = OTITEM then
    begin
      ihashlock.Acquire;
      Result := itemhash.Exists(CardToStr(ID));
      ihashlock.Release;
      Exit;

    end;

  Result := False;

end;

function PrimitiveGetObject(ObjectType: Integer; ID: Cardinal): Cardinal;
begin
  if not IsServerActive then
    begin
      Result := 0;
      Exit;

    end;

  if not ObjectExistsByID(ObjectType, ID) then
    begin
      Result := 0;
      Exit;

    end;

  if ObjectType = OTPLAYER then
    begin
      phashlock.Acquire;
      Result := playerhash[CardToStr(ID)];
      phashlock.Release;
      Exit;

    end;

  if ObjectType = OTNPC then
    begin
      nhashlock.Acquire;
      Result := npchash[CardToStr(ID)];
      nhashlock.Release;
      Exit;

    end;

  if ObjectType = OTITEM then
    begin
      ihashlock.Acquire;
      Result := itemhash[CardToStr(ID)];
      ihashlock.Release;
      Exit;

    end;

  Result := 0;

end;

function CheckObjectType(ID: Cardinal): Integer;
begin
  if not IsServerActive then
    begin
      Result := OTNONE;
      Exit;

    end;

  othashlock.Acquire;
  if objtypehash.Exists(CardToStr(ID)) then
    begin
      Result := objtypehash[CardToStr(ID)];
      othashlock.Release;
      Exit;

    end;

  othashlock.Release;
  Result := OTNONE;

end;

function PrimitiveListObjects(ObjectType: Integer): TPrimitiveObjectArray;
var
  i: Cardinal;
  temparray: TPrimitiveObjectArray;

begin
  if not IsServerActive then
    Exit;

  SetLength(temparray, 0);
  if ObjectType = OTPLAYER then
    if datah.getplayerslen > 1 then
      for i := 1 to datah.getplayerslen - 1 do
        if datah.players[i].id <> 0 then
          begin
            SetLength(temparray, Length(temparray) + 1);
            temparray[Length(temparray) - 1] := i;

          end;

  if ObjectType = OTNPC then
    if datah.getnpcslen > 1 then
      for i := 1 to datah.getnpcslen - 1 do
        if datah.npcs[i].id <> 0 then
          begin
            SetLength(temparray, Length(temparray) + 1);
            temparray[Length(temparray) - 1] := i;

          end;

  if ObjectType = OTITEM then
    if datah.getitemslen > 1 then
      for i := 1 to datah.getitemslen - 1 do
        if (datah.items[i].id <> 0) then
          begin
            SetLength(temparray, Length(temparray) + 1);
            temparray[Length(temparray) - 1] := i;

          end;

  Result := temparray;

end;

function CheckDistance(X1, X2, Y1, Y2: Word; Z1, Z2: ShortInt): Cardinal;
begin
  if not IsServerActive then
    begin
      Result := 0;
      Exit;

    end;

  Result := Round(Sqrt(Sqr(X2 - X1) + Sqr(Y2 - Y1) + Sqr(Z2 - Z1)));

end;

function PrimitiveListObjectsNearLocation(ObjectType: Integer; X, Y: Word;
         Distance: Cardinal): TPrimitiveObjectArray;
var
  searchx, searchy: Integer;
  i: Cardinal;
  temparray1, temparray2: TPrimitiveObjectArray;

begin
  if not IsServerActive then
    Exit;

  SetLength(temparray1, 0);
  SetLength(temparray2, 0);
  if ObjectType = OTPLAYER then
    for searchx := X - Distance to X + Distance do
      for searchy := Y - Distance to Y + Distance do
        if (searchx >= 0) and (searchy >= 0) then
          try
            temparray1 := getplayersat2dpos(searchx, searchy);
            if Length(temparray1) > 0 then
              begin
                i := Length(temparray2);
                SetLength(temparray2, Length(temparray2) + Length(temparray1));
                Move(temparray1[0], temparray2[i], Length(temparray1) * 4);

              end;

          except
          end;

  if ObjectType = OTNPC then
    for searchx := X - Distance to X + Distance do
      for searchy := Y - Distance to Y + Distance do
        if (searchx >= 0) and (searchy >= 0) then
          try
            temparray1 := getnpcsat2dpos(searchx, searchy);
            if Length(temparray1) > 0 then
              begin
                i := Length(temparray2);
                SetLength(temparray2, Length(temparray2) + Length(temparray1));
                Move(temparray1[0], temparray2[i], Length(temparray1) * 4);

              end;

          except
          end;

  if ObjectType = OTITEM then
    for searchx := X - Distance to X + Distance do
      for searchy := Y - Distance to Y + Distance do
        if (searchx >= 0) and (searchy >= 0) then
          try
            temparray1 := getitemsat2dpos(searchx, searchy);
            if Length(temparray1) > 0 then
              begin
                i := Length(temparray2);
                SetLength(temparray2, Length(temparray2) + Length(temparray1));
                Move(temparray1[0], temparray2[i], Length(temparray1) * 4);

              end;

          except
          end;

  Result := temparray2;

end;

function PrimitiveListObjectsNearLocationAccurate(ObjectType: Integer; X, Y: Word; Z: ShortInt;
         Distance: Cardinal): TPrimitiveObjectArray;
var
  i: Cardinal;
  temparray1, temparray2: TPrimitiveObjectArray;

begin
  temparray1 := PrimitiveListObjects(ObjectType);
  if not IsServerActive then
    Exit;

  if Length(temparray1) > 0 then
    for i := 0 to Length(temparray1) - 1 do
      if CheckDistance(X, PrimitiveGetObjectX(ObjectType, temparray1[i]), Y, PrimitiveGetObjectY(ObjectType, temparray1[i]),
         Z, PrimitiveGetObjectZ(ObjectType, temparray1[i])) <= Distance then
        if (ObjectType = OTITEM) and (datah.items[temparray1[i]].equipped = 0) and
           (datah.items[temparray1[i]].contained = 0) then
          begin
            SetLength(temparray2, Length(temparray2) + 1);
            temparray2[Length(temparray2) - 1] := temparray1[i];

          end

        else if (ObjectType = OTPLAYER) or (ObjectType = OTNPC) then
          begin
            SetLength(temparray2, Length(temparray2) + 1);
            temparray2[Length(temparray2) - 1] := temparray1[i];

          end;

  Result := temparray2;

end;

function PrimitiveGetObjectX(ObjectType: Integer; ObjectReference: Cardinal): Word;
begin
  if not IsServerActive then
    begin
      Result := 0;
      Exit;

    end;

  if ObjectType = OTPLAYER then
    begin
      Result := datah.players[ObjectReference].x;
      Exit;

    end;

  if ObjectType = OTNPC then
    begin
      Result := datah.npcs[ObjectReference].x;
      Exit;

    end;

  if ObjectType = OTITEM then
    begin
      Result := datah.items[ObjectReference].x;
      Exit;

    end;

  Result := 0;

end;

function PrimitiveGetObjectY(ObjectType: Integer; ObjectReference: Cardinal): Word;
begin
  if not IsServerActive then
    begin
      Result := 0;
      Exit;

    end;

  if ObjectType = OTPLAYER then
    begin
      Result := datah.players[ObjectReference].y;
      Exit;

    end;

  if ObjectType = OTNPC then
    begin
      Result := datah.npcs[ObjectReference].y;
      Exit;

    end;

  if ObjectType = OTITEM then
    begin
      Result := datah.items[ObjectReference].y;
      Exit;

    end;

  Result := 0;

end;

function PrimitiveGetObjectZ(ObjectType: Integer; ObjectReference: Cardinal): ShortInt;
begin
  if not IsServerActive then
    begin
      Result := 0;
      Exit;

    end;

  if ObjectType = OTPLAYER then
    begin
      Result := datah.players[ObjectReference].z;
      Exit;

    end;

  if ObjectType = OTNPC then
    begin
      Result := datah.npcs[ObjectReference].z;
      Exit;

    end;

  if ObjectType = OTITEM then
    begin
      Result := datah.items[ObjectReference].z;
      Exit;

    end;

  Result := 0;

end;

function PrimitiveGetEvent(NPC: Cardinal): TEvent;
var
  tempevs: teventarray;
  tempev: TEvent;

begin
  SetLength(tempevs, 0);
  tempev.evtype := ETNONE;
  if not IsServerActive then
    begin
      Result := tempev;
      Exit;

    end;

  if Length(datah.npcs[NPC].events) > 0 then
    begin
      while datah.npcs[NPC].eoc = True do
        Sleep(1);

      datah.npcs[NPC].eoc := True;
      tempev := datah.npcs[NPC].events[Length(datah.npcs[NPC].events) - 1];
      SetLength(tempevs, Length(datah.npcs[NPC].events) - 1);
      if Length(tempevs) > 0 then
        Move(datah.npcs[NPC].events[0], tempevs[0], Length(tempevs) * 4);

      datah.npcs[NPC].seteventslen(Length(tempevs));
      if Length(datah.npcs[NPC].events) > 0 then
        datah.npcs[NPC].events := tempevs;

      datah.npcs[NPC].eoc := False;

    end;

  Result := tempev;

end;

function GetEventType(Event: TEvent): Integer;
begin
  if not IsServerActive then
    begin
      Result := ETNONE;
      Exit;

    end;

  Result := Event.evtype;

end;

function GetEventIntegerValue(Event: TEvent): Integer;
begin
  if not IsServerActive then
    begin
      Result := 0;
      Exit;

    end;

  Result := Event.intval;

end;

function GetEventStringValue(Event: TEvent): String;
begin
  if not IsServerActive then
    begin
      Result := '';
      Exit;

    end;

  Result := Event.strval;

end;

function GetEventCardinalValue(Event: TEvent): Cardinal;
begin
  if not IsServerActive then
    begin
      Result := 0;
      Exit;

    end;

  Result := Event.cardval;

end;

procedure PrimitiveSetEvent(NPC: Cardinal; EventType: Integer; IntegerValue: Integer;
                            StringValue: String; CardinalValue: Cardinal);
var
  index: Cardinal;

begin
  if not IsServerActive then
    Exit;

  while datah.npcs[NPC].eoc = True do
    Sleep(1);

  datah.npcs[NPC].eoc := True;
  index := Length(datah.npcs[NPC].events);
  datah.npcs[NPC].seteventslen(index + 1);
  datah.npcs[NPC].eoc := False;
  datah.npcs[NPC].events[index].evtype := EventType;
  datah.npcs[NPC].events[index].intval := IntegerValue;
  datah.npcs[NPC].events[index].strval := StringValue;
  datah.npcs[NPC].events[index].cardval := CardinalValue;

end;

procedure PrimitiveEquipItem(ObjectType: Integer; ObjectReference, Item: Cardinal);
var
  index, i: Cardinal;
  objtype: Integer;
  objarray: TPrimitiveObjectArray;

begin
  if not IsServerActive or
     (PrimitiveGetEquipmentByLayer(ObjectType, ObjectReference,
     getstatictile(datah.items[Item].graphic).layer) > 0) or
     (getstatictile(datah.items[Item].graphic).flags and FLAGWEARABLE = 0) then
    Exit;

  if datah.items[Item].dragger > 0 then
    begin
      datah.players[datah.items[Item].dragger].dragging := False;
      datah.players[datah.items[Item].dragger].dragitem := 0;
      datah.players[datah.items[Item].dragger].dragamt := 0;
      denydragging(datah.items[Item].dragger);
      datah.items[Item].dragger := 0;
      datah.items[Item].occupied := False;

    end;

  while datah.items[Item].occupied do
    Sleep(1);

  datah.items[Item].occupied := True;
  SetLength(objarray, 0);
  if ObjectType = OTPLAYER then
    begin
      if datah.items[Item].contained > 0 then
        begin
          datah.items[Item].occupied := False;
          PrimitiveRemoveItem(Item, PrimitiveGetObject(OTITEM, datah.items[Item].contained), 0, 0, 0, 0);
          PrimitiveEquipItem(ObjectType, ObjectReference, Item);
          Exit;

        end;

      if datah.items[Item].equipped > 0 then
        begin
          objtype := CheckObjectType(datah.items[Item].equipped);
          datah.items[Item].occupied := False;
          PrimitiveUnequipItem(objtype, PrimitiveGetObject(objtype,
                               datah.items[Item].equipped), Item, 0, 0,
                               0);
          PrimitiveEquipItem(ObjectType, ObjectReference, Item);
          Exit;

        end;

      remitemfrom2dpos(Item, datah.items[Item].x, datah.items[Item].y);
      datah.items[Item].equipped := datah.players[ObjectReference].id;
      while datah.players[ObjectReference].eioc = True do
        Sleep(1);

      datah.players[ObjectReference].eioc := True;
      index := Length(datah.players[ObjectReference].equitems);
      datah.players[ObjectReference].setequitemslen(index + 1);
      datah.players[ObjectReference].eioc := False;
      datah.players[ObjectReference].equitems[index] := datah.items[Item].id;
      objarray := PrimitiveListObjectsNearLocation(OTPLAYER, datah.items[Item].x,
                                                   datah.items[Item].y, 16);
      if Length(objarray) > 0 then
        for i := 0 to Length(objarray) - 1 do
          if datah.players[objarray[i]].online and ((datah.items[Item].invisible = 0)
             or (datah.players[objarray[i]].privileged = 1)) then
            delobj(OTITEM, objarray[i], Item);

      objarray := PrimitiveListObjectsNearLocation(OTPLAYER, datah.players[ObjectReference].x,
                                                   datah.players[ObjectReference].y, 16);
      if Length(objarray) > 0 then
        for i := 0 to Length(objarray) - 1 do
          if datah.players[objarray[i]].online and ((datah.items[Item].invisible = 0)
             or (datah.players[objarray[i]].privileged = 1)) then
            if ((datah.players[ObjectReference].hidden = 0) or
               (datah.players[objarray[i]].privileged = 1)) then
              begin
                equitem(objarray[i], datah.players[ObjectReference].id, Item);
                equchanged(datah.players[ObjectReference].id, objarray[i]);

              end;

      datah.items[Item].occupied := False;
      startitemscript(datah.items[Item].scriptname, CardToStr(Item), IntToStr(ETEQUIPPED),
                      IntToStr(OTPLAYER), '', CardToStr(ObjectReference));

    end;

  if ObjectType = OTNPC then
    begin
      if datah.items[Item].contained > 0 then
        begin
          datah.items[Item].occupied := False;
          PrimitiveRemoveItem(Item, PrimitiveGetObject(OTITEM, datah.items[Item].contained), 0, 0, 0, 0);
          PrimitiveEquipItem(ObjectType, ObjectReference, Item);
          Exit;

        end;

      if datah.items[Item].equipped > 0 then
        begin
          objtype := CheckObjectType(datah.items[Item].equipped);
          datah.items[Item].occupied := False;
          PrimitiveUnequipItem(objtype, PrimitiveGetObject(objtype,
                               datah.items[Item].equipped), Item, 0, 0,
                               0);
          PrimitiveEquipItem(ObjectType, ObjectReference, Item);
          Exit;

        end;

      remitemfrom2dpos(Item, datah.items[Item].x, datah.items[Item].y);
      datah.items[Item].equipped := datah.npcs[ObjectReference].id;
      while datah.npcs[ObjectReference].eioc = True do
        Sleep(1);

      datah.npcs[ObjectReference].eioc := True;
      index := Length(datah.npcs[ObjectReference].equitems);
      datah.npcs[ObjectReference].setequitemslen(index + 1);
      datah.npcs[ObjectReference].eioc := False;
      datah.npcs[ObjectReference].equitems[index] := datah.items[Item].id;
      objarray := PrimitiveListObjectsNearLocation(OTPLAYER, datah.items[Item].x,
                                                   datah.items[Item].y, 16);
      if Length(objarray) > 0 then
        for i := 0 to Length(objarray) - 1 do
          if datah.players[objarray[i]].online and ((datah.items[Item].invisible = 0)
             or (datah.players[objarray[i]].privileged = 1)) then
            delobj(OTITEM, objarray[i], Item);

      objarray := PrimitiveListObjectsNearLocation(OTPLAYER, datah.npcs[ObjectReference].x,
                                                   datah.npcs[ObjectReference].y, 16);
      if Length(objarray) > 0 then
        for i := 0 to Length(objarray) - 1 do
          if datah.players[objarray[i]].online and ((datah.items[Item].invisible = 0)
             or (datah.players[objarray[i]].privileged = 1)) then
            if ((datah.npcs[ObjectReference].hidden = 0) or
               (datah.players[objarray[i]].privileged = 1)) then
              begin
                equitem(objarray[i], datah.npcs[ObjectReference].id, Item);
                equchanged(datah.npcs[ObjectReference].id, objarray[i]);

              end;

      datah.items[Item].occupied := False;
      startitemscript(datah.items[Item].scriptname, CardToStr(Item), IntToStr(ETEQUIPPED),
                      IntToStr(OTNPC), '', CardToStr(ObjectReference));

    end

  else
    datah.items[Item].occupied := False;

end;

procedure PrimitiveUnequipItem(ObjectType: Integer; ObjectReference, Item: Cardinal;
                      X, Y: Word; Z: ShortInt);
var
  wasequipped, i: Cardinal;
  temparray: Array of Cardinal;
  objarray: TPrimitiveObjectArray;

begin
  if not IsServerActive then
    Exit;

  if datah.items[Item].dragger > 0 then
    begin
      datah.players[datah.items[Item].dragger].dragging := False;
      datah.players[datah.items[Item].dragger].dragitem := 0;
      datah.players[datah.items[Item].dragger].dragamt := 0;
      denydragging(datah.items[Item].dragger);
      datah.items[Item].dragger := 0;
      datah.items[Item].occupied := False;

    end;

  while datah.items[Item].occupied do
    Sleep(1);
    
  datah.items[Item].occupied := True;
  SetLength(temparray, 0);
  SetLength(objarray, 0);
  if ObjectType = OTPLAYER then
    if datah.items[Item].equipped = datah.players[ObjectReference].id then
      begin
        wasequipped := datah.items[Item].equipped;
        datah.items[Item].equipped := 0;
        datah.items[Item].x := X;
        datah.items[Item].y := Y;
        additemto2dpos(Item, X, Y);
        datah.items[Item].z := Z;
        while datah.players[ObjectReference].eioc = True do
          Sleep(1);

        datah.players[ObjectReference].eioc := True;
        for i := 0 to Length(datah.players[ObjectReference].equitems) - 1 do
          if datah.players[ObjectReference].equitems[i] <> datah.items[Item].id then
            begin
              SetLength(temparray, Length(temparray) + 1);
              temparray[Length(temparray) - 1] := datah.players[ObjectReference].equitems[i];

            end;

        datah.players[ObjectReference].setequitemslen(Length(temparray));
        if Length(temparray) > 0 then
            for i := 0 to Length(temparray) - 1 do
              datah.players[ObjectReference].equitems[i] := temparray[i];

        datah.players[ObjectReference].eioc := False;
        objarray := PrimitiveListObjectsNearLocation(OTPLAYER, datah.players[ObjectReference].x,
                                                     datah.players[ObjectReference].y, 16);
        if Length(objarray) > 0 then
          for i := 0 to Length(objarray) - 1 do
            if datah.players[objarray[i]].online and ((datah.items[Item].invisible = 0)
               or (datah.players[objarray[i]].privileged = 1)) then
              begin
                if (datah.players[objarray[i]].id = datah.players[ObjectReference].id)
                   or (datah.players[ObjectReference].hidden = 0)
                   or (datah.players[objarray[i]].privileged = 1) then
                  begin
                    delobj(OTITEM, objarray[i], Item);
                    equchanged(wasequipped, objarray[i]);

                  end;

                updateobj(OTITEM, objarray[i], Item);
                addnouitem(Item, objarray[i]);

              end;

        datah.items[Item].occupied := False;
        startitemscript(datah.items[Item].scriptname, CardToStr(Item), IntToStr(ETUNEQUIPPED),
                        IntToStr(OTPLAYER), '', CardToStr(ObjectReference));

      end;

  if ObjectType = OTNPC then
    if datah.items[Item].equipped = datah.npcs[ObjectReference].id then
      begin
        wasequipped := datah.items[Item].equipped;
        datah.items[Item].equipped := 0;
        datah.items[Item].x := X;
        datah.items[Item].y := Y;
        additemto2dpos(Item, X, Y);
        datah.items[Item].z := Z;
        while datah.npcs[ObjectReference].eioc = True do
          Sleep(1);

        datah.npcs[ObjectReference].eioc := True;
        for i := 0 to Length(datah.npcs[ObjectReference].equitems) - 1 do
          if datah.npcs[ObjectReference].equitems[i] <> datah.items[Item].id then
            begin
              SetLength(temparray, Length(temparray) + 1);
              temparray[Length(temparray) - 1] := datah.npcs[ObjectReference].equitems[i];

            end;

        datah.npcs[ObjectReference].setequitemslen(Length(temparray));
        if Length(temparray) > 0 then
            for i := 0 to Length(temparray) - 1 do
              datah.npcs[ObjectReference].equitems[i] := temparray[i];

        datah.npcs[ObjectReference].eioc := False;
        objarray := PrimitiveListObjectsNearLocation(OTPLAYER, datah.npcs[ObjectReference].x,
                                                     datah.npcs[ObjectReference].y, 16);
        if Length(objarray) > 0 then
          for i := 0 to Length(objarray) - 1 do
            begin
              if datah.players[objarray[i]].online and ((datah.items[Item].invisible = 0)
                 or (datah.players[objarray[i]].privileged = 1)) then
                begin
                  if (datah.npcs[ObjectReference].hidden = 0) or
                     (datah.players[objarray[i]].privileged = 1) then
                    begin
                      delobj(OTITEM, objarray[i], Item);
                      equchanged(wasequipped, objarray[i]);

                    end;

                  updateobj(OTITEM, objarray[i], Item);
                  addnouitem(Item, objarray[i]);

                end;

            end;

        datah.items[Item].occupied := False;
        startitemscript(datah.items[Item].scriptname, CardToStr(Item), IntToStr(ETUNEQUIPPED),
                        IntToStr(OTNPC), '', CardToStr(ObjectReference));

      end

  else
    datah.items[Item].occupied := False;

end;

function PrimitiveCreateObject(ObjectType: Integer; TypeID: Cardinal; X, Y: Word;
         Z: ShortInt): Cardinal;
var
  index, id, itemtype, npctype, i, tempitem: Cardinal;
  objarray: TPrimitiveObjectArray;

begin
  SetLength(objarray, 0);
  index := 0;
  if not IsServerActive then
    begin
      Result := index;
      Exit;

    end;

  if ObjectType = OTITEM then
    begin
      itemtype := gettype(OTITEM, TypeID);
      if itemtype = 0 then
        begin
          Result := 0;
          Exit;

        end;

      hidlock.Acquire;
      id := highestid + 1;
      if (id and $0FFFFFFF) = id then
        begin
          highestid := id;
          hidlock.Release;

        end

      else
        begin
          printsm(10, 'Maximum ID capacity reached!');
          hidlock.Release;
          Result := 0;
          Exit;

        end;

      itemslock.Acquire;
      index := Length(items);
      SetLength(items, index + 1);
      itemslock.Release;
      datah.items[index] := titem.Create;
      datah.items[index].itemtype := TypeID;
      datah.items[index].amount := itemtypes[itemtype].amount;
      datah.items[index].lighting := itemtypes[itemtype].lighting;
      datah.items[index].x := X;
      datah.items[index].y := Y;
      datah.items[index].weight := itemtypes[itemtype].weight;
      datah.items[index].graphic := itemtypes[itemtype].graphic;
      datah.items[index].gump := itemtypes[itemtype].gump;
      datah.items[index].definsposx := itemtypes[itemtype].definsposx;
      datah.items[index].definsposy := itemtypes[itemtype].definsposy;
      datah.items[index].color := itemtypes[itemtype].color;
      datah.items[index].z := Z;
      datah.items[index].scriptname := itemtypes[itemtype].scriptname;
      datah.items[index].container := itemtypes[itemtype].container;
      datah.items[index].weapon := itemtypes[itemtype].weapon;
      datah.items[index].weapspeed := itemtypes[itemtype].weapspeed;
      datah.items[index].weapdamage := itemtypes[itemtype].weapdamage;
      datah.items[index].armor := itemtypes[itemtype].armor;
      datah.items[index].armorstr := itemtypes[itemtype].armorstr;
      datah.items[index].invisible := itemtypes[itemtype].invisible;
      datah.items[index].stackable := itemtypes[itemtype].stackable;
      datah.items[index].moveable := itemtypes[itemtype].moveable;
      datah.items[index].walkable := itemtypes[itemtype].walkable;
      if Length(itemtypes[itemtype].contitemtypes) > 0 then
        begin
          datah.items[index].setcontitemslen(Length(itemtypes[itemtype].contitemtypes));
          for i := 0 to Length(itemtypes[itemtype].contitemtypes) - 1 do
            begin
              tempitem := PrimitiveCreateObject(OTITEM, itemtypes[itemtype].contitemtypes[i], 0, 0, 0);
              if tempitem = 0 then
                begin
                  datah.items[index].setcontitemslen(i);
                  Break;

                end

              else
                begin
                  datah.items[tempitem].contained := id;
                  datah.items[index].contitems[i] := datah.items[tempitem].id;
                  remitemfrom2dpos(tempitem, 0, 0);

                end;

            end;

        end;

      if Length(itemtypes[itemtype].cprops) > 0 then
        begin
          datah.items[index].setcpropslen(Length(itemtypes[itemtype].cprops));
          for i := 0 to Length(itemtypes[itemtype].cprops) - 1 do
            datah.items[index].cprops[i] := itemtypes[itemtype].cprops[i];

        end;

      datah.items[index].occupied := False;
      datah.items[index].cioc := False;
      datah.items[index].cpoc := False;
      datah.items[index].id := id;
      additemto2dpos(index, X, Y);
      ihashlock.Acquire;
      itemhash[CardToStr(id)] := index;
      ihashlock.Release;
      othashlock.Acquire;
      objtypehash[CardToStr(id)] := OTITEM;
      othashlock.Release;
      objarray := PrimitiveListObjectsNearLocation(OTPLAYER, X, Y, 16);
      if Length(objarray) > 0 then
        for i := 0 to Length(objarray) - 1 do
          if datah.players[objarray[i]].online and ((datah.items[index].invisible = 0)
             or (datah.players[objarray[i]].privileged = 1)) then
            begin
              updateobj(OTITEM, objarray[i], index);
              addnouitem(index, objarray[i]);

            end;

    end;

  if ObjectType = OTNPC then
    begin
      npctype := gettype(OTNPC, TypeID);
      if npctype = 0 then
        begin
          Result := 0;
          Exit;

        end;

      hidlock.Acquire;
      id := highestid + 1;
      if (id and $0FFFFFFF) = id then
        begin
          highestid := id;
          hidlock.Release;

        end

      else
        begin
          printsm(10, 'Maximum ID capacity reached!');
          hidlock.Release;
          Result := 0;
          Exit;

        end;

      npcslock.Acquire;
      index := Length(npcs);
      SetLength(npcs, index + 1);
      npcslock.Release;
      datah.npcs[index] := tnpc.Create;
      datah.npcs[index].npctype := TypeID;
      datah.npcs[index].x := X;
      datah.npcs[index].y := Y;
      datah.npcs[index].z := Z;
      datah.npcs[index].name := npctypes[npctype].name;
      datah.npcs[index].sex := npctypes[npctype].sex;
      datah.npcs[index].str := npctypes[npctype].str;
      datah.npcs[index].dex := npctypes[npctype].dex;
      datah.npcs[index].int := npctypes[npctype].int;
      datah.npcs[index].hits := npctypes[npctype].hits;
      datah.npcs[index].mana := npctypes[npctype].mana;
      datah.npcs[index].fat := npctypes[npctype].fat;
      datah.npcs[index].magicdef := npctypes[npctype].magicdef;
      datah.npcs[index].battledef := npctypes[npctype].battledef;
      datah.npcs[index].stealing := npctypes[npctype].stealing;
      datah.npcs[index].hiding := npctypes[npctype].hiding;
      datah.npcs[index].firstaid := npctypes[npctype].firstaid;
      datah.npcs[index].detecttr := npctypes[npctype].detecttr;
      datah.npcs[index].peek := npctypes[npctype].peek;
      datah.npcs[index].magic := npctypes[npctype].magic;
      datah.npcs[index].melee := npctypes[npctype].melee;
      datah.npcs[index].rangedweap := npctypes[npctype].rangedweap;
      datah.npcs[index].level := npctypes[npctype].level;
      datah.npcs[index].privileged := npctypes[npctype].privileged;
      datah.npcs[index].hidden := npctypes[npctype].hidden;
      datah.npcs[index].war := npctypes[npctype].war;
      datah.npcs[index].facing := npctypes[npctype].facing;
      datah.npcs[index].criminal := npctypes[npctype].criminal;
      datah.npcs[index].graphic := npctypes[npctype].graphic;
      datah.npcs[index].exp := npctypes[npctype].exp;
      datah.npcs[index].scriptname := npctypes[npctype].scriptname;
      datah.npcs[index].eioc := False;
      datah.npcs[index].cpoc := False;
      datah.npcs[index].eoc := False;
      datah.npcs[index].id := id;
      addnpcto2dpos(index, X, Y);
      nhashlock.Acquire;
      npchash[CardToStr(id)] := index;
      nhashlock.Release;
      othashlock.Acquire;
      objtypehash[CardToStr(id)] := OTNPC;
      othashlock.Release;
      if Length(npctypes[npctype].equitemtypes) > 0 then
        begin
          datah.npcs[index].setequitemslen(Length(npctypes[npctype].equitemtypes));
          for i := 0 to Length(npctypes[npctype].equitemtypes) - 1 do
            begin
              tempitem := PrimitiveCreateObject(OTITEM, npctypes[npctype].equitemtypes[i], 0, 0, 0);
              if tempitem = 0 then
                begin
                  datah.npcs[index].setequitemslen(i);
                  Break;

                end

              else
                begin
                  datah.items[tempitem].equipped := id;
                  datah.npcs[index].equitems[i] := datah.items[tempitem].id;
                  remitemfrom2dpos(tempitem, 0, 0);

                end;

            end;

        end;

      if Length(npctypes[npctype].cprops) > 0 then
        begin
          datah.npcs[index].setcpropslen(Length(npctypes[npctype].cprops));
          for i := 0 to Length(npctypes[npctype].cprops) - 1 do
            datah.npcs[index].cprops[i] := npctypes[npctype].cprops[i];

        end;

      objarray := PrimitiveListObjectsNearLocation(OTPLAYER, X, Y, 16);
      if Length(objarray) > 0 then
        for i := 0 to Length(objarray) - 1 do
          if datah.players[objarray[i]].online and ((datah.npcs[index].hidden = 0)
             or (datah.players[objarray[i]].privileged = 1)) then
            begin
              updateobj(OTNPC, objarray[i], index);
              updateequ(OTNPC, objarray[i], index);

            end;

      startnpcscript(datah.npcs[index].scriptname, CardToStr(index));

    end;

  Result := index;

end;

procedure PrimitiveDeleteObject(ObjectType: Integer; ObjectReference: Cardinal);
var
  id, i, objtype: Cardinal;
  objarray: TPrimitiveObjectArray;
  oldxm, oldym, x, y: Word;

begin
  if not IsServerActive or
     not PrimitiveObjectExists(ObjectType, ObjectReference) then
    Exit;

  SetLength(objarray, 0);
  if ObjectType = OTITEM then
    begin
      if datah.items[ObjectReference].container = 1 then
        begin
          objarray := PrimitiveListItemsInContainer(ObjectReference);
          if Length(objarray) > 0 then
            for i := 0 to Length(objarray) - 1 do
              PrimitiveDeleteObject(OTITEM, objarray[i]);

          SetLength(objarray, 0);

        end;

      if datah.items[ObjectReference].equipped > 0 then
        begin
          objtype := CheckObjectType(datah.items[ObjectReference].equipped);
          datah.items[ObjectReference].occupied := False;
          PrimitiveUnequipItem(objtype, PrimitiveGetObject(objtype,
                               datah.items[ObjectReference].equipped), ObjectReference, 0, 0,
                               0);

        end;

      if datah.items[ObjectReference].contained > 0 then
        begin
          oldxm := PrimitiveGetObjectXMain(OTITEM, ObjectReference);
          oldym := PrimitiveGetObjectYMain(OTITEM, ObjectReference);
          datah.items[ObjectReference].occupied := False;
          PrimitiveRemoveItem(ObjectReference, PrimitiveGetObject(OTITEM,
                              datah.items[ObjectReference].contained), 0, 0, 0,
                              datah.items[ObjectReference].amount);
          objarray := PrimitiveListObjectsNearLocation(OTPLAYER, oldxm,
                                                       oldym, 16);
          if Length(objarray) > 0 then
            for i := 0 to Length(objarray) - 1 do
              begin
                if datah.players[objarray[i]].online and ((datah.items[ObjectReference].invisible = 0)
                   or (datah.players[objarray[i]].privileged = 1))then
                  delobj(OTITEM, objarray[i], ObjectReference);

              end;

        end;

      datah.items[ObjectReference].occupied := True;
      if datah.items[ObjectReference].dragger > 0 then
        begin
          datah.players[datah.items[ObjectReference].dragger].dragging := False;
          datah.players[datah.items[ObjectReference].dragger].dragitem := 0;
          datah.players[datah.items[ObjectReference].dragger].dragamt := 0;
          denydragging(datah.items[ObjectReference].dragger);

        end;

      objarray := PrimitiveListObjectsNearLocation(OTPLAYER, datah.items[ObjectReference].x,
                                                   datah.items[ObjectReference].y, 16);
      if Length(objarray) > 0 then
        for i := 0 to Length(objarray) - 1 do
          begin
            if datah.players[objarray[i]].online and ((datah.items[ObjectReference].invisible = 0)
               or (datah.players[objarray[i]].privileged = 1))then
              delobj(OTITEM, objarray[i], ObjectReference);

          end;

      if datah.items[ObjectReference].inaccessible then
        Exit;

      id := datah.items[ObjectReference].id;
      x := datah.items[ObjectReference].x;
      y := datah.items[ObjectReference].y;
      datah.items[ObjectReference].inaccessible := True;
      hidlock.Acquire;
      if highestid = datah.items[ObjectReference].id then
        highestid := highestid - 1;

      hidlock.Release;
      ihashlock.Acquire;
      itemhash.Delete(CardToStr(id));
      ihashlock.Release;
      othashlock.Acquire;
      objtypehash.Delete(CardToStr(id));
      othashlock.Release;
      remitemfrom2dpos(ObjectReference, x, y);
      itemslock.Acquire;
      datah.items[ObjectReference].Destroy;
      datah.items[ObjectReference] := nil;
      if ObjectReference = Cardinal(Length(items) - 1) then
        SetLength(items, Length(items) - 1);

      itemslock.Release;

    end

  else if ObjectType = OTPLAYER then
    begin
      if datah.players[ObjectReference].client <> nil then
        try
          (datah.players[ObjectReference].client as tclient).Shutdown(0);

        finally
        end;

      objarray := PrimitiveListEquippedItems(ObjectType, ObjectReference);
      if Length(objarray) > 0 then
        for i := 0 to Length(objarray) - 1 do
          PrimitiveDeleteObject(OTITEM, objarray[i]);

      SetLength(objarray, 0);
      objarray := PrimitiveListObjectsNearLocation(OTPLAYER, datah.players[ObjectReference].x,
                                                   datah.players[ObjectReference].y, 16);
      if Length(objarray) > 0 then
        for i := 0 to Length(objarray) - 1 do
          begin
            if datah.players[objarray[i]].online and ((datah.players[ObjectReference].hidden = 0)
               or (datah.players[objarray[i]].privileged = 1))then
              delobj(OTPLAYER, objarray[i], ObjectReference);

          end;

      if datah.players[ObjectReference].inaccessible then
        Exit;

      id := datah.players[ObjectReference].id;
      x := datah.players[ObjectReference].x;
      y := datah.players[ObjectReference].y;
      datah.players[ObjectReference].inaccessible := True;
      hidlock.Acquire;
      if highestid = datah.players[ObjectReference].id then
        highestid := highestid - 1;

      hidlock.Release;
      phashlock.Acquire;
      playerhash.Delete(CardToStr(id));
      phashlock.Release;
      othashlock.Acquire;
      objtypehash.Delete(CardToStr(id));
      othashlock.Release;
      remplayerfrom2dpos(ObjectReference, x, y);
      playerslock.Acquire;
      datah.players[ObjectReference].Destroy;
      datah.players[ObjectReference] := nil;
      if ObjectReference = Cardinal(Length(players) - 1) then
        SetLength(players, Length(players) - 1);

      playerslock.Release;

    end

  else if ObjectType = OTNPC then
    begin
      objarray := PrimitiveListEquippedItems(ObjectType, ObjectReference);
      if Length(objarray) > 0 then
        for i := 0 to Length(objarray) - 1 do
          PrimitiveDeleteObject(OTITEM, objarray[i]);

      SetLength(objarray, 0);
      objarray := PrimitiveListObjectsNearLocation(OTPLAYER, datah.npcs[ObjectReference].x,
                                                   datah.npcs[ObjectReference].y, 16);
      if Length(objarray) > 0 then
        for i := 0 to Length(objarray) - 1 do
          begin
            if datah.players[objarray[i]].online and ((datah.npcs[ObjectReference].hidden = 0)
               or (datah.players[objarray[i]].privileged = 1))then
              delobj(OTNPC, objarray[i], ObjectReference);

          end;

      if datah.npcs[ObjectReference].inaccessible then
        Exit;

      id := datah.npcs[ObjectReference].id;
      x := datah.npcs[ObjectReference].x;
      y := datah.npcs[ObjectReference].y;
      datah.npcs[ObjectReference].inaccessible := True;
      hidlock.Acquire;
      if highestid = datah.npcs[ObjectReference].id then
        highestid := highestid - 1;

      hidlock.Release;
      nhashlock.Acquire;
      npchash.Delete(CardToStr(id));
      nhashlock.Release;
      othashlock.Acquire;
      objtypehash.Delete(CardToStr(id));
      othashlock.Release;
      remnpcfrom2dpos(ObjectReference, x, y);
      npcslock.Acquire;
      datah.npcs[ObjectReference].Destroy;
      datah.npcs[ObjectReference] := nil;
      if ObjectReference = Cardinal(Length(npcs) - 1) then
        SetLength(npcs, Length(npcs) - 1);

      npcslock.Release;

    end;

end;

procedure PrimitiveInsertItem(Item, Container: Cardinal; X, Y, Amount: Word);
var
  index, i, tempcard, tempindex: Cardinal;
  objtype: Integer;
  tempitem: titem;
  objarray: TPrimitiveObjectArray;

begin
  if not IsServerActive then
    Exit;

  if datah.items[Item].dragger > 0 then
    begin
      datah.players[datah.items[Item].dragger].dragging := False;
      datah.players[datah.items[Item].dragger].dragitem := 0;
      datah.players[datah.items[Item].dragger].dragamt := 0;
      denydragging(datah.items[Item].dragger);
      datah.items[Item].dragger := 0;
      datah.items[Item].occupied := False;

    end;
    
  while datah.items[Item].occupied do
    Sleep(1);

  datah.items[Item].occupied := True;
  SetLength(objarray, 0);
  if (datah.items[Item].id = 0) or (datah.items[Container].id = 0) then
    begin
      datah.items[Item].occupied := False;
      Exit;

    end;

  if datah.items[Container].container = 1 then
    begin
      if X = DEFINSPOS then
        X := datah.items[Container].definsposx;

      if Y = DEFINSPOS then
        Y := datah.items[Container].definsposy;

      if datah.items[Item].equipped > 0 then
        begin
          objtype := CheckObjectType(datah.items[Item].equipped);
          datah.items[Item].occupied := False;
          PrimitiveUnequipItem(objtype, PrimitiveGetObject(objtype, datah.items[Item].equipped), Item,
                               0, 0, 0);
          PrimitiveInsertItem(Item, Container, X, Y, Amount);
          Exit;

        end;

      if Amount > datah.items[Item].amount then
        Amount := datah.items[Item].amount;

      if (Amount = datah.items[Item].amount) or (datah.items[Item].stackable = 0) then
        begin
          if datah.items[Item].contained > 0 then
            begin
              datah.items[Item].occupied := False;
              PrimitiveRemoveItem(Item, PrimitiveGetObject(OTITEM, datah.items[Item].contained), 0, 0, 0,
                                  Amount);
              PrimitiveInsertItem(Item, Container, X, Y, Amount);
              Exit;

            end;

          datah.items[Item].contained := datah.items[Container].id;
          while datah.items[Container].cioc = True do
            Sleep(1);

          datah.items[Container].cioc := True;
          index := Length(datah.items[Container].contitems);
          datah.items[Container].setcontitemslen(index + 1);
          datah.items[Container].cioc := False;
          datah.items[Container].contitems[index] := datah.items[Item].id;
          objarray := PrimitiveListObjectsNearLocation(OTPLAYER, datah.items[Item].x,
                                              datah.items[Item].y, 16);
          if Length(objarray) > 0 then
            for i := 0 to Length(objarray) - 1 do
              if datah.players[objarray[i]].online and ((datah.items[Item].invisible = 0)
                 or (datah.players[objarray[i]].privileged = 1)) then
                delobj(OTITEM, objarray[i], Item);

          remitemfrom2dpos(Item, datah.items[Item].x, datah.items[Item].y);
          datah.items[Item].x := X;
          datah.items[Item].y := Y;
          objarray := PrimitiveListObjectsNearLocation(OTPLAYER, PrimitiveGetObjectXMain(OTITEM, Container),
                                                       PrimitiveGetObjectYMain(OTITEM, Container), 16);
          if Length(objarray) > 0 then
            for i := 0 to Length(objarray) - 1 do
              if datah.players[objarray[i]].online and ((datah.items[Item].invisible = 0)
                 or (datah.players[objarray[i]].privileged = 1)) and
                 ((datah.items[PrimitiveGetMainContainer(Item)].equipped = 0) or
                 PrimitiveIsUnhidden(CheckObjectType(datah.items[PrimitiveGetMainContainer(Item)].equipped), PrimitiveGetObject(CheckObjectType(datah.items[PrimitiveGetMainContainer(Item)].equipped),
                                     datah.items[PrimitiveGetMainContainer(Item)].equipped)) or
                 (datah.players[objarray[i]].privileged = 1)) and
                 ((datah.items[Container].invisible = 0) or (datah.players[objarray[i]].privileged = 1)) then
                insitem(objarray[i], datah.items[Item].id);

          datah.items[Item].occupied := False;
          startitemscript(datah.items[Item].scriptname, CardToStr(Item), IntToStr(ETINSERTED),
                          '', '', CardToStr(Container));

        end

      else if (Amount < datah.items[Item].amount) and (datah.items[Item].stackable = 1) then
        begin
          if (datah.items[Item].id = 0) or (datah.items[Container].id = 0) then
            begin
              datah.items[Item].occupied := False;
              Exit;

            end;

          hidlock.Acquire;
          tempcard := highestid + 1;
          if (tempcard and $0FFFFFFF) = tempcard then
            begin
              highestid := tempcard;
              hidlock.Release;

            end

          else
            begin
              printsm(10, 'Maximum ID capacity reached!');
              hidlock.Release;
              datah.items[Item].occupied := False;
              Exit;

            end;

          datah.items[Item].amount := datah.items[Item].amount - Amount;
          tempitem := datah.items[Item].clone;
          if tempitem = nil then
            Exit;

          itemslock.Acquire;
          index := Length(items);
          SetLength(items, index + 1);
          itemslock.Release;
          tempitem.id := tempcard;
          tempitem.amount := Amount;
          tempitem.x := X;
          tempitem.y := Y;
          tempitem.occupied := False;
          datah.items[index] := tempitem;
          ihashlock.Acquire;
          itemhash[CardToStr(tempcard)] := index;
          ihashlock.Release;
          othashlock.Acquire;
          objtypehash[CardToStr(tempcard)] := OTITEM;
          othashlock.Release;
          datah.items[index].contained := datah.items[Container].id;
          while datah.items[Container].cioc = True do
            Sleep(1);

          datah.items[Container].cioc := True;
          tempindex := Length(datah.items[Container].contitems);
         datah.items[Container].setcontitemslen(tempindex + 1);
          datah.items[Container].cioc := False;
          datah.items[Container].contitems[tempindex] := tempcard;
          objarray := PrimitiveListObjectsNearLocation(OTPLAYER, PrimitiveGetObjectXMain(OTITEM, Item),
                                              PrimitiveGetObjectXMain(OTITEM, Item), 16);
          if Length(objarray) > 0 then
            for i := 0 to Length(objarray) - 1 do
              if datah.players[objarray[i]].online and ((datah.items[Item].invisible = 0)
                 or (datah.players[objarray[i]].privileged = 1)) then
                if datah.items[Item].contained = 0 then
                  updateobj(OTITEM, objarray[i], Item)

                else
                  if ((datah.items[PrimitiveGetMainContainer(Item)].equipped = 0) or
                     PrimitiveIsUnhidden(CheckObjectType(datah.items[PrimitiveGetMainContainer(Item)].equipped), PrimitiveGetObject(CheckObjectType(datah.items[PrimitiveGetMainContainer(Item)].equipped),
                                         datah.items[PrimitiveGetMainContainer(Item)].equipped)) or
                     (datah.players[objarray[i]].privileged = 1)) and
                     ((datah.items[Container].invisible = 0) or (datah.players[objarray[i]].privileged = 1)) then
                    insitem(objarray[i], datah.items[Item].id);

          objarray := PrimitiveListObjectsNearLocation(OTPLAYER, PrimitiveGetObjectXMain(OTITEM, Container),
                                                       PrimitiveGetObjectYMain(OTITEM, Container), 16);
          if Length(objarray) > 0 then
            for i := 0 to Length(objarray) - 1 do
              if datah.players[objarray[i]].online and ((datah.items[index].invisible
                 = 0) or (datah.players[objarray[i]].privileged = 1)) and
                 ((datah.items[PrimitiveGetMainContainer(Item)].equipped = 0) or
                 PrimitiveIsUnhidden(CheckObjectType(datah.items[PrimitiveGetMainContainer(Item)].equipped), PrimitiveGetObject(CheckObjectType(datah.items[PrimitiveGetMainContainer(Item)].equipped),
                                     datah.items[PrimitiveGetMainContainer(Item)].equipped)) or
                 (datah.players[objarray[i]].privileged = 1)) and
                 ((datah.items[Container].invisible = 0) or (datah.players[objarray[i]].privileged = 1)) then
                insitem(objarray[i], tempcard);

          datah.items[Item].occupied := False;
          startitemscript(datah.items[Item].scriptname, CardToStr(Item), IntToStr(ETUNSTACKED),
                          '', '', CardToStr(index));

        end;

    end

  else
    begin
      Exit;
      datah.items[Item].occupied := False;

    end;

  if datah.items[Item].occupied then
    datah.items[Item].occupied := False;
    
  startitemscript(datah.items[Container].scriptname, CardToStr(Container), IntToStr(ETITEMINSERTED),
                  '', '', CardToStr(Item));

end;

procedure PrimitiveOpenContainer(Player, Container: Cardinal);
var
  pbuf: Array of Byte;
  tempcard, i: Cardinal;
  tempword: Word;
  temparray: TPrimitiveObjectArray;

begin
  if not IsServerActive then
    Exit;

  SetLength(pbuf, 10);
  pbuf[0] := $FE;
  pbuf[1] := $42;
  pbuf[2] := $00;
  pbuf[3] := $0A;
  tempcard := swapdword(datah.items[Container].id or $40000000);
  Move(tempcard, pbuf[4], 4);
  tempword := swapword(datah.items[Container].gump);
  Move(tempword, pbuf[8], 2);
  try
    datah.players[Player].client.Send(Addr(pbuf[0]), 10);
    datah.players[Player].client.Flush;

  except
    Exit;

  end;
  updatecontitems(Player, Container);
  while datah.players[Player].ococ do
    Sleep(1);

  datah.players[Player].ococ := True;
  SetLength(temparray, 0);
  if Length(datah.players[Player].openconts) > 0 then
    for i := 0 to Length(datah.players[Player].openconts) - 1 do
      if (datah.players[Player].openconts[i] <> Container) and
         (PrimitiveGetMainContainer(datah.players[Player].openconts[i]) <> Container) then
        begin
          SetLength(temparray, Length(temparray) + 1);
          temparray[Length(temparray) - 1] := datah.players[Player].openconts[i];

        end;

  SetLength(temparray, Length(temparray) + 1);
  temparray[Length(temparray) - 1] := Container;
  datah.players[Player].setopencontslen(Length(temparray));
  datah.players[Player].openconts := temparray;
  datah.players[Player].ococ := False;

end;

procedure PrimitiveRemoveItem(Item, Container: Cardinal; X, Y: Word; Z: ShortInt;
                     Amount: Word);
var
  index, i, tempcard: Cardinal;
  tempitem: titem;
  objarray: TPrimitiveObjectArray;
  temparray: Array of Cardinal;

begin
  if not IsServerActive then
    Exit;

  if datah.items[Item].dragger > 0 then
    begin
      datah.players[datah.items[Item].dragger].dragging := False;
      datah.players[datah.items[Item].dragger].dragitem := 0;
      datah.players[datah.items[Item].dragger].dragamt := 0;
      denydragging(datah.items[Item].dragger);
      datah.items[Item].dragger := 0;
      datah.items[Item].occupied := False;

    end;
    
  while datah.items[Item].occupied do
    Sleep(1);
    
  datah.items[Item].occupied := True;
  SetLength(objarray, 0);
  if (datah.items[Item].id = 0) or (datah.items[Container].id = 0) then
    begin
      datah.items[Item].occupied := False;
      Exit;

    end;

  if datah.items[Container].container = 1 then
    begin
      if Amount > datah.items[Item].amount then
        Amount := datah.items[Item].amount;

      if (Amount = datah.items[Item].amount) or (datah.items[Item].stackable = 0) then
        begin
          datah.items[Item].contained := 0;
          SetLength(temparray, 0);
          while datah.items[Container].cioc = True do
            Sleep(1);

          datah.items[Container].cioc := True;
          for i := 0 to Length(datah.items[Container].contitems) - 1 do
            if datah.items[Container].contitems[i] <> datah.items[Item].id then
              begin
                SetLength(temparray, Length(temparray) + 1);
                temparray[Length(temparray) - 1] := datah.items[Container].contitems[i];

              end;

          datah.items[Container].setcontitemslen(Length(temparray));
          if Length(temparray) > 0 then
            for i := 0 to Length(temparray) - 1 do
              datah.items[Container].contitems[i] := temparray[i];

          datah.items[Container].cioc := False;
          objarray := PrimitiveListObjectsNearLocation(OTPLAYER, PrimitiveGetObjectXMain(OTITEM, Container),
                                                       PrimitiveGetObjectYMain(OTITEM, Container), 16);
          if Length(objarray) > 0 then
            for i := 0 to Length(objarray) - 1 do
              if datah.players[objarray[i]].online and ((datah.items[Item].invisible = 0)
                 or (datah.players[objarray[i]].privileged = 1)) then
                delobj(OTITEM, objarray[i], Item);

          datah.items[Item].x := X;
          datah.items[Item].y := Y;
          additemto2dpos(Item, datah.items[Item].x, datah.items[Item].y);
          datah.items[Item].z := Z;
          objarray := PrimitiveListObjectsNearLocation(OTPLAYER, X, Y, 16);
          if Length(objarray) > 0 then
            for i := 0 to Length(objarray) - 1 do
              if datah.players[objarray[i]].online and ((datah.items[Item].invisible = 0)
                 or (datah.players[objarray[i]].privileged = 1)) then
                begin
                  updateobj(OTITEM, objarray[i], Item);
                  addnouitem(Item, objarray[i]);

                end;

          datah.items[Item].occupied := False;
          startitemscript(datah.items[Item].scriptname, CardToStr(Item), IntToStr(ETREMOVED),
                          '', '', CardToStr(Container));

        end

      else if (Amount < datah.items[Item].amount) and (datah.items[Item].stackable = 1) then
        begin
          if (datah.items[Item].id = 0) or (datah.items[Container].id = 0) then
            Exit;

          hidlock.Acquire;
          tempcard := highestid + 1;
          if (tempcard and $0FFFFFFF) = tempcard then
            begin
              highestid := tempcard;
              hidlock.Release;

            end

          else
            begin
              printsm(10, 'Maximum ID capacity reached!');
              hidlock.Release;
              datah.items[Item].occupied := False;
              Exit;

            end;

          datah.items[Item].amount := datah.items[Item].amount - Amount;
          tempitem := datah.items[Item].clone;
          if tempitem = nil then
            Exit;
            
          itemslock.Acquire;
          index := Length(items);
          SetLength(items, index + 1);
          itemslock.Release;
          tempitem.id := tempcard;
          tempitem.amount := Amount;
          tempitem.x := X;
          tempitem.y := Y;
          additemto2dpos(index, X, Y);
          tempitem.z := Z;
          tempitem.occupied := False;
          datah.items[index] := tempitem;
          ihashlock.Acquire;
          itemhash[CardToStr(tempcard)] := index;
          ihashlock.Release;
          othashlock.Acquire;
          objtypehash[CardToStr(tempcard)] := OTITEM;
          othashlock.Release;
          datah.items[index].contained := 0;
          objarray := PrimitiveListObjectsNearLocation(OTPLAYER, datah.items[index].x,
                                                       datah.items[index].y, 16);
          if Length(objarray) > 0 then
            for i := 0 to Length(objarray) - 1 do
              if datah.players[objarray[i]].online and ((datah.items[index].invisible = 0)
                 or (datah.players[objarray[i]].privileged = 1)) then
                begin
                  updateobj(OTITEM, objarray[i], index);
                  addnouitem(index, objarray[i]);

                end;

          objarray := PrimitiveListObjectsNearLocation(OTPLAYER, PrimitiveGetObjectXMain(OTITEM, Container),
                                                       PrimitiveGetObjectYMain(OTITEM, Container), 16);
          if Length(objarray) > 0 then
            for i := 0 to Length(objarray) - 1 do
              if datah.players[objarray[i]].online and ((datah.items[Item].invisible
                 = 0) or (datah.players[objarray[i]].privileged = 1)) and
                 ((datah.items[PrimitiveGetMainContainer(Item)].equipped = 0) or
                 PrimitiveIsUnhidden(CheckObjectType(datah.items[PrimitiveGetMainContainer(Item)].equipped), PrimitiveGetObject(CheckObjectType(datah.items[PrimitiveGetMainContainer(Item)].equipped),
                                     datah.items[PrimitiveGetMainContainer(Item)].equipped)) or
                 (datah.players[objarray[i]].privileged = 1)) and
                 ((datah.items[Container].invisible = 0) or (datah.players[objarray[i]].privileged = 1)) then
                insitem(objarray[i], datah.items[Item].id);

          datah.items[Item].occupied := False;
          startitemscript(datah.items[Item].scriptname, CardToStr(Item), IntToStr(ETUNSTACKED),
                          '', '', CardToStr(index));

        end;

    end

  else
    begin
      datah.items[Item].occupied := False;
      Exit;

    end;

  if datah.items[Item].occupied then
    datah.items[Item].occupied := False;

  startitemscript(datah.items[Container].scriptname, CardToStr(Container), IntToStr(ETITEMREMOVED),
                  '', '', CardToStr(Item));

end;

function PrimitiveGetMainContainer(Item: Cardinal): Cardinal;
var
  i: Cardinal;

begin
  i := 0;
  if not IsServerActive then
    begin
      Result := i;
      Exit;

    end;

  if datah.items[Item].contained > 0 then
    begin
      i := Item;
      while datah.items[i].contained > 0 do
        i := PrimitiveGetObject(OTITEM, datah.items[i].contained);

    end;

  Result := i;

end;

procedure PrimitiveSetAmount(Item: Cardinal; Amount: Word);
begin
  if not IsServerActive then
    Exit;

  if datah.items[Item].stackable = 0 then
    Exit;

  datah.items[Item].amount := Amount;
  updateobjao(OTITEM, Item);

end;

function PrimitiveGetSex(ObjectType: Integer; ObjectReference: Cardinal): Integer;
var
  sex: Integer;

begin
  sex := 0;
  if not IsServerActive then
    begin
      Result := sex;
      Exit;

    end;

  if ObjectType = OTPLAYER then
    sex := datah.players[ObjectReference].sex;

  if ObjectType = OTNPC then
    sex := datah.npcs[ObjectReference].sex;

  Result := sex;

end;

procedure PrimitiveSetColor(Item: Cardinal; Color: Word);
begin
  if not IsServerActive then
    Exit;

  datah.items[Item].color := Color;
  delobjao(OTITEM, Item);
  updateobjao(OTITEM, Item);

end;

procedure PrimitivePlayAnimationPrivate(Player: Cardinal; ObjectType: Integer;
                               ObjectReference: Cardinal; Animation: Integer);
var
  pbuf: Array of Byte;
  tempcard: Cardinal;

begin
  if not IsServerActive then
    Exit;

  SetLength(pbuf, 13);
  pbuf[0] := $FE;
  pbuf[1] := $4E;
  pbuf[2] := $00;
  pbuf[3] := $0D;
  pbuf[4] := Animation;
  tempcard := 0;
  if ObjectType = OTPLAYER then
    tempcard := swapdword(datah.players[ObjectReference].id);

  if ObjectType = OTNPC then
    tempcard := swapdword(datah.npcs[ObjectReference].id);

  Move(tempcard, pbuf[5], 4);
  Move(tempcard, pbuf[9], 4);
  try
    datah.players[Player].client.Send(Addr(pbuf[0]), 13);
    datah.players[Player].client.Flush;

  except
    Exit;

  end;

end;

procedure PrimitivePlayAnimation(ObjectType: Integer; ObjectReference: Cardinal;
                        Animation: Integer);
var
  objarray: TPrimitiveObjectArray;
  i: Cardinal;

begin
  if not IsServerActive then
    Exit;

  SetLength(objarray, 0);
  objarray := PrimitiveListObjectsNearLocation(OTPLAYER, PrimitiveGetObjectX(ObjectType,
                                               ObjectReference), PrimitiveGetObjectY(ObjectType,
                                               ObjectReference), 16);
  if Length(objarray) > 0 then
    for i := 0 to Length(objarray) - 1 do
      if (PrimitiveIsUnhidden(ObjectType, ObjectReference) or
         (datah.players[objarray[i]].privileged = 1)) and  datah.players[objarray[i]].online then
        PrimitivePlayAnimationPrivate(objarray[i], ObjectType, ObjectReference, Animation);

end;

function PrimitiveGetObjectXMain(ObjectType: Integer; ObjectReference: Cardinal): Word;
var
  objx: Word;
  obj, maincont: Cardinal;
  objtype: Integer;

begin
  objx := 0;
  if not IsServerActive then
    begin
      Result := objx;
      Exit;

    end;

  if ObjectType = OTPLAYER then
    objx := datah.players[ObjectReference].x

  else if ObjectType = OTNPC then
    objx := datah.npcs[ObjectReference].x

  else if ObjectType = OTITEM then
    begin
      objx := datah.items[ObjectReference].x;
      if datah.items[ObjectReference].equipped > 0 then
        begin
          objtype := CheckObjectType(datah.items[ObjectReference].equipped);
          obj := PrimitiveGetObject(objtype, datah.items[ObjectReference].equipped);
          objx := PrimitiveGetObjectX(objtype, obj);

        end

      else if datah.items[ObjectReference].contained > 0 then
        begin
          maincont := PrimitiveGetMainContainer(ObjectReference);
          objx := datah.items[maincont].x;
          if datah.items[maincont].equipped > 0 then
            begin
              objtype := CheckObjectType(datah.items[maincont].equipped);
              obj := PrimitiveGetObject(objtype, datah.items[maincont].equipped);
              objx := PrimitiveGetObjectX(objtype, obj);

            end;

        end;

    end;

  Result := objx;

end;

function PrimitiveGetObjectYMain(ObjectType: Integer; ObjectReference: Cardinal): Word;
var
  objy: Word;
  obj, maincont: Cardinal;
  objtype: Integer;

begin
  objy := 0;
  if not IsServerActive then
    begin
      Result := objy;
      Exit;

    end;

  if ObjectType = OTPLAYER then
    objy := datah.players[ObjectReference].y

  else if ObjectType = OTNPC then
    objy := datah.npcs[ObjectReference].y

  else if ObjectType = OTITEM then
    begin
      objy := datah.items[ObjectReference].y;
      if datah.items[ObjectReference].equipped > 0 then
        begin
          objtype := CheckObjectType(datah.items[ObjectReference].equipped);
          obj := PrimitiveGetObject(objtype, datah.items[ObjectReference].equipped);
          objy := PrimitiveGetObjectY(objtype, obj);

        end

      else if datah.items[ObjectReference].contained > 0 then
        begin
          maincont := PrimitiveGetMainContainer(ObjectReference);
          objy := datah.items[maincont].y;
          if datah.items[maincont].equipped > 0 then
            begin
              objtype := CheckObjectType(datah.items[maincont].equipped);
              obj := PrimitiveGetObject(objtype, datah.items[maincont].equipped);
              objy := PrimitiveGetObjectY(objtype, obj);

            end;

        end;

    end;

  Result := objy;

end;

function PrimitiveGetObjectZMain(ObjectType: Integer; ObjectReference: Cardinal): ShortInt;
var
  objz: ShortInt;
  obj, maincont: Cardinal;
  objtype: Integer;

begin
  objz := 0;
  if not IsServerActive then
    begin
      Result := objz;
      Exit;

    end;

  if ObjectType = OTPLAYER then
    objz := datah.players[ObjectReference].z

  else if ObjectType = OTNPC then
    objz := datah.npcs[ObjectReference].z

  else if ObjectType = OTITEM then
    begin
      objz := datah.items[ObjectReference].z;
      if datah.items[ObjectReference].equipped > 0 then
        begin
          objtype := CheckObjectType(datah.items[ObjectReference].equipped);
          obj := PrimitiveGetObject(objtype, datah.items[ObjectReference].equipped);
          objz := PrimitiveGetObjectZ(objtype, obj);

        end

      else if datah.items[ObjectReference].contained > 0 then
        begin
          maincont := PrimitiveGetMainContainer(ObjectReference);
          objz := datah.items[maincont].z;
          if datah.items[maincont].equipped > 0 then
            begin
              objtype := CheckObjectType(datah.items[maincont].equipped);
              obj := PrimitiveGetObject(objtype, datah.items[maincont].equipped);
              objz := PrimitiveGetObjectZ(objtype, obj);

            end;

        end;

    end;

  Result := objz;

end;

function PrimitiveCheckObjectDistance(ObjectType1: Integer; ObjectReference1: Cardinal;
         ObjectType2: Integer; ObjectReference2: Cardinal): Cardinal;
begin
  if not IsServerActive then
    begin
      Result := 0;
      Exit;

    end;

  Result := CheckDistance(PrimitiveGetObjectXMain(ObjectType1, ObjectReference1),
                          PrimitiveGetObjectXMain(ObjectType2, ObjectReference2),
                          PrimitiveGetObjectYMain(ObjectType1, ObjectReference1),
                          PrimitiveGetObjectYMain(ObjectType2, ObjectReference2),
                          PrimitiveGetObjectZMain(ObjectType1, ObjectReference1),
                          PrimitiveGetObjectZMain(ObjectType2, ObjectReference2));

end;

function PrimitiveCheckObjectToCoordinatesDistance(ObjectType: Integer; ObjectReference: Cardinal;
         X, Y: Word; Z: ShortInt): Cardinal;
begin
  if not IsServerActive then
    begin
      Result := 0;
      Exit;

    end;

  Result := CheckDistance(PrimitiveGetObjectXMain(ObjectType, ObjectReference),
                          X,
                          PrimitiveGetObjectYMain(ObjectType, ObjectReference),
                          Y,
                          PrimitiveGetObjectZMain(ObjectType, ObjectReference),
                          Z);

end;

procedure PrimitivePlaySoundEffectPrivate(Player: Cardinal; SoundEffect: Word);
var
  pbuf: Array of Byte;
  tempword: Word;

begin   
  if not IsServerActive then
    Exit;

  SetLength(pbuf, 15);
  pbuf[0] := $FE;
  pbuf[1] := $B8;
  pbuf[2] := $00;
  pbuf[3] := $0F;
  pbuf[4] := $00;
  tempword := swapword(SoundEffect);
  Move(tempword, pbuf[5], 2);
  pbuf[7] := $00;
  pbuf[8] := $00;
  pbuf[9] := $00;
  pbuf[10] := $00;
  pbuf[11] := $00;
  pbuf[12] := $00;
  pbuf[13] := $00;
  pbuf[14] := $00;
  try
    datah.players[Player].client.Send(Addr(pbuf[0]), 15);
    datah.players[Player].client.Flush;

  except
    try
      datah.players[Player].client.Shutdown(0);

    finally
    end;

  end;

end;

procedure PlaySoundEffect(X, Y: Word; SoundEffect: Word);
var
  objarray: TPrimitiveObjectArray;
  i: Cardinal;

begin
  SetLength(objarray, 0);
  if not IsServerActive then
    Exit;

  objarray := PrimitiveListObjectsNearLocation(OTPLAYER, X, Y, 16);
  if Length(objarray) > 0 then
    for i := 0 to Length(objarray) - 1 do
      if datah.players[objarray[i]].online then
        PrimitivePlaySoundEffectPrivate(objarray[i], SoundEffect);

end;

procedure PrimitiveSetLightLevelPrivate(Player: Cardinal; LightLevel: Byte);
var
  pbuf: Array of Byte;

begin  
  if not IsServerActive then
    Exit;

  SetLength(pbuf, 5);
  pbuf[0] := $FE;
  pbuf[1] := $A9;
  pbuf[2] := $00;
  pbuf[3] := $0F;
  pbuf[4] := LightLevel;
  try
    datah.players[Player].client.Send(Addr(pbuf[0]), 5);
    datah.players[Player].client.Flush;

  except
    try
      datah.players[Player].client.Shutdown(0);

    finally
    end;

  end;
  updateplayer(Player);

end;

procedure SetLightLevel(LightLevel: Byte);
var
  objarray: TPrimitiveObjectArray;
  i: Cardinal;

begin
  SetLength(objarray, 0);
  if not IsServerActive then
    Exit;

  objarray := PrimitiveListObjects(OTPLAYER);
  if Length(objarray) > 0 then
    for i := 0 to Length(objarray) - 1 do
      if datah.players[objarray[i]].online then
        PrimitiveSetLightLevelPrivate(objarray[i], LightLevel);

end;

function PrimitiveGetAmount(Item: Cardinal): Word;
begin  
  if not IsServerActive or (datah.items[Item].stackable = 0) then
    begin
      Result := 0;
      Exit;

    end;

  Result := datah.items[Item].amount;

end;

function PrimitiveGetItemType(Item: Cardinal): Cardinal;
begin  
  if not IsServerActive then
    begin
      Result := 0;
      Exit;

    end;

  Result := datah.items[Item].itemtype;

end;

function PrimitiveListItemsInContainer(Container: Cardinal): TPrimitiveObjectArray;
var
  i: Cardinal;
  objarray: TPrimitiveObjectArray;

begin 
  if not IsServerActive then
    Exit;

  SetLength(objarray, 0);
  if datah.items[Container].container = 1 then
    if Length(datah.items[Container].contitems) > 0 then
      for i := 0 to Length(datah.items[Container].contitems) - 1 do
        begin
          SetLength(objarray, Length(objarray) + 1);
          objarray[Length(objarray) - 1] := PrimitiveGetObject(OTITEM, datah.items[Container].contitems[i]);

        end;

  Result := objarray;

end;

function GetSubString(MainString: String; SubStringNumber: Integer): String;
var
  strarray: Array of String;
  i: Integer;

begin 
  if not IsServerActive then
    begin
      Result := '';
      Exit;

    end;

  SetLength(strarray, 0);
  repeat
    SetLength(strarray, Length(strarray) + 1);
    i := Pos(' ', MainString);
    if i = 0 then
      i := Length(MainString) + 1;

    if i > 1 then
      strarray[Length(strarray) - 1] := Copy(MainString, 1, i - 1);
      
    Delete(MainString, 1, i);

  until Length(MainString) = 0;
  if (Length(strarray) = 0) or (SubStringNumber > Length(strarray)) then
    begin
      Result := '';
      Exit;

    end;

  Result := strarray[SubStringNumber - 1];

end;

procedure PrimitiveSendText(TextType, ObjectType: Integer; ObjectReference,
          Player: Cardinal; Text: String; R, G, B: Byte);
var
  i: Cardinal;
  objarray: TPrimitiveObjectArray;

begin 
  if not IsServerActive then
    Exit;

  SetLength(objarray, 0);
  if TextType = TTSYSTEMMESSAGE then
    sendsysmsg(Text, R, G, B, Player)

  else if TextType = TTSPEECHPRIVATE then
    sendspeech(Text, R, G, B, ObjectType, Player, ObjectReference)

  else if TextType = TTSPEECH then
    begin
      objarray := PrimitiveListObjectsNearLocation(OTPLAYER, PrimitiveGetObjectXMain(ObjectType,
                  ObjectReference), PrimitiveGetObjectYMain(ObjectType, ObjectReference),
                  16);
      if Length(objarray) > 0 then
        for i := 0 to Length(objarray) - 1 do
          sendspeech(Text, R, G, B, ObjectType, objarray[i], ObjectReference);

    end

  else if TextType = TTTEXTABOVEPRIVATE then
    printtxtabv(Text, R, G, B, ObjectType, Player, ObjectReference)

  else if TextType = TTTEXTABOVE then
    begin
      objarray := PrimitiveListObjectsNearLocation(OTPLAYER, PrimitiveGetObjectXMain(ObjectType,
                  ObjectReference), PrimitiveGetObjectYMain(ObjectType, ObjectReference),
                  16);
      if Length(objarray) > 0 then
        for i := 0 to Length(objarray) - 1 do
          printtxtabv(Text, R, G, B, ObjectType, objarray[i], ObjectReference);

    end;

end;

function CheckLOS(X1, X2, Y1, Y2: Word; Z1, Z2: ShortInt): Boolean;
var
  x, y: Word;
  z: ShortInt;
  staidxstart, staidxend, i: Cardinal;
  static: tstatic;
  statictile: tstatictile;
  r: Real;
  objarray: TPrimitiveObjectArray;

begin 
  if not IsServerActive then
    begin
      Result := False;
      Exit;

    end;

  SetLength(objarray, 0);
  r := 0.01;
  x := Round(X1 + r * (X2 - X1));
  y := Round(Y1 + r * (Y2 - Y1));
  z := Round(Z1 + r * (Z2 - Z1));
  while (x <> X2) or (y <> Y2) or (z <> Z2) do
    begin
      if getworldheight(x, y) > z then
        begin
          Result := False;
          Exit;

        end;

      if getstaidx(x, y).start <> NOSTATICS then
        begin
          staidxstart := getstaidx(x, y).start div SizeOf(tstatic);
          staidxend := getstaidx(x, y).length div SizeOf(tstatic) + staidxstart;
          for i := staidxstart to staidxend - 1 do
            begin
              static := getstatic(i);
              statictile := getstatictile(static.graphic);
              if (static.x = x mod 8) and (static.y = y mod 8) and
                 (z >= static.z) and (z <= static.z + statictile.height) then
                begin
                  Result := False;
                  Exit;

                end;

            end;

        end;

      objarray := getitemsat2dpos(x, y);
      if Length(objarray) > 0 then
        for i := 0 to Length(objarray) - 1 do
          begin
            statictile := getstatictile(datah.items[objarray[i]].graphic);
            if (z >= datah.items[objarray[i]].z) and
               (z <= datah.items[objarray[i]].z + statictile.height) then
              begin
                Result := False;
                Exit;

              end;

          end;

      SetLength(objarray, 0);
      r := r + 0.01;
      x := Round(X1 + r * (X2 - X1));
      y := Round(Y1 + r * (Y2 - Y1));
      z := Round(Z1 + r * (Z2 - Z1));

    end;

  Result := True;

end;

function PrimitiveListEquippedItems(ObjectType: Integer; ObjectReference: Cardinal): TPrimitiveObjectArray;
var
  i: Cardinal;
  objarray: TPrimitiveObjectArray;

begin
  if not IsServerActive then
    Exit;

  SetLength(objarray, 0);
  if ObjectType = OTPLAYER then
    if Length(datah.players[ObjectReference].equitems) > 0 then
      for i := 0 to Length(datah.players[ObjectReference].equitems) - 1 do
        begin
          SetLength(objarray, Length(objarray) + 1);
          objarray[Length(objarray) - 1] := PrimitiveGetObject(OTITEM, datah.players[ObjectReference].equitems[i]);

        end;

  if ObjectType = OTNPC then
    if Length(datah.npcs[ObjectReference].equitems) > 0 then
      for i := 0 to Length(datah.npcs[ObjectReference].equitems) - 1 do
        begin
          SetLength(objarray, Length(objarray) + 1);
          objarray[Length(objarray) - 1] := PrimitiveGetObject(OTITEM, datah.npcs[ObjectReference].equitems[i]);

        end;

  Result := objarray;

end;

procedure PrimitiveSetSex(ObjectType: Integer; ObjectReference: Cardinal; Sex: Integer);
var
  objarray: TPrimitiveObjectArray;
  i, objid: Cardinal;

begin    
  if not IsServerActive then
    Exit;

  SetLength(objarray, 0);
  if ObjectType = OTPLAYER then
    begin
      datah.players[ObjectReference].sex := Sex;
      objid := datah.players[ObjectReference].id;

    end

  else if ObjectType = OTNPC then
    begin
      datah.npcs[ObjectReference].sex := Sex;
      objid := datah.npcs[ObjectReference].id;

    end

  else
    Exit;

  objarray := PrimitiveListObjectsNearLocation(OTPLAYER, PrimitiveGetObjectXMain(ObjectType, ObjectReference),
                                               PrimitiveGetObjectYMain(ObjectType, ObjectReference), 16);
  if Length(objarray) > 0 then
    for i := 0 to Length(objarray) - 1 do
      if datah.players[objarray[i]].online and ((datah.items[ObjectReference].invisible = 0) or
         (datah.players[objarray[i]].privileged = 1)) then
        showstatus(objarray[i], objid);

end;

function PrimitiveGetGraphic(ObjectType: Integer; ObjectReference: Cardinal): Word;
begin    
  if not IsServerActive then
    begin
      Result := 0;
      Exit;

    end;

  if ObjectType = OTPLAYER then
    Result := datah.players[ObjectReference].graphic

  else if ObjectType = OTNPC then
    Result := datah.npcs[ObjectReference].graphic

  else if ObjectType = OTITEM then
    Result := datah.items[ObjectReference].graphic

  else
    Result := 0;

end;

procedure PrimitiveSetGraphic(ObjectType: Integer; ObjectReference: Cardinal; Graphic: Word);
begin    
  if not IsServerActive then
    Exit;

  if ObjectType = OTPLAYER then
    datah.players[ObjectReference].graphic := Graphic

  else if ObjectType = OTNPC then
    datah.npcs[ObjectReference].graphic := Graphic

  else if ObjectType = OTITEM then
    datah.items[ObjectReference].graphic := Graphic

  else
    Exit;

  updateobjao(ObjectType, ObjectReference);

end;

function PrimitiveGetName(ObjectType: Integer; ObjectReference: Cardinal): String;
begin     
  if not IsServerActive then
    Exit;

  if ObjectType = OTPLAYER then
    Result := datah.players[ObjectReference].name

  else if ObjectType = OTNPC then
    Result := datah.npcs[ObjectReference].name

  else
    Result := '';

end;

procedure PrimitiveSetName(ObjectType: Integer; ObjectReference: Cardinal; Name: String);
begin    
  if not IsServerActive then
    Exit;

  if ObjectType = OTPLAYER then
    datah.players[ObjectReference].name := Name

  else if ObjectType = OTNPC then
    datah.npcs[ObjectReference].name := Name

  else
    Exit;

  updatestatusao(ObjectType, ObjectReference);

end;

function PrimitiveGetFacing(ObjectType: Integer; ObjectReference: Cardinal): Byte;
begin    
  if not IsServerActive then
    begin
      Result := 0;
      Exit;

    end;

  if ObjectType = OTPLAYER then
    Result := datah.players[ObjectReference].facing

  else if ObjectType = OTNPC then
    Result := datah.npcs[ObjectReference].facing

  else
    Result := 0;

end;

procedure PrimitiveSetFacing(ObjectType: Integer; ObjectReference: Cardinal; Facing: Byte);
var
  objarray: TPrimitiveObjectArray;
  i: Cardinal;

begin   
  if not IsServerActive or (Facing > 7) or
     (Facing = PrimitiveGetFacing(ObjectType, ObjectReference)) then
    Exit;

  SetLength(objarray, 0);
  if ObjectType = OTPLAYER then
    datah.players[ObjectReference].facing := Facing

  else if ObjectType = OTNPC then
    datah.npcs[ObjectReference].facing := Facing

  else
    Exit;

  objarray := PrimitiveListObjectsNearLocation(OTPLAYER, PrimitiveGetObjectXMain(ObjectType, ObjectReference),
                                               PrimitiveGetObjectYMain(ObjectType, ObjectReference), 16);
  if Length(objarray) > 0 then
    for i := 0 to Length(objarray) - 1 do
      if datah.players[objarray[i]].online then
        if (ObjectType = OTNPC) and ((datah.npcs[ObjectReference].hidden = 0) or
           (datah.players[objarray[i]].privileged = 1)) then
          updateobj(ObjectType, objarray[i], ObjectReference)

        else if (ObjectType = OTPLAYER) and
                (datah.players[objarray[i]].id <> datah.players[ObjectReference].id) and
                ((datah.players[ObjectReference].hidden = 0) or
                (datah.players[objarray[i]].privileged = 1)) then
          updateobj(ObjectType, objarray[i], ObjectReference)

        else if (ObjectType = OTPLAYER) and
                (datah.players[objarray[i]].id = datah.players[ObjectReference].id) then
          updateplayer(ObjectReference);

end;

function PrimitiveGetStrength(ObjectType: Integer; ObjectReference: Cardinal): Byte;
begin   
  if not IsServerActive then
    begin
      Result := 0;
      Exit;

    end;

  if ObjectType = OTPLAYER then
    Result := datah.players[ObjectReference].str

  else if ObjectType = OTNPC then
    Result := datah.npcs[ObjectReference].str

  else
    Result := 0;

end;

procedure PrimitiveSetStrength(ObjectType: Integer; ObjectReference: Cardinal; Strength: Byte);
begin    
  if not IsServerActive then
    Exit;

  if ObjectType = OTPLAYER then
    datah.players[ObjectReference].str := Strength

  else if ObjectType = OTNPC then
    datah.npcs[ObjectReference].str := Strength

  else
    Exit;

  updatestatusao(ObjectType, ObjectReference);

end;

function PrimitiveGetDexterity(ObjectType: Integer; ObjectReference: Cardinal): Byte;
begin   
  if not IsServerActive then
    begin
      Result := 0;
      Exit;

    end;

  if ObjectType = OTPLAYER then
    Result := datah.players[ObjectReference].dex

  else if ObjectType = OTNPC then
    Result := datah.npcs[ObjectReference].dex

  else
    Result := 0;

end;

procedure PrimitiveSetDexterity(ObjectType: Integer; ObjectReference: Cardinal; Dexterity: Byte);
begin      
  if not IsServerActive then
    Exit;

  if ObjectType = OTPLAYER then
    datah.players[ObjectReference].dex := Dexterity

  else if ObjectType = OTNPC then
    datah.npcs[ObjectReference].dex := Dexterity

  else
    Exit;

  updatestatusao(ObjectType, ObjectReference);

end;

function PrimitiveGetIntelligence(ObjectType: Integer; ObjectReference: Cardinal): Byte;
begin     
  if not IsServerActive then
    begin
      Result := 0;
      Exit;

    end;

  if ObjectType = OTPLAYER then
    Result := datah.players[ObjectReference].int

  else if ObjectType = OTNPC then
    Result := datah.npcs[ObjectReference].int

  else
    Result := 0;

end;

procedure PrimitiveSetIntelligence(ObjectType: Integer; ObjectReference: Cardinal; Intelligence: Byte);
begin 
  if not IsServerActive then
    Exit;

  if ObjectType = OTPLAYER then
    datah.players[ObjectReference].int := Intelligence

  else if ObjectType = OTNPC then
    datah.npcs[ObjectReference].int := Intelligence

  else
    Exit;

  updatestatusao(ObjectType, ObjectReference);

end;

procedure PrimitiveSetCProp(ObjectType: Integer; ObjectReference: Cardinal; Name, StringValue: String;
          CardinalValue: Cardinal; IntegerValue: Integer);
var
  index: Cardinal;
  exists: Boolean;

begin
  if not IsServerActive then
    Exit;

  if Name = '' then
    Exit;

  if ObjectType = OTPLAYER then
    begin
      while datah.players[ObjectReference].cpoc = True do
        Sleep(1);

      datah.players[ObjectReference].cpoc := True;
      index := 0;
      exists := False;
      if Length(datah.players[ObjectReference].cprops) > 0 then
        for index := 0 to Length(datah.players[ObjectReference].cprops) - 1 do
          if datah.players[ObjectReference].cprops[index].name = Name then
            begin
              exists := True;
              Break;

            end;

      if not exists then
        begin
          index := Length(datah.players[ObjectReference].cprops);
          datah.players[ObjectReference].setcpropslen(index + 1);

        end;

      datah.players[ObjectReference].cpoc := False;
      datah.players[ObjectReference].cprops[index].name := Name;
      datah.players[ObjectReference].cprops[index].intval := IntegerValue;
      datah.players[ObjectReference].cprops[index].strval := StringValue;
      datah.players[ObjectReference].cprops[index].cardval := CardinalValue;

    end;

  if ObjectType = OTNPC then
    begin
      while datah.npcs[ObjectReference].cpoc = True do
        Sleep(1);

      datah.npcs[ObjectReference].cpoc := True;
      index := 0;
      exists := False;
      if Length(datah.npcs[ObjectReference].cprops) > 0 then
        for index := 0 to Length(datah.npcs[ObjectReference].cprops) - 1 do
          if datah.npcs[ObjectReference].cprops[index].name = Name then
            begin
              exists := True;
              Break;

            end;

      if not exists then
        begin
          index := Length(datah.npcs[ObjectReference].cprops);
          datah.npcs[ObjectReference].setcpropslen(index + 1);

        end;

      datah.npcs[ObjectReference].cpoc := False;
      datah.npcs[ObjectReference].cprops[index].name := Name;
      datah.npcs[ObjectReference].cprops[index].intval := IntegerValue;
      datah.npcs[ObjectReference].cprops[index].strval := StringValue;
      datah.npcs[ObjectReference].cprops[index].cardval := CardinalValue;

    end;

  if ObjectType = OTITEM then
    begin
      while datah.items[ObjectReference].cpoc = True do
        Sleep(1);

      datah.items[ObjectReference].cpoc := True;
      index := 0;
      exists := False;
      if Length(datah.items[ObjectReference].cprops) > 0 then
        for index := 0 to Length(datah.items[ObjectReference].cprops) - 1 do
          if datah.items[ObjectReference].cprops[index].name = Name then
            begin
              exists := True;
              Break;

            end;

      if not exists then
        begin
          index := Length(datah.items[ObjectReference].cprops);
          datah.items[ObjectReference].setcpropslen(index + 1);

        end;

      datah.items[ObjectReference].cpoc := False;
      datah.items[ObjectReference].cprops[index].name := Name;
      datah.items[ObjectReference].cprops[index].intval := IntegerValue;
      datah.items[ObjectReference].cprops[index].strval := StringValue;
      datah.items[ObjectReference].cprops[index].cardval := CardinalValue;

    end;

end;

function PrimitiveGetCPropStringValue(ObjectType: Integer; ObjectReference: Cardinal;
         Name: String): String;
var
  i: Cardinal;
  res: String;

begin  
  if not IsServerActive then
    Exit;

  res := '';
  if ObjectType = OTPLAYER then
    begin
      while datah.players[ObjectReference].cpoc = True do
        Sleep(1);

      datah.players[ObjectReference].cpoc := True;
      if Length(datah.players[ObjectReference].cprops) > 0 then
        for i := 0 to Length(datah.players[ObjectReference].cprops) - 1 do
          if datah.players[ObjectReference].cprops[i].name = Name then
            begin
              res := datah.players[ObjectReference].cprops[i].strval;
              Break;

            end;

      datah.players[ObjectReference].cpoc := False;

    end;

  if ObjectType = OTNPC then
    begin
      while datah.npcs[ObjectReference].cpoc = True do
        Sleep(1);

      datah.npcs[ObjectReference].cpoc := True;
      if Length(datah.npcs[ObjectReference].cprops) > 0 then
        for i := 0 to Length(datah.npcs[ObjectReference].cprops) - 1 do
          if datah.npcs[ObjectReference].cprops[i].name = Name then
            begin
              res := datah.npcs[ObjectReference].cprops[i].strval;
              Break;

            end;

      datah.npcs[ObjectReference].cpoc := False;

    end;

  if ObjectType = OTITEM then
    begin
      while datah.items[ObjectReference].cpoc = True do
        Sleep(1);

      datah.items[ObjectReference].cpoc := True;
      if Length(datah.items[ObjectReference].cprops) > 0 then
        for i := 0 to Length(datah.items[ObjectReference].cprops) - 1 do
          if datah.items[ObjectReference].cprops[i].name = Name then
            begin
              res := datah.items[ObjectReference].cprops[i].strval;
              Break;

            end;

      datah.items[ObjectReference].cpoc := False;

    end;

  Result := res;

end;

function PrimitiveGetCPropCardinalValue(ObjectType: Integer; ObjectReference: Cardinal;
         Name: String): Cardinal;
var
  i: Cardinal;
  res: Cardinal;

begin
  res := 0;
  if not IsServerActive then
    begin
      Result := res;
      Exit;

    end;

  if ObjectType = OTPLAYER then
    begin
      while datah.players[ObjectReference].cpoc = True do
        Sleep(1);

      datah.players[ObjectReference].cpoc := True;
      if Length(datah.players[ObjectReference].cprops) > 0 then
        for i := 0 to Length(datah.players[ObjectReference].cprops) - 1 do
          if datah.players[ObjectReference].cprops[i].name = Name then
            begin
              res := datah.players[ObjectReference].cprops[i].cardval;
              Break;

            end;

      datah.players[ObjectReference].cpoc := False;

    end;

  if ObjectType = OTNPC then
    begin
      while datah.npcs[ObjectReference].cpoc = True do
        Sleep(1);

      datah.npcs[ObjectReference].cpoc := True;
      if Length(datah.npcs[ObjectReference].cprops) > 0 then
        for i := 0 to Length(datah.npcs[ObjectReference].cprops) - 1 do
          if datah.npcs[ObjectReference].cprops[i].name = Name then
            begin
              res := datah.npcs[ObjectReference].cprops[i].cardval;
              Break;

            end;

      datah.npcs[ObjectReference].cpoc := False;

    end;

  if ObjectType = OTITEM then
    begin
      while datah.items[ObjectReference].cpoc = True do
        Sleep(1);

      datah.items[ObjectReference].cpoc := True;
      if Length(datah.items[ObjectReference].cprops) > 0 then
        for i := 0 to Length(datah.items[ObjectReference].cprops) - 1 do
          if datah.items[ObjectReference].cprops[i].name = Name then
            begin
              res := datah.items[ObjectReference].cprops[i].cardval;
              Break;

            end;

      datah.items[ObjectReference].cpoc := False;

    end;

  Result := res;

end;

function PrimitiveGetCPropIntegerValue(ObjectType: Integer; ObjectReference: Cardinal;
         Name: String): Integer;
var
  i: Cardinal;
  res: Integer;

begin
  res := 0;
  if not IsServerActive then
    begin
      Result := res;
      Exit;

    end;

  if ObjectType = OTPLAYER then
    begin
      while datah.players[ObjectReference].cpoc = True do
        Sleep(1);

      datah.players[ObjectReference].cpoc := True;
      if Length(datah.players[ObjectReference].cprops) > 0 then
        for i := 0 to Length(datah.players[ObjectReference].cprops) - 1 do
          if datah.players[ObjectReference].cprops[i].name = Name then
            begin
              res := datah.players[ObjectReference].cprops[i].intval;
              Break;

            end;

      datah.players[ObjectReference].cpoc := False;

    end;

  if ObjectType = OTNPC then
    begin
      while datah.npcs[ObjectReference].cpoc = True do
        Sleep(1);

      datah.npcs[ObjectReference].cpoc := True;
      if Length(datah.npcs[ObjectReference].cprops) > 0 then
        for i := 0 to Length(datah.npcs[ObjectReference].cprops) - 1 do
          if datah.npcs[ObjectReference].cprops[i].name = Name then
            begin
              res := datah.npcs[ObjectReference].cprops[i].intval;
              Break;

            end;

      datah.npcs[ObjectReference].cpoc := False;

    end;

  if ObjectType = OTITEM then
    begin
      while datah.items[ObjectReference].cpoc = True do
        Sleep(1);

      datah.items[ObjectReference].cpoc := True;
      if Length(datah.items[ObjectReference].cprops) > 0 then
        for i := 0 to Length(datah.items[ObjectReference].cprops) - 1 do
          if datah.items[ObjectReference].cprops[i].name = Name then
            begin
              res := datah.items[ObjectReference].cprops[i].intval;
              Break;

            end;

      datah.items[ObjectReference].cpoc := False;

    end;

  Result := res;

end;

function PrimitiveCPropExists(ObjectType: Integer; ObjectReference: Cardinal;
         Name: String): Boolean;
var
  i: Cardinal;
  res: Boolean;

begin
  res := False;
  if not IsServerActive then
    begin
      Result := res;
      Exit;

    end;

  if ObjectType = OTPLAYER then
    begin
      while datah.players[ObjectReference].cpoc = True do
        Sleep(1);

      datah.players[ObjectReference].cpoc := True;
      if Length(datah.players[ObjectReference].cprops) > 0 then
        for i := 0 to Length(datah.players[ObjectReference].cprops) - 1 do
          if datah.players[ObjectReference].cprops[i].name = Name then
            begin
              res := True;
              Break;

            end;

      datah.players[ObjectReference].cpoc := False;

    end;

  if ObjectType = OTNPC then
    begin
      while datah.npcs[ObjectReference].cpoc = True do
        Sleep(1);

      datah.npcs[ObjectReference].cpoc := True;
      if Length(datah.npcs[ObjectReference].cprops) > 0 then
        for i := 0 to Length(datah.npcs[ObjectReference].cprops) - 1 do
          if datah.npcs[ObjectReference].cprops[i].name = Name then
            begin
              res := True;
              Break;

            end;

      datah.npcs[ObjectReference].cpoc := False;

    end;

  if ObjectType = OTITEM then
    begin
      while datah.items[ObjectReference].cpoc = True do
        Sleep(1);

      datah.items[ObjectReference].cpoc := True;
      if Length(datah.items[ObjectReference].cprops) > 0 then
        for i := 0 to Length(datah.items[ObjectReference].cprops) - 1 do
          if datah.items[ObjectReference].cprops[i].name = Name then
            begin
              res := True;
              Break;

            end;

      datah.items[ObjectReference].cpoc := False;

    end;

  Result := res;

end;

procedure PrimitiveEraseCProp(ObjectType: Integer; ObjectReference: Cardinal;
          Name: String);
var
  i: Cardinal;
  tempcprops: Array of tcprop;

begin 
  if not IsServerActive then
    Exit;

  SetLength(tempcprops, 0);
  if ObjectType = OTPLAYER then
    if Length(datah.players[ObjectReference].cprops) > 0 then
      begin
        while datah.players[ObjectReference].cpoc = True do
          Sleep(1);

        datah.players[ObjectReference].cpoc := True;
        for i := 0 to Length(datah.players[ObjectReference].cprops) - 1 do
          if datah.players[ObjectReference].cprops[i].name <> Name then
            begin
              SetLength(tempcprops, Length(tempcprops) + 1);
              tempcprops[Length(tempcprops) - 1] := datah.players[ObjectReference].cprops[i];

            end;

        datah.players[ObjectReference].setcpropslen(Length(tempcprops));
        if Length(tempcprops) > 0 then
          for i := 0 to Length(tempcprops) - 1 do
            datah.players[ObjectReference].cprops[i] := tempcprops[i];

        datah.players[ObjectReference].cpoc := False;

      end;

  if ObjectType = OTNPC then
    if Length(datah.npcs[ObjectReference].cprops) > 0 then
      begin
        while datah.npcs[ObjectReference].cpoc = True do
          Sleep(1);

        datah.npcs[ObjectReference].cpoc := True;
        for i := 0 to Length(datah.npcs[ObjectReference].cprops) - 1 do
          if datah.npcs[ObjectReference].cprops[i].name <> Name then
            begin
              SetLength(tempcprops, Length(tempcprops) + 1);
              tempcprops[Length(tempcprops) - 1] := datah.npcs[ObjectReference].cprops[i];

            end;

        datah.npcs[ObjectReference].setcpropslen(Length(tempcprops));
        if Length(tempcprops) > 0 then
          for i := 0 to Length(tempcprops) - 1 do
            datah.npcs[ObjectReference].cprops[i] := tempcprops[i];

        datah.npcs[ObjectReference].cpoc := False;

      end;

  if ObjectType = OTITEM then
    if Length(datah.items[ObjectReference].cprops) > 0 then
      begin
        while datah.items[ObjectReference].cpoc = True do
          Sleep(1);

        datah.items[ObjectReference].cpoc := True;
        for i := 0 to Length(datah.items[ObjectReference].cprops) - 1 do
          if datah.items[ObjectReference].cprops[i].name <> Name then
            begin
              SetLength(tempcprops, Length(tempcprops) + 1);
              tempcprops[Length(tempcprops) - 1] := datah.items[ObjectReference].cprops[i];

            end;

        datah.items[ObjectReference].setcpropslen(Length(tempcprops));
        if Length(tempcprops) > 0 then
          for i := 0 to Length(tempcprops) - 1 do
            datah.items[ObjectReference].cprops[i] := tempcprops[i];

        datah.items[ObjectReference].cpoc := False;

      end;

end;

function PrimitiveRequestInput(Player: Cardinal): String;
var
  tempstr: String;

begin  
  if not IsServerActive then
    Exit;

  while datah.players[Player].inreq and datah.players[Player].online do
    Sleep(1);

  datah.players[Player].inreq := True;
  while (datah.players[Player].inreqres = '') and datah.players[Player].online do
    Sleep(1);

  tempstr := datah.players[Player].inreqres;
  datah.players[Player].inreqres := '';
  datah.players[Player].inreq := False;
  Result := tempstr;

end;

procedure SetGProp(Name, StringValue: String; CardinalValue: Cardinal; IntegerValue: Integer);
var
  index: Cardinal;
  exists: Boolean;

begin  
  if not IsServerActive then
    Exit;

  if Name = '' then
    Exit;

  gpropslock.Acquire;
  index := 0;
  exists := False;
  if Length(gprops) > 0 then
    for index := 0 to Length(gprops) - 1 do
      if gprops[index].name = Name then
        begin
          exists := True;
          Break;

        end;

  if not exists then
    begin
      index := Length(gprops);
      SetLength(gprops, index + 1);

    end;

  gpropslock.Release;
  gprops[index].name := Name;
  gprops[index].intval := IntegerValue;
  gprops[index].strval := StringValue;
  gprops[index].cardval := CardinalValue;

end;

function GetGPropStringValue(Name: String): String;
var
  i: Cardinal;
  res: String;

begin  
  if not IsServerActive then
    Exit;

  res := '';
  gpropslock.Acquire;
  if Length(gprops) > 0 then
    for i := 0 to Length(gprops) - 1 do
      if gprops[i].name = Name then
        begin
          res := gprops[i].strval;
          Break;

        end;

  gpropslock.Release;
  Result := res;

end;

function GetGPropCardinalValue(Name: String): Cardinal;
var
  i: Cardinal;
  res: Cardinal;

begin
  res := 0;
  if not IsServerActive then
    begin
      Result := res;
      Exit;

    end;

  gpropslock.Acquire;
  if Length(gprops) > 0 then
    for i := 0 to Length(gprops) - 1 do
      if gprops[i].name = Name then
        begin
          res := gprops[i].cardval;
          Break;

        end;

  gpropslock.Release;
  Result := res;

end;

function GetGPropIntegerValue(Name: String): Integer;
var
  i: Cardinal;
  res: Integer;

begin
  res := 0;
  if not IsServerActive then
    begin
      Result := res;
      Exit;

    end;

  gpropslock.Acquire;
  if Length(gprops) > 0 then
    for i := 0 to Length(gprops) - 1 do
      if gprops[i].name = Name then
        begin
          res := gprops[i].intval;
          Break;

        end;

  gpropslock.Release;
  Result := res;

end;

function GPropExists(Name: String): Boolean;
var
  i: Cardinal;
  res: Boolean;

begin
  res := False;
  if not IsServerActive then
    begin
      Result := res;
      Exit;

    end;

  gpropslock.Acquire;
  if Length(gprops) > 0 then
    for i := 0 to Length(gprops) - 1 do
      if gprops[i].name = Name then
        begin
          res := True;
          Break;

        end;

  gpropslock.Release;
  Result := res;

end;

procedure EraseGProp(Name: String);
var
  i: Cardinal;
  tempgprops: Array of tcprop;

begin   
  if not IsServerActive then
    Exit;

  SetLength(tempgprops, 0);
  if Length(gprops) > 0 then
    begin
      gpropslock.Acquire;
      for i := 0 to Length(gprops) - 1 do
        if gprops[i].name <> Name then
          begin
            SetLength(tempgprops, Length(tempgprops) + 1);
            tempgprops[Length(tempgprops) - 1] := gprops[i];

          end;

      SetLength(gprops, Length(tempgprops));
      if Length(tempgprops) > 0 then
        for i := 0 to Length(tempgprops) - 1 do
          gprops[i] := tempgprops[i];

      gpropslock.Release;

    end;

end;

procedure PrimitiveSetExperience(ObjectType: Integer; ObjectReference: Cardinal; Experience: Cardinal);
begin
  if not IsServerActive then
    Exit;

  if ObjectType = OTPLAYER then
    datah.players[ObjectReference].exp := Experience;

  if ObjectType = OTNPC then
    datah.npcs[ObjectReference].exp := Experience;

  updatestatusao(ObjectType, ObjectReference);

end;

procedure PrimitiveSetLevel(ObjectType: Integer; ObjectReference: Cardinal; Level: Byte);
begin   
  if not IsServerActive then
    Exit;

  if ObjectType = OTPLAYER then
    datah.players[ObjectReference].level := Level;

  if ObjectType = OTNPC then
    datah.npcs[ObjectReference].level := Level;

  updatestatusao(ObjectType, ObjectReference);

end;

procedure PrimitiveSetSkill(ObjectType: Integer; ObjectReference: Cardinal; Skill: Integer;
          SkillValue: Byte);
begin  
  if not IsServerActive then
    Exit;

  if ObjectType = OTPLAYER then
    case Skill of
      SKIDMAGICDEFENSE: datah.players[ObjectReference].magicdef := SkillValue;
      SKIDBATTLEDEFENSE: datah.players[ObjectReference].battledef := SkillValue;
      SKIDSTEALING: datah.players[ObjectReference].stealing := SkillValue;
      SKIDHIDING: datah.players[ObjectReference].hiding := SkillValue;
      SKIDFIRSTAID: datah.players[ObjectReference].firstaid := SkillValue;
      SKIDDETECTTRAP: datah.players[ObjectReference].detecttr := SkillValue;
      SKIDPEEK: datah.players[ObjectReference].peek := SkillValue;
      SKIDMAGIC: datah.players[ObjectReference].magic := SkillValue;
      SKIDMELEE: datah.players[ObjectReference].melee := SkillValue;
      SKIDRANGEDWEAPONS: datah.players[ObjectReference].rangedweap := SkillValue;

    end;

  if ObjectType = OTNPC then
    case Skill of
      SKIDMAGICDEFENSE: datah.npcs[ObjectReference].magicdef := SkillValue;
      SKIDBATTLEDEFENSE: datah.npcs[ObjectReference].battledef := SkillValue;
      SKIDSTEALING: datah.npcs[ObjectReference].stealing := SkillValue;
      SKIDHIDING: datah.npcs[ObjectReference].hiding := SkillValue;
      SKIDFIRSTAID: datah.npcs[ObjectReference].firstaid := SkillValue;
      SKIDDETECTTRAP: datah.npcs[ObjectReference].detecttr := SkillValue;
      SKIDPEEK: datah.npcs[ObjectReference].peek := SkillValue;
      SKIDMAGIC: datah.npcs[ObjectReference].magic := SkillValue;
      SKIDMELEE: datah.npcs[ObjectReference].melee := SkillValue;
      SKIDRANGEDWEAPONS: datah.npcs[ObjectReference].rangedweap := SkillValue;

    end;

end;

procedure PrimitiveSetHits(ObjectType: Integer; ObjectReference: Cardinal; Hits: Byte);
begin
  if not IsServerActive or PrimitiveIsPrivileged(ObjectType, ObjectReference) then
    Exit;

  if ObjectType = OTPLAYER then
    begin
      datah.players[ObjectReference].hits := Hits;
      if Hits = 0 then
        PrimitiveSetDead(ObjectReference);

    end

  else if ObjectType = OTNPC then
    begin
      datah.npcs[ObjectReference].hits := Hits;
      if Hits = 0 then
        startmiscscript('ondeath', IntToStr(OTNPC), CardToStr(ObjectReference));

    end;

  updatestatusao(ObjectType, ObjectReference);

end;

procedure PrimitiveSetMana(ObjectType: Integer; ObjectReference: Cardinal; Mana: Byte);
begin  
  if not IsServerActive or PrimitiveIsPrivileged(ObjectType, ObjectReference) then
    Exit;

  if ObjectType = OTPLAYER then
    datah.players[ObjectReference].mana := Mana;

  if ObjectType = OTNPC then
    datah.npcs[ObjectReference].mana := Mana;

  updatestatusao(ObjectType, ObjectReference);

end;

procedure PrimitiveSetFatigue(ObjectType: Integer; ObjectReference: Cardinal; Fatigue: Byte);
begin   
  if not IsServerActive or PrimitiveIsPrivileged(ObjectType, ObjectReference) then
    Exit;

  if ObjectType = OTPLAYER then
    datah.players[ObjectReference].fat := Fatigue;

  if ObjectType = OTNPC then
    datah.npcs[ObjectReference].fat := Fatigue;

  updatestatusao(ObjectType, ObjectReference);

end;

procedure PrimitiveSetWeight(Item: Cardinal; Weight: Word);
begin   
  if not IsServerActive then
    Exit;

  datah.items[Item].weight := Weight;

end;

procedure PrimitiveMoveObject(ObjectType: Integer; ObjectReference: Cardinal; X, Y: Word; Z: ShortInt);
var
  objtype: Integer;
  objarray: TPrimitiveObjectArray;
  i: Cardinal;

begin
  SetLength(objarray, 0);
  if not IsServerActive then
    Exit;

  if ObjectType = OTITEM then
    begin
      if datah.items[ObjectReference].contained > 0 then
        begin
          PrimitiveRemoveItem(ObjectReference, PrimitiveGetObject(OTITEM, datah.items[ObjectReference].contained),
                              X, Y, Z, datah.items[ObjectReference].amount);
          Exit;

        end

      else if datah.items[ObjectReference].equipped > 0 then
        begin
          objtype := CheckObjectType(datah.items[ObjectReference].equipped);
          PrimitiveUnequipItem(objtype, PrimitiveGetObject(objtype,
                               datah.items[ObjectReference].equipped), ObjectReference,
                               X, Y, Z);
          Exit;

        end

      else if (datah.items[ObjectReference].contained = 0) and
              (datah.items[ObjectReference].equipped = 0) then
        begin
          if datah.items[ObjectReference].dragger > 0 then
            begin
             datah.players[datah.items[ObjectReference].dragger].dragging := False;
             datah.players[datah.items[ObjectReference].dragger].dragitem := 0;
             datah.players[datah.items[ObjectReference].dragger].dragamt := 0;
             denydragging(datah.items[ObjectReference].dragger);
             datah.items[ObjectReference].dragger := 0;
             datah.items[ObjectReference].occupied := False;

            end;

          while datah.items[ObjectReference].occupied do
            Sleep(1);

          datah.items[ObjectReference].occupied := True;
          delobjao(ObjectType, ObjectReference);
          remitemfrom2dpos(ObjectReference, datah.items[ObjectReference].x, datah.items[ObjectReference].y);
          datah.items[ObjectReference].x := X;
          datah.items[ObjectReference].y := Y;
          datah.items[ObjectReference].z := Z;
          additemto2dpos(ObjectReference, X, Y);
          objarray := PrimitiveListObjectsNearLocation(OTPLAYER, X, Y, 16);
          if Length(objarray) > 0 then
            for i := 0 to Length(objarray) - 1 do
              if datah.players[objarray[i]].online and ((datah.items[ObjectReference].invisible = 0)
                 or (datah.players[objarray[i]].privileged = 1)) then
                begin
                  updateobj(OTITEM, objarray[i], ObjectReference);
                  addnouitem(ObjectReference, objarray[i]);

                end;

          datah.items[ObjectReference].occupied := False;

        end;

      end

    else if ObjectType = OTNPC then
      begin
        delobjao(ObjectType, ObjectReference);
        remnpcfrom2dpos(ObjectReference, datah.npcs[ObjectReference].x, datah.npcs[ObjectReference].y);
        datah.npcs[ObjectReference].x := X;
        datah.npcs[ObjectReference].y := Y;
        datah.npcs[ObjectReference].z := Z;
        addnpcto2dpos(ObjectReference, X, Y);
        updateobjao(ObjectType, ObjectReference);

      end

    else if ObjectType = OTPLAYER then
      begin
        if datah.players[ObjectReference].online then
          begin
            objarray := PrimitiveListObjectsNearLocation(OTPLAYER, datah.players[ObjectReference].x,
                                                         datah.players[ObjectReference].y, 17);
            if Length(objarray) > 0 then
              for i := 0 to Length(objarray) - 1 do
                if datah.players[objarray[i]].online and (ObjectReference <> objarray[i]) and
                   ((datah.players[objarray[i]].hidden = 0) or (datah.players[ObjectReference].privileged = 1)) then
                  delobj(OTPLAYER, ObjectReference, objarray[i]);

            SetLength(objarray, 0);
            objarray := PrimitiveListObjectsNearLocation(OTNPC, datah.players[ObjectReference].x,
                                                         datah.players[ObjectReference].y, 17);
            if Length(objarray) > 0 then
              for i := 0 to Length(objarray) - 1 do
                if ((datah.npcs[objarray[i]].hidden = 0) or (datah.players[ObjectReference].privileged = 1)) then
                  delobj(OTNPC, ObjectReference, objarray[i]);

            SetLength(objarray, 0);
            objarray := PrimitiveListObjectsNearLocation(OTITEM, datah.players[ObjectReference].x,
                                                         datah.players[ObjectReference].y, 17);
            if Length(objarray) > 0 then
              for i := 0 to Length(objarray) - 1 do
                if ((datah.items[objarray[i]].invisible = 0) or
                   (datah.players[ObjectReference].privileged = 1)) then
                  delobj(OTITEM, ObjectReference, objarray[i]);

          end;

        delobjao(ObjectType, ObjectReference);
        remplayerfrom2dpos(ObjectReference, datah.players[ObjectReference].x, datah.players[ObjectReference].y);
        datah.players[ObjectReference].x := X;
        datah.players[ObjectReference].y := Y;
        datah.players[ObjectReference].z := Z;
        addplayerto2dpos(ObjectReference, X, Y);
        updateobjao(ObjectType, ObjectReference);
        if datah.players[ObjectReference].online then
          begin
            objarray := PrimitiveListObjectsNearLocation(OTPLAYER, datah.players[ObjectReference].x,
                                                         datah.players[ObjectReference].y, 17);
            if Length(objarray) > 0 then
              for i := 0 to Length(objarray) - 1 do
                if datah.players[objarray[i]].online and (ObjectReference <> objarray[i]) and
                   ((datah.players[objarray[i]].hidden = 0) or (datah.players[ObjectReference].privileged = 1)) then
                  begin
                    updateobj(OTPLAYER, ObjectReference, objarray[i]);
                    updateequ(OTPLAYER, ObjectReference, objarray[i]);

                  end;

            SetLength(objarray, 0);
            objarray := PrimitiveListObjectsNearLocation(OTNPC, datah.players[ObjectReference].x,
                                                         datah.players[ObjectReference].y, 17);
            if Length(objarray) > 0 then
              for i := 0 to Length(objarray) - 1 do
                if ((datah.npcs[objarray[i]].hidden = 0) or (datah.players[ObjectReference].privileged = 1)) then
                  begin
                    updateobj(OTNPC, ObjectReference, objarray[i]);
                    updateequ(OTNPC, ObjectReference, objarray[i]);

                  end;

            SetLength(objarray, 0);
            objarray := PrimitiveListObjectsNearLocation(OTITEM, datah.players[ObjectReference].x,
                                                         datah.players[ObjectReference].y, 17);
            if Length(objarray) > 0 then
              for i := 0 to Length(objarray) - 1 do
                if ((datah.items[objarray[i]].invisible = 0) or
                   (datah.players[ObjectReference].privileged = 1)) then
                  begin
                    updateobj(OTITEM, ObjectReference, objarray[i]);
                    addnouitem(objarray[i], ObjectReference);

                  end;

          end;

      end;

end;

procedure PrimitiveSetWeaponSpeed(Weapon: Cardinal; WeaponSpeed: Integer);
begin  
  if not IsServerActive then
    Exit;

  if datah.items[Weapon].weapon = 1 then
    datah.items[Weapon].weapspeed := WeaponSpeed;

end;

procedure PrimitiveSetWeaponDamage(Weapon: Cardinal; WeaponDamage: Integer);
begin  
  if not IsServerActive then
    Exit;

  if datah.items[Weapon].weapon = 1 then
    datah.items[Weapon].weapdamage := WeaponDamage;

end;

procedure PrimitiveSetArmorStrength(Armor: Cardinal; ArmorStrength: Integer);
begin  
  if not IsServerActive then
    Exit;

  if datah.items[Armor].armor = 1 then
    datah.items[Armor].armorstr := ArmorStrength;

end;

procedure PrimitiveSetMoveable(Item: Cardinal);
begin 
  if not IsServerActive then
    Exit;

  datah.items[Item].moveable := 1;

end;

procedure PrimitiveSetUnmoveable(Item: Cardinal);
begin  
  if not IsServerActive then
    Exit;

  datah.items[Item].moveable := 0;

end;

procedure PrimitiveSetVisible(Item: Cardinal);
var
  objarray: TPrimitiveObjectArray;
  i: Cardinal;

begin
  SetLength(objarray, 0);
  if not IsServerActive then
    Exit;

  datah.items[Item].invisible := 0;
  objarray := PrimitiveListObjectsNearLocation(OTPLAYER, PrimitiveGetObjectXMain(OTITEM, Item),
                                               PrimitiveGetObjectYMain(OTITEM, Item), 16);
  if Length(objarray) > 0 then
    for i := 0 to Length(objarray) - 1 do
      if datah.players[objarray[i]].online then
        if (datah.items[Item].contained > 0) and
           PrimitiveIsUnhidden(CheckObjectType(datah.items[PrimitiveGetMainContainer(Item)].equipped), PrimitiveGetObject(CheckObjectType(datah.items[PrimitiveGetMainContainer(Item)].equipped),
                               datah.items[PrimitiveGetMainContainer(Item)].equipped)) then
          insitem(objarray[i], datah.items[Item].id)

        else if (datah.items[Item].equipped > 0) and
                PrimitiveIsUnhidden(CheckObjectType(datah.items[Item].equipped), PrimitiveGetObject(CheckObjectType(datah.items[Item].equipped), datah.items[Item].equipped)) then
          begin
            equitem(objarray[i], datah.items[Item].equipped, Item);
            equchanged(datah.items[Item].equipped, objarray[i]);

          end

        else if (datah.items[Item].contained = 0) and
                (datah.items[Item].equipped = 0) then
          begin
            updateobj(OTITEM, objarray[i], Item);
            addnouitem(Item, objarray[i]);

          end;

end;

procedure PrimitiveSetInvisible(Item: Cardinal);
var
  objarray: TPrimitiveObjectArray;
  i: Cardinal;

begin
  SetLength(objarray, 0);
  if not IsServerActive then
    Exit;

  datah.items[Item].invisible := 1;
  if datah.items[Item].dragger > 0 then
    begin
      datah.items[Item].occupied := False;
      datah.players[datah.items[Item].dragger].dragging := False;
      datah.players[datah.items[Item].dragger].dragitem := 0;
      datah.players[datah.items[Item].dragger].dragamt := 0;
      denydragging(datah.items[Item].dragger);

    end;

  objarray := PrimitiveListObjectsNearLocation(OTPLAYER, PrimitiveGetObjectXMain(OTITEM, Item),
                                               PrimitiveGetObjectYMain(OTITEM, Item), 16);
  if Length(objarray) > 0 then
    for i := 0 to Length(objarray) - 1 do
      if datah.players[objarray[i]].online then
        if (datah.items[Item].equipped > 0) and (datah.items[Item].equipped <> datah.players[objarray[i]].id) and
           (datah.players[objarray[i]].privileged = 0) then
          begin
            delobj(OTITEM, objarray[i], Item);
            equchanged(datah.items[Item].equipped, objarray[i]);

          end

        else if ((datah.items[Item].equipped = 0) or (datah.items[Item].equipped = datah.players[objarray[i]].id)) and
                (datah.players[objarray[i]].privileged = 0) then
          delobj(OTITEM, objarray[i], Item);

end;

procedure PrimitiveSetPrivileged(ObjectType: Integer; ObjectReference: Cardinal);
var
  objarray, equitems: TPrimitiveObjectArray;
  i, j: Cardinal;

begin
  SetLength(objarray, 0);
  SetLength(equitems, 0);
  if not IsServerActive then
    Exit;

  if ObjectType = OTPLAYER then
    begin
      datah.players[ObjectReference].privileged := 1;
      if datah.players[ObjectReference].online then
        begin
          objarray := PrimitiveListObjectsNearLocation(OTPLAYER, datah.players[ObjectReference].x,
                                                       datah.players[ObjectReference].y, 16);
          if Length(objarray) > 0 then
            for i := 0 to Length(objarray) - 1 do
              begin
                if (datah.players[objarray[i]].hidden = 1) and
                   (objarray[i] <> ObjectReference) then
                  begin
                    updateobj(OTPLAYER, ObjectReference, objarray[i]);
                    updateequ(OTPLAYER, ObjectReference, objarray[i]);

                  end

                else
                  begin
                    equitems := PrimitiveListEquippedItems(OTPLAYER, objarray[i]);
                    if Length(equitems) > 0 then
                      for j := 0 to Length(objarray) - 1 do
                        if datah.items[equitems[j]].invisible = 1 then
                          begin
                            equitem(ObjectReference, datah.players[objarray[i]].id, equitems[j]);
                            equchanged(datah.players[objarray[i]].id, ObjectReference);

                          end

                        else if datah.items[equitems[j]].container = 1 then
                          begin
                            delobj(OTITEM, ObjectReference, equitems[j]);
                            equitem(ObjectReference, datah.players[objarray[i]].id, equitems[j]);
                            equchanged(datah.players[objarray[i]].id, ObjectReference);

                          end;

                  end;

              end;

          objarray := PrimitiveListObjectsNearLocation(OTNPC, datah.players[ObjectReference].x,
                                                       datah.players[ObjectReference].y, 16);
          if Length(objarray) > 0 then
            for i := 0 to Length(objarray) - 1 do
              begin
                if datah.npcs[objarray[i]].hidden = 1 then
                  begin
                    updateobj(OTNPC, ObjectReference, objarray[i]);
                    updateequ(OTNPC, ObjectReference, objarray[i]);

                  end

                else
                  begin
                    equitems := PrimitiveListEquippedItems(OTNPC, objarray[i]);
                    if Length(equitems) > 0 then
                      for j := 0 to Length(objarray) - 1 do
                        if datah.items[equitems[j]].invisible = 1 then
                          begin
                            equitem(ObjectReference, datah.npcs[objarray[i]].id, equitems[j]);
                            equchanged(datah.npcs[objarray[i]].id, ObjectReference);

                          end

                        else if datah.items[equitems[j]].container = 1 then
                          begin
                            delobj(OTITEM, ObjectReference, equitems[j]);
                            equitem(ObjectReference, datah.players[objarray[i]].id, equitems[j]);
                            equchanged(datah.npcs[objarray[i]].id, ObjectReference);

                          end;

                  end;

              end;

          objarray := PrimitiveListObjectsNearLocation(OTITEM, datah.players[ObjectReference].x,
                                                       datah.players[ObjectReference].y, 16);
          if Length(objarray) > 0 then
            for i := 0 to Length(objarray) - 1 do
              begin
                if datah.items[objarray[i]].invisible = 1 then
                  begin
                    updateobj(OTITEM, ObjectReference, objarray[i]);
                    addnouitem(objarray[i], ObjectReference);

                  end;

                if datah.items[objarray[i]].container = 1 then
                  begin
                    delobj(OTITEM, ObjectReference, objarray[i]);
                    updateobj(OTITEM, ObjectReference, objarray[i]);
                    addnouitem(objarray[i], ObjectReference);

                  end;

              end;

        end;

    end

  else if ObjectType = OTNPC then
    datah.npcs[ObjectReference].privileged := 1;

end;

procedure PrimitiveSetUnprivileged(ObjectType: Integer; ObjectReference: Cardinal);
var
  objarray, equitems: TPrimitiveObjectArray;
  i, j: Cardinal;

begin
  SetLength(objarray, 0);
  SetLength(equitems, 0);
  if not IsServerActive then
    Exit;

  if ObjectType = OTPLAYER then
    begin
      datah.players[ObjectReference].privileged := 0;
      if datah.players[ObjectReference].online then
        begin
          objarray := PrimitiveListObjectsNearLocation(OTPLAYER, datah.players[ObjectReference].x,
                                                       datah.players[ObjectReference].y, 16);
          if Length(objarray) > 0 then
            for i := 0 to Length(objarray) - 1 do
              begin
                if (datah.players[objarray[i]].hidden = 1) and
                   (objarray[i] <> ObjectReference) then
                    begin
                      delobj(OTPLAYER, ObjectReference, objarray[i]);

                    end

                else
                  begin
                    equitems := PrimitiveListEquippedItems(OTPLAYER, objarray[i]);
                    if Length(equitems) > 0 then
                      for j := 0 to Length(objarray) - 1 do
                        if datah.items[equitems[j]].invisible = 1 then
                          begin
                            delobj(OTITEM, ObjectReference, equitems[j]);
                            equchanged(datah.players[objarray[i]].id, ObjectReference);

                          end;

                  end;

              end;

          objarray := PrimitiveListObjectsNearLocation(OTNPC, datah.players[ObjectReference].x,
                                                       datah.players[ObjectReference].y, 16);
          if Length(objarray) > 0 then
            for i := 0 to Length(objarray) - 1 do
              begin
                if datah.npcs[objarray[i]].hidden = 1 then
                  begin
                    delobj(OTNPC, ObjectReference, objarray[i]);

                  end

                else
                  begin
                    equitems := PrimitiveListEquippedItems(OTNPC, objarray[i]);
                    if Length(equitems) > 0 then
                      for j := 0 to Length(objarray) - 1 do
                        if datah.items[equitems[j]].invisible = 1 then
                          begin
                            delobj(OTITEM, ObjectReference, equitems[j]);
                            equchanged(datah.npcs[objarray[i]].id, ObjectReference);

                          end;

                  end;

              end;

          objarray := PrimitiveListObjectsNearLocation(OTITEM, datah.players[ObjectReference].x,
                                                       datah.players[ObjectReference].y, 16);
          if Length(objarray) > 0 then
            for i := 0 to Length(objarray) - 1 do
              begin
                if datah.items[objarray[i]].invisible = 1 then
                  begin
                    delobj(OTITEM, ObjectReference, objarray[i]);

                  end

                else
                  if datah.items[objarray[i]].container = 1 then
                    begin
                      delobj(OTITEM, ObjectReference, objarray[i]);
                      updateobj(OTITEM, ObjectReference, objarray[i]);

                    end;

              end;

        end;

    end

  else if ObjectType = OTNPC then
    datah.npcs[ObjectReference].privileged := 0;

end;

procedure PrimitiveSetUnhidden(ObjectType: Integer; ObjectReference: Cardinal);
var
  objarray: TPrimitiveObjectArray;
  i: Cardinal;

begin
  SetLength(objarray, 0);
  if not IsServerActive then
    Exit;

  if ObjectType = OTPLAYER then
    begin
      datah.players[ObjectReference].hidden := 0;
      objarray := PrimitiveListObjectsNearLocation(OTPLAYER, datah.players[ObjectReference].x,
                                                   datah.players[ObjectReference].y, 16);
      if Length(objarray) > 0 then
      for i := 0 to Length(objarray) - 1 do
        if datah.players[objarray[i]].online then
          if (ObjectReference <> objarray[i]) then
            begin
              updateobj(ObjectType, objarray[i], ObjectReference);
              updateequ(ObjectType, objarray[i], ObjectReference);

            end;

    end

  else if ObjectType = OTNPC then
    begin
      datah.npcs[ObjectReference].hidden := 0;
      objarray := PrimitiveListObjectsNearLocation(OTPLAYER, datah.players[ObjectReference].x,
                                                   datah.players[ObjectReference].y, 16);
      if Length(objarray) > 0 then
      for i := 0 to Length(objarray) - 1 do
        if datah.players[objarray[i]].online then
          begin
            updateobj(ObjectType, objarray[i], ObjectReference);
            updateequ(ObjectType, objarray[i], ObjectReference);

          end;

    end;

end;

procedure PrimitiveSetHidden(ObjectType: Integer; ObjectReference: Cardinal);
var
  objarray: TPrimitiveObjectArray;
  i: Cardinal;

begin
  SetLength(objarray, 0);
  if not IsServerActive then
    Exit;

  if ObjectType = OTPLAYER then
    begin
      datah.players[ObjectReference].hidden := 1;
      objarray := PrimitiveListObjectsNearLocation(OTPLAYER, datah.players[ObjectReference].x,
                                                   datah.players[ObjectReference].y, 16);
      if Length(objarray) > 0 then
      for i := 0 to Length(objarray) - 1 do
        if datah.players[objarray[i]].online then
          if (ObjectReference <> objarray[i]) and (datah.players[objarray[i]].privileged = 0) then
            delobj(ObjectType, objarray[i], ObjectReference);

    end

  else if ObjectType = OTNPC then
    begin
      datah.npcs[ObjectReference].hidden := 1;
      objarray := PrimitiveListObjectsNearLocation(OTPLAYER, datah.npcs[ObjectReference].x,
                                                   datah.npcs[ObjectReference].y, 16);
      if Length(objarray) > 0 then
      for i := 0 to Length(objarray) - 1 do
        if datah.players[objarray[i]].online then
          if (datah.players[objarray[i]].privileged = 0) then
            delobj(ObjectType, objarray[i], ObjectReference);

    end;

end;

procedure PrimitiveSetItemLighting(Item: Cardinal; Lighting: Byte);
begin
  if not IsServerActive then
    Exit;

  datah.items[Item].lighting := Lighting;
  delobjao(OTITEM, Item);
  updateobjao(OTITEM, Item);

end;

procedure SaveWorldState;
begin
  if not IsServerActive and not issaving and not isshuttingdown then
    Exit;

  savedata;

end;

procedure ShutDown;
begin  
  if not IsServerActive and not isshuttingdown and not issaving then
    Exit;

  shutdownserver;

end;

procedure PrimitiveKick(Player: Cardinal);
begin  
  if not IsServerActive then
    Exit;

  if datah.players[Player].client <> nil then
    try
      (datah.players[Player].client as tclient).Shutdown(2);
      (datah.players[Player].client as tclient).Shutdown(0);

    finally
    end;

end;

procedure PrimitiveSetPlayerRealName(Player: Cardinal; RealName: String);
begin 
  if not IsServerActive then
    Exit;

  datah.players[Player].realname := RealName;

end;

procedure PrimitiveSetPlayerHomepage(Player: Cardinal; Homepage: String);
begin 
  if not IsServerActive then
    Exit;

  datah.players[Player].homepage := Homepage;

end;

procedure PrimitiveSetPlayerEMailAddress(Player: Cardinal; EMailAddress: String);
begin  
  if not IsServerActive then
    Exit;

  datah.players[Player].emailaddr := EMailAddress;

end;

procedure PrimitiveSetPlayerPCInfo(Player: Cardinal; PCInfo: String);
begin  
  if not IsServerActive then
    Exit;

  datah.players[Player].pcinfo := PCInfo;

end;

procedure PrimitiveWalk(NPC: Cardinal; Direction: Byte);
var
  oldx, oldy: Word;
  oldz, xmod, ymod: ShortInt;
  staidxstart, staidxend: Cardinal;
  static: tstatic;
  statictile: tstatictile;
  objarray: TPrimitiveObjectArray;
  i, j: Cardinal;
  openconts: Array of Cardinal;

begin  
  if not IsServerActive then
    Exit;

  oldx := datah.npcs[NPC].x;
  oldy := datah.npcs[NPC].y;
  oldz := datah.npcs[NPC].z;
  xmod := 0;
  ymod := 0;
  if Direction <> datah.npcs[NPC].facing then
    PrimitiveSetFacing(OTNPC, NPC, Direction);

  if Direction = DFNORTH then
    ymod := -1

  else if Direction = DFNORTHEAST then
    begin
      xmod := 1;
      ymod := -1;

    end

  else if Direction = DFEAST then
    xmod := 1

  else if Direction = DFSOUTHEAST then
    begin
      xmod := 1;
      ymod := 1;

    end

  else if Direction = DFSOUTH then
    ymod := 1

  else if Direction = DFSOUTHWEST then
    begin
      xmod := -1;
      ymod := 1;

    end

  else if Direction = DFWEST then
    xmod := -1

  else if Direction = DFNORTHWEST then
    begin
      xmod := -1;
      ymod := -1;

    end;

  datah.npcs[NPC].x := datah.npcs[NPC].x + xmod;
  datah.npcs[NPC].y := datah.npcs[NPC].y + ymod;
  datah.npcs[NPC].z := getstandingheight(datah.npcs[NPC].x, datah.npcs[NPC].y, datah.npcs[NPC].z);
  if getstaidx(datah.npcs[NPC].x, datah.npcs[NPC].y).start = NOSTATICS then
    begin
      if (getworldheight(oldx, oldy) - datah.npcs[NPC].z < -MAXHEIGHT) or
         (getlandtile(gettile(datah.npcs[NPC].x, datah.npcs[NPC].y).graphic).flags and FLAGIMPASSIBLE <> 0) then
        begin
          datah.npcs[NPC].x := oldx;
          datah.npcs[NPC].y := oldy;
          datah.npcs[NPC].z := oldz;
          Exit;

        end;

    end

  else
    begin
      staidxstart := getstaidx(datah.npcs[NPC].x, datah.npcs[NPC].y).start div SizeOf(tstatic);
      staidxend := getstaidx(datah.npcs[NPC].x, datah.npcs[NPC].y).length div SizeOf(tstatic) + staidxstart;
      for i := staidxstart to staidxend - 1 do
        begin
          static := getstatic(i);
          statictile := getstatictile(static.graphic);
          if (static.x = datah.npcs[NPC].x mod 8) and (static.y = datah.npcs[NPC].y mod 8) and
             (datah.npcs[NPC].z = static.z) and (statictile.flags and FLAGIMPASSIBLE <> 0) then
            begin
              datah.npcs[NPC].x := oldx;
              datah.npcs[NPC].y := oldy;
              datah.npcs[NPC].z := oldz;
              Exit;

            end

        end;

    end;

  (*
  SetLength(objarray, 0);
  objarray := getnpcsat2dpos(datah.npcs[NPC].x, datah.npcs[NPC].y);
  if Length(objarray) > 0 then
    for i := 0 to Length(objarray) - 1 do
      if datah.npcs[objarray[i]].z = datah.npcs[NPC].z then
        begin
          datah.npcs[NPC].x := oldx;
          datah.npcs[NPC].y := oldy;
          datah.npcs[NPC].z := oldz;
          Exit;

        end;

  SetLength(objarray, 0);
  objarray := getplayersat2dpos(datah.npcs[NPC].x, datah.npcs[NPC].y);
  if Length(objarray) > 0 then
    for i := 0 to Length(objarray) - 1 do
      if (datah.npcs[NPC].z = datah.players[objarray[i]].z) and
         datah.players[objarray[i]].online then
        begin
          datah.npcs[NPC].x := oldx;
          datah.npcs[NPC].y := oldy;
          datah.npcs[NPC].z := oldz;
          Exit;

        end;
  *)

  SetLength(objarray, 0);
  objarray := getitemsat2dpos(datah.npcs[NPC].x, datah.npcs[NPC].y);
  if Length(objarray) > 0 then
    for i := 0 to Length(objarray) - 1 do
      if (datah.items[objarray[i]].z = datah.npcs[NPC].z) and
         (datah.items[objarray[i]].walkable <> Direction) and
         (datah.items[objarray[i]].walkable <> DFALL) then
        begin
          datah.npcs[NPC].x := oldx;
          datah.npcs[NPC].y := oldy;
          datah.npcs[NPC].z := oldz;
          Exit;

        end;

  if Length(objarray) > 0 then
    for i := 0 to Length(objarray) - 1 do
      if datah.items[objarray[i]].z = datah.npcs[NPC].z then
        startitemscript(datah.items[objarray[i]].scriptname, CardToStr(objarray[i]),
                        IntToStr(ETWALKEDON), IntToStr(OTNPC), '',
                        CardToStr(NPC));

  remnpcfrom2dpos(NPC, oldx, oldy);
  addnpcto2dpos(NPC, datah.npcs[NPC].x, datah.npcs[NPC].y);
  SetLength(objarray, 0);
  objarray := PrimitiveListObjectsNearLocation(OTPLAYER, datah.npcs[NPC].x,
                                               datah.npcs[NPC].y, 17);
  if Length(objarray) > 0 then
    for i := 0 to Length(objarray) - 1 do
      begin
        if (Abs(datah.npcs[NPC].x - datah.players[objarray[i]].x) <= 16) and
           (Abs(datah.npcs[NPC].y - datah.players[objarray[i]].y) <= 16) and
           datah.players[objarray[i]].online then
          begin
            if ((datah.npcs[NPC].hidden = 0) or (datah.players[objarray[i]].privileged = 1)) and
               not isnouenpc(NPC, objarray[i]) then
              begin
                updateobj(OTNPC, objarray[i], NPC);
                updateequ(OTNPC, objarray[i], NPC);

              end

            else if ((datah.npcs[NPC].hidden = 0) or (datah.players[objarray[i]].privileged = 1)) and
                    isnouenpc(NPC, objarray[i]) then
              updateobj(OTNPC, objarray[i], NPC);

          end

        else if datah.players[objarray[i]].online and
                ((datah.npcs[NPC].hidden = 0) or (datah.players[objarray[i]].privileged = 1)) then
          delobj(OTNPC, objarray[i], NPC);

        if not datah.players[objarray[i]].online then
          Continue;

        while datah.players[objarray[i]].ococ do
          Sleep(1);

        datah.players[objarray[i]].ococ := True;
        SetLength(openconts, Length(datah.players[objarray[i]].openconts));
        Move(datah.players[objarray[i]].openconts[0], openconts[0], Length(datah.players[objarray[i]].openconts) * 4);
        datah.players[objarray[i]].ococ := False;
        if Length(openconts) > 0 then
          begin
            for j := 0 to Length(openconts) - 1 do
              if datah.players[objarray[i]].online then
                begin
                  if PrimitiveCheckObjectDistance(OTITEM, openconts[j],
                                                  OTPLAYER, objarray[i]) <= 16 then
                    begin
                      if (((PrimitiveGetMainContainer(openconts[j]) > 0) and
                         (datah.items[PrimitiveGetMainContainer(openconts[j])].equipped = datah.npcs[NPC].id)) or
                         ((PrimitiveGetMainContainer(openconts[j]) = 0) and
                         (datah.items[openconts[j]].equipped = datah.npcs[NPC].id))) and
                         ((datah.items[openconts[j]].invisible = 0) or
                         (datah.players[objarray[i]].privileged = 1)) and
                         ((datah.npcs[NPC].hidden = 0) or
                         (datah.players[objarray[i]].privileged = 1)) then
                        begin
                          delobj(OTITEM, objarray[i], openconts[j]);
                          equitem(objarray[i], datah.npcs[NPC].id, openconts[j]);
                          equchanged(datah.npcs[NPC].id, objarray[i]);

                        end;

                    end

                end

              else
                Break;

          end;

      end;

end;

procedure PrimitiveAttack(NPC: Cardinal; ObjectType: Integer; ObjectReference: Cardinal);
begin
  if not IsServerActive then
    Exit;

  startmiscscript('onattack', IntToStr(OTNPC), CardToStr(NPC), IntToStr(ObjectType),
                  CardToStr(ObjectReference));

  if ObjectType = OTNPC then
    PrimitiveSetEvent(ObjectReference, ETATTACKED, OTNPC, '', NPC);

end;

procedure PrimitiveSetDead(Player: Cardinal);
begin
  if not IsServerActive or PrimitiveIsPrivileged(OTPLAYER, Player) or
     (datah.players[Player].dead = 1) then
    Exit;

  datah.players[Player].dead := 1;
  startmiscscript('ondeath', IntToStr(OTPLAYER), CardToStr(Player));

end;

procedure PrimitiveSetAlive(Player: Cardinal);
begin      
  if not IsServerActive or (datah.players[Player].dead = 0) then
    Exit;

  datah.players[Player].dead := 0;
  startmiscscript('onres', CardToStr(Player));

end;

procedure StartScript(ScriptType: Integer; ScriptName, Parameter1, Parameter2, Parameter3, Parameter4, Parameter5: String);
begin  
  if not IsServerActive and not isshuttingdown then
    Exit;

  if ScriptType = STMISC then
    startmiscscript(ScriptName, Parameter1, Parameter2, Parameter3, Parameter4, Parameter5)

  else if ScriptType = STNPC then
    startnpcscript(ScriptName, Parameter1, Parameter2, Parameter3, Parameter4, Parameter5)

  else if ScriptType = STITEM then
    startitemscript(ScriptName, Parameter1, Parameter2, Parameter3, Parameter4, Parameter5)

  else if ScriptType = STCMD then
    startcmdscript(ScriptName, Parameter1, Parameter2, Parameter3, Parameter4, Parameter5)

  else if ScriptType = STSKILL then
    startskillscript(ScriptName, Parameter1, Parameter2, Parameter3, Parameter4, Parameter5);

end;

function PrimitiveGetNPCType(NPC: Cardinal): Cardinal;
begin     
  if not IsServerActive then
    begin
      Result := 0;
      Exit;

    end;

  Result := datah.npcs[NPC].npctype;

end;

function PrimitiveGetExperience(ObjectType: Integer; ObjectReference: Cardinal): Cardinal;
begin     
  if not IsServerActive then
    begin
      Result := 0;
      Exit;

    end;

  if ObjectType = OTPLAYER then
    Result := datah.players[ObjectReference].exp

  else if ObjectType = OTNPC then
    Result := datah.npcs[ObjectReference].exp

  else
    Result := 0;

end;

function PrimitiveGetLevel(ObjectType: Integer; ObjectReference: Cardinal): Cardinal;
begin    
  if not IsServerActive then
    begin
      Result := 0;
      Exit;

    end;

  if ObjectType = OTPLAYER then
    Result := datah.players[ObjectReference].level

  else if ObjectType = OTNPC then
    Result := datah.npcs[ObjectReference].level

  else
    Result := 0;

end;

function PrimitiveGetSkill(ObjectType: Integer; ObjectReference: Cardinal; Skill: Integer): Byte;
begin    
  if not IsServerActive then
    begin
      Result := 0;
      Exit;

    end;

  if ObjectType = OTPLAYER then
    case Skill of
      SKIDMAGICDEFENSE: Result := datah.players[ObjectReference].magicdef;
      SKIDBATTLEDEFENSE: Result := datah.players[ObjectReference].battledef;
      SKIDSTEALING: Result := datah.players[ObjectReference].stealing;
      SKIDHIDING: Result := datah.players[ObjectReference].hiding;
      SKIDFIRSTAID: Result := datah.players[ObjectReference].firstaid;
      SKIDDETECTTRAP: Result := datah.players[ObjectReference].detecttr;
      SKIDPEEK: Result := datah.players[ObjectReference].peek;
      SKIDMAGIC: Result := datah.players[ObjectReference].magic;
      SKIDMELEE: Result := datah.players[ObjectReference].melee;
      SKIDRANGEDWEAPONS: Result := datah.players[ObjectReference].rangedweap

    else
      Result := 0;

    end

  else if ObjectType = OTNPC then
    case Skill of
      SKIDMAGICDEFENSE: Result := datah.npcs[ObjectReference].magicdef;
      SKIDBATTLEDEFENSE: Result := datah.npcs[ObjectReference].battledef;
      SKIDSTEALING: Result := datah.npcs[ObjectReference].stealing;
      SKIDHIDING: Result := datah.npcs[ObjectReference].hiding;
      SKIDFIRSTAID: Result := datah.npcs[ObjectReference].firstaid;
      SKIDDETECTTRAP: Result := datah.npcs[ObjectReference].detecttr;
      SKIDPEEK: Result := datah.npcs[ObjectReference].peek;
      SKIDMAGIC: Result := datah.npcs[ObjectReference].magic;
      SKIDMELEE: Result := datah.npcs[ObjectReference].melee;
      SKIDRANGEDWEAPONS: Result := datah.npcs[ObjectReference].rangedweap

    else
      Result := 0;

    end

  else
    Result := 0;

end;

function PrimitiveIsOnline(Player: Cardinal): Boolean;
begin    
  if not IsServerActive then
    begin
      Result := False;
      Exit;

    end;

  Result := datah.players[Player].online;

end;

function PrimitiveIsAlive(Player: Cardinal): Boolean;
begin 
  if not IsServerActive then
    begin
      Result := False;
      Exit;

    end;

  if datah.players[Player].dead = 0 then
    Result := True

  else
    Result := False;

end;

function PrimitiveGetHits(ObjectType: Integer; ObjectReference: Cardinal): Byte;
begin  
  if not IsServerActive then
    begin
      Result := 0;
      Exit;

    end;

  if ObjectType = OTPLAYER then
    Result := datah.players[ObjectReference].hits

  else if ObjectType = OTNPC then
    Result := datah.npcs[ObjectReference].hits

  else
    Result := 0;

end;

function PrimitiveGetMana(ObjectType: Integer; ObjectReference: Cardinal): Byte;
begin   
  if not IsServerActive then
    begin
      Result := 0;
      Exit;

    end;

  if ObjectType = OTPLAYER then
    Result := datah.players[ObjectReference].mana

  else if ObjectType = OTNPC then
    Result := datah.npcs[ObjectReference].mana

  else
    Result := 0;

end;

function PrimitiveGetFatigue(ObjectType: Integer; ObjectReference: Cardinal): Byte;
begin 
  if not IsServerActive then
    begin
      Result := 0;
      Exit;

    end;

  if ObjectType = OTPLAYER then
    Result := datah.players[ObjectReference].fat

  else if ObjectType = OTNPC then
    Result := datah.npcs[ObjectReference].fat

  else
    Result := 0;

end;

function PrimitiveIsCriminal(ObjectType: Integer; ObjectReference: Cardinal): Boolean;
begin
  if not IsServerActive then
    begin
      Result := False;
      Exit;

    end;

  if ObjectType = OTPLAYER then
    if datah.players[ObjectReference].criminal = 1 then
      Result := True

    else
      Result := False

  else if ObjectType = OTNPC then
    if datah.npcs[ObjectReference].criminal = 1 then
      Result := True

    else
      Result := False

  else
    Result := False;

end;

function PrimitiveIsAtWar(Player: Cardinal): Boolean;
begin   
  if not IsServerActive then
    begin
      Result := False;
      Exit;

    end;

  if datah.players[Player].war = 1 then
    Result := True

  else
    Result := False;

end;

function PrimitiveIsContainedIn(Item: Cardinal): Cardinal;
begin   
  if not IsServerActive then
    begin
      Result := 0;
      Exit;

    end;

  Result := PrimitiveGetObject(OTITEM, datah.items[Item].contained);

end;

function PrimitiveIsEquippedBy(Item: Cardinal): Cardinal;
begin    
  if not IsServerActive then
    begin
      Result := 0;
      Exit;

    end;

  Result := PrimitiveGetObject(CheckObjectType(datah.items[Item].equipped), datah.items[Item].equipped);

end;

function PrimitiveGetWeight(Item: Cardinal): Word;
begin  
  if not IsServerActive then
    begin
      Result := 0;
      Exit;

    end;

  Result := datah.items[Item].weight;

end;

function PrimitiveIsWeapon(Item: Cardinal): Boolean;
begin
  if not IsServerActive then
    begin
      Result := False;
      Exit;

    end;

  if datah.items[Item].weapon = 1 then
    Result := True

  else
    Result := False;

end;

function PrimitiveIsArmor(Item: Cardinal): Boolean;
begin  
  if not IsServerActive then
    begin
      Result := False;
      Exit;

    end;

  if datah.items[Item].armor = 1 then
    Result := True

  else
    Result := False;

end;

function PrimitiveGetWeaponSpeed(Weapon: Cardinal): Byte;
begin   
  if not IsServerActive or (datah.items[Weapon].weapon = 0) then
    begin
      Result := 0;
      Exit;

    end;

  Result := datah.items[Weapon].weapspeed;

end;

function PrimitiveGetWeaponDamage(Weapon: Cardinal): Byte;
begin  
  if not IsServerActive or (datah.items[Weapon].weapon = 0) then
    begin
      Result := 0;
      Exit;

    end;

  Result := datah.items[Weapon].weapdamage;

end;

function PrimitiveGetArmorStrength(Armor: Cardinal): Byte;
begin    
  if not IsServerActive or (datah.items[Armor].armor = 0) then
    begin
      Result := 0;
      Exit;

    end;

  Result := datah.items[Armor].armorstr;

end;

function PrimitiveIsMoveable(Item: Cardinal): Boolean;
begin    
  if not IsServerActive then
    begin
      Result := False;
      Exit;

    end;

  if datah.items[Item].moveable = 1 then
    Result := True

  else
    Result := False;

end;

function PrimitiveIsVisible(Item: Cardinal): Boolean;
begin   
  if not IsServerActive then
    begin
      Result := False;
      Exit;

    end;

  if datah.items[Item].invisible = 0 then
    Result := True

  else
    Result := False;

end;

function PrimitiveIsPrivileged(ObjectType: Integer; ObjectReference: Cardinal): Boolean;
begin    
  if not IsServerActive then
    begin
      Result := False;
      Exit;

    end;

  if ObjectType = OTPLAYER then
    if datah.players[ObjectReference].privileged = 1 then
      Result := True

    else
      Result := False

  else if ObjectType = OTNPC then
    if datah.npcs[ObjectReference].privileged = 1 then
      Result := True

    else
      Result := False

  else
    Result := False;

end;

function PrimitiveIsUnhidden(ObjectType: Integer; ObjectReference: Cardinal): Boolean;
begin   
  if not IsServerActive then
    begin
      Result := False;
      Exit;

    end;

  if ObjectType = OTPLAYER then
    if datah.players[ObjectReference].hidden = 0 then
      Result := True

    else
      Result := False

  else if ObjectType = OTNPC then
    if datah.npcs[ObjectReference].hidden = 0 then
      Result := True

    else
      Result := False

  else
    Result := False;

end;

function PrimitiveIsStackable(Item: Cardinal): Boolean;
begin   
  if not IsServerActive then
    begin
      Result := False;
      Exit;

    end;

  if datah.items[Item].stackable = 1 then
    Result := True

  else
    Result := False;

end;

function PrimitiveGetItemLighting(Item: Cardinal): Byte;
begin   
  if not IsServerActive then
    begin
      Result := 0;
      Exit;

    end;

  Result := datah.items[Item].lighting;

end;

function PrimitiveGetPlayerRealName(Player: Cardinal): String;
begin   
  if not IsServerActive then
    Exit;

  Result := datah.players[Player].realname;

end;

function PrimitiveGetPlayerHomepage(Player: Cardinal): String;
begin   
  if not IsServerActive then
    Exit;

  Result := datah.players[Player].realname;

end;

function PrimitiveGetPlayerEMailAddress(Player: Cardinal): String;
begin  
  if not IsServerActive then
    Exit;

  Result := datah.players[Player].realname;

end;

function PrimitiveGetPlayerPCInfo(Player: Cardinal): String;
begin   
  if not IsServerActive then
    Exit;

  Result := datah.players[Player].realname;

end;

function PrimitiveGetScriptName(ObjectType: Integer; ObjectReference: Cardinal): String;
begin
  if not IsServerActive then
    Exit;

  if ObjectType = OTITEM then
    Result := datah.items[ObjectReference].scriptname

  else if ObjectType = OTNPC then
    Result := datah.npcs[ObjectReference].scriptname

  else
    Result := '';

end;

function PrimitiveIsWalkable(Item: Cardinal): Byte;
begin    
  if not IsServerActive then
    begin
      Result := DFNONE;
      Exit;

    end;

  Result := datah.items[Item].walkable;

end;

procedure PrimitiveSetWalkable(Item: Cardinal; Direction: Byte);
begin    
  if not IsServerActive then
    Exit;

  datah.items[Item].walkable := Direction;

end;

function PrimitiveGetObjectID(ObjectType: Integer; ObjectReference: Cardinal): Cardinal;
begin    
  if not IsServerActive then
    begin
      Result := 0;
      Exit;

    end;

  if ObjectType = OTITEM then
    Result := datah.items[ObjectReference].id

  else if ObjectType = OTNPC then
    Result := datah.npcs[ObjectReference].id

  else if ObjectType = OTPLAYER then
    Result := datah.players[ObjectReference].id

  else
    Result := 0;

end;

procedure PrimitiveOpenOrCloseDoor(Door: Cardinal; Graphic: Word; XRelative, YRelative: ShortInt);
begin    
  if not IsServerActive then
    Exit;

  if (Abs(XRelative) > 1) or (Abs(YRelative) > 1) then
    Exit;

  if datah.items[Door].contained > 0 then
    Exit;

  while datah.items[Door].occupied do
    Sleep(1);

  datah.items[Door].occupied := True;
  if (XRelative = 0) and (YRelative = 0) then
    PrimitiveSetGraphic(OTITEM, Door, Graphic)

  else
    begin
      remitemfrom2dpos(Door, datah.items[Door].x, datah.items[Door].y);
      datah.items[Door].x := datah.items[Door].x + XRelative;
      datah.items[Door].y := datah.items[Door].y + YRelative;
      additemto2dpos(Door, datah.items[Door].x, datah.items[Door].y);
      datah.items[Door].graphic := Graphic;
      updateobjao(OTITEM, Door);

    end;

  datah.items[Door].occupied := False;

end;

function RandomInteger(Limit: Integer): Integer;
begin
  if not IsServerActive then
    begin
      Result := 0;
      Exit;

    end;

  Result := Random(Limit + 1);

end;

function PrimitiveListOnlinePlayers: TPrimitiveObjectArray;
var
  temparray: TPrimitiveObjectArray;
  i: Cardinal;

begin
  SetLength(temparray, 0);
  if not IsServerActive then
    begin
      Result := temparray;
      Exit;

    end;

  for i := 1 to datah.getplayerslen - 1 do
    if datah.players[i].online then
      begin
        SetLength(temparray, Length(temparray) + 1);
        temparray[Length(temparray) - 1] := i;

      end;

  Result := temparray;

end;

function PrimitiveGetColor(Item: Cardinal): Word;
begin
  if not IsServerActive then
    begin
      Result := 0;
      Exit;

    end;

  Result := datah.items[Item].color;

end;

function IsServerActive: Boolean;
begin
  serveractivelock.Acquire;
  Result := serveractive;
  serveractivelock.Release;

end;

function IsEquippedByObjectType(Item: Cardinal): Integer;
begin
  if not IsServerActive then
    begin
      Result := OTNONE;
      Exit;

    end;

  Result := CheckObjectType(datah.items[Item].equipped);

end;

function PrimitiveGetEquipmentByLayer(ObjectType: Integer; ObjectReference: Cardinal; Layer: Byte): Cardinal;
var
  objarray: TPrimitiveObjectArray;
  i: Cardinal;

begin
  SetLength(objarray, 0);
  if not IsServerActive then
    begin
      Result := 0;
      Exit;

    end;

  objarray := PrimitiveListEquippedItems(ObjectType, ObjectReference);
  if Length(objarray) > 0 then
    for i := 0 to Length(objarray) - 1 do
      if getstatictile(datah.items[objarray[i]].graphic).layer = Layer then
        begin
          Result := objarray[i];
          Exit;

        end;

  Result := 0;

end;

function CardToStr(Card: Cardinal): String;
begin
  Result := IntToStr(Card);

end;

function StrToCard(Str: String): Cardinal;
begin
  Result := StrToInt64(Str);

end;

function GetObject(ObjectType: Integer; ID: Cardinal): TObjectReference;
var
  tempobjref: TObjectReference;

begin
  tempobjref.objtype := CheckObjectType(ID);
  tempobjref.pobjref := PrimitiveGetObject(tempobjref.objtype, ID);
  Result := tempobjref;

end;

function ListObjects(ObjectType: Integer): TObjectArray;
var
  temppobjarray: TPrimitiveObjectArray;
  tempobjarray: TObjectArray;
  i: Cardinal;

begin
  SetLength(tempobjarray, 0);
  temppobjarray := PrimitiveListObjects(ObjectType);
  if Length(temppobjarray) > 0 then
    begin
      SetLength(tempobjarray, Length(temppobjarray));
      for i := 0 to Length(temppobjarray) - 1 do
        begin
          tempobjarray[i].objtype := ObjectType;
          tempobjarray[i].pobjref := temppobjarray[i];

        end;

    end;

  Result := tempobjarray;

end;

function ListObjectsNearLocation(ObjectType: Integer; X, Y: Word; Distance: Cardinal): TObjectArray;
var
  temppobjarray: TPrimitiveObjectArray;
  tempobjarray: TObjectArray;
  i, len: Cardinal;

begin
  SetLength(tempobjarray, 0);
  if ObjectType = OTALL then
    begin
      temppobjarray := PrimitiveListObjectsNearLocation(OTPLAYER, X, Y, Distance);
      if Length(temppobjarray) > 0 then
        begin
          SetLength(tempobjarray, Length(temppobjarray));
          for i := 0 to Length(temppobjarray) - 1 do
            begin
              tempobjarray[i].objtype := OTPLAYER;
              tempobjarray[i].pobjref := temppobjarray[i];

            end;

        end;

      temppobjarray := PrimitiveListObjectsNearLocation(OTNPC, X, Y, Distance);
      if Length(temppobjarray) > 0 then
        begin
          len := Length(tempobjarray);
          SetLength(tempobjarray, Length(tempobjarray) + Length(temppobjarray));
          for i := 0 to Length(temppobjarray) - 1 do
            begin
              tempobjarray[len + i].objtype := OTNPC;
              tempobjarray[len + i].pobjref := temppobjarray[i];

            end;

        end;

      temppobjarray := PrimitiveListObjectsNearLocation(OTITEM, X, Y, Distance);
      if Length(temppobjarray) > 0 then
        begin
          len := Length(tempobjarray);
          SetLength(tempobjarray, Length(tempobjarray) + Length(temppobjarray));
          for i := 0 to Length(temppobjarray) - 1 do
            begin
              tempobjarray[len + i].objtype := OTITEM;
              tempobjarray[len + i].pobjref := temppobjarray[i];

            end;

        end;

    end

  else
    begin
      temppobjarray := PrimitiveListObjectsNearLocation(ObjectType, X, Y, Distance);
      if Length(temppobjarray) > 0 then
        begin
          SetLength(tempobjarray, Length(temppobjarray));
          for i := 0 to Length(temppobjarray) - 1 do
            begin
              tempobjarray[i].objtype := ObjectType;
              tempobjarray[i].pobjref := temppobjarray[i];

            end;

        end;

    end;

  Result := tempobjarray;

end;

function ListObjectsNearLocationAccurate(ObjectType: Integer; X, Y: Word; Z: ShortInt;
                                         Distance: Cardinal): TObjectArray;
var
  temppobjarray: TPrimitiveObjectArray;
  tempobjarray: TObjectArray;
  i, len: Cardinal;

begin
  SetLength(tempobjarray, 0);
  if ObjectType = OTALL then
    begin
      temppobjarray := PrimitiveListObjectsNearLocationAccurate(OTPLAYER, X, Y, Z, Distance);
      if Length(temppobjarray) > 0 then
        begin
          SetLength(tempobjarray, Length(temppobjarray));
          for i := 0 to Length(temppobjarray) - 1 do
            begin
              tempobjarray[i].objtype := OTPLAYER;
              tempobjarray[i].pobjref := temppobjarray[i];

            end;

        end;

      temppobjarray := PrimitiveListObjectsNearLocationAccurate(OTNPC, X, Y, Z, Distance);
      if Length(temppobjarray) > 0 then
        begin
          len := Length(tempobjarray);
          SetLength(tempobjarray, Length(tempobjarray) + Length(temppobjarray));
          for i := 0 to Length(temppobjarray) - 1 do
            begin
              tempobjarray[len + i].objtype := OTNPC;
              tempobjarray[len + i].pobjref := temppobjarray[i];

            end;

        end;

      temppobjarray := PrimitiveListObjectsNearLocationAccurate(OTITEM, X, Y, Z, Distance);
      if Length(temppobjarray) > 0 then
        begin
          len := Length(tempobjarray);
          SetLength(tempobjarray, Length(tempobjarray) + Length(temppobjarray));
          for i := 0 to Length(temppobjarray) - 1 do
            begin
              tempobjarray[len + i].objtype := OTITEM;
              tempobjarray[len + i].pobjref := temppobjarray[i];

            end;

        end;

    end

  else
    begin
      temppobjarray := PrimitiveListObjectsNearLocationAccurate(ObjectType, X, Y, Z, Distance);
      if Length(temppobjarray) > 0 then
        begin
          SetLength(tempobjarray, Length(temppobjarray));
          for i := 0 to Length(temppobjarray) - 1 do
            begin
              tempobjarray[i].objtype := ObjectType;
              tempobjarray[i].pobjref := temppobjarray[i];

            end;

        end;

    end;

  Result := tempobjarray;

end;

function GetObjectX(ObjectReference: TObjectReference): Word;
begin
  Result := PrimitiveGetObjectX(ObjectReference.objtype, ObjectReference.pobjref);

end;

function GetObjectY(ObjectReference: TObjectReference): Word;
begin
  Result := PrimitiveGetObjectY(ObjectReference.objtype, ObjectReference.pobjref);

end;

function GetObjectZ(ObjectReference: TObjectReference): ShortInt;
begin
  Result := PrimitiveGetObjectZ(ObjectReference.objtype, ObjectReference.pobjref);

end;

function GetEvent(NPC: TObjectReference): TEvent;
var
  tempev: TEvent;

begin
  tempev.evtype := OTNONE;
  if NPC.objtype = OTNPC then
    Result := PrimitiveGetEvent(NPC.pobjref)

  else
    Result := tempev;

end;

procedure SetEvent(NPC: TObjectReference; EventType: Integer; IntegerValue: Integer;
                   StringValue: String; CardinalValue: Cardinal);
begin
  if NPC.objtype = OTNPC then
    PrimitiveSetEvent(NPC.pobjref, EventType, IntegerValue, StringValue, CardinalValue);

end;

procedure EquipItem(ObjectReference, Item: TObjectReference);
begin
  if Item.objtype = OTITEM then
    PrimitiveEquipItem(ObjectReference.objtype, ObjectReference.pobjref, Item.pobjref);

end;

procedure UnequipItem(ObjectReference, Item: TObjectReference;
                      X, Y: Word; Z: ShortInt);
begin
  if Item.objtype = OTITEM then
    PrimitiveUnequipItem(ObjectReference.objtype, ObjectReference.pobjref,
                         Item.pobjref, X, Y, Z);

end;

function CreateObject(ObjectType: Integer; TypeID: Cardinal; X, Y: Word;
                      Z: ShortInt): TObjectReference;
var
  tempobjref: TObjectReference;

begin
  tempobjref.pobjref := PrimitiveCreateObject(ObjectType, TypeID, X, Y, Z);
  if tempobjref.pobjref = 0 then
    tempobjref.objtype := OTNONE

  else
    tempobjref.objtype := ObjectType;

  Result := tempobjref;

end;

procedure DeleteObject(ObjectReference: TObjectReference);
begin
  PrimitiveDeleteObject(ObjectReference.objtype, ObjectReference.pobjref);

end;

procedure InsertItem(Item, Container: TObjectReference; X, Y, Amount: Word);
begin
  if (Item.objtype = OTITEM) and (Container.objtype = OTITEM) then
    PrimitiveInsertItem(Item.pobjref, Container.pobjref, X, Y, Amount);

end;

procedure OpenContainer(Player, Container: TObjectReference);
begin
  if Container.objtype = OTITEM then
    PrimitiveOpenContainer(Player.pobjref, Container.pobjref);

end;

procedure RemoveItem(Item, Container: TObjectReference; X, Y: Word; Z: ShortInt;
                     Amount: Word);
begin
  if (Item.objtype = OTITEM) and (Container.objtype = OTITEM) then
    PrimitiveRemoveItem(Item.pobjref, Container.pobjref, X, Y, Z, Amount);

end;

function GetMainContainer(Item: TObjectReference): TObjectReference;
var
  tempobjref: TObjectReference;

begin
  if Item.objtype = OTITEM then
    tempobjref.pobjref := PrimitiveGetMainContainer(Item.pobjref)

  else
    tempobjref.pobjref := 0;

  if tempobjref.pobjref = 0 then
    tempobjref.objtype := OTNONE

  else
    tempobjref.objtype := OTITEM;

  Result := tempobjref;

end;

procedure SetAmount(Item: TObjectReference; Amount: Word);
begin
  if Item.objtype = OTITEM then
    PrimitiveSetAmount(Item.pobjref, Amount);

end;

function GetSex(ObjectReference: TObjectReference): Integer;
begin
  Result := PrimitiveGetSex(ObjectReference.objtype, ObjectReference.pobjref)

end;

procedure SetColor(Item: TObjectReference; Color: Word);
begin
  if Item.objtype = OTITEM then
    PrimitiveSetColor(Item.pobjref, Color);

end;

procedure PlayAnimationPrivate(Player: TObjectReference;
                               ObjectReference: TObjectReference; Animation: Integer);
begin
  if Player.objtype = OTPLAYER then
    PrimitivePlayAnimationPrivate(Player.pobjref, ObjectReference.objtype,
                                  ObjectReference.pobjref, Animation);

end;

procedure PlayAnimation(ObjectReference: TObjectReference;
                        Animation: Integer);
begin
  PrimitivePlayAnimation(ObjectReference.objtype, ObjectReference.pobjref, Animation);

end;

function CheckObjectDistance(ObjectReference1, ObjectReference2: TObjectReference): Cardinal;
begin
  Result := PrimitiveCheckObjectDistance(ObjectReference1.objtype,
                                         ObjectReference1.pobjref,
                                         ObjectReference2.objtype,
                                         ObjectReference2.pobjref);

end;

function CheckObjectToCoordinatesDistance(ObjectReference:  TObjectReference;
                                          X, Y: Word; Z: ShortInt): Cardinal;
begin
  Result := PrimitiveCheckObjectToCoordinatesDistance(ObjectReference.objtype,
                                                      ObjectReference.pobjref,
                                                      X, Y, Z);

end;

function GetObjectXMain(ObjectReference: TObjectReference): Word;
begin
  Result := PrimitiveGetObjectXMain(ObjectReference.objtype, ObjectReference.pobjref);

end;

function GetObjectYMain(ObjectReference: TObjectReference): Word;
begin
  Result := PrimitiveGetObjectYMain(ObjectReference.objtype, ObjectReference.pobjref);

end;

function GetObjectZMain(ObjectReference: TObjectReference): ShortInt;
begin
  Result := PrimitiveGetObjectZMain(ObjectReference.objtype, ObjectReference.pobjref);

end;

procedure PlaySoundEffectPrivate(Player: TObjectReference; SoundEffect: Word);
begin
  if Player.objtype = OTPLAYER then
    PrimitivePlaySoundEffectPrivate(Player.pobjref, SoundEffect);

end;

procedure SetLightLevelPrivate(Player: TObjectReference; LightLevel: Byte);
begin
  if Player.objtype = OTPLAYER then
    PrimitiveSetLightLevelPrivate(Player.pobjref, LightLevel);

end;

function GetAmount(Item: TObjectReference): Word;
begin
  if Item.objtype = OTITEM then
    Result := PrimitiveGetAmount(Item.pobjref)

  else
    Result := 0;

end;

function GetItemType(Item: TObjectReference): Cardinal;
begin
  if Item.objtype = OTITEM then
    Result := PrimitiveGetItemType(Item.pobjref)

  else
    Result := 0;

end;

function ListItemsInContainer(Container: TObjectReference): TObjectArray;
var
  temppobjarray: TPrimitiveObjectArray;
  tempobjarray: TObjectArray;
  i: Cardinal;

begin
  SetLength(tempobjarray, 0);
  SetLength(temppobjarray, 0);
  if Container.objtype = OTITEM then
    begin
      temppobjarray := PrimitiveListItemsInContainer(Container.pobjref);
      if Length(temppobjarray) > 0 then
        begin
          SetLength(tempobjarray, Length(temppobjarray));
          for i := 0 to Length(temppobjarray) - 1 do
            begin
              tempobjarray[i].objtype := OTITEM;
              tempobjarray[i].pobjref := temppobjarray[i];

            end;

        end;

    end;

  Result := tempobjarray;

end;

procedure SendText(TextType: Integer; ObjectReference,
                   Player: TObjectReference; Text: String; R, G, B: Byte);
begin
  if (Player.objtype = OTPLAYER) or (TextType = TTSPEECH) or (TextType = TTTEXTABOVE) then
    PrimitiveSendText(TextType, ObjectReference.objtype, ObjectReference.pobjref,
                      Player.pobjref, Text, R, G, B)

end;

function ListEquippedItems(ObjectReference: TObjectReference): TObjectArray;
var
  temppobjarray: TPrimitiveObjectArray;
  tempobjarray: TObjectArray;
  i: Cardinal;

begin
  SetLength(tempobjarray, 0);
  temppobjarray := PrimitiveListEquippedItems(ObjectReference.objtype, ObjectReference.pobjref);
  if Length(temppobjarray) > 0 then
    begin
      SetLength(tempobjarray, Length(temppobjarray));
      for i := 0 to Length(temppobjarray) - 1 do
        begin
          tempobjarray[i].objtype := OTITEM;
          tempobjarray[i].pobjref := temppobjarray[i];

        end;

    end;

  Result := tempobjarray;

end;

procedure SetSex(ObjectReference: TObjectReference; Sex: Integer);
begin
  PrimitiveSetSex(ObjectReference.objtype, ObjectReference.pobjref, Sex);

end;

function GetGraphic(ObjectReference: TObjectReference): Word;
begin
  Result := PrimitiveGetGraphic(ObjectReference.objtype, ObjectReference.pobjref);

end;

procedure SetGraphic(ObjectReference: TObjectReference; Graphic: Word);
begin
  PrimitiveSetGraphic(ObjectReference.objtype, ObjectReference.pobjref, Graphic);

end;

function GetName(ObjectReference: TObjectReference): String;
begin
  Result := PrimitiveGetName(ObjectReference.objtype, ObjectReference.pobjref);

end;

procedure SetName(ObjectReference: TObjectReference; Name: String);
begin
  PrimitiveSetName(ObjectReference.objtype, ObjectReference.pobjref, Name);

end;

function GetFacing(ObjectReference: TObjectReference): Byte;
begin
  Result := PrimitiveGetFacing(ObjectReference.objtype, ObjectReference.pobjref);

end;

procedure SetFacing(ObjectReference: TObjectReference; Facing: Byte);
begin
  PrimitiveSetFacing(ObjectReference.objtype, ObjectReference.pobjref, Facing);

end;

function GetStrength(ObjectReference: TObjectReference): Byte;
begin
  Result := PrimitiveGetStrength(ObjectReference.objtype, ObjectReference.pobjref);

end;

procedure SetStrength(ObjectReference: TObjectReference; Strength: Byte);
begin
  PrimitiveSetStrength(ObjectReference.objtype, ObjectReference.pobjref, Strength);

end;

function GetDexterity(ObjectReference: TObjectReference): Byte;
begin
  Result := PrimitiveGetDexterity(ObjectReference.objtype, ObjectReference.pobjref);

end;

procedure SetDexterity(ObjectReference: TObjectReference; Dexterity: Byte);
begin
  PrimitiveSetDexterity(ObjectReference.objtype, ObjectReference.pobjref, Dexterity);

end;

function GetIntelligence(ObjectReference: TObjectReference): Byte;
begin
  Result := PrimitiveGetIntelligence(ObjectReference.objtype, ObjectReference.pobjref);

end;

procedure SetIntelligence(ObjectReference: TObjectReference; Intelligence: Byte);
begin
  PrimitiveGetIntelligence(ObjectReference.objtype, ObjectReference.pobjref);

end;

procedure SetCProp(ObjectReference: TObjectReference; Name, StringValue: String;
                   CardinalValue: Cardinal; IntegerValue: Integer);
begin
  PrimitiveSetCProp(ObjectReference.objtype, ObjectReference.pobjref, Name,
                    StringValue, CardinalValue, IntegerValue);

end;

function GetCPropStringValue(ObjectReference: TObjectReference;
                             Name: String): String;
begin
  Result := PrimitiveGetCPropStringValue(ObjectReference.objtype,
                                         ObjectReference.pobjref, Name);

end;

function GetCPropCardinalValue(ObjectReference: TObjectReference;
                               Name: String): Cardinal;
begin
  Result := PrimitiveGetCPropCardinalValue(ObjectReference.objtype,
                                           ObjectReference.pobjref, Name);

end;

function GetCPropIntegerValue(ObjectReference: TObjectReference;
                              Name: String): Integer;
begin
  Result := PrimitiveGetCPropIntegerValue(ObjectReference.objtype,
                                          ObjectReference.pobjref, Name);

end;

function CPropExists(ObjectReference: TObjectReference;
                     Name: String): Boolean;
begin
  Result := PrimitiveCPropExists(ObjectReference.objtype,
                                 ObjectReference.pobjref, Name);

end;

procedure EraseCProp(ObjectReference: TObjectReference;
                     Name: String);
begin
  PrimitiveEraseCProp(ObjectReference.objtype,
                      ObjectReference.pobjref, Name);

end;

function RequestInput(Player: TObjectReference): String;
begin
  if Player.objtype = OTPLAYER then
    Result := PrimitiveRequestInput(Player.pobjref)

  else
    Result := '';

end;

procedure SetExperience(ObjectReference: TObjectReference; Experience: Cardinal);
begin
  PrimitiveSetExperience(ObjectReference.objtype, ObjectReference.pobjref, Experience);

end;

procedure SetLevel(ObjectReference: TObjectReference; Level: Byte);
begin
  PrimitiveSetLevel(ObjectReference.objtype, ObjectReference.pobjref, Level);

end;

procedure SetSkill(ObjectReference: TObjectReference; Skill: Integer;
                   SkillValue: Byte);
begin
  PrimitiveSetSkill(ObjectReference.objtype, ObjectReference.pobjref, Skill, SkillValue);

end;

procedure SetHits(ObjectReference: TObjectReference; Hits: Byte);
begin
  PrimitiveSetHits(ObjectReference.objtype, ObjectReference.pobjref, Hits);

end;

procedure SetMana(ObjectReference: TObjectReference; Mana: Byte);
begin
  PrimitiveSetMana(ObjectReference.objtype, ObjectReference.pobjref, Mana);

end;

procedure SetFatigue(ObjectReference: TObjectReference; Fatigue: Byte);
begin
  PrimitiveSetFatigue(ObjectReference.objtype, ObjectReference.pobjref, Fatigue);

end;

procedure SetWeight(Item: TObjectReference; Weight: Word);
begin
  if Item.objtype = OTITEM then
    PrimitiveSetWeight(Item.pobjref, Weight);

end;

procedure MoveObject(ObjectReference: TObjectReference; X, Y: Word; Z: ShortInt);
begin
  PrimitiveMoveObject(ObjectReference.objtype, ObjectReference.pobjref, X, Y, Z);

end;

procedure SetWeaponSpeed(Weapon: TObjectReference; WeaponSpeed: Integer);
begin
  if Weapon.objtype = OTITEM then
    PrimitiveSetWeaponSpeed(Weapon.pobjref, WeaponSpeed);

end;

procedure SetWeaponDamage(Weapon: TObjectReference; WeaponDamage: Integer);
begin
  if Weapon.objtype = OTITEM then
    PrimitiveSetWeaponDamage(Weapon.pobjref, WeaponDamage);

end;

procedure SetArmorStrength(Armor: TObjectReference; ArmorStrength: Integer);
begin
  if Armor.objtype = OTITEM then
    PrimitiveSetArmorStrength(Armor.pobjref, ArmorStrength);

end;

procedure SetMoveable(Item: TObjectReference);
begin
  if Item.objtype = OTITEM then
    PrimitiveSetMoveable(Item.pobjref);

end;

procedure SetUnmoveable(Item: TObjectReference);
begin
  if Item.objtype = OTITEM then
    PrimitiveSetUnmoveable(Item.pobjref);

end;

procedure SetVisible(Item: TObjectReference);
begin
  if Item.objtype = OTITEM then
    PrimitiveSetVisible(Item.pobjref);

end;

procedure SetInvisible(Item: TObjectReference);
begin
  if Item.objtype = OTITEM then
    PrimitiveSetInvisible(Item.pobjref);

end;

procedure SetPrivileged(ObjectReference: TObjectReference);
begin
  PrimitiveSetPrivileged(ObjectReference.objtype, ObjectReference.pobjref);

end;

procedure SetUnprivileged(ObjectReference: TObjectReference);
begin
  PrimitiveSetUnprivileged(ObjectReference.objtype, ObjectReference.pobjref);

end;

procedure SetUnhidden(ObjectReference: TObjectReference);
begin
  PrimitiveSetUnhidden(ObjectReference.objtype, ObjectReference.pobjref);

end;

procedure SetHidden(ObjectReference: TObjectReference);
begin
  PrimitiveSetHidden(ObjectReference.objtype, ObjectReference.pobjref);

end;

procedure SetItemLighting(Item: TObjectReference; Lighting: Byte);
begin
  if Item.objtype = OTITEM then
    PrimitiveSetItemLighting(Item.pobjref, Lighting);

end;

procedure Kick(Player: TObjectReference);
begin
  if Player.objtype = OTPLAYER then
    PrimitiveKick(Player.pobjref);

end;

procedure SetPlayerRealName(Player: TObjectReference; RealName: String);
begin
  if Player.objtype = OTPLAYER then
    PrimitiveSetPlayerRealName(Player.pobjref, RealName);

end;

procedure SetPlayerHomepage(Player: TObjectReference; Homepage: String);
begin
  if Player.objtype = OTPLAYER then
    PrimitiveSetPlayerHomepage(Player.pobjref, Homepage);

end;

procedure SetPlayerEMailAddress(Player: TObjectReference; EMailAddress: String);
begin
  if Player.objtype = OTPLAYER then
    PrimitiveSetPlayerEMailAddress(Player.pobjref, EMailAddress);

end;

procedure SetPlayerPCInfo(Player: TObjectReference; PCInfo: String);
begin
  if Player.objtype = OTPLAYER then
    PrimitiveSetPlayerPCInfo(Player.pobjref, PCInfo);

end;

procedure Walk(NPC: TObjectReference; Direction: Byte);
begin
  if NPC.objtype = OTNPC then
    PrimitiveWalk(NPC.pobjref, Direction);

end;

procedure Attack(NPC, ObjectReference: TObjectReference);
begin
  if NPC.objtype = OTNPC then
    PrimitiveAttack(NPC.pobjref, ObjectReference.objtype, ObjectReference.pobjref);

end;

procedure SetDead(Player: TObjectReference);
begin
  if Player.objtype = OTPLAYER then
    PrimitiveSetDead(Player.pobjref);

end;

procedure SetAlive(Player: TObjectReference);
begin
  if Player.objtype = OTPLAYER then
    PrimitiveSetAlive(Player.pobjref);

end;

function GetNPCType(NPC: TObjectReference): Cardinal;
begin
  if NPC.objtype = OTNPC then
    Result := PrimitiveGetNPCType(NPC.pobjref)

  else
    Result := 0;

end;

function GetExperience(ObjectReference: TObjectReference): Cardinal;
begin
  Result := PrimitiveGetExperience(ObjectReference.objtype, ObjectReference.pobjref);

end;

function GetLevel(ObjectReference: TObjectReference): Cardinal;
begin
  Result := PrimitiveGetLevel(ObjectReference.objtype, ObjectReference.pobjref);

end;

function GetSkill(ObjectReference: TObjectReference; Skill: Integer): Byte;
begin
  Result := PrimitiveGetSkill(ObjectReference.objtype, ObjectReference.pobjref, Skill);

end;

function IsOnline(Player: TObjectReference): Boolean;
begin
  if Player.objtype = OTPLAYER then
    Result := PrimitiveIsOnline(Player.pobjref)

  else
    Result := False;

end;

function IsAlive(Player: TObjectReference): Boolean;
begin
  if Player.objtype = OTPLAYER then
    Result := PrimitiveIsAlive(Player.pobjref)

  else
    Result := True;

end;

function GetHits(ObjectReference: TObjectReference): Byte;
begin
  Result := PrimitiveGetHits(ObjectReference.objtype, ObjectReference.pobjref);

end;

function GetMana(ObjectReference: TObjectReference): Byte;
begin
  Result := PrimitiveGetMana(ObjectReference.objtype, ObjectReference.pobjref);

end;

function GetFatigue(ObjectReference: TObjectReference): Byte;
begin
  Result := PrimitiveGetFatigue(ObjectReference.objtype, ObjectReference.pobjref);

end;

function IsCriminal(ObjectReference: TObjectReference): Boolean;
begin
  Result := PrimitiveIsCriminal(ObjectReference.objtype, ObjectReference.pobjref);

end;

function IsAtWar(Player: TObjectReference): Boolean;
begin
  if Player.objtype = OTPLAYER then
    Result := PrimitiveIsAtWar(Player.pobjref)

  else
    Result := False;

end;

function IsContainedIn(Item: TObjectReference): TObjectReference;
var
  tempobjref: TObjectReference;

begin
  if Item.objtype = OTITEM then
    tempobjref.pobjref := PrimitiveIsContainedIn(Item.pobjref)

  else
    tempobjref.pobjref := 0;

  if tempobjref.pobjref = 0 then
    tempobjref.objtype := OTNONE

  else
    tempobjref.objtype := OTITEM;

  Result := tempobjref;

end;

function IsEquippedBy(Item: TObjectReference): TObjectReference;
var
  tempobjref: TObjectReference;

begin
  if Item.objtype = OTITEM then
    tempobjref.pobjref := PrimitiveIsEquippedBy(Item.pobjref)

  else
    tempobjref.pobjref := 0;

  if tempobjref.pobjref = 0 then
    tempobjref.objtype := OTNONE

  else
    tempobjref.objtype := IsEquippedByObjectType(Item.pobjref);

  Result := tempobjref;

end;

function GetWeight(Item: TObjectReference): Word;
begin
  if Item.objtype = OTITEM then
    Result := PrimitiveGetWeight(Item.pobjref)

  else
    Result := 0;

end;

function IsWeapon(Item: TObjectReference): Boolean;
begin
  if Item.objtype = OTITEM then
    Result := PrimitiveIsWeapon(Item.pobjref)

  else
    Result := False;

end;

function IsArmor(Item: TObjectReference): Boolean;
begin
  if Item.objtype = OTITEM then
    Result := PrimitiveIsArmor(Item.pobjref)

  else
    Result := False;

end;

function GetWeaponSpeed(Weapon: TObjectReference): Byte;
begin
  if Weapon.objtype = OTITEM then
    Result := PrimitiveGetWeaponSpeed(Weapon.pobjref)

  else
    Result := 0;

end;

function GetWeaponDamage(Weapon: TObjectReference): Byte;
begin
  if Weapon.objtype = OTITEM then
    Result := PrimitiveGetWeaponDamage(Weapon.pobjref)

  else
    Result := 0;

end;

function GetArmorStrength(Armor: TObjectReference): Byte;
begin
  if Armor.objtype = OTITEM then
    Result := PrimitiveGetArmorStrength(Armor.pobjref)

  else
    Result := 0;

end;

function IsMoveable(Item: TObjectReference): Boolean;
begin
  if Item.objtype = OTITEM then
    Result := PrimitiveIsMoveable(Item.pobjref)

  else
    Result := True;

end;

function IsVisible(Item: TObjectReference): Boolean;
begin
  if Item.objtype = OTITEM then
    Result := PrimitiveIsVisible(Item.pobjref)

  else
    Result := True;

end;

function IsPrivileged(ObjectReference: TObjectReference): Boolean;
begin
  Result := PrimitiveIsPrivileged(ObjectReference.objtype, ObjectReference.pobjref);

end;

function IsUnhidden(ObjectReference: TObjectReference): Boolean;
begin
  Result := PrimitiveIsUnhidden(ObjectReference.objtype, ObjectReference.pobjref);

end;

function IsStackable(Item: TObjectReference): Boolean;
begin
  if Item.objtype = OTITEM then
    Result := PrimitiveIsStackable(Item.pobjref)

  else
    Result := True;

end;

function GetItemLighting(Item: TObjectReference): Byte;
begin
  if Item.objtype = OTITEM then
    Result := PrimitiveGetItemLighting(Item.pobjref)

  else
    Result := 0;

end;

function GetPlayerRealName(Player: TObjectReference): String;
begin
  if Player.objtype = OTPLAYER then
    Result := PrimitiveGetPlayerRealName(Player.pobjref)

  else
    Result := '';

end;

function GetPlayerHomepage(Player: TObjectReference): String;
begin
  if Player.objtype = OTPLAYER then
    Result := PrimitiveGetPlayerHomepage(Player.pobjref)

  else
    Result := '';

end;

function GetPlayerEMailAddress(Player: TObjectReference): String;
begin
  if Player.objtype = OTPLAYER then
    Result := PrimitiveGetPlayerEMailAddress(Player.pobjref)

  else
    Result := '';

end;

function GetPlayerPCInfo(Player: TObjectReference): String;
begin
  if Player.objtype = OTPLAYER then
    Result := PrimitiveGetPlayerPCInfo(Player.pobjref)

  else
    Result := '';

end;

function GetScriptName(ObjectReference: TObjectReference): String;
begin
  Result := PrimitiveGetScriptName(ObjectReference.objtype, ObjectReference.pobjref);

end;

function IsWalkable(Item: TObjectReference): Byte;
begin
  if Item.objtype = OTITEM then
    Result := PrimitiveIsWalkable(Item.pobjref)

  else
    Result := DFALL;

end;

procedure SetWalkable(Item: TObjectReference; Direction: Byte);
begin
  if Item.objtype = OTITEM then
    PrimitiveSetWalkable(Item.pobjref, Direction);

end;

procedure OpenOrCloseDoor(Door: TObjectReference; Graphic: Word; XRelative, YRelative: ShortInt);
begin
  if Door.objtype = OTITEM then
    PrimitiveOpenOrCloseDoor(Door.pobjref, Graphic, XRelative, YRelative);

end;

function GetObjectID(ObjectReference: TObjectReference): Cardinal;
begin
  Result := PrimitiveGetObjectID(ObjectReference.objtype, ObjectReference.pobjref);

end;

function ListOnlinePlayers: TObjectArray;
var
  temppobjarray: TPrimitiveObjectArray;
  tempobjarray: TObjectArray;
  i: Cardinal;

begin
  SetLength(tempobjarray, 0);
  temppobjarray := PrimitiveListOnlinePlayers;
  if Length(temppobjarray) > 0 then
    begin
      SetLength(tempobjarray, Length(temppobjarray));
      for i := 0 to Length(temppobjarray) - 1 do
        begin
          tempobjarray[i].objtype := OTPLAYER;
          tempobjarray[i].pobjref := temppobjarray[i];

        end;

    end;

  Result := tempobjarray;

end;

function GetColor(Item: TObjectReference): Word;
begin
  if Item.objtype = OTITEM then
    Result := PrimitiveGetColor(Item.pobjref)

  else
    Result := 0;

end;

function GetEquipmentByLayer(ObjectReference: TObjectReference; Layer: Byte): TObjectReference;
var
  tempobjref: TObjectReference;

begin
  tempobjref.pobjref := PrimitiveGetEquipmentByLayer(ObjectReference.objtype, ObjectReference.pobjref, Layer);
  if tempobjref.pobjref = 0 then
    tempobjref.objtype := OTNONE

  else
    tempobjref.objtype := OTITEM;

  Result := tempobjref;

end;

function PrimitiveIsContainer(Item: Cardinal): Boolean;
begin
  if datah.items[Item].container = 1 then
    Result := True

  else
    Result := False;

end;

function IsContainer(Item: TObjectReference): Boolean;
begin
  if Item.objtype = OTITEM then
    Result := PrimitiveIsContainer(Item.pobjref)

  else
    Result := False;

end;

function GetPrimitiveObjectReference(ObjectReference: TObjectReference): Cardinal;
begin
  Result := ObjectReference.pobjref;

end;

function GetObjectType(ObjectReference: TObjectReference): Integer;
begin
  Result := ObjectReference.objtype;

end;

function GetObjectReference(ObjectType: Integer; PrimitiveObjectReference: Cardinal): TObjectReference;
var
  tempobjref: TObjectReference;

begin
  tempobjref.objtype := ObjectType;
  tempobjref.pobjref := PrimitiveObjectReference;
  Result := tempobjref;

end;

function GetTileGraphic(X, Y: Word): Word;
begin
  if not IsServerActive then
    begin
      Result := 0;
      Exit;

    end;

  Result := gettile(X, Y).graphic;

end;

function GetStaticsGraphics(X, Y: Word; Z: ShortInt): TArrayOfWord;
var
  i, staidxstart, staidxend: Cardinal;
  temparray: TArrayOfWord;
  static: tstatic;

begin
  SetLength(temparray, 0);
  if not IsServerActive or (getstaidx(X, Y).start = NOSTATICS) then
    begin
      Result := temparray;
      Exit;

    end;

  staidxstart := getstaidx(X, Y).start div SizeOf(tstatic);
  staidxend := getstaidx(X, Y).length div SizeOf(tstatic) + staidxstart;
  for i := staidxstart to staidxend - 1 do
    begin
      static := getstatic(i);
      if (static.x = X mod 8) and (static.y = Y mod 8) and (static.z = Z) then
        begin
          SetLength(temparray, Length(temparray) + 1);
          temparray[Length(temparray) - 1] := static.graphic;

        end;

    end;

  Result := temparray;

end;

function GetDirectionTo(FromX, FromY, ToX, ToY: Word): Byte;
var
  diffx, diffy, comp: Extended;
  
begin
  if not IsServerActive then
    begin
      Result := DFNONE;
      Exit;

    end;

  diffx := ToX - FromX;
  diffy := ToY - FromY;
  if diffx = 0.0 then
    diffx := 0.01;
    
  if diffy = 0.0 then
    diffy := 0.01;
    
  comp := Abs(diffx / diffy);
  if (diffx < 0.0) and (diffy < 0.0) and (comp >= 0.5) and (comp <= 2.0) then
    Result := DFNORTHWEST

  else if ((diffx < 0.0) and (diffy < 0.0) and (comp > 2.0)) or ((diffx < 0.0) and (diffy > 0.0) and (comp > 2.0)) then
    Result := DFWEST

  else if (diffx < 0.0) and (diffy > 0.0) and (comp >= 0.5) and (comp <= 2.0) then
    Result := DFSOUTHWEST

  else if ((diffx < 0.0) and (diffy > 0.0) and (comp < 0.5)) or ((diffx > 0.0) and (diffy > 0.0) and (comp < 0.5)) then
    Result := DFSOUTH

  else if (diffx > 0.0) and (diffy > 0.0) and (comp >= 0.5) and (comp <= 2.0) then
    Result := DFSOUTHEAST

  else if ((diffx > 0.0) and (diffy < 0.0) and (comp > 2.0)) or ((diffx > 0.0) and (diffy > 0.0) and (comp > 2.0)) then
    Result := DFEAST

  else if (diffx > 0.0) and (diffy < 0.0) and (comp >= 0.5) and (comp <= 2.0) then
    Result := DFNORTHEAST

  else if ((diffx > 0.0) and (diffy < 0.0) and (comp < 0.5)) or ((diffx < 0.0) and (diffy < 0.0) and (comp < 0.5)) then
    Result := DFNORTH

  else
    Result := DFNONE;
    
end;

function PrimitiveFindItemInContainer(Container, TypeID: Cardinal; DeepSearch: Boolean): Cardinal;
var
  objarray: TPrimitiveObjectArray;
  res, i: Cardinal;

begin
  SetLength(objarray, 0);
  res := 0;
  if not IsServerActive then
    begin
      Result := res;
      Exit;

    end;

  objarray := PrimitiveListItemsInContainer(Container);
  if Length(objarray) > 0 then
    for i := 0 to Length(objarray) - 1 do
      begin
        if datah.items[objarray[i]].itemtype = TypeID then
          begin
            res := objarray[i];
            Break;

          end;

        if (datah.items[objarray[i]].container = 1) and DeepSearch then
          begin
            res := PrimitiveFindItemInContainer(objarray[i], TypeID, True);
            if res > 0 then
              Break;

          end;

      end;

  Result := res;

end;

procedure PrimitiveUnstack(Item: Cardinal; X, Y: Word; Z: ShortInt; Amount: Word);
var
  tempcard, index: Cardinal;
  tempitem: titem;

begin
  if not IsServerActive then
    Exit;

  if datah.items[Item].stackable = 1 then
    if datah.items[Item].contained > 0 then
      PrimitiveRemoveItem(Item, PrimitiveGetObject(OTITEM, datah.items[Item].contained),
                          X, Y, Z, Amount)

    else
      if Amount >= datah.items[Item].amount then
        PrimitiveMoveObject(OTITEM, Item, X, Y, Z)

      else if (Amount < datah.items[Item].amount) and (Amount > 0) then
        begin
          if datah.items[Item].dragger > 0 then
            begin
             datah.players[datah.items[Item].dragger].dragging := False;
             datah.players[datah.items[Item].dragger].dragitem := 0;
             datah.players[datah.items[Item].dragger].dragamt := 0;
             denydragging(datah.items[Item].dragger);
             datah.items[Item].dragger := 0;
             datah.items[Item].occupied := False;

            end;

          while datah.items[Item].occupied do
            Sleep(1);

          datah.items[Item].occupied := True;
          hidlock.Acquire;
          tempcard := highestid + 1;
          if (tempcard and $0FFFFFFF) = tempcard then
            begin
              highestid := tempcard;
              hidlock.Release;

            end

          else
            begin
              printsm(10, 'Maximum ID capacity reached!');
              hidlock.Release;
              datah.items[Item].occupied := False;
              Exit;

            end;

          datah.items[Item].amount := datah.items[Item].amount - Amount;
          tempitem := datah.items[Item].clone;
          if tempitem = nil then
            Exit;
            
          itemslock.Acquire;
          index := Length(items);
          SetLength(items, index + 1);
          itemslock.Release;
          tempitem.id := tempcard;
          tempitem.amount := Amount;
          tempitem.x := X;
          tempitem.y := Y;
          additemto2dpos(index, X, Y);
          tempitem.z := Z;
          tempitem.occupied := False;
          datah.items[index] := tempitem;
          ihashlock.Acquire;
          itemhash[CardToStr(tempcard)] := index;
          ihashlock.Release;
          othashlock.Acquire;
          objtypehash[CardToStr(tempcard)] := OTITEM;
          othashlock.Release;
          updateobjao(OTITEM, Item);
          updateobjao(OTITEM, index);
          datah.items[Item].occupied := False;
          startitemscript(datah.items[Item].scriptname, CardToStr(Item), IntToStr(ETUNSTACKED),
                          '', '', CardToStr(index));

        end;

end;

function FindItemInContainer(Container: TObjectReference; TypeID: Cardinal; DeepSearch: Boolean): TObjectReference;
var
  tempobjref: TObjectReference;

begin
  if Container.objtype = OTITEM then
    begin
      tempobjref.objtype := OTITEM;
      tempobjref.pobjref := PrimitiveFindItemInContainer(Container.pobjref, TypeID, DeepSearch);
      Result := tempobjref;

    end

  else
    begin
      tempobjref.objtype := OTNONE;
      tempobjref.pobjref := 0;
      Result := tempobjref;

    end;

end;

procedure Unstack(Item: TObjectReference; X, Y: Word; Z: ShortInt; Amount: Word);
begin
  if Item.objtype = OTITEM then
    PrimitiveUnstack(Item.pobjref, X, Y, Z, Amount);

end;

function GetDate: Cardinal;
begin
  if not IsServerActive then
    begin
      Result := 0;
      Exit;

    end;

  Result := Round(Date);

end;

function GetTimeOfDay: Integer;
begin
  if not IsServerActive then
    begin
      Result := 0;
      Exit;

    end;

  Result := Round(86400 * Time);

end;

procedure AddByte(var Packet: TArrayOfByte; Value: Byte);
begin
  if not IsServerActive then
    Exit;

  SetLength(Packet, Length(Packet) + 1);
  Packet[Length(Packet) - 1] := Value;

end;

procedure AddWord(var Packet: TArrayOfByte; Value: Word);
var
  tempword: Word;

begin
  if not IsServerActive then
    Exit;

  tempword := swapword(Value);
  SetLength(Packet, Length(Packet) + 2);
  Move(tempword, Packet[Length(Packet) - 2], 2);

end;

procedure AddDWord(var Packet: TArrayOfByte; Value: DWord);
var
  tempdword: DWord;

begin
  if not IsServerActive then
    Exit;

  tempdword := swapdword(Value);
  SetLength(Packet, Length(Packet) + 4);
  Move(tempdword, Packet[Length(Packet) - 4], 4);

end;

procedure PrimitiveSendPacket(var Packet: TArrayOfByte; Player: Cardinal);
begin
  if not IsServerActive then
    Exit;

  try
    datah.players[Player].client.Send(Addr(Packet[0]), Length(Packet));
    datah.players[Player].client.Flush;

  except
    try
      datah.players[Player].client.Shutdown(0);

    finally
    end;

  end;

end;

procedure SendPacket(var Packet: TArrayOfByte; Player: TObjectReference);
begin
  if Player.objtype = OTPLAYER then
    PrimitiveSendPacket(Packet, Player.pobjref);

end;

procedure PrimitiveSetCriminal(ObjectType: Integer; ObjectReference: Cardinal);
begin
  if not IsServerActive then
    Exit;

  if ObjectType = OTPLAYER then
    datah.players[ObjectReference].criminal := 1

  else if ObjectType = OTNPC then
    datah.npcs[ObjectReference].criminal := 1;

end;

procedure SetCriminal(ObjectReference: TObjectReference);
begin
  PrimitiveSetCriminal(ObjectReference.objtype, ObjectReference.pobjref);

end;

procedure PrimitiveSetInnocent(ObjectType: Integer; ObjectReference: Cardinal);
begin
  if not IsServerActive then
    Exit;

  if ObjectType = OTPLAYER then
    datah.players[ObjectReference].criminal := 0

  else if ObjectType = OTNPC then
    datah.npcs[ObjectReference].criminal := 0;

end;

procedure SetInnocent(ObjectReference: TObjectReference);
begin
  PrimitiveSetInnocent(ObjectReference.objtype, ObjectReference.pobjref);

end;

procedure WriteHTML(HTTPConnection: Cardinal; HTML: String);
begin
  if not IsServerActive then
    Exit;

  if httpconnslock <> nil then
    begin
      httpconnslock.Acquire;
      httpconns[HTTPConnection].lock.Acquire;
      httpconns[HTTPConnection].str := httpconns[HTTPConnection].str + HTML;
      httpconns[HTTPConnection].lock.Release;
      httpconnslock.Release;

    end;

end;

function QueryParameter(HTTPConnection: Cardinal; Name: String): String;
var
  paramstr: String;
  startpos, endpos, i: Integer;
  params: TStringList;

begin
  if not IsServerActive then
    begin
      Result := '';
      Exit;

    end;

  paramstr := '';
  if httpconnslock <> nil then
    begin
      httpconnslock.Acquire;
      httpconns[HTTPConnection].lock.Acquire;
      paramstr := httpconns[HTTPConnection].Params;
      httpconns[HTTPConnection].lock.Release;
      httpconnslock.Release;

    end;

  params := TStringList.Create;
  startpos := 1;
  while startpos <= Length(paramstr) do
  begin
    while (startpos <= Length(paramstr)) and (paramstr[startpos] = '&') do
      Inc(startpos);

    if startpos <= Length(paramstr) then
      begin
        endpos := startpos + 1;
        while (endpos <= Length(paramstr)) and (paramstr[endpos] <> '&') do
          Inc(endpos);

        params.Add(Copy(paramstr, startpos, endpos - startpos));
        startpos := endpos + 1;

      end;

  end;
  if params.Count > 0 then
    for i := 0 to params.Count - 1 do
      if LowerCase(Copy(params.Strings[i], 1, Pos('=', params.Strings[i]) - 1)) = LowerCase(Name) then
        begin
          Result := Copy(params.Strings[i], Pos('=', params.Strings[i]) + 1,
                         Length(params.Strings[i]) - Pos('=', params.Strings[i]));
          params.Free;
          Exit;

        end;


  params.Free;
  Result := '';

end;

function QueryIP(HTTPConnection: Cardinal): String;
begin
  if not IsServerActive then
    begin
      Result := '0.0.0.0';
      Exit;

    end;

  if httpconnslock <> nil then
    begin
      httpconnslock.Acquire;
      httpconns[HTTPConnection].lock.Acquire;
      Result := httpconns[HTTPConnection].PeerAddr;
      httpconns[HTTPConnection].lock.Release;
      httpconnslock.Release;


    end;

end;

function ScriptGetTickCount: Cardinal;
begin
  if not IsServerActive then
    begin
      Result := 0;
      Exit;

    end;

  Result := GetTickCount;

end;

function PrimitiveGetIP(Player: Cardinal): String;
begin
 if not IsServerActive then
    begin
      Result := '0.0.0.0';
      Exit;

    end;

  if datah.players[Player].client <> nil then
    try
      Result := datah.players[Player].client.PeerAddr;

    except
      Result := '0.0.0.0';

    end

  else
    Result := '0.0.0.0';

end;

function GetIP(Player: TObjectReference): String;
begin
  if Player.objtype = OTPLAYER then
    Result := PrimitiveGetIP(Player.pobjref)

  else
    Result := '0.0.0.0';

end;

function PrimitiveObjectExists(ObjectType: Integer; ObjectReference: Cardinal): Boolean;
begin
  if not IsServerActive then
    begin
      Result := False;
      Exit;

    end;

  if ObjectType = OTPLAYER then
    if (datah.getplayerslen > ObjectReference) and
       (datah.players[ObjectReference].id <> 0) then
      Result := True

    else
      Result := False

  else if ObjectType = OTNPC then
    if (datah.getnpcslen > ObjectReference) and
       (datah.npcs[ObjectReference].id <> 0) then
      Result := True

    else
      Result := False

  else if ObjectType = OTITEM then
    if (datah.getitemslen > ObjectReference) and
       (datah.items[ObjectReference].id <> 0) then
      Result := True

    else
      Result := False

  else
    Result := False;

end;

function ObjectExists(ObjectReference: TObjectReference): Boolean;
begin
  Result := PrimitiveObjectExists(ObjectReference.objtype, ObjectReference.pobjref);

end;

procedure PrimitiveSetScriptName(ObjectType: Integer; ObjectReference: Cardinal; ScriptName: String);
begin
  if not IsServerActive then
    Exit;

  if ObjectType = OTITEM then
    datah.items[ObjectReference].scriptname := ScriptName

  else if ObjectType = OTNPC then
    datah.npcs[ObjectReference].scriptname := ScriptName;

end;

procedure SetScriptName(ObjectReference: TObjectReference; ScriptName: String);
begin
  if not IsServerActive then
    Exit;

  PrimitiveSetScriptName(ObjectReference.objtype, ObjectReference.pobjref, ScriptName);

end;

procedure PrimitiveSetPassword(Player: Cardinal; Password: String);
begin
  if not IsServerActive then
    Exit;

  datah.players[Player].passw := Password;

end;

procedure SetPassword(Player: TObjectReference; Password: String);
begin
  if not IsServerActive or (Player.objtype <> OTPLAYER) then
    Exit;

  PrimitiveSetPassword(Player.pobjref, Password);

end;

function PrimitiveGetPassword(Player: Cardinal): String;
begin
  if not IsServerActive then
    begin
      Result := '';
      Exit;

    end;

  Result := datah.players[Player].passw;

end;

function GetPassword(Player: TObjectReference): String;
begin
  if not IsServerActive or (Player.objtype <> OTPLAYER) then
    begin
      Result := '';
      Exit;

    end;

  Result := PrimitiveGetPassword(Player.pobjref);

end;

procedure TForm1.WSocketServer1ClientConnect(Sender: TObject;
  Client: TWSocketClient; Error: Word);
begin
  RichEdit1.Lines.Add('Client (Address: '+ Client.PeerAddr +') connected.');
  (Client as tclient).FlushTimeout := 0;
  (Client as tclient).OnSessionClosed := clientsessionclosed;
  (Client as tclient).OnDataAvailable := clientdataav;

end;

procedure TForm1.clientsessionclosed(sender: TObject; error: Word);
var
  player: Cardinal;

begin
  printsm(0, 'Client (Address: '+ (sender as tclient).PeerAddr +') disconnected.');
  player := (sender as tclient).player;
  if PrimitiveGetObjectID(OTPLAYER, player) <> 0 then
    begin
      if datah.players[player].dragging = True then
        begin
          datah.items[datah.players[player].dragitem].occupied := False;
          datah.items[datah.players[player].dragitem].dragger := 0;
          datah.players[player].dragging := False;
          datah.players[player].dragitem := 0;
          datah.players[player].dragamt := 0;

        end;

      startmiscscript('onlogout', CardToStr(player));

    end;

end;

procedure TForm1.clientdataav(sender: TObject; error: Word);
var
  pbuf: Array of Byte;
  plen, tempword, tempx, tempy, tempamount: Word;
  tempcard, tempel, i, objid, item, container, backpack, spellbook: Cardinal;
  objarray: TPrimitiveObjectArray;
  tempint: Integer;
  tempstr, cmd, cmdparams, subj, text: String;
  screxists: Boolean;

begin
  SetLength(objarray, 0);
  SetLength(pbuf, 4);
  try
    (sender as tclient).Receive(Addr(pbuf[0]), 4);

  except
    try
      (sender as tclient).Shutdown(0);

    finally
    end;
    Exit;

  end;
  if pbuf[1] = $01 then
    plen := 10099

  else
    begin
      Move(pbuf[2], plen, 2);
      plen := swapword(plen);

    end;

  SetLength(pbuf, plen);
  try
    (sender as tclient).Receive(Addr(pbuf[4]), plen - 4);

  except
    try
      (sender as tclient).Shutdown(0);

    finally
    end;
    Exit;

  end;
  if Length(pbuf) = 0 then
    Exit;

  if (pbuf[0] = 0) or (pbuf[1] = 0) then
    Exit;

  // tempstr := 'Packetstring:';
  // for i := 0 to Length(pbuf) - 1 do
    // tempstr := tempstr +' '+ IntToStr(pbuf[i]);

  // printsm(10, tempstr);
  case pbuf[1] of
    $01:
      begin
        Move(pbuf[4], tempcard, Sizeof(Cardinal));
        tempcard := swapdword(tempcard);
        tempel := 0;
        if (tempcard = 0) and not ObjectExistsByID(OTPLAYER, tempcard) then
          begin
            hidlock.Acquire;
            tempcard := highestid + 1;
            if (tempcard and $0FFFFFFF) = tempcard then
              begin
                highestid := tempcard;
                hidlock.Release;

              end

            else
              begin
                try
                  (sender as tclient).Shutdown(0);

                finally
                end;
                printsm(10, 'Maximum ID capacity reached!');
                hidlock.Release;
                Exit;

              end;

            playerslock.Acquire;
            tempel := Length(players);
            SetLength(players, tempel + 1);
            playerslock.Release;
            datah.players[tempel] := tplayer.Create;
            datah.players[tempel].id := tempcard;
            phashlock.Acquire;
            playerhash[CardToStr(tempcard)] := tempel;
            phashlock.Release;
            othashlock.Acquire;
            objtypehash[CardToStr(tempcard)] := OTPLAYER;
            othashlock.Release;
            SetLength(tempstr, 30);
            Move(pbuf[12], tempstr[1], 30);
            datah.players[tempel].name := unpadstr(tempstr);
            Move(pbuf[558], tempstr[1], 30);
            datah.players[tempel].passw := unpadstr(tempstr);
            datah.players[tempel].sex := pbuf[588];
            datah.players[tempel].graphic := pbuf[588];
            datah.players[tempel].str := pbuf[589];
            datah.players[tempel].hits := pbuf[589];
            datah.players[tempel].dex := pbuf[590];
            datah.players[tempel].fat := pbuf[590];
            datah.players[tempel].int := pbuf[591];
            datah.players[tempel].mana := pbuf[591];
            SetLength(tempstr, 128);
            Move(pbuf[302], tempstr[1], 128);
            datah.players[tempel].realname := unpadstr(tempstr);
            Move(pbuf[42], tempstr[1], 128);
            datah.players[tempel].homepage := unpadstr(tempstr);
            Move(pbuf[174], tempstr[1], 128);
            datah.players[tempel].emailaddr := unpadstr(tempstr);
            Move(pbuf[430], tempstr[1], 128);
            datah.players[tempel].pcinfo := unpadstr(tempstr);
            datah.players[tempel].x := 554;
            datah.players[tempel].y := 576;
            addplayerto2dpos(tempel, 554, 576);
            datah.players[tempel].client := (sender as tclient);
            datah.players[tempel].online := True;
            datah.players[tempel].level := 1;
            (sender as tclient).player := tempel;
            printsm(10, 'Player created: '+ datah.players[tempel].name +'.');
            startmiscscript('oncreate', CardToStr(tempel), IntToStr(pbuf[594]),
                            IntToStr(pbuf[593]));

          end

        else if (tempcard <> 0) and ObjectExistsByID(OTPLAYER, tempcard) then
          begin
            tempel := PrimitiveGetObject(OTPLAYER, tempcard);
            SetLength(tempstr, 30);
            Move(pbuf[558], tempstr[1], 30);
            if (unpadstr(tempstr) = datah.players[tempel].passw) and not
               datah.players[tempel].online then
              begin
                datah.players[tempel].online := True;
                datah.players[tempel].client := (sender as tclient);
                (sender as tclient).player := tempel;

              end

            else if (unpadstr(tempstr) = datah.players[tempel].passw) and
               datah.players[tempel].online then
              begin
                SetLength(pbuf, 5);
                pbuf[0] := $FE;
                pbuf[1] := $B7;
                pbuf[2] := $00;
                pbuf[3] := $05;
                pbuf[4] := $00;
                try
                  (sender as tclient).Send(Addr(pbuf[0]), 5);
                  (sender as tclient).Flush;
                  (sender as tclient).Shutdown(0);

                except
                  try
                    (sender as tclient).Shutdown(0);

                  finally
                  end;
                  Exit;

                end;
                printsm(10, 'Client (Address: '+ (sender as tclient).PeerAddr
                        +') tried to log in as player '+ datah.players[tempel].name +' (ID: '+ CardToStr(tempcard)
                        +') who is already logged in.');
                Exit;

              end

            else if ((unpadstr(tempstr) <> datah.players[tempel].passw) and datah.players[tempel].online)
                    or ((unpadstr(tempstr) <> datah.players[tempel].passw) and not datah.players[tempel].online) then
              begin
                SetLength(pbuf, 5);
                pbuf[0] := $FE;
                pbuf[1] := $B7;
                pbuf[2] := $00;
                pbuf[3] := $05;
                pbuf[4] := $00;
                try
                  (sender as tclient).Send(Addr(pbuf[0]), 5);
                  (sender as tclient).Flush;
                  (sender as tclient).Shutdown(0);

                except
                  try
                    (sender as tclient).Shutdown(0);

                  finally
                  end;
                  Exit;

                end;
                printsm(10, 'Client (Address: '+ (sender as tclient).PeerAddr
                        +') tried to log in as player '+ datah.players[tempel].name +' (ID: '+ CardToStr(tempcard) +
                        ') with a wrong password.');
                Exit;

              end;

          end

        else if (tempcard <> 0) and not ObjectExistsByID(OTPLAYER, tempcard) then
          begin
            SetLength(pbuf, 5);
            pbuf[0] := $FE;
            pbuf[1] := $B7;
            pbuf[2] := $00;
            pbuf[3] := $05;
            pbuf[4] := $01;
            try
              (sender as tclient).Send(Addr(pbuf[0]), 5);
              (sender as tclient).Flush;
              (sender as tclient).Shutdown(0);

            except
              try
                (sender as tclient).Shutdown(0);

              finally
              end;
              Exit;

            end;
            printsm(10, 'Client (Address: '+ (sender as tclient).PeerAddr
                    +') tried to log in as a non existing player.');
            Exit;

          end;

        initplayer(tempel);
        updateplayer(tempel);
        updateequ(OTPLAYER, tempel, tempel);
        objarray := PrimitiveListObjectsNearLocation(OTPLAYER, datah.players[tempel].x,
                                                     datah.players[tempel].y, 16);
        if Length(objarray) > 1 then
          for i := 0 to Length(objarray) - 1 do
            if datah.players[objarray[i]].online and (datah.players[objarray[i]].id <>
               datah.players[tempel].id) then
               begin
                 if (datah.players[objarray[i]].hidden = 0) or (datah.players[tempel].privileged
                    = 1) then
                   begin
                     updateobj(OTPLAYER, tempel, objarray[i]);
                     updateequ(OTPLAYER, tempel, objarray[i]);

                   end;

                 if (datah.players[tempel].hidden = 0) or (datah.players[objarray[i]].privileged
                    = 1) then
                   begin
                     updateobj(OTPLAYER, objarray[i], tempel);
                     updateequ(OTPLAYER, objarray[i], tempel);

                   end;

               end;

        objarray := PrimitiveListObjectsNearLocation(OTNPC, datah.players[tempel].x,
                                                     datah.players[tempel].y, 16);
        if Length(objarray) > 0 then
          for i := 0 to Length(objarray) - 1 do
            begin
              if (datah.npcs[objarray[i]].hidden = 0) or (datah.players[tempel].privileged
                 = 1) then
                begin
                  updateobj(OTNPC, tempel, objarray[i]);
                  updateequ(OTNPC, tempel, objarray[i]);

                end;

            end;

        objarray := PrimitiveListObjectsNearLocation(OTITEM, datah.players[tempel].x,
                                                     datah.players[tempel].y, 16);
        if Length(objarray) > 0 then
          for i := 0 to Length(objarray) - 1 do
            begin
              if (datah.items[objarray[i]].invisible = 0) or (datah.players[tempel].privileged
                 = 1) then
                 begin
                   updateobj(OTITEM, tempel, objarray[i]);
                   addnouitem(objarray[i], tempel);

                 end;

             end;

        sendsysmsg('Ultima Online: Shattered Legacy Server (Emulator)',
                   0, 0, 255, tempel);
        sendsysmsg('Version: r1y2005', 0, 0, 255, tempel);
        sendsysmsg('© 2005 Maximilian Scherr', 0, 0, 255, tempel);
        sendsysmsg('This is not an official Ultima Online server.', 0, 0, 255, tempel);
        sendsysmsg('Ultima Online is a trademark of Electronic Arts Inc.', 0, 0, 255, tempel);
        sendsysmsg('Important: Your player ID is '+ CardToStr(datah.players[tempel].id)
                   +'.', 255, 0, 0, tempel);
        printsm(10, 'Player logged in: '+ datah.players[tempel].name +'.');
        startmiscscript('onlogin', CardToStr(tempel));

      end;

    $04: playerwalk((sender as tclient).player, pbuf[4], pbuf[5]);
    $06:
      begin
        SetLength(tempstr, Length(pbuf) - 10);
        Move(pbuf[9], tempstr[1], Length(pbuf) - 10);
        if datah.players[(sender as tclient).player].inreq then
          begin
            datah.players[(sender as tclient).player].inreqres := tempstr;
            Exit;

          end;

        if tempstr[1] = '#' then
          begin
            cmd := '';
            cmdparams := '';
            if Length(tempstr) > 1 then
              begin
                for tempint := 2 to Length(tempstr) do
                  if tempstr[tempint] = ' ' then
                    Break

                  else
                    cmd := cmd + LowerCase(tempstr[tempint]);

                if Length(tempstr) > tempint then
                  for tempint := tempint + 1 to Length(tempstr) do
                    cmdparams := cmdparams + tempstr[tempint];

                screxists := False;
                if Length(cmdscripts) > 0 then
                  for i := 0 to Length(cmdscripts) - 1 do
                    if cmdscripts[i].name = cmd then
                      screxists := True;

                if screxists then
                  startcmdscript(cmd, CardToStr((sender as tclient).player),
                                 cmdparams)

                else
                  sendsysmsg('The command "#'+ cmd +'" does not exist!', 255, 255,
                             255, (sender as tclient).player);

              end;

          end

        else
          begin
            objarray := PrimitiveListObjectsNearLocation(OTPLAYER, datah.players[(sender as tclient).player].x,
                                                         datah.players[(sender as tclient).player].y,
                                                         16);
            if Length(objarray) > 0 then
              for i := 0 to Length(objarray) - 1 do
                if datah.players[objarray[i]].online and ((datah.players[(sender as tclient).player].hidden = 0)
                   or (datah.players[objarray[i]].privileged = 1))then
                  sendspeech(tempstr, pbuf[8], pbuf[7], pbuf[6], OTPLAYER,
                             objarray[i], (sender as tclient).player);

            objarray := PrimitiveListObjectsNearLocation(OTNPC, datah.players[(sender as tclient).player].x,
                                                         datah.players[(sender as tclient).player].y,
                                                         16);
            if Length(objarray) > 0 then
              for i := 0 to Length(objarray) - 1 do
                PrimitiveSetEvent(objarray[i], ETTALKED, OTPLAYER, tempstr,
                                  (sender as tclient).player);

            objarray := PrimitiveListObjectsNearLocation(OTITEM, datah.players[(sender as tclient).player].x,
                                                         datah.players[(sender as tclient).player].y,
                                                         16);
            if Length(objarray) > 0 then
              for i := 0 to Length(objarray) - 1 do
                startitemscript(datah.items[objarray[i]].scriptname, CardToStr(objarray[i]), IntToStr(ETTALKED),
                                IntToStr(OTPLAYER), tempstr,
                                CardToStr((sender as tclient).player));

          end;

      end;

    $0B:
      begin
        Move(pbuf[4], tempcard, 4);
        tempcard := swapdword(tempcard) and not $F0000000;
        datah.players[(sender as tclient).player].war := 1;
        if datah.players[(sender as tclient).player].dead = 1 then
          sendsysmsg('You are dead and cannot do that!', 255, 255, 255,
                     (sender as tclient).player)

        else
          dclick((sender as tclient).player, tempcard);

      end;

    $0C:
      begin
        Move(pbuf[4], tempcard, 4);
        tempcard := swapdword(tempcard) and not $F0000000;
        if (CheckObjectType(tempcard) <> OTITEM) and (tempcard <> datah.players[(sender as tclient).player].id) then
          datah.players[(sender as tclient).player].war := 0;
          
        dclick((sender as tclient).player, tempcard);

      end;

    $0E:
      begin
        Move(pbuf[4], tempcard, 4);
        tempcard := swapdword(tempcard) and not $F0000000;
        Move(pbuf[8], tempword, 2);
        tempword := swapword(tempword);
        drag((sender as tclient).player, tempcard, tempword);

      end;

    $0F:
      begin
        Move(pbuf[4], tempcard, 4);
        tempcard := swapdword(tempcard) and not $F0000000;
        Move(pbuf[8], tempx, 2);
        tempx := swapword(tempx);
        Move(pbuf[10], tempy, 2);
        tempy := swapword(tempy);
        Move(pbuf[13], objid, 4);
        objid := swapdword(objid) and not $F0000000;
        if objid = $FFFFFFF then
          drop((sender as tclient).player, tempcard, tempx, tempy, pbuf[12])

        else if objid <> $FFFFFFF then
          begin
            item := PrimitiveGetObject(OTITEM, tempcard);
            container := PrimitiveGetObject(OTITEM, objid);
            if tempx = $FFFF then
              tempx := datah.items[container].definsposx;

            if tempy = $FFFF then
              tempy := datah.items[container].definsposy;

            if datah.players[(sender as tclient).player].dragging = False then
              begin
                denydropping((sender as tclient).player, item);
                Exit;

              end;

            if (PrimitiveCheckObjectDistance(OTPLAYER, (sender as tclient).player, OTITEM,
               item) > 3) or (PrimitiveCheckObjectDistance(OTPLAYER, (sender as tclient).player,
               OTITEM, container) > 3) then
              begin
                sendsysmsg('Too far away!', 255, 255, 255, (sender as tclient).player);
                datah.items[item].occupied := False;
                datah.items[item].dragger := 0;
                datah.players[(sender as tclient).player].dragging := False;
                datah.players[(sender as tclient).player].dragitem := 0;
                datah.players[(sender as tclient).player].dragamt := 0;
                denydropping((sender as tclient).player, item);
                Exit;

              end;

            if (datah.items[item].container = 0) and (datah.items[container].container = 0)
               and (datah.items[item].itemtype = datah.items[container].itemtype) then
              if (datah.items[item].stackable = 1) and
                 (datah.items[container].stackable = 1) then
                begin
                  stack((sender as tclient).player, item, container);
                  Exit;

                end

              else
                Exit;

            datah.items[item].occupied := False;
            datah.items[item].dragger := 0;
            datah.players[(sender as tclient).player].dragging := False;
            datah.players[(sender as tclient).player].dragitem := 0;
            if datah.items[container].itemtype = ITIDSPELLBOOK then
              if (datah.items[item].itemtype < ITIDSOLIGHTSOURCE) or
                 (datah.items[item].itemtype > ITIDSOCREATEFOOD) then
                begin
                  denydropping((sender as tclient).player, item);
                  Exit;

                end

              else
                begin
                  objarray := PrimitiveListItemsInContainer(container);
                  if Length(objarray) > 0 then
                    for i := 0 to Length(objarray) - 1 do
                      if datah.items[objarray[i]].itemtype = datah.items[item].itemtype then
                        begin
                          denydropping((sender as tclient).player, item);
                          Exit;

                        end;

                end;

            if (((datah.items[item].invisible = 1) and (datah.players[(sender as tclient).player].privileged = 0)) or
               ((PrimitiveGetMainContainer(item) = 0) and (datah.items[item].equipped > 0) and (datah.items[item].equipped <> datah.players[(sender as tclient).player].id) and not
               PrimitiveIsUnhidden(CheckObjectType(datah.items[item].equipped),
               PrimitiveGetObject(CheckObjectType(datah.items[item].equipped), datah.items[item].equipped)) and
               (datah.players[(sender as tclient).player].privileged = 0)) or
               ((PrimitiveGetMainContainer(item) > 0) and (datah.items[PrimitiveGetMainContainer(item)].equipped > 0) and (datah.items[PrimitiveGetMainContainer(item)].equipped <> datah.players[(sender as tclient).player].id) and not
               PrimitiveIsUnhidden(CheckObjectType(datah.items[PrimitiveGetMainContainer(item)].equipped),
               PrimitiveGetObject(CheckObjectType(datah.items[PrimitiveGetMainContainer(item)].equipped), datah.items[PrimitiveGetMainContainer(item)].equipped)) and
               (datah.players[(sender as tclient).player].privileged = 0))) or
               (((datah.items[container].invisible = 1) and (datah.players[(sender as tclient).player].privileged = 0)) or
               ((PrimitiveGetMainContainer(container) = 0) and (datah.items[container].equipped > 0) and (datah.items[container].equipped <> datah.players[(sender as tclient).player].id) and not
               PrimitiveIsUnhidden(CheckObjectType(datah.items[container].equipped),
               PrimitiveGetObject(CheckObjectType(datah.items[container].equipped), datah.items[container].equipped)) and
               (datah.players[(sender as tclient).player].privileged = 0)) or
               ((PrimitiveGetMainContainer(container) > 0) and (datah.items[PrimitiveGetMainContainer(container)].equipped > 0) and (datah.items[PrimitiveGetMainContainer(container)].equipped <> datah.players[(sender as tclient).player].id) and not
               PrimitiveIsUnhidden(CheckObjectType(datah.items[PrimitiveGetMainContainer(container)].equipped),
               PrimitiveGetObject(CheckObjectType(datah.items[PrimitiveGetMainContainer(container)].equipped), datah.items[PrimitiveGetMainContainer(container)].equipped)) and
               (datah.players[(sender as tclient).player].privileged = 0))) then
              Exit;

            tempword := datah.players[(sender as tclient).player].dragamt;
            datah.players[(sender as tclient).player].dragamt := 0;
            tempamount := datah.items[item].amount;
            tempcard := PrimitiveGetObject(OTITEM, datah.items[item].contained);
            PrimitiveInsertItem(item, container, tempx, tempy, tempword);
            if (tempword > 0) and (tempamount > 0) and
               (tempamount = datah.items[item].amount) and
               (tempamount - tempword <> 0) then
              begin
                denydropping((sender as tclient).player, item);

              end;

            tempamount := tempamount - datah.items[item].amount;
            if (tempcard > 0) then
              if ((PrimitiveGetMainContainer(tempcard) = 0) and
                 (datah.items[tempcard].equipped > 0) and (datah.items[tempcard].equipped <> datah.players[(sender as tclient).player].id)) or
                 ((PrimitiveGetMainContainer(tempcard) > 0) and (datah.items[PrimitiveGetMainContainer(tempcard)].equipped > 0) and
                 (datah.items[PrimitiveGetMainContainer(tempcard)].equipped <> datah.players[(sender as tclient).player].id)) then
                startskillscript('stealing', CardToStr((sender as tclient).player), CardToStr(item), CardToStr(tempcard), IntToStr(tempamount))

              else
                begin
                  if (datah.items[PrimitiveGetMainContainer(item)].equipped > 0) and
                     (PrimitiveGetObject(OTNPC, datah.items[PrimitiveGetMainContainer(item)].equipped) > 0) then
                    PrimitiveSetEvent(PrimitiveGetObject(OTNPC, datah.items[PrimitiveGetMainContainer(item)].equipped),
                                      ETITEMGIVEN, OTPLAYER, CardToStr(item), (sender as tclient).player)
                end
                
            else
              if (datah.items[PrimitiveGetMainContainer(item)].equipped > 0) and
                 (PrimitiveGetObject(OTNPC, datah.items[PrimitiveGetMainContainer(item)].equipped) > 0) then
                PrimitiveSetEvent(PrimitiveGetObject(OTNPC, datah.items[PrimitiveGetMainContainer(item)].equipped),
                                  ETITEMGIVEN, OTPLAYER, CardToStr(item), (sender as tclient).player);
                                  
          end;

      end;

    $11:
      begin
        Move(pbuf[4], tempcard, 4);
        tempcard := swapdword(tempcard);
        sclick((sender as tclient).player, tempcard);

      end;

    $17:
      begin
        if pbuf[4] = $2F then
          begin
            SetLength(tempstr, Length(pbuf) - 6);
            Move(pbuf[5], tempstr[1], Length(pbuf) - 6);
            if ObjectExistsByID(OTITEM, StrToCard(GetSubString(tempstr, 1)) and not $40000000) then
              begin
                item := PrimitiveGetObject(OTITEM, StrToCard(GetSubString(tempstr, 1)) and not $40000000);
                if ((datah.items[item].invisible = 1) and (datah.players[(sender as tclient).player].privileged = 0)) or
                   ((PrimitiveGetMainContainer(item) > 0) and (datah.items[PrimitiveGetMainContainer(item)].equipped > 0) and (datah.items[PrimitiveGetMainContainer(item)].equipped <> datah.players[(sender as tclient).player].id) and not
                   PrimitiveIsUnhidden(CheckObjectType(datah.items[PrimitiveGetMainContainer(item)].equipped),
                   PrimitiveGetObject(CheckObjectType(datah.items[PrimitiveGetMainContainer(item)].equipped), datah.items[PrimitiveGetMainContainer(item)].equipped)) and
                   (datah.players[(sender as tclient).player].privileged = 0)) then
                  Exit;

                if PrimitiveCheckObjectDistance(OTITEM, item, OTPLAYER, (sender as tclient).player) > 3 then
                  begin
                    sendsysmsg('You can''t use that item anymore from here!', 255, 255,
                               255, (sender as tclient).player);
                    Exit;

                  end;

                if GetSubString(tempstr, 2) = '' then
                  startmiscscript('onspecact', CardToStr((sender as tclient).player),
                                  CardToStr(item))

                else if GetSubString(tempstr, 3) = '' then
                  startmiscscript('onspecact', CardToStr((sender as tclient).player),
                                  CardToStr(item),
                                  IntToStr(CheckObjectType(StrToCard(GetSubString(tempstr, 2)))),
                                  GetSubString(tempstr, 2))

                else
                  startmiscscript('onspecact', CardToStr((sender as tclient).player),
                                  CardToStr(item), GetSubString(tempstr, 2),
                                  GetSubString(tempstr, 3),
                                  GetSubString(tempstr, 4))

              end;

          end

        else if pbuf[4] = $27 then
          if pbuf[5] <> $00 then
            begin
              spellbook := 0;
              while datah.players[(sender as tclient).player].ococ do
                Sleep(1);

              datah.players[(sender as tclient).player].ococ := True;
              if Length(datah.players[(sender as tclient).player].openconts) > 0 then
                for i := Length(datah.players[(sender as tclient).player].openconts) - 1 downto 0 do
                  if datah.items[datah.players[(sender as tclient).player].openconts[i]].itemtype = ITIDSPELLBOOK then
                    begin
                      spellbook := datah.players[(sender as tclient).player].openconts[i];
                      Break;

                    end;

              datah.players[(sender as tclient).player].ococ := False;
              if (spellbook = 0) or ((spellbook > 0) and
                 (PrimitiveCheckObjectDistance(OTITEM, spellbook, OTPLAYER,
                 (sender as tclient).player) > 3)) then
                begin
                  sendsysmsg('No spellbook handy!', 255, 255,
                             255, (sender as tclient).player);
                  Exit;

                end;

              SetLength(tempstr, Length(pbuf) - 6);
              Move(pbuf[5], tempstr[1], Length(pbuf) - 6);
              if (PrimitiveFindItemInContainer(spellbook, ITIDSOLIGHTSOURCE, True) > 0) and
                 (GetSubString(tempstr, 1) = 'Quas') and (GetSubString(tempstr, 2)
                 = 'In') and (GetSubString(tempstr, 3) = 'Lor') then
                startskillscript('magic', CardToStr((sender as tclient).player), IntToStr(SIDLIGHTSOURCE),
                                 GetSubString(tempstr, 4), GetSubString(tempstr, 5),
                                 GetSubString(tempstr, 6))

              else if (PrimitiveFindItemInContainer(spellbook, ITIDSODARKSOURCE, True) > 0) and
                 (GetSubString(tempstr, 1) = 'Quas') and (GetSubString(tempstr, 2)
                 = 'An') and (GetSubString(tempstr, 3) = 'Lor') then
                startskillscript('magic', CardToStr((sender as tclient).player), IntToStr(SIDDARKSOURCE),
                                 GetSubString(tempstr, 4), GetSubString(tempstr, 5),
                                 GetSubString(tempstr, 6))

              else if (PrimitiveFindItemInContainer(spellbook, ITIDSOGREATLIGHT, True) > 0) and
                 (GetSubString(tempstr, 1) = 'In') and (GetSubString(tempstr, 2)
                 = 'Vas') and (GetSubString(tempstr, 3) = 'Lor') then
                startskillscript('magic', CardToStr((sender as tclient).player), IntToStr(SIDGREATLIGHT))

              else if (PrimitiveFindItemInContainer(spellbook, ITIDSOLIGHT, True) > 0) and
                (GetSubString(tempstr, 1) = 'In') and (GetSubString(tempstr, 2)
                 = 'Lor') then
                startskillscript('magic', CardToStr((sender as tclient).player), IntToStr(SIDLIGHT))

              else if (PrimitiveFindItemInContainer(spellbook, ITIDSOHEALING, True) > 0) and
                 (GetSubString(tempstr, 1) = 'Mani') then
                startskillscript('magic', CardToStr((sender as tclient).player), IntToStr(SIDHEALING),
                                 GetSubString(tempstr, 4))

              else if (PrimitiveFindItemInContainer(spellbook, ITIDSOFIREBALL, True) > 0) and
                 (GetSubString(tempstr, 1) = 'Por') and (GetSubString(tempstr, 2)
                 = 'Flam') then
                startskillscript('magic', CardToStr((sender as tclient).player), IntToStr(SIDFIREBALL),
                                 GetSubString(tempstr, 4))

              else if (PrimitiveFindItemInContainer(spellbook, ITIDSOCREATEFOOD, True) > 0) and
                 (GetSubString(tempstr, 1) = 'In') and (GetSubString(tempstr, 2)
                 = 'Mani') and (GetSubString(tempstr, 3) = 'Ylem') then
                startskillscript('magic', CardToStr((sender as tclient).player), IntToStr(SIDCREATEFOOD))

              else
                sendsysmsg('That spellbook doesn''t contain that spell!', 255, 255,
                            255, (sender as tclient).player);

            end;

        if pbuf[4] = $43 then
          begin
            backpack := PrimitiveGetEquipmentByLayer(OTPLAYER, (sender as tclient).player, LBACKPACK);
            spellbook := PrimitiveFindItemInContainer(backpack, ITIDSPELLBOOK, True);;
            if spellbook > 0 then
              startitemscript(datah.items[spellbook].scriptname, CardToStr(spellbook),
                              IntToStr(ETDOUBLECLICKED), '0', '', CardToStr((sender as tclient).player))

            else
              sendsysmsg('No spellbook available!', 255, 255,
                         255, (sender as tclient).player);

          end;

        if pbuf[4] = $20 then
          if pbuf[5] <> $00 then
            begin
              SetLength(tempstr, Length(pbuf) - 6);
              Move(pbuf[5], tempstr[1], Length(pbuf) - 6);
              if GetSubString(tempstr, 1) = 'list' then
                if Length(bbposts) > 0 then
                  for i := 0 to Length(bbposts) - 1 do
                    sendbbpostlistsubj((sender as tclient).player, i);

              if GetSubString(tempstr, 1) = 'read' then
                sendbbpost((sender as tclient).player, StrToCard(GetSubString(tempstr, 2)));

            end;

      end;

    $18:
      begin
        Move(pbuf[4], tempcard, 4);
        tempcard := swapdword(tempcard) and not $F0000000;
        Move(pbuf[9], objid, 4);
        objid := swapdword(objid);
        item := PrimitiveGetObject(OTITEM, tempcard);
        if datah.players[(sender as tclient).player].dragging = False then
          begin
            denydropping((sender as tclient).player, item);
            Exit;

          end;

        if PrimitiveCheckObjectDistance(OTPLAYER, (sender as tclient).player, OTITEM,
           item) > 3 then
          begin
            sendsysmsg('Too far away!', 255, 255, 255, (sender as tclient).player);
            datah.items[item].occupied := False;
            datah.items[item].dragger := 0;
            datah.players[(sender as tclient).player].dragging := False;
            datah.players[(sender as tclient).player].dragitem := 0;
            datah.players[(sender as tclient).player].dragamt := 0;
            denydropping((sender as tclient).player, item);
            Exit;

          end;

        if objid = datah.players[(sender as tclient).player].id then
          begin
            datah.items[item].occupied := False;
            datah.items[item].dragger := 0;
            datah.players[(sender as tclient).player].dragging := False;
            datah.players[(sender as tclient).player].dragitem := 0;
            datah.players[(sender as tclient).player].dragamt := 0;
            if PrimitiveGetEquipmentByLayer(OTPLAYER, (sender as tclient).player,
               getstatictile(datah.items[item].graphic).layer) = 0 then
              PrimitiveEquipItem(OTPLAYER, (sender as tclient).player, item)

            else
              begin
                equitem((sender as tclient).player, objid, item);
                equchanged(objid, (sender as tclient).player);
                startitemscript(datah.items[item].scriptname, CardToStr(item), IntToStr(ETEQUIPPED),
                                IntToStr(OTPLAYER), '', CardToStr((sender as tclient).player));

              end;

          end

        else
          begin
            datah.items[item].occupied := False;
            datah.items[item].dragger := 0;
            datah.players[(sender as tclient).player].dragging := False;
            datah.players[(sender as tclient).player].dragitem := 0;
            datah.players[(sender as tclient).player].dragamt := 0;
            denydropping((sender as tclient).player, item);

          end;

      end;

    $64:
      begin
        if pbuf[4] <> $03 then
          begin
            Move(pbuf[5], tempcard, 4);
            tempcard := swapdword(tempcard);
            if pbuf[4] = $04 then
              begin
                if PrimitiveCheckObjectDistance(CheckObjectType(tempcard),
                   PrimitiveGetObject(CheckObjectType(tempcard), tempcard),
                   OTPLAYER, (sender as tclient).player) <= 16 then
                  showstatus((sender as tclient).player, tempcard)

              end

            else if pbuf[4] = $FE then
              if datah.players[(sender as tclient).player].id = tempcard then
                showskills((sender as tclient).player, tempcard);

          end;

      end;

    $B6:
      begin
        SetLength(subj, 79);
        Move(pbuf[4], subj[1], 79);
        subj := unpadstr(subj);
        SetLength(text, Length(pbuf) - 85);
        Move(pbuf[84], text[1], Length(pbuf) - 85);
        addbbpost(subj, text);

      end;

    $6E:
      begin
        Move(pbuf[8], tempcard, 4);
        tempcard := swapdword(tempcard);
        if (ObjectExistsByID(OTNPC, tempcard) or ObjectExistsByID(OTPLAYER, tempcard)) and
           (PrimitiveIsUnhidden(CheckObjectType(tempcard),
           PrimitiveGetObject(CheckObjectType(tempcard), tempcard)) or
           (datah.players[(sender as tclient).player].privileged = 1)) then
          startmiscscript('onadclick', CardToStr((sender as tclient).player),
                          IntToStr(CheckObjectType(tempcard)),
                          CardToStr(PrimitiveGetObject(CheckObjectType(tempcard), tempcard)));

      end;

  end;

end;

function padstr(str: String; len: Integer): String;
var
  tempstr: String;
  i: Cardinal;

begin
  tempstr := str;
  if Length(tempstr) <> len then
    for i := Length(str) + 1 to len do
      tempstr := tempstr + #0;

  Result := tempstr;

end;

function unpadstr(str: String): String;
var
  tempstr: String;
  i: Cardinal;

begin
  tempstr := '';
  for i := 1 to Length(str) do
    if str[i] = #0 then
      Break

    else
      tempstr := tempstr + str[i];
      
  Result := tempstr;

end;

function swapword(w: Word): Word; register;
asm
  xchg al, ah

end;

function swapdword(dw: DWord): DWord; register;
asm
  bswap eax

end;

procedure initplayer(player: Cardinal);
var
  pbuf: Array of Byte;
  objarray: TPrimitiveObjectArray;
  tempcard, i: Cardinal;
  tempword: Word;
  tempstr: String;

begin
  SetLength(objarray, 0);
  SetLength(pbuf, 26);
  pbuf[0] := $FE;
  pbuf[1] := $36;
  pbuf[2] := $00;
  pbuf[3] := $1A;
  tempcard := swapdword(datah.players[player].id);
  Move(tempcard, pbuf[4], 4);
  pbuf[8] := $00;
  pbuf[9] := $00;
  pbuf[10] := $00;
  pbuf[11] := $00;
  tempword := swapword(datah.players[player].graphic);
  Move(tempword, pbuf[12], 2);
  pbuf[14] := $00;
  pbuf[15] := $00;
  pbuf[16] := $00;
  pbuf[17] := $00;
  pbuf[18] := $00;
  pbuf[19] := $00;
  pbuf[20] := $00;
  pbuf[21] := $00;
  pbuf[22] := $00;
  pbuf[23] := $00;
  pbuf[24] := $00;
  pbuf[25] := $00;
  try
    datah.players[player].client.Send(Addr(pbuf[0]), 26);
    datah.players[player].client.Flush;

  except
    try
      datah.players[player].client.Shutdown(0);

    finally
    end;
    Exit;

  end;
  SetLength(pbuf, 20);
  pbuf[0] := $FE;
  pbuf[1] := $4C;
  pbuf[2] := $00;
  pbuf[3] := $14;
  Move(tempcard, pbuf[4], 4);
  pbuf[8] := $00;
  pbuf[9] := $00;
  pbuf[10] := $00;
  pbuf[11] := $00;
  pbuf[12] := $00;
  pbuf[13] := $00;
  pbuf[14] := $00;
  pbuf[15] := $00;
  pbuf[16] := $00;
  pbuf[17] := $00;
  pbuf[18] := $00;
  pbuf[19] := $05;
  try
    datah.players[player].client.Send(Addr(pbuf[0]), 20);
    datah.players[player].client.Flush;

  except
    try
      datah.players[player].client.Shutdown(0);

    finally
    end;
    Exit;

  end;
  SetLength(pbuf, 13 + Length(datah.players[player].name));
  pbuf[0] := $FE;
  pbuf[1] := $A6;
  pbuf[2] := $00;
  pbuf[3] := 13 + Length(datah.players[player].name);
  pbuf[4] := $00;
  pbuf[5] := $00;
  pbuf[6] := $00;
  pbuf[7] := $00;
  pbuf[8] := $00;
  pbuf[9] := $00;
  pbuf[10] := $00;
  pbuf[11] := $00;
  tempstr := datah.players[player].name;
  Move(tempstr[1], pbuf[12], Length(datah.players[player].name));
  pbuf[12 + Length(datah.players[player].name)] := $00;
  objarray := PrimitiveListObjects(OTPLAYER);
  if Length(objarray) > 0 then
    for i := 0 to Length(objarray) - 1 do
      if datah.players[objarray[i]].online then
        try
          datah.players[objarray[i]].client.Send(Addr(pbuf[0]), 13 + Length(datah.players[player].name));
          datah.players[objarray[i]].client.Flush;

        except
          try
            datah.players[objarray[i]].client.Shutdown(0);

          finally
          end;

        end;

end;

procedure updateplayer(player: Cardinal);
var
  pbuf: Array of Byte;
  tempcard: Cardinal;
  tempword: Word;

begin
  SetLength(pbuf, 19);
  pbuf[0] := $FE;
  pbuf[1] := $3E;
  pbuf[2] := $00;
  pbuf[3] := $13;
  tempcard := swapdword(datah.players[player].id);
  Move(tempcard, pbuf[4], 4);
  tempword := swapword(datah.players[player].graphic);
  Move(tempword, pbuf[8], 2);
  pbuf[10] := 0;
  tempword := swapword(datah.players[player].x);
  Move(tempword, pbuf[11], 2);
  tempword := swapword(datah.players[player].y);
  Move(tempword, pbuf[13], 2);
  pbuf[15] := $00;
  pbuf[16] := $00;
  pbuf[17] := datah.players[player].facing;
  pbuf[18] := datah.players[player].z;
  try
    datah.players[player].client.Send(Addr(pbuf[0]), 19);
    datah.players[player].client.Flush;

  except
    try
      datah.players[player].client.Shutdown(0);

    finally
    end;

  end;

end;

procedure delobj(objtype: Integer; player, obj: Cardinal);
var
  pbuf: Array of Byte;
  tempcard, i: Cardinal;
  temparray: TPrimitiveObjectArray;

begin
  if objtype = OTPLAYER then
    remnoueplayer(obj, player)

  else if objtype = OTNPC then
    remnouenpc(obj, player)

  else if objtype = OTITEM then
    remnouitem(obj, player);

  SetLength(pbuf, 8);
  pbuf[0] := $FE;
  pbuf[1] := $3A;
  pbuf[2] := $00;
  pbuf[3] := $08;
  tempcard := 0;
  if objtype = OTPLAYER then
    tempcard := swapdword(datah.players[obj].id)

  else if objtype = OTNPC then
    tempcard := swapdword(datah.npcs[obj].id)

  else if objtype = OTITEM then
    tempcard := swapdword(datah.items[obj].id or $40000000);

  Move(tempcard, pbuf[4], 4);
  try
    datah.players[player].client.Send(Addr(pbuf[0]), 8);
    datah.players[player].client.Flush;

  except
    try
      datah.players[player].client.Shutdown(0);

    finally
    end;

  end;
  while datah.players[player].ococ do
    Sleep(1);

  datah.players[player].ococ := True;
  if Length(datah.players[player].openconts) > 0 then
    if objtype = OTPLAYER then
      begin
        tempcard := PrimitiveGetEquipmentByLayer(OTPLAYER, obj, LBACKPACK);
        SetLength(temparray, 0);
        for i := 0 to Length(datah.players[player].openconts) - 1 do
          if (datah.players[player].openconts[i] <> tempcard) and
             (PrimitiveGetMainContainer(datah.players[player].openconts[i]) <> tempcard) then
            begin
              SetLength(temparray, Length(temparray) + 1);
              temparray[Length(temparray) - 1] := datah.players[player].openconts[i];

            end;

        datah.players[player].setopencontslen(Length(temparray));
        if Length(temparray) > 0 then
          datah.players[player].openconts := temparray;

      end

    else if objtype = OTNPC then
      begin
        tempcard := PrimitiveGetEquipmentByLayer(OTNPC, obj, LBACKPACK);
        SetLength(temparray, 0);
        for i := 0 to Length(datah.players[player].openconts) - 1 do
          if (datah.players[player].openconts[i] <> tempcard) and
             (PrimitiveGetMainContainer(datah.players[player].openconts[i]) <> tempcard) then
            begin
              SetLength(temparray, Length(temparray) + 1);
              temparray[Length(temparray) - 1] := datah.players[player].openconts[i];

            end;

        datah.players[player].setopencontslen(Length(temparray));
        if Length(temparray) > 0 then
          datah.players[player].openconts := temparray;

      end

    else if objtype = OTITEM then
      if datah.items[obj].container = 1 then
        begin
          SetLength(temparray, 0);
          for i := 0 to Length(datah.players[player].openconts) - 1 do
            if (datah.players[player].openconts[i] <> obj) and
               (PrimitiveGetMainContainer(datah.players[player].openconts[i]) <> obj) then
              begin
                SetLength(temparray, Length(temparray) + 1);
                temparray[Length(temparray) - 1] := datah.players[player].openconts[i];

              end;

          datah.players[player].setopencontslen(Length(temparray));
          if Length(temparray) > 0 then
            datah.players[player].openconts := temparray;

        end;

  datah.players[player].ococ := False;

end;

procedure updateobj(objtype: Integer; player, obj: Cardinal);
var
  pbuf: Array of Byte;
  tempcard: Cardinal;
  tempword: Word;

begin
  SetLength(pbuf, 21);
  pbuf[0] := $FE;
  pbuf[1] := $35;
  pbuf[2] := $00;
  pbuf[3] := $15;
  tempcard := 0;
  if objtype = OTPLAYER then
    tempcard := swapdword(datah.players[obj].id)

  else if objtype = OTNPC then
    tempcard := swapdword(datah.npcs[obj].id)

  else if objtype = OTITEM then
    tempcard := swapdword(datah.items[obj].id or $40000000);

  Move(tempcard, pbuf[4], 4);
  tempword := 0;
  if objtype = OTPLAYER then
    tempword := swapword(datah.players[obj].graphic)

  else if objtype = OTNPC then
    tempword := swapword(datah.npcs[obj].graphic)

  else if objtype = OTITEM then
    tempword := swapword(datah.items[obj].graphic);

  Move(tempword, pbuf[8], 2);
  pbuf[10] := 0;
  tempword := 0;
  if (objtype = OTITEM) and (datah.items[obj].stackable = 1) then
    tempword := swapword(datah.items[obj].amount);

  Move(tempword, pbuf[11], 2);
  tempword := 0;
  if objtype = OTPLAYER then
    tempword := swapword(datah.players[obj].x)

  else if objtype = OTNPC then
    tempword := swapword(datah.npcs[obj].x)

  else if objtype = OTITEM then
    tempword := swapword(datah.items[obj].x);

  Move(tempword, pbuf[13], 2);
  tempword := 0;
  if objtype = OTPLAYER then
    tempword := swapword(datah.players[obj].y)

  else if objtype = OTNPC then
    tempword := swapword(datah.npcs[obj].y)

  else if objtype = OTITEM then
    tempword := swapword(datah.items[obj].y);

  Move(tempword, pbuf[15], 2);
  pbuf[17] := $00;
  if objtype = OTPLAYER then
    pbuf[17] := datah.players[obj].facing

  else if objtype = OTNPC then
    pbuf[17] := datah.npcs[obj].facing

  else if objtype = OTITEM then
    pbuf[17] := datah.items[obj].lighting;

  pbuf[18] := $00;
  if objtype = OTPLAYER then
    pbuf[18] := datah.players[obj].z

  else if objtype = OTNPC then
    pbuf[18] := datah.npcs[obj].z

  else if objtype = OTITEM then
    pbuf[18] := datah.items[obj].z;

  tempword := 0;
  if objtype = OTITEM then
    tempword := swapword(datah.items[obj].color);

  Move(tempword, pbuf[19], 2);
  try
    datah.players[player].client.Send(Addr(pbuf[0]), 21);
    datah.players[player].client.Flush;

  except
    try
      datah.players[player].client.Shutdown(0);

    finally
    end;

  end;

end;

procedure playerwalk(player: Cardinal; dir: Integer; seq: Byte);
var
  pbuf: Array of Byte;
  objarray: TPrimitiveObjectArray;
  i: Integer;
  oldx, oldy: Word;
  oldz, xmod, ymod: ShortInt;
  staidxstart, staidxend: Cardinal;
  static: tstatic;
  statictile: tstatictile;
  openconts: Array of Cardinal;

begin
  oldx := datah.players[player].x;
  oldy := datah.players[player].y;
  oldz := datah.players[player].z;
  if dir > 7 then
    dir := dir - 128;

  xmod := 0;
  ymod := 0;
  if dir <> datah.players[player].facing then
    begin
      datah.players[player].facing := dir;
      SetLength(pbuf, 5);
      pbuf[0] := $FE;
      pbuf[1] := $40;
      pbuf[2] := $00;
      pbuf[3] := $05;
      pbuf[4] := seq;
      try
       datah.players[player].client.Send(Addr(pbuf[0]), 5);
       datah.players[player].client.Flush;

      except
        try
          datah.players[player].client.Shutdown(0);

        finally
        end;
        Exit;

      end;
      updateobjao(OTPLAYER, player, False);
      Exit;

    end;

  if dir = DFNORTH then
    ymod := -1

  else if dir = DFNORTHEAST then
    begin
      xmod := 1;
      ymod := -1;

    end

  else if dir = DFEAST then
    xmod := 1

  else if dir = DFSOUTHEAST then
    begin
      xmod := 1;
      ymod := 1;

    end

  else if dir = DFSOUTH then
    ymod := 1

  else if dir = DFSOUTHWEST then
    begin
      xmod := -1;
      ymod := 1;

    end

  else if dir = DFWEST then
    xmod := -1

  else if dir = DFNORTHWEST then
    begin
      xmod := -1;
      ymod := -1;

    end;

  datah.players[player].x := datah.players[player].x + xmod;
  datah.players[player].y := datah.players[player].y + ymod;
  datah.players[player].z := getstandingheight(datah.players[player].x, datah.players[player].y, datah.players[player].z);
  SetLength(objarray, 0);
  if getstaidx(datah.players[player].x, datah.players[player].y).start = NOSTATICS then
    begin
      if (getworldheight(oldx, oldy) - datah.players[player].z < -MAXHEIGHT) or
         (getlandtile(gettile(datah.players[player].x, datah.players[player].y).graphic).flags and FLAGIMPASSIBLE <> 0) then
        begin
          denywalking(player, seq, oldx, oldy, oldz);
          Exit;

        end;

    end

  else
    begin
      staidxstart := getstaidx(datah.players[player].x, datah.players[player].y).start div SizeOf(tstatic);
      staidxend := getstaidx(datah.players[player].x, datah.players[player].y).length div SizeOf(tstatic) + staidxstart;
      for i := staidxstart to staidxend - 1 do
        begin
          static := getstatic(i);
          statictile := getstatictile(static.graphic);
          if (static.x = datah.players[player].x mod 8) and (static.y = datah.players[player].y mod 8) and
             (datah.players[player].z = static.z) and (statictile.flags and FLAGIMPASSIBLE <> 0) then
            begin
              denywalking(player, seq, oldx, oldy, oldz);
              Exit;

            end

        end;

    end;

  (*
  SetLength(objarray, 0);
  objarray := getnpcsat2dpos(datah.players[player].x, datah.players[player].y);
  if Length(objarray) > 0 then
    for i := 0 to Length(objarray) - 1 do
      if datah.npcs[objarray[i]].z = datah.players[player].z then
        begin
          denywalking(player, seq, oldx, oldy, oldz);
          Exit;

        end;

  SetLength(objarray, 0);
  objarray := getplayersat2dpos(datah.players[player].x, datah.players[player].y);
  if Length(objarray) > 0 then
    for i := 0 to Length(objarray) - 1 do
      if (datah.players[objarray[i]].z = datah.players[player].z) and
         (objarray[i] <> player) and
         datah.players[objarray[i]].online then
        begin
          denywalking(player, seq, oldx, oldy, oldz);
          Exit;

        end;
  *)

  SetLength(objarray, 0);
  objarray := getitemsat2dpos(datah.players[player].x, datah.players[player].y);
  if Length(objarray) > 0 then
    for i := 0 to Length(objarray) - 1 do
      if (datah.items[objarray[i]].z = datah.players[player].z) and
         (datah.items[objarray[i]].walkable <> dir) and
         (datah.items[objarray[i]].walkable <> DFALL) then
        begin
          denywalking(player, seq, oldx, oldy, oldz);
          Exit;

        end;

  if Length(objarray) > 0 then
    for i := 0 to Length(objarray) - 1 do
      if (datah.items[objarray[i]].z = datah.players[player].z) then
        startitemscript(datah.items[objarray[i]].scriptname, CardToStr(objarray[i]),
                        IntToStr(ETWALKEDON), IntToStr(OTPLAYER), '',
                        CardToStr(player));

  remplayerfrom2dpos(player, oldx, oldy);
  addplayerto2dpos(player, datah.players[player].x, datah.players[player].y);
  SetLength(objarray, 0);
  SetLength(pbuf, 5);
  pbuf[0] := $FE;
  pbuf[1] := $40;
  pbuf[2] := $00;
  pbuf[3] := $05;
  pbuf[4] := seq;
  try
    datah.players[player].client.Send(Addr(pbuf[0]), 5);
    datah.players[player].client.Flush;

  except
    try
      datah.players[player].client.Shutdown(0);

    finally
    end;
    Exit;

  end;
  SetLength(objarray, 0);
  objarray := PrimitiveListObjectsNearLocation(OTPLAYER, datah.players[player].x,
                                               datah.players[player].y, 17);
  if Length(objarray) > 0 then
    for i := 0 to Length(objarray) - 1 do
      if (Abs(datah.players[player].x - datah.players[objarray[i]].x) <= 16) and
         (Abs(datah.players[player].y - datah.players[objarray[i]].y) <= 16) and
         (player <> objarray[i]) and datah.players[objarray[i]].online then
        begin
          if ((datah.players[objarray[i]].hidden = 0) or (datah.players[player].privileged = 1)) and
             not isnoueplayer(objarray[i], player) then
            begin
              updateobj(OTPLAYER, player, objarray[i]);
              updateequ(OTPLAYER, player, objarray[i]);

            end

          else if (datah.players[player].hidden = 0) or (datah.players[objarray[i]].privileged = 1) then
            if not isnoueplayer(player, objarray[i]) then
              begin
                updateobj(OTPLAYER, objarray[i], player);
                updateequ(OTPLAYER, objarray[i], player);

              end

            else
              updateobj(OTPLAYER, objarray[i], player);

        end

      else if (player <> objarray[i]) and datah.players[objarray[i]].online then
        begin
          if ((datah.players[objarray[i]].hidden = 0) or (datah.players[player].privileged = 1)) and
             isnoueplayer(objarray[i], player) then
            delobj(OTPLAYER, player, objarray[i]);

          if ((datah.players[player].hidden = 0) or (datah.players[objarray[i]].privileged = 1)) and
             isnoueplayer(player, objarray[i]) then
            delobj(OTPLAYER, objarray[i], player);

        end;

  SetLength(objarray, 0);
  objarray := PrimitiveListObjectsNearLocation(OTNPC, datah.players[player].x,
                                               datah.players[player].y, 17);
  if Length(objarray) > 0 then
    for i := 0 to Length(objarray) - 1 do
      if (Abs(datah.players[player].x - datah.npcs[objarray[i]].x) <= 16) and
         (Abs(datah.players[player].y - datah.npcs[objarray[i]].y) <= 16) then
        begin
          if ((datah.npcs[objarray[i]].hidden = 0) or (datah.players[player].privileged = 1)) and
             not isnouenpc(objarray[i], player) then
            begin
              updateobj(OTNPC, player, objarray[i]);
              updateequ(OTNPC, player, objarray[i]);

            end;

        end

      else
        if ((datah.npcs[objarray[i]].hidden = 0) or (datah.players[player].privileged = 1)) and
           isnouenpc(objarray[i], player) then
          delobj(OTNPC, player, objarray[i]);

  SetLength(objarray, 0);
  objarray := PrimitiveListObjectsNearLocation(OTITEM, datah.players[player].x,
                                               datah.players[player].y, 17);
  if Length(objarray) > 0 then
    for i := 0 to Length(objarray) - 1 do
      if (Abs(datah.players[player].x - datah.items[objarray[i]].x) <= 16) and
         (Abs(datah.players[player].y - datah.items[objarray[i]].y) <= 16) then
        begin
          if ((datah.items[objarray[i]].invisible = 0) or
             (datah.players[player].privileged = 1)) and
             not isnouitem(objarray[i], player) then
            begin
              updateobj(OTITEM, player, objarray[i]);
              addnouitem(objarray[i], player);

            end;

        end

      else
        if ((datah.items[objarray[i]].invisible = 0) or
           (datah.players[player].privileged = 1)) and
           isnouitem(objarray[i], player) then
          delobj(OTITEM, player, objarray[i]);

  while datah.players[player].ococ do
    Sleep(1);

  datah.players[player].ococ := True;
  SetLength(openconts, Length(datah.players[player].openconts));
  Move(datah.players[player].openconts[0], openconts[0], Length(datah.players[player].openconts) * 4);
  datah.players[player].ococ := False;
  if Length(openconts) > 0 then
    begin
      for i := 0 to Length(openconts) - 1 do
        if (PrimitiveCheckObjectDistance(OTITEM, openconts[i],
           OTPLAYER, player) <= 16) and
           ((datah.items[openconts[i]].invisible = 0) or
           (datah.players[player].privileged = 1)) then
          if (datah.items[openconts[i]].equipped > 0) and
             (datah.items[openconts[i]].equipped <> datah.players[player].id) and
             (PrimitiveIsUnhidden(CheckObjectType(datah.items[openconts[i]].equipped),
             PrimitiveGetObject(CheckObjectType(datah.items[openconts[i]].equipped),
             datah.items[openconts[i]].equipped)) or
             (datah.players[player].privileged = 1)) then
            begin
              delobj(OTITEM, player, openconts[i]);
              equitem(player, datah.items[openconts[i]].equipped, openconts[i]);
              equchanged(datah.items[openconts[i]].equipped, player);

            end

          else if (datah.items[openconts[i]].contained > 0) and
             ((datah.items[PrimitiveIsContainedIn(openconts[i])].invisible = 0) or
             (datah.players[player].privileged = 1)) and
             ((datah.items[PrimitiveGetMainContainer(openconts[i])].invisible = 0) or
             (datah.players[player].privileged = 1)) then
            if (PrimitiveGetMainContainer(openconts[i]) = 0) and
               (datah.items[PrimitiveGetMainContainer(openconts[i])].equipped = 0) then
              begin
                delobj(OTITEM, player, openconts[i]);
                insitem(player, datah.items[openconts[i]].id);

              end

            else
              begin
                if (datah.items[PrimitiveGetMainContainer(openconts[i])].equipped <> datah.players[player].id) and
                   (PrimitiveIsUnhidden(CheckObjectType(datah.items[PrimitiveGetMainContainer(openconts[i])].equipped),
                   PrimitiveGetObject(CheckObjectType(datah.items[PrimitiveGetMainContainer(openconts[i])].equipped),
                   datah.items[PrimitiveGetMainContainer(openconts[i])].equipped)) or
                   (datah.players[player].privileged = 1)) then
                  begin
                    delobj(OTITEM, player, openconts[i]);
                    insitem(player, datah.items[openconts[i]].id);

                  end;

              end

          else if (datah.items[openconts[i]].contained = 0) and
                  (datah.items[openconts[i]].equipped = 0) then
            begin
              delobj(OTITEM, player, openconts[i]);
              updateobj(OTITEM, player, openconts[i]);
              addnouitem(openconts[i], player);

            end;

    end;

  if datah.players[player].dragging then
    if PrimitiveCheckObjectDistance(OTPLAYER, player, OTITEM,
       datah.players[player].dragitem) > 3 then
      begin
        datah.items[datah.players[player].dragitem].occupied := False;
        datah.players[player].dragging := False;
        datah.players[player].dragitem := 0;
        datah.players[player].dragamt := 0;
        denydragging(player);

      end;

  startmiscscript('onwalk', CardToStr(player), IntToStr(oldx), IntToStr(oldy),
                  IntToStr(oldz));

end;

procedure dclick(player, objid: Cardinal);
var
  objtype: Integer;
  obj, i, spellbook: Cardinal;
  openconts: Array of Cardinal;

begin
  objtype := CheckObjectType(objid);
  if objtype = OTPLAYER then
    begin
      obj := PrimitiveGetObject(objtype, objid);
      if (datah.players[player].id <> objid) and not PrimitiveIsUnhidden(objtype, obj)
         and (datah.players[player].privileged = 0) then
        Exit;

      if (datah.players[player].war = 0) or (datah.players[player].id = objid) then
        showpd(player, obj, objtype)

      else if datah.players[player].war = 1 then
        startmiscscript('onattack', IntToStr(OTPLAYER), CardToStr(player), IntToStr(objtype),
                        CardToStr(obj));

    end

  else if objtype = OTNPC then
    begin
      obj := PrimitiveGetObject(objtype, objid);
      if not PrimitiveIsUnhidden(objtype, obj) and (datah.players[player].privileged = 0) then
        Exit;
        
      if datah.players[player].war = 0 then
        begin
          showpd(player, obj, objtype);
          PrimitiveSetEvent(obj, ETDOUBLECLICKED, 0, '', player);

        end

      else if datah.players[player].war = 1 then
        begin
          startmiscscript('onattack', IntToStr(OTPLAYER), CardToStr(player), IntToStr(objtype),
                          CardToStr(obj));
          PrimitiveSetEvent(obj, ETATTACKED, OTPLAYER, '', player);

        end;

    end

  else if objtype = OTITEM then
    begin
      obj := PrimitiveGetObject(objtype, objid);
      if ((datah.items[obj].invisible = 1) and (datah.players[obj].privileged = 0)) or
         ((PrimitiveGetMainContainer(obj) = 0) and (datah.items[obj].equipped > 0) and (datah.items[obj].equipped <> datah.players[player].id) and not
         PrimitiveIsUnhidden(CheckObjectType(datah.items[obj].equipped),
         PrimitiveGetObject(CheckObjectType(datah.items[obj].equipped), datah.items[obj].equipped)) and
         (datah.players[player].privileged = 0)) or
         ((PrimitiveGetMainContainer(obj) > 0) and (datah.items[PrimitiveGetMainContainer(obj)].equipped > 0) and (datah.items[PrimitiveGetMainContainer(obj)].equipped <> datah.players[player].id) and not
         PrimitiveIsUnhidden(CheckObjectType(datah.items[PrimitiveGetMainContainer(obj)].equipped),
         PrimitiveGetObject(CheckObjectType(datah.items[PrimitiveGetMainContainer(obj)].equipped), datah.items[PrimitiveGetMainContainer(obj)].equipped)) and
         (datah.players[player].privileged = 0)) then
        Exit;

      if PrimitiveCheckObjectDistance(OTPLAYER, player, OTITEM, obj) > 3 then
        sendsysmsg('Too far away!', 255, 255, 255, player)

      else
        begin
          if datah.items[obj].itemtype = ITIDSPELLBOOK then
            begin
              while datah.players[player].ococ do
                Sleep(1);

              datah.players[player].ococ := True;
              SetLength(openconts, Length(datah.players[player].openconts));
              Move(datah.players[player].openconts[0], openconts[0], Length(datah.players[player].openconts) * 4);
              datah.players[player].ococ := False;
              spellbook := 0;
              if Length(openconts) > 0 then
                for i := Length(openconts) - 1 downto 0 do
                  if datah.items[openconts[i]].itemtype = ITIDSPELLBOOK then
                    begin
                      spellbook := openconts[i];
                      Break;

                    end;

              if spellbook > 0 then
                begin
                  delobj(OTITEM, player, spellbook);
                  if datah.items[spellbook].contained > 0 then
                    insitem(player, datah.items[spellbook].id)

                  else
                    begin
                      updateobj(OTITEM, player, spellbook);
                      addnouitem(spellbook, player);

                    end;

                end;

            end;

          startitemscript(datah.items[obj].scriptname, CardToStr(obj), IntToStr(ETDOUBLECLICKED),
                          '', '', CardToStr(player));

        end;

    end;

end;

procedure showpd(player, obj: Cardinal; objtype: Integer);
var
  pbuf: Array of Byte;
  tempcard: Cardinal;

begin
  if objtype = OTPLAYER then
    if (datah.players[obj].graphic <> 0) and (datah.players[obj].graphic <> 1) then
      Exit;

  if objtype = OTNPC then
    if (datah.npcs[obj].graphic <> 0) and (datah.npcs[obj].graphic <> 1) then
      Exit;

  SetLength(pbuf, 10);
  pbuf[0] := $FE;
  pbuf[1] := $42;
  pbuf[2] := $00;
  pbuf[3] := $0A;
  tempcard := 0;
  if objtype = OTPLAYER then
    tempcard := swapdword(datah.players[obj].id)

  else if objtype = OTNPC then
    tempcard := swapdword(datah.npcs[obj].id);

  Move(tempcard, pbuf[4], 4);
  pbuf[8] := $00;
  pbuf[9] := $0A;
  try
    datah.players[player].client.Send(Addr(pbuf[0]), 10);
    datah.players[player].client.Flush;

  except
    try
      datah.players[player].client.Shutdown(0);

    finally
    end;

  end;

end;

procedure printtxtabv(txt: String; R, G, B: Byte; objtype: Integer; player,
                      obj: Cardinal);
var
  pbuf: Array of Byte;
  tempcard: Cardinal;
  tempword: Word;
  tempstr: String;

begin
  SetLength(pbuf, Length(txt) + 46);
  pbuf[0] := $FE;
  pbuf[1] := $37;
  tempword := swapword(Length(txt) + 46);
  Move(tempword, pbuf[2], 2);
  tempcard := 0;
  if objtype = OTPLAYER then
    tempcard := swapdword(datah.players[obj].id)

  else if objtype = OTNPC then
    tempcard := swapdword(datah.npcs[obj].id)

  else if objtype = OTITEM then
    tempcard := swapdword(datah.items[obj].id);

  Move(tempcard, pbuf[4], 4);
  pbuf[8] := $00;
  pbuf[9] := $00;
  pbuf[10] := $06;
  pbuf[11] := $00;
  pbuf[12] := B;
  pbuf[13] := G;
  pbuf[14] := R;
  tempstr := padstr('', 30);
  Move(tempstr[1], pbuf[15], 30);
  Move(txt[1], pbuf[45], Length(txt));
  pbuf[45 + Length(txt)] := $00;
  try
    datah.players[player].client.Send(Addr(pbuf[0]), 46 + Length(txt));
    datah.players[player].client.Flush;

  except
    try
      datah.players[player].client.Shutdown(0);

    finally
    end;

  end;

end;

procedure sclick(player, objid: Cardinal);
var
  objtype: Integer;
  obj: Cardinal;

begin
  objtype := CheckObjectType(objid);
  obj := PrimitiveGetObject(objtype, objid);
  if (datah.players[player].id <> objid) and not PrimitiveIsUnhidden(objtype, obj) and (datah.players[player].privileged = 0) then
    Exit;

  startmiscscript('onsclick', CardToStr(player), IntToStr(objtype), CardToStr(obj));

end;

procedure sendsysmsg(msg: String; R, G, B: Byte; player: Cardinal);
var
  pbuf: Array of Byte;
  tempstr: String;
  tempword: Word;

begin
  SetLength(pbuf, Length(msg) + 46);
  pbuf[0] := $FE;
  pbuf[1] := $37;
  tempword := swapword(Length(msg) + 46);
  Move(tempword, pbuf[2], 2);
  pbuf[4] := $00;
  pbuf[5] := $00;
  pbuf[6] := $00;
  pbuf[7] := $00;
  pbuf[8] := $00;
  pbuf[9] := $00;
  pbuf[10] := $06;
  pbuf[11] := $00;
  pbuf[12] := B;
  pbuf[13] := G;
  pbuf[14] := R;
  tempstr := padstr('', 30);
  Move(tempstr[1], pbuf[15], 30);
  Move(msg[1], pbuf[45], Length(msg));
  pbuf[45 + Length(msg)] := $00;
  try
    datah.players[player].client.Send(Addr(pbuf[0]), 46 + Length(msg));
    datah.players[player].client.Flush;

  except
    try
      datah.players[player].client.Shutdown(0);

    finally
    end;

  end;

end;

procedure drag(player, itemid: Cardinal; amt: Word);
var
  item: Cardinal;
  pbuf: Array of Byte;
  tempcard: Cardinal;
  tempword: Word;

begin
  if datah.players[player].dead = 1 then
    begin
      sendsysmsg('You are dead and cannot do that!', 255, 255, 255, player);
      datah.players[player].dragging := False;
      denydragging(player);
      Exit;

    end;

  item := PrimitiveGetObject(OTITEM, itemid);
  if ((datah.items[item].invisible = 1) and (datah.players[player].privileged = 0)) or
     ((PrimitiveGetMainContainer(item) = 0) and (datah.items[item].equipped > 0) and (datah.items[item].equipped <> datah.players[player].id) and not
     PrimitiveIsUnhidden(CheckObjectType(datah.items[item].equipped),
     PrimitiveGetObject(CheckObjectType(datah.items[item].equipped), datah.items[item].equipped)) and
     (datah.players[player].privileged = 0)) or
     ((PrimitiveGetMainContainer(item) > 0) and (datah.items[PrimitiveGetMainContainer(item)].equipped > 0) and (datah.items[PrimitiveGetMainContainer(item)].equipped <> datah.players[player].id) and not
     PrimitiveIsUnhidden(CheckObjectType(datah.items[PrimitiveGetMainContainer(item)].equipped),
     PrimitiveGetObject(CheckObjectType(datah.items[PrimitiveGetMainContainer(item)].equipped), datah.items[PrimitiveGetMainContainer(item)].equipped)) and
     (datah.players[player].privileged = 0)) then
    Exit;

  if datah.items[item].moveable = 0 then
    begin
      sendsysmsg('This item is not moveable!', 255, 255, 255, player);
      datah.players[player].dragging := False;
      denydragging(player);
      Exit;

    end

  else
    begin
      if datah.items[item].occupied then
        if datah.items[item].dragger = 0 then
          begin
            sendsysmsg('You cannot move this item at the moment!', 255, 255, 255, player);
            datah.players[player].dragging := False;
            denydragging(player);
            Exit;

          end

        else
          begin
            sendsysmsg('You have got competition!', 255, 255, 255, datah.items[item].dragger);
            datah.players[datah.items[item].dragger].dragging := False;
            datah.players[datah.items[item].dragger].dragitem := 0;
            datah.players[datah.items[item].dragger].dragamt := 0;
            denydragging(datah.items[item].dragger);
            datah.items[item].dragger := 0;

          end;

      if not datah.items[item].occupied then
        datah.items[item].occupied := True;
        
      datah.players[player].dragging := True;
      datah.players[player].dragitem := item;
      datah.players[player].dragamt := amt;
      datah.items[item].dragger := player;
      if (amt > 0) and (datah.items[item].amount - amt > 0) then
        if datah.items[item].contained = 0 then
          begin
            SetLength(pbuf, 21);
            pbuf[0] := $FE;
            pbuf[1] := $35;
            pbuf[2] := $00;
            pbuf[3] := $15;
            tempcard := swapdword(datah.items[item].id or $40000000);
            Move(tempcard, pbuf[4], 4);
            tempword := swapword(datah.items[item].graphic);
            Move(tempword, pbuf[8], 2);
            pbuf[10] := $00;
            tempword := swapword(datah.items[item].amount - amt);
            Move(tempword, pbuf[11], 2);
            tempword := swapword(datah.items[item].x);
            Move(tempword, pbuf[13], 2);
            tempword := swapword(datah.items[item].y);
            Move(tempword, pbuf[15], 2);
            pbuf[17] := $00;
            pbuf[18] := datah.items[item].z;
            tempword := swapword(datah.items[item].color);
            Move(tempword, pbuf[19], 2);
            try
              datah.players[player].client.Send(Addr(pbuf[0]), 21);
              datah.players[player].client.Flush;

            except
              try
                datah.players[player].client.Shutdown(0);

              finally
              end;
              Exit;

            end;

          end

        else
          begin
            SetLength(pbuf, 23);
            pbuf[0] := $FE;
            pbuf[1] := $43;
            pbuf[2] := $00;
            pbuf[3] := $17;
            tempcard := swapdword(datah.items[item].id or $40000000);
            Move(tempcard, pbuf[4], 4);
            tempword := swapword(datah.items[item].graphic);
            Move(tempword, pbuf[8], 2);
            pbuf[10] := $00;
            tempword := swapword(datah.items[item].amount - amt);
            Move(tempword, pbuf[11], 2);
            tempword := swapword(datah.items[item].x);
            Move(tempword, pbuf[13], 2);
            tempword := swapword(datah.items[item].y);
            Move(tempword, pbuf[15], 2);
            tempcard := swapdword(datah.items[item].contained or $40000000);
            Move(tempcard, pbuf[17], 4);
            tempword := swapword(datah.items[item].color);
            Move(tempword, pbuf[21], 2);
            try
              datah.players[player].client.Send(Addr(pbuf[0]), 23);
              datah.players[player].client.Flush;

            except
              try
                datah.players[player].client.Shutdown(0);

              finally
              end;

            end;
            
          end;

    end;

end;

procedure drop(player, itemid: Cardinal; x, y, z: Word);
var
  tempword, tempamount: Word;
  item, index, tempcard, i: Cardinal;
  objtype: Integer;
  tempitem: titem;
  objarray: TPrimitiveObjectArray;

begin
  SetLength(objarray, 0);
  item := PrimitiveGetObject(OTITEM, itemid);
  if ((datah.items[item].invisible = 1) and (datah.players[player].privileged = 0)) or
     ((PrimitiveGetMainContainer(item) = 0) and (datah.items[item].equipped > 0) and (datah.items[item].equipped <> datah.players[player].id) and not
     PrimitiveIsUnhidden(CheckObjectType(datah.items[item].equipped),
     PrimitiveGetObject(CheckObjectType(datah.items[item].equipped), datah.items[item].equipped)) and
     (datah.players[player].privileged = 0)) or
     ((PrimitiveGetMainContainer(item) > 0) and (datah.items[PrimitiveGetMainContainer(item)].equipped > 0) and (datah.items[PrimitiveGetMainContainer(item)].equipped <> datah.players[player].id) and not
     PrimitiveIsUnhidden(CheckObjectType(datah.items[PrimitiveGetMainContainer(item)].equipped),
     PrimitiveGetObject(CheckObjectType(datah.items[PrimitiveGetMainContainer(item)].equipped), datah.items[PrimitiveGetMainContainer(item)].equipped)) and
     (datah.players[player].privileged = 0)) then
    Exit;

  if item <> datah.players[player].dragitem then
    begin
      datah.players[player].dragging := False;
      datah.players[player].dragitem := 0;
      datah.players[player].dragamt := 0;
      Exit;

    end;

  if datah.items[item].id = 0 then
    begin
      datah.players[player].dragging := False;
      datah.players[player].dragitem := 0;
      datah.players[player].dragamt := 0;
      Exit;

    end;

  if datah.players[player].dragging = False then
    begin
      denydropping(player, item);
      Exit;

    end;

  if (PrimitiveCheckObjectDistance(OTPLAYER, player, OTITEM, item) > 3) or
     (PrimitiveCheckObjectToCoordinatesDistance(OTITEM, item, x, y, z) > 3) then
    begin
      sendsysmsg('Too far away!', 255, 255, 255, player);
      datah.items[item].occupied := False;
      datah.items[item].dragger := 0;
      datah.players[player].dragging := False;
      datah.players[player].dragitem := 0;
      datah.players[player].dragamt := 0;
      denydropping(player, item);
      Exit;

    end;

  if datah.items[item].equipped > 0 then
    begin
      datah.items[item].occupied := False;
      datah.items[item].dragger := 0;
      datah.players[player].dragging := False;
      datah.players[player].dragitem := 0;
      datah.players[player].dragamt := 0;
      objtype := CheckObjectType(datah.items[item].equipped);
      PrimitiveUnequipItem(objtype, PrimitiveGetObject(objtype, datah.items[item].equipped), item, x, y, z);
      Exit;

    end

  else if datah.items[item].contained > 0 then
    begin
      datah.items[item].occupied := False;
      datah.items[item].dragger := 0;
      datah.players[player].dragging := False;
      datah.players[player].dragitem := 0;
      tempword := datah.players[player].dragamt;
      datah.players[player].dragamt := 0;
      tempamount := datah.items[item].amount;
      tempcard := PrimitiveGetObject(OTITEM, datah.items[item].contained);
      PrimitiveRemoveItem(item, tempcard, x, y, z, tempword);
      if (tempword > 0) and (tempamount > 0) and
         (tempamount = datah.items[item].amount) and
         (tempamount - tempword <> 0) then
        begin
          denydropping(player, item);

        end;

      tempamount := tempamount - datah.items[item].amount;
      if (tempcard > 0) then
        if ((PrimitiveGetMainContainer(tempcard) = 0) and
           (datah.items[tempcard].equipped > 0) and (datah.items[tempcard].equipped <> datah.players[player].id)) or
           ((PrimitiveGetMainContainer(tempcard) > 0) and (datah.items[PrimitiveGetMainContainer(tempcard)].equipped > 0) and
           (datah.items[PrimitiveGetMainContainer(tempcard)].equipped <> datah.players[player].id)) then
          startskillscript('stealing', CardToStr(player), CardToStr(item), CardToStr(tempcard), IntToStr(tempamount));

      Exit;

    end;

  if (datah.players[player].dragamt = 0) or (datah.items[item].amount - datah.players[player].dragamt
     = 0) then
    begin
      remitemfrom2dpos(item, datah.items[item].x, datah.items[item].y);
      datah.items[item].x := x;
      datah.items[item].y := y;
      additemto2dpos(item, x, y);
      datah.items[item].z := z;
      datah.items[item].occupied := False;
      objarray := PrimitiveListObjectsNearLocation(OTPLAYER, datah.players[player].x, datah.players[player].y,
                                                   16);
      if Length(objarray) > 0 then
        for i := 0 to Length(objarray) - 1 do
          if datah.players[objarray[i]].online and ((datah.items[item].invisible = 0) or
             (datah.players[objarray[i]].privileged = 1)) then
            updateobj(OTITEM, objarray[i], item);

      startitemscript(datah.items[item].scriptname, CardToStr(item), IntToStr(ETMOVED), IntToStr(OTPLAYER),
                      '', CardToStr(player));

    end

  else
    begin
      if datah.items[item].id = 0 then
        begin
          datah.players[player].dragging := False;
          datah.players[player].dragitem := 0;
          datah.players[player].dragamt := 0;
          Exit;

        end;

      hidlock.Acquire;
      tempcard := highestid + 1;
      if (tempcard and $0FFFFFFF) = tempcard then
        begin
          highestid := tempcard;
          hidlock.Release;

        end

      else
        begin
          datah.items[item].occupied := False;
          datah.items[item].dragger := 0;
          datah.players[player].dragging := False;
          datah.players[player].dragitem := 0;
          datah.players[player].dragamt := 0;
          denydropping(player, item);
          printsm(10, 'Maximum ID capacity reached!');
          hidlock.Release;
          Exit;

        end;

      tempitem := datah.items[item].clone;
      if tempitem = nil then
        Exit;

      datah.items[item].amount := datah.items[item].amount - datah.players[player].dragamt;
      datah.items[item].occupied := False;
      itemslock.Acquire;
      index := Length(items);
      SetLength(items, index + 1);
      itemslock.Release;
      tempitem.id := tempcard;
      tempitem.amount := datah.players[player].dragamt;
      tempitem.x := x;
      tempitem.y := y;
      additemto2dpos(index, x, y);
      tempitem.z := z;
      tempitem.occupied := False;
      datah.items[index] := tempitem;
      ihashlock.Acquire;
      itemhash[CardToStr(tempcard)] := index;
      ihashlock.Release;
      othashlock.Acquire;
      objtypehash[CardToStr(tempcard)] := OTITEM;
      othashlock.Release;
      objarray := PrimitiveListObjectsNearLocation(OTPLAYER, datah.players[player].x, datah.players[player].y,
                                                   16);
      if Length(objarray) > 0 then
        for i := 0 to Length(objarray) - 1 do
          if datah.players[objarray[i]].online then
            begin
              if (datah.items[item].invisible = 0) or
                 (datah.players[objarray[i]].privileged = 1) then
                updateobj(OTITEM, objarray[i], item);

              if (datah.items[index].invisible = 0) or
                 (datah.players[objarray[i]].privileged = 1) then
                updateobj(OTITEM, objarray[i], index);

            end;

      startitemscript(datah.items[item].scriptname, CardToStr(item), IntToStr(ETUNSTACKED),
                      '', '', CardToStr(index));

    end;

  datah.items[item].dragger := 0;
  datah.players[player].dragging := False;
  datah.players[player].dragitem := 0;
  datah.players[player].dragamt := 0;

end;

procedure sendspeech(speechstr: String; R, G, B: Byte; objtype: Integer;
                     player, obj: Cardinal);
var
  pbuf: Array of Byte;
  tempcard: Cardinal;
  tempstr: String;
  tempword: Word;

begin
  SetLength(pbuf, Length(speechstr) + 46);
  pbuf[0] := $FE;
  pbuf[1] := $37;
  tempword := swapword(Length(speechstr) + 46);
  Move(tempword, pbuf[2], 2);
  tempcard := 0;
  if objtype = OTPLAYER then
    tempcard := swapdword(datah.players[obj].id)

  else if objtype = OTNPC then
    tempcard := swapdword(datah.npcs[obj].id);

  Move(tempcard, pbuf[4], 4);
  pbuf[8] := $00;
  pbuf[9] := $00;
  pbuf[10] := $00;
  pbuf[11] := $00;
  pbuf[12] := B;
  pbuf[13] := G;
  pbuf[14] := R;
  tempstr := padstr('', 30);
  if objtype = OTPLAYER then
    tempstr := padstr(datah.players[obj].name, 30)

  else if objtype = OTNPC then
    tempstr := padstr(datah.npcs[obj].name, 30);

  Move(tempstr[1], pbuf[15], 30);
  Move(speechstr[1], pbuf[45], Length(speechstr));
  pbuf[45 + Length(speechstr)] := $00;
  try
    datah.players[player].client.Send(Addr(pbuf[0]), 46 + Length(speechstr));
    datah.players[player].client.Flush;

  except
    try
      datah.players[player].client.Shutdown(0);

    finally
    end;

  end;

end;

procedure showstatus(player, objid: Cardinal);
var
  objtype: Integer;
  obj, tempcard: Cardinal;
  pbuf: Array of Byte;
  tempstr: String;
  tempword: Word;

begin
  objtype := CheckObjectType(objid);
  if objtype = OTPLAYER then
    if objid = datah.players[player].id then
      begin
        SetLength(pbuf, 68);
        pbuf[0] := $FE;
        pbuf[1] := $33;
        pbuf[2] := $00;
        pbuf[3] := $44;
        tempcard := swapdword(datah.players[player].id);
        Move(tempcard, pbuf[4], 4);
        tempstr := padstr(datah.players[player].name, 30);
        Move(tempstr[1], pbuf[8], 30);
        tempword := swapword(datah.players[player].hits);
        Move(tempword, pbuf[38], 2);
        tempword := swapword(datah.players[player].str);
        Move(tempword, pbuf[40], 2);
        pbuf[42] := $01;
        pbuf[43] := datah.players[player].sex;
        tempword := swapword(datah.players[player].str);
        Move(tempword, pbuf[44], 2);
        tempword := swapword(datah.players[player].dex);
        Move(tempword, pbuf[46], 2);
        tempword := swapword(datah.players[player].int);
        Move(tempword, pbuf[48], 2);
        tempword := swapword(datah.players[player].fat);
        Move(tempword, pbuf[50], 2);
        tempword := swapword(datah.players[player].dex);
        Move(tempword, pbuf[52], 2);
        tempword := swapword(datah.players[player].mana);
        Move(tempword, pbuf[54], 2);
        tempword := swapword(datah.players[player].int);
        Move(tempword, pbuf[56], 2);
        tempcard := swapdword(datah.players[player].exp);
        Move(tempcard, pbuf[58], 4);
        tempcard := swapdword(Sqr(datah.players[player].level * 10));
        Move(tempcard, pbuf[62], 4);
        tempword := swapword(datah.players[player].level - 1);
        Move(tempword, pbuf[66], 2);
        try
          datah.players[player].client.Send(Addr(pbuf[0]), 68);
          datah.players[player].client.Flush;

        except
          try
            datah.players[player].client.Shutdown(0);

          finally
          end;

        end;

      end

    else
      begin
        obj := PrimitiveGetObject(objtype, objid);
        SetLength(pbuf, 43);
        pbuf[0] := $FE;
        pbuf[1] := $33;
        pbuf[2] := $00;
        pbuf[3] := $2B;
        tempcard := swapdword(objid);
        Move(tempcard, pbuf[4], 4);
        tempstr := padstr(datah.players[obj].name, 30);
        Move(tempstr[1], pbuf[8], 30);
        tempword := swapword(datah.players[obj].hits);
        Move(tempword, pbuf[38], 2);
        tempword := swapword(datah.players[obj].str);
        Move(tempword, pbuf[40], 2);
        pbuf[42] := $01;
        try
          datah.players[player].client.Send(Addr(pbuf[0]), 43);
          datah.players[player].client.Flush;

        except
          try
            datah.players[player].client.Shutdown(0);

          finally
          end;

        end;

      end

  else if objtype = OTNPC then
    begin
      obj := PrimitiveGetObject(objtype, objid);
      SetLength(pbuf, 43);
      pbuf[0] := $FE;
      pbuf[1] := $33;
      pbuf[2] := $00;
      pbuf[3] := $2B;
      tempcard := swapdword(objid);
      Move(tempcard, pbuf[4], 4);
      tempstr := padstr(datah.npcs[obj].name, 30);
      Move(tempstr[1], pbuf[8], 30);
      tempword := swapword(datah.npcs[obj].hits);
      Move(tempword, pbuf[38], 2);
      tempword := swapword(datah.npcs[obj].str);
      Move(tempword, pbuf[40], 2);
      pbuf[42] := $01;
      try
        datah.players[player].client.Send(Addr(pbuf[0]), 43);
        datah.players[player].client.Flush;

      except
        try
          datah.players[player].client.Shutdown(0);

        finally
        end;

      end;

    end;

end;

procedure showskills(player, objid: Cardinal);
var
  objtype: Integer;
  obj: Cardinal;
  pbuf: Array of Byte;
  tempword: Word;

begin
  objtype := CheckObjectType(objid);
  obj := PrimitiveGetObject(objtype, objid);
  SetLength(pbuf, 25);
  pbuf[0] := $FE;
  pbuf[1] := $6F;
  pbuf[2] := $00;
  pbuf[3] := $19;
  pbuf[4] := $00;
  tempword := 0;
  if objtype = OTPLAYER then
    tempword := swapword(datah.players[obj].magicdef * 10)

  else if objtype = OTNPC then
    tempword := swapword(datah.npcs[obj].magicdef * 10);

  Move(tempword, pbuf[5], 2);
  tempword := 0;
  if objtype = OTPLAYER then
    tempword := swapword(datah.players[obj].battledef * 10)

  else if objtype = OTNPC then
    tempword := swapword(datah.npcs[obj].battledef * 10);

  Move(tempword, pbuf[7], 2);
  tempword := 0;
  if objtype = OTPLAYER then
    tempword := swapword(datah.players[obj].stealing * 10)

  else if objtype = OTNPC then
    tempword := swapword(datah.npcs[obj].stealing * 10);

  Move(tempword, pbuf[9], 2);
  tempword := 0;
  if objtype = OTPLAYER then
    tempword := swapword(datah.players[obj].hiding * 10)

  else if objtype = OTNPC then
    tempword := swapword(datah.npcs[obj].hiding * 10);

  Move(tempword, pbuf[11], 2);
  tempword := 0;
  if objtype = OTPLAYER then
    tempword := swapword(datah.players[obj].firstaid * 10)

  else if objtype = OTNPC then
    tempword := swapword(datah.npcs[obj].firstaid * 10);

  Move(tempword, pbuf[13], 2);
  tempword := 0;
  if objtype = OTPLAYER then
    tempword := swapword(datah.players[obj].detecttr * 10)

  else if objtype = OTNPC then
    tempword := swapword(datah.npcs[obj].detecttr * 10);

  Move(tempword, pbuf[15], 2);
  tempword := 0;
  if objtype = OTPLAYER then
    tempword := swapword(datah.players[obj].peek * 10)

  else if objtype = OTNPC then
    tempword := swapword(datah.npcs[obj].peek * 10);

  Move(tempword, pbuf[17], 2);
  tempword := 0;
  if objtype = OTPLAYER then
    tempword := swapword(datah.players[obj].magic * 10)

  else if objtype = OTNPC then
    tempword := swapword(datah.npcs[obj].magic * 10);

  Move(tempword, pbuf[19], 2);
  tempword := 0;
  if objtype = OTPLAYER then
    tempword := swapword(datah.players[obj].melee * 10)

  else if objtype = OTNPC then
    tempword := swapword(datah.npcs[obj].melee * 10);

  Move(tempword, pbuf[21], 2);
  tempword := 0;
  if objtype = OTPLAYER then
    tempword := swapword(datah.players[obj].rangedweap * 10)

  else if objtype = OTNPC then
    tempword := swapword(datah.npcs[obj].rangedweap * 10);

  Move(tempword, pbuf[23], 2);
  try
    datah.players[player].client.Send(Addr(pbuf[0]), 25);
    datah.players[player].client.Flush;

  except
    try
      datah.players[player].client.Shutdown(0);

    finally
    end;

  end;

end;

procedure equitem(player, objid, item: Cardinal);
var
  pbuf: Array of Byte;
  tempcard: Cardinal;
  tempword: Word;

begin
  SetLength(pbuf, 18);
  pbuf[0] := $FE;
  pbuf[1] := $4D;
  pbuf[2] := $00;
  pbuf[3] := $12;
  tempcard := swapdword(datah.items[item].id or $40000000);
  Move(tempcard, pbuf[4], 4);
  tempword := swapword(datah.items[item].graphic);
  Move(tempword, pbuf[8], 2);
  pbuf[10] := 0;
  pbuf[11] := getstatictile(datah.items[item].graphic).layer;
  tempcard := swapdword(objid);
  Move(tempcard, pbuf[12], 4);
  tempword := swapword(datah.items[item].color);
  Move(tempword, pbuf[16], 2);
  try
    datah.players[player].client.Send(Addr(pbuf[0]), 18);
    datah.players[player].client.Flush;

  except
    try
      datah.players[player].client.Shutdown(0);

    finally
    end;

  end;

end;

procedure updateequ(objtype: Integer; player, obj: Cardinal);
var
  i, item: Cardinal;

begin
  if objtype = OTPLAYER then
    begin
      if (Length(datah.players[obj].equitems) > 0) and not isnoueplayer(obj, player) then
        begin
          addnoueplayer(obj, player);
          for i := 0 to Length(datah.players[obj].equitems) - 1 do
            begin
              item := PrimitiveGetObject(OTITEM, datah.players[obj].equitems[i]);
              if (datah.items[item].invisible = 0) or (datah.players[player].privileged = 1) then
                equitem(player, datah.players[obj].id, item);

            end;

          equchanged(datah.players[obj].id, player);

         end

      else
        addnoueplayer(obj, player);

    end;

  if objtype = OTNPC then
    begin
      if (Length(datah.npcs[obj].equitems) > 0) and not isnouenpc(obj, player) then
        begin
          addnouenpc(obj, player);
          for i := 0 to Length(datah.npcs[obj].equitems) - 1 do
            begin
              item := PrimitiveGetObject(OTITEM, datah.npcs[obj].equitems[i]);
              if (datah.items[item].invisible = 0) or (datah.players[player].privileged = 1) then
                equitem(player, datah.npcs[obj].id, PrimitiveGetObject(OTITEM, datah.npcs[obj].equitems[i]));

            end;

          equchanged(datah.npcs[obj].id, player);

        end

      else
        addnouenpc(obj, player);

    end;

end;

procedure updatecontitems(player, container: Cardinal);
var
  pbuf: Array of Byte;
  itemarray: Array of Cardinal;
  tempcard, i, j, item: Cardinal;
  tempword: Word;

begin
  SetLength(itemarray, 0);
  if Length(datah.items[container].contitems) > 0 then
    for i := 0 to Length(datah.items[container].contitems) - 1 do
      begin
        item := PrimitiveGetObject(OTITEM, datah.items[container].contitems[i]);
        if (datah.items[item].invisible = 0) or (datah.players[player].privileged = 1) then
          begin
            SetLength(itemarray, Length(itemarray) + 1);
            itemarray[Length(itemarray) - 1] := item;

          end;

      end;

  if Length(itemarray) = 0 then
    Exit;

  SetLength(pbuf, 6 + Length(itemarray) * 19);
  pbuf[0] := $FE;
  pbuf[1] := $71;
  tempword := swapword(6 + Length(itemarray) * 19);
  Move(tempword, pbuf[2], 2);
  tempword := swapword(Length(itemarray));
  Move(tempword, pbuf[4], 2);
  j := 0;
  for i := 0 to Length(itemarray) - 1 do
    begin
      tempcard := swapdword(datah.items[itemarray[i]].id or $40000000);
      Move(tempcard, pbuf[6 + j * 19], 4);
      tempword := swapword(datah.items[itemarray[i]].graphic);
      Move(tempword, pbuf[10 + j * 19], 2);
      pbuf[12 + j * 19] := $00;
      tempword := 0;
      if (datah.items[itemarray[i]].itemtype > ITIDSOCREATEFOOD) or
         (datah.items[itemarray[i]].itemtype < ITIDSOLIGHTSOURCE) then
        tempword := swapword(datah.items[itemarray[i]].amount)

      else
        case datah.items[itemarray[i]].itemtype of
          ITIDSOLIGHTSOURCE: tempword := swapword(SIDLIGHTSOURCE);
          ITIDSODARKSOURCE: tempword := swapword(SIDDARKSOURCE);
          ITIDSOGREATLIGHT: tempword := swapword(SIDGREATLIGHT);
          ITIDSOLIGHT: tempword := swapword(SIDLIGHT);
          ITIDSOHEALING: tempword := swapword(SIDHEALING);
          ITIDSOFIREBALL: tempword := swapword(SIDFIREBALL);
          ITIDSOCREATEFOOD: tempword := swapword(SIDCREATEFOOD);

        end;

      Move(tempword, pbuf[13 + j * 19], 2);
      tempword := swapword(datah.items[itemarray[i]].x);
      Move(tempword, pbuf[15 + j * 19], 2);
      tempword := swapword(datah.items[itemarray[i]].y);
      Move(tempword, pbuf[17 + j * 19], 2);
      tempcard := swapdword(datah.items[container].id or $40000000);
      Move(tempcard, pbuf[19 + j * 19], 4);
      tempword := swapword(datah.items[itemarray[i]].color);
      Move(tempword, pbuf[23 + j * 19], 2);
      Inc(j);

    end;

  try
    datah.players[player].client.Send(Addr(pbuf[0]), 6 + Length(itemarray) * 19);
    datah.players[player].client.Flush;

  except
    try
      datah.players[player].client.Shutdown(0);

    finally
    end;

  end;

end;

procedure insitem(player, itemid: Cardinal);
var
  pbuf: Array of Byte;
  tempcard, item: Cardinal;
  tempword: Word;
  i: Integer;

begin
  item := PrimitiveGetObject(OTITEM, itemid);
  if PrimitiveGetEquipmentByLayer(OTPLAYER, player, LBACKPACK) <>
     PrimitiveGetMainContainer(item) then
    begin
      while datah.players[player].ococ do
        Sleep(1);

      datah.players[player].ococ := True;
      if Length(datah.players[player].openconts) > 0 then
        for i := 0 to Length(datah.players[player].openconts) - 1 do
          if (i <> Length(datah.players[player].openconts) - 1)  and
             (datah.items[item].contained = datah.items[datah.players[player].openconts[i]].id) then
            Break

          else if (i = Length(datah.players[player].openconts) - 1)  and
                  (datah.items[item].contained <> datah.items[datah.players[player].openconts[i]].id) then
            begin
              datah.players[player].ococ := False;
              Exit;

            end;

      datah.players[player].ococ := False;

    end;

  SetLength(pbuf, 23);
  pbuf[0] := $FE;
  pbuf[1] := $43;
  pbuf[2] := $00;
  pbuf[3] := $17;
  tempcard := swapdword(itemid or $40000000);
  Move(tempcard, pbuf[4], 4);
  tempword := swapword(datah.items[item].graphic);
  Move(tempword, pbuf[8], 2);
  pbuf[10] := $00;
  tempword := 0;
  if (datah.items[item].itemtype > ITIDSOCREATEFOOD) or
     (datah.items[item].itemtype < ITIDSOLIGHTSOURCE) then
    tempword := swapword(datah.items[item].amount)

  else
    case datah.items[item].itemtype of
      ITIDSOLIGHTSOURCE: tempword := swapword(SIDLIGHTSOURCE);
      ITIDSODARKSOURCE: tempword := swapword(SIDDARKSOURCE);
      ITIDSOGREATLIGHT: tempword := swapword(SIDGREATLIGHT);
      ITIDSOLIGHT: tempword := swapword(SIDLIGHT);
      ITIDSOHEALING: tempword := swapword(SIDHEALING);
      ITIDSOFIREBALL: tempword := swapword(SIDFIREBALL);
      ITIDSOCREATEFOOD: tempword := swapword(SIDCREATEFOOD);

    end;

  Move(tempword, pbuf[11], 2);
  tempword := swapword(datah.items[item].x);
  Move(tempword, pbuf[13], 2);
  tempword := swapword(datah.items[item].y);
  Move(tempword, pbuf[15], 2);
  tempcard := swapdword(datah.items[item].contained or $40000000);
  Move(tempcard, pbuf[17], 4);
  tempword := swapword(datah.items[item].color);
  Move(tempword, pbuf[21], 2);
  try
    datah.players[player].client.Send(Addr(pbuf[0]), 23);
    datah.players[player].client.Flush;

  except
    try
      datah.players[player].client.Shutdown(0);

    finally
    end;

  end;

end;

procedure stack(player, item1, item2: Cardinal);
var
 amount1, amount2: Word;
 i: Cardinal;
 objarray: TPrimitiveObjectArray;

begin
  SetLength(objarray, 0);
  if (((datah.items[item1].invisible = 1) and (datah.players[player].privileged = 0)) or
     ((PrimitiveGetMainContainer(item1) = 0) and (datah.items[item1].equipped > 0) and (datah.items[item1].equipped <> datah.players[player].id) and not
     PrimitiveIsUnhidden(CheckObjectType(datah.items[item1].equipped),
     PrimitiveGetObject(CheckObjectType(datah.items[item1].equipped), datah.items[item1].equipped)) and
     (datah.players[player].privileged = 0)) or
     ((PrimitiveGetMainContainer(item1) > 0) and (datah.items[PrimitiveGetMainContainer(item1)].equipped > 0) and (datah.items[PrimitiveGetMainContainer(item1)].equipped <> datah.players[player].id) and not
     PrimitiveIsUnhidden(CheckObjectType(datah.items[PrimitiveGetMainContainer(item1)].equipped),
     PrimitiveGetObject(CheckObjectType(datah.items[PrimitiveGetMainContainer(item1)].equipped), datah.items[PrimitiveGetMainContainer(item1)].equipped)) and
     (datah.players[player].privileged = 0))) or
     (((datah.items[item2].invisible = 1) and (datah.players[player].privileged = 0)) or
     ((PrimitiveGetMainContainer(item2) = 0) and (datah.items[item2].equipped > 0) and (datah.items[item2].equipped <> datah.players[player].id) and not
     PrimitiveIsUnhidden(CheckObjectType(datah.items[item2].equipped),
     PrimitiveGetObject(CheckObjectType(datah.items[item2].equipped), datah.items[item2].equipped)) and
     (datah.players[player].privileged = 0)) or
     ((PrimitiveGetMainContainer(item2) > 0) and (datah.items[PrimitiveGetMainContainer(item2)].equipped > 0) and (datah.items[PrimitiveGetMainContainer(item2)].equipped <> datah.players[player].id) and not
     PrimitiveIsUnhidden(CheckObjectType(datah.items[PrimitiveGetMainContainer(item2)].equipped),
     PrimitiveGetObject(CheckObjectType(datah.items[PrimitiveGetMainContainer(item2)].equipped), datah.items[PrimitiveGetMainContainer(item2)].equipped)) and
     (datah.players[player].privileged = 0))) then
    Exit;

  if item1 <> datah.players[player].dragitem then
    begin
      datah.players[player].dragging := False;
      datah.players[player].dragitem := 0;
      datah.players[player].dragamt := 0;
      Exit;

    end;

  if datah.items[item1].id <> datah.items[item2].id then
    begin
      if datah.players[player].dragamt = 0 then
        begin
          amount1 := 1;
          amount2 := 1;

        end

      else
        begin
          amount1 := datah.players[player].dragamt;
          amount2 := datah.items[item2].amount;

        end;

      datah.items[item2].amount := amount1 + amount2;
      if (amount1 = datah.items[item1].amount) or (amount1 = 0) then
        PrimitiveDeleteObject(OTITEM, item1)

      else
        begin
          datah.items[item1].amount := datah.items[item1].amount - amount1;
          objarray := PrimitiveListObjectsNearLocation(OTPLAYER, datah.players[player].x, datah.players[player].y,
                                                       16);
          if Length(objarray) > 0 then
            for i := 0 to Length(objarray) - 1 do
              if datah.players[objarray[i]].online then
                begin
                  if (datah.items[item1].contained = 0) and ((datah.items[item1].invisible = 0)
                     or (datah.players[objarray[i]].privileged = 1)) then
                    updateobj(OTITEM, objarray[i], item1)

                  else if (datah.items[item1].contained > 0) and ((datah.items[item1].invisible
                          = 0) or (datah.players[objarray[i]].privileged = 1)) then
                    insitem(objarray[i], datah.items[item1].id);

                  end;

        end;

      startitemscript(datah.items[item2].scriptname, CardToStr(item2), IntToStr(ETSTACKED),
                      '', '', IntToStr(amount1));

    end;

  datah.items[item1].occupied := False;
  datah.items[item1].dragger := 0;
  datah.players[player].dragging := False;
  datah.players[player].dragitem := 0;
  datah.players[player].dragamt := 0;
  objarray := PrimitiveListObjectsNearLocation(OTPLAYER, datah.players[player].x, datah.players[player].y,
                                               16);
  if Length(objarray) > 0 then
    for i := 0 to Length(objarray) - 1 do
      if datah.players[objarray[i]].online then
        begin
          if (datah.items[item2].contained = 0) and ((datah.items[item2].invisible = 0)
             or (datah.players[objarray[i]].privileged = 1)) then
            updateobj(OTITEM, objarray[i], item2)

          else if (datah.items[item2].contained > 0) and ((datah.items[item2].invisible = 0)
                  or (datah.players[objarray[i]].privileged = 1)) then
            insitem(objarray[i], datah.items[item2].id);

        end;

end;

procedure TForm1.WSocketServer1ClientCreate(Sender: TObject;
  Client: TWSocketClient);
begin
  Client.ThreadDetach;
  Client.MultiThreaded := True;
  (Client as tclient).clientthread := tclientthread.Create(True);
  (Client as tclient).clientthread.FreeOnTerminate := True;
  (Client as tclient).clientthread.wsocket := Client;
  (Client as tclient).clientthread.Suspended := False;
  while not (Client as tclient).clientthread.threadattached do
    Sleep(1);

end;

procedure tclientthread.Execute;
begin
  wsocket.ThreadAttach;
  threadattached := True;
  Sleep(100);
  wsocket.MessageLoop;
  Sleep(1);
  wsocket.ThreadDetach;

end;

function getplayersat2dpos(x, y: Word): TPrimitiveObjectArray;
begin
  playersat2dposlock.Acquire;
  Result := playersat2dpos[x, y];
  playersat2dposlock.Release;

end;

procedure addplayerto2dpos(player: Cardinal; x, y: Word);
var
  index: Cardinal;
  temparray: TPrimitiveObjectArray;

begin
  playersat2dposlock.Acquire;
  temparray := getplayersat2dpos(x, y);
  index := Length(temparray);
  SetLength(temparray, index + 1);
  temparray[index] := player;
  playersat2dpos[x, y] := temparray;
  playersat2dposlock.Release;

end;

procedure remplayerfrom2dpos(player: Cardinal; x, y: Word);
var
  i: Cardinal;
  temparray1, temparray2: TPrimitiveObjectArray;

begin
  playersat2dposlock.Acquire;
  temparray1 := getplayersat2dpos(x, y);
  SetLength(temparray2, 0);
  if Length(temparray1) > 0 then
    for i := 0 to Length(temparray1) - 1 do
      if temparray1[i] <> player then
        begin
          SetLength(temparray2, Length(temparray2) + 1);
          temparray2[Length(temparray2) - 1] := temparray1[i];

        end;

  playersat2dpos[x, y] := temparray2;
  playersat2dposlock.Release;

end;

function getnpcsat2dpos(x, y: Word): TPrimitiveObjectArray;
begin
  npcsat2dposlock.Acquire;
  Result := npcsat2dpos[x, y];
  npcsat2dposlock.Release;

end;

procedure addnpcto2dpos(npc: Cardinal; x, y: Word);
var
  index: Cardinal;
  temparray: TPrimitiveObjectArray;

begin
  npcsat2dposlock.Acquire;
  temparray := getnpcsat2dpos(x, y);
  index := Length(temparray);
  SetLength(temparray, index + 1);
  temparray[index] := npc;
  npcsat2dpos[x, y] := temparray;
  npcsat2dposlock.Release;

end;

procedure remnpcfrom2dpos(npc: Cardinal; x, y: Word);
var
  i: Cardinal;
  temparray1, temparray2: TPrimitiveObjectArray;

begin
  npcsat2dposlock.Acquire;
  temparray1 := getnpcsat2dpos(x, y);
  SetLength(temparray2, 0);
  if Length(temparray1) > 0 then
    for i := 0 to Length(temparray1) - 1 do
      if temparray1[i] <> npc then
        begin
          SetLength(temparray2, Length(temparray2) + 1);
          temparray2[Length(temparray2) - 1] := temparray1[i];

        end;

  npcsat2dpos[x, y] := temparray2;
  npcsat2dposlock.Release;

end;

function getitemsat2dpos(x, y: Word): TPrimitiveObjectArray;
begin
  itemsat2dposlock.Acquire;
  Result := itemsat2dpos[x, y];
  itemsat2dposlock.Release;

end;

procedure additemto2dpos(item: Cardinal; x, y: Word);
var
  index: Cardinal;
  temparray: TPrimitiveObjectArray;

begin
  itemsat2dposlock.Acquire;
  temparray := getitemsat2dpos(x, y);
  index := Length(temparray);
  SetLength(temparray, index + 1);
  temparray[index] := item;
  itemsat2dpos[x, y] := temparray;
  itemsat2dposlock.Release;

end;

procedure remitemfrom2dpos(item: Cardinal; x, y: Word);
var
  i: Cardinal;
  temparray1, temparray2: TPrimitiveObjectArray;

begin
  itemsat2dposlock.Acquire;
  temparray1 := getitemsat2dpos(x, y);
  SetLength(temparray2, 0);
  if Length(temparray1) > 0 then
    for i := 0 to Length(temparray1) - 1 do
      if temparray1[i] <> item then
        begin
          SetLength(temparray2, Length(temparray2) + 1);
          temparray2[Length(temparray2) - 1] := temparray1[i];

        end;

  itemsat2dpos[x, y] := temparray2;
  itemsat2dposlock.Release;

end;

procedure denydropping(player, item: Cardinal);
var
  objtype: Integer;

begin
  if (datah.items[item].invisible = 1) and (datah.players[player].privileged = 0) then
    Exit;

  if datah.items[item].equipped > 0 then
    begin
      objtype := CheckObjectType(datah.items[item].equipped);
      equitem(PrimitiveGetObject(objtype, datah.items[item].equipped), datah.items[item].equipped,
              item);
      equchanged(datah.items[item].equipped, player);

    end

  else if datah.items[item].contained > 0 then
    insitem(player, datah.items[item].id)

  else
    updateobj(OTITEM, player, item);

end;

procedure denydragging(player: Cardinal);
var
  pbuf: Array of Byte;

begin
  SetLength(pbuf, 4);
  pbuf[0] := $FE;
  pbuf[1] := $45;
  pbuf[2] := $00;
  pbuf[3] := $04;
  try
    datah.players[player].client.Send(Addr(pbuf[0]), 4);
    datah.players[player].client.Flush;

  except
    try
      datah.players[player].client.Shutdown(0);

    finally
    end;

  end;

end;

procedure denywalking(player: Cardinal; denseq: Byte; oldx, oldy: Word; oldz: ShortInt);
var
  pbuf: Array of Byte;
  tempword: Word;

begin
  remplayerfrom2dpos(player, datah.players[player].x, datah.players[player].y);
  datah.players[player].x := oldx;
  datah.players[player].y := oldy;
  addplayerto2dpos(player, datah.players[player].x, datah.players[player].y);
  datah.players[player].z := oldz;
  SetLength(pbuf, 11);
  pbuf[0] := $FE;
  pbuf[1] := $3F;
  pbuf[2] := $00;
  pbuf[3] := $0B;
  pbuf[4] := denseq;
  tempword := swapword(oldx);
  Move(tempword, pbuf[5], 2);
  tempword := swapword(oldy);
  Move(tempword, pbuf[7], 2);
  pbuf[9] := datah.players[player].facing;
  pbuf[10] := oldz;
  try
    datah.players[player].client.Send(Addr(pbuf[0]), 11);
    datah.players[player].client.Flush;

  except
    try
      datah.players[player].client.Shutdown(0);

    finally
    end;

  end;

end;

procedure addbbpost(subj, text: String);
var
  index, i: Cardinal;
  objarray: TPrimitiveObjectArray;

begin
  bbpostslock.Acquire;
  index := Length(bbposts);
  SetLength(bbposts, index + 1);
  bbposts[index].subj := subj;
  bbposts[index].text := text;
  objarray := PrimitiveListObjects(OTPLAYER);
  if Length(objarray) > 0 then
    for i := 0 to Length(objarray) - 1 do
      if datah.players[objarray[i]].online then
        sendbbpostlistsubj(objarray[i], index);

  bbpostslock.Release;

end;

procedure sendbbpostlistsubj(player, bbpost: Cardinal);
var
  pbuf: Array of Byte;
  tempword: Word;
  tempdword: DWord;
  tempstr: String;

begin
  bbpostslock.Acquire;
  SetLength(pbuf, 9 + Length(bbposts[bbpost].subj));
  pbuf[0] := $FE;
  pbuf[1] := $B4;
  tempword := swapword(9 + Length(bbposts[bbpost].subj));
  Move(tempword, pbuf[2], 2);
  tempdword := swapdword(bbpost);
  Move(tempdword, pbuf[4], 4);
  tempstr := bbposts[bbpost].subj;
  Move(tempstr[1], pbuf[8], Length(tempstr));
  pbuf[Length(pbuf) - 1] := $00;
  try
    datah.players[player].client.Send(Addr(pbuf[0]), 9 + Length(bbposts[bbpost].subj));
    datah.players[player].client.Flush;

  except
    try
      datah.players[player].client.Shutdown(0);

    finally
    end;

  end;
  bbpostslock.Release

end;

procedure sendbbpost(player, bbpost: Cardinal);
var
  pbuf: Array of Byte;
  tempword: Word;
  tempstr: String;

begin
  bbpostslock.Acquire;
  SetLength(pbuf, 6 + Length(bbposts[bbpost].subj) + Length(bbposts[bbpost].text));
  pbuf[0] := $FE;
  pbuf[1] := $B5;
  tempword := swapword(6 + Length(bbposts[bbpost].subj) + Length(bbposts[bbpost].text));
  Move(tempword, pbuf[2], 2);
  tempstr := bbposts[bbpost].subj + #13 + bbposts[bbpost].text;
  Move(tempstr[1], pbuf[4], Length(tempstr));
  pbuf[Length(pbuf) - 1] := $00;
  try
    datah.players[player].client.Send(Addr(pbuf[0]), 6 + Length(bbposts[bbpost].subj) + Length(bbposts[bbpost].text));
    datah.players[player].client.Flush;

  except
    try
      datah.players[player].client.Shutdown(0);

    finally
    end;

  end;
  bbpostslock.Release;

end;

procedure updateobjao(objtype: Integer; obj: Cardinal; updself: Boolean = True);
var
  objarray: TPrimitiveObjectArray;
  i: Cardinal;

begin
  objarray := PrimitiveListObjectsNearLocation(OTPLAYER, PrimitiveGetObjectXMain(objtype, obj),
                                               PrimitiveGetObjectYMain(objtype, obj), 16);
  if Length(objarray) > 0 then
    for i := 0 to Length(objarray) - 1 do
      if datah.players[objarray[i]].online then
        if (objtype = OTITEM) and (datah.items[obj].contained > 0) and
           ((datah.items[obj].invisible = 0) or
           (datah.players[objarray[i]].privileged = 1)) and
           ((datah.items[PrimitiveGetMainContainer(obj)].equipped = 0) or
           PrimitiveIsUnhidden(CheckObjectType(datah.items[PrimitiveGetMainContainer(obj)].equipped), PrimitiveGetObject(CheckObjectType(datah.items[PrimitiveGetMainContainer(obj)].equipped),
                               datah.items[PrimitiveGetMainContainer(obj)].equipped)) or
           (datah.players[objarray[i]].privileged = 1)) then
          insitem(objarray[i], datah.items[obj].id)

        else if (objtype = OTITEM) and (datah.items[obj].equipped > 0) and
                ((datah.items[obj].invisible = 0) or
                (datah.players[objarray[i]].privileged = 1)) and
                (PrimitiveIsUnhidden(CheckObjectType(datah.items[PrimitiveGetMainContainer(obj)].equipped), PrimitiveGetObject(CheckObjectType(datah.items[obj].equipped), datah.items[obj].equipped)) or
                (datah.players[objarray[i]].privileged = 1)) then
          begin
            equitem(objarray[i], datah.items[obj].equipped, obj);
            equchanged(datah.items[obj].equipped, objarray[i]);

          end

        else if (objtype = OTITEM) and (datah.items[obj].contained = 0) and
                (datah.items[obj].equipped = 0) and ((datah.items[obj].invisible = 0) or
                (datah.players[objarray[i]].privileged = 1)) then
          updateobj(objtype, objarray[i], obj)

        else if (objtype = OTNPC) and ((datah.npcs[obj].hidden = 0) or
                (datah.players[objarray[i]].privileged = 1)) then
          begin
            updateobj(objtype, objarray[i], obj);
            updateequ(objtype, objarray[i], obj);
            updateobj(objtype, objarray[i], obj);

          end

        else if (objtype = OTPLAYER) and
                (datah.players[objarray[i]].id <> datah.players[obj].id) and
                ((datah.players[obj].hidden = 0) or
                (datah.players[objarray[i]].privileged = 1)) then
          begin
            updateobj(objtype, objarray[i], obj);
            updateequ(objtype, objarray[i], obj);
            updateobj(objtype, objarray[i], obj);

          end

        else if (objtype = OTPLAYER) and updself and
                (datah.players[objarray[i]].id = datah.players[obj].id) then
          begin
            updateplayer(obj);
            updateequ(objtype, objarray[i], obj);

          end;

end;

procedure updatestatusao(objtype: Integer; obj: Cardinal);
var
  objarray: TPrimitiveObjectArray;
  i, objid: Cardinal;

begin
  SetLength(objarray, 0);
  if objtype = OTPLAYER then
    objid := datah.players[obj].id

  else if objtype = OTNPC then
    objid := datah.npcs[obj].id

  else
    Exit;

  objarray := PrimitiveListObjectsNearLocation(OTPLAYER, PrimitiveGetObjectXMain(objtype, obj),
                                               PrimitiveGetObjectYMain(objtype, obj), 16);
  if Length(objarray) > 0 then
    for i := 0 to Length(objarray) - 1 do
      if datah.players[objarray[i]].online then
        if (objtype = OTNPC) and ((datah.npcs[obj].hidden = 0) or
           (datah.players[objarray[i]].privileged = 1)) then
          showstatus(objarray[i], objid)

        else if (objtype = OTPLAYER) and
                (datah.players[objarray[i]].id <> datah.players[obj].id) and
                ((datah.players[obj].hidden = 0) or
                (datah.players[objarray[i]].privileged = 1)) then
          showstatus(objarray[i], objid)

        else if (objtype = OTPLAYER) and
                (datah.players[objarray[i]].id = datah.players[obj].id) then
          showstatus(objarray[i], objid);

end;

procedure delobjao(objtype: Integer; obj: Cardinal);
var
  objarray: TPrimitiveObjectArray;
  i: Cardinal;

begin
  objarray := PrimitiveListObjectsNearLocation(OTPLAYER, PrimitiveGetObjectXMain(objtype, obj),
                                               PrimitiveGetObjectYMain(objtype, obj), 16);
  if Length(objarray) > 0 then
    for i := 0 to Length(objarray) - 1 do
      if datah.players[objarray[i]].online then
        if (objtype = OTITEM) and (datah.items[obj].equipped > 0) and
           ((datah.items[obj].invisible = 0) or
           (datah.players[objarray[i]].privileged = 1)) and
           (PrimitiveIsUnhidden(CheckObjectType(datah.items[PrimitiveGetMainContainer(obj)].equipped), PrimitiveGetObject(CheckObjectType(datah.items[obj].equipped), datah.items[obj].equipped)) or
           (datah.players[objarray[i]].privileged = 1)) then
          begin
            delobj(objtype, objarray[i], obj);
            equchanged(datah.items[obj].equipped, objarray[i]);

          end

        else if (objtype = OTITEM) and (datah.items[obj].equipped = 0) and ((datah.items[obj].invisible = 0) or
                (datah.players[objarray[i]].privileged = 1)) then
          delobj(objtype, objarray[i], obj)

        else if (objtype = OTNPC) and ((datah.npcs[obj].hidden = 0) or
                (datah.players[objarray[i]].privileged = 1)) then
          delobj(objtype, objarray[i], obj)

        else if (objtype = OTPLAYER) and (objarray[i] <> obj) and
                ((datah.players[obj].hidden = 0) or
                (datah.players[objarray[i]].privileged = 1)) then
          delobj(objtype, objarray[i], obj);

end;

function gettype(objtype: Integer; typeid: Cardinal): Cardinal;
var
  i, t: Cardinal;

begin
  t := 0;
  if objtype = OTITEM then
    if Length(itemtypes) > 1 then
      for i := 1 to Length(itemtypes) - 1 do
        if itemtypes[i].id = typeid then
          begin
            t := i;
            Break;

          end;

  if objtype = OTNPC then
    if Length(npctypes) > 1 then
      for i := 1 to Length(npctypes) - 1 do
        if npctypes[i].id = typeid then
          begin
            t := i;
            Break;

          end;

  Result := t;

end;

procedure addnouenpc(nouenpc, player: Cardinal);
begin
  if not datah.players[player].online then
    Exit;

  if not isnouenpc(nouenpc, player) then
    begin
      while datah.players[player].nouenpcsoc = True do
        Sleep(1);

      datah.players[player].nouenpcsoc := True;
      datah.players[player].setnouenpcslen(Length(datah.players[player].nouenpcs) + 1);
      datah.players[player].nouenpcs[Length(datah.players[player].nouenpcs) - 1] := nouenpc;
      datah.players[player].nouenpcsoc := False;

    end;

end;

procedure remnouenpc(nouenpc, player: Cardinal);
var
  temparray: TPrimitiveObjectArray;
  i: Cardinal;

begin
  if not datah.players[player].online then
    Exit;

  if not isnouenpc(nouenpc, player) then
    Exit;

  if Length(datah.players[player].nouenpcs) > 0 then
    begin
      while datah.players[player].nouenpcsoc = True do
        Sleep(1);

      datah.players[player].nouenpcsoc := True;
      SetLength(temparray, 0);
      for i := 0 to Length(datah.players[player].nouenpcs) - 1 do
        if datah.players[player].nouenpcs[i] <> nouenpc then
          begin
            SetLength(temparray, Length(temparray) + 1);
            temparray[Length(temparray) - 1] := datah.players[player].nouenpcs[i];

          end;

      datah.players[player].setnouenpcslen(Length(temparray));
      datah.players[player].nouenpcs := temparray;
      datah.players[player].nouenpcsoc := False;

    end;

end;

function isnouenpc(npciq, player: Cardinal): Boolean;
var
  i: Cardinal;

begin
  if not datah.players[player].online then
    begin
      Result := False;
      Exit;

    end;

  if Length(datah.players[player].nouenpcs) > 0 then
    for i := 0 to Length(datah.players[player].nouenpcs) - 1 do
      if datah.players[player].nouenpcs[i] = npciq then
        begin
          Result := True;
          Exit;

        end;

  Result := False;

end;

procedure addnoueplayer(noueplayer, player: Cardinal);
begin
  if not datah.players[player].online then
    Exit;

  if not isnoueplayer(noueplayer, player) then
    begin
      while datah.players[player].noueplayersoc = True do
        Sleep(1);

      datah.players[player].noueplayersoc := True;
      datah.players[player].setnoueplayerslen(Length(datah.players[player].noueplayers) + 1);
      datah.players[player].noueplayers[Length(datah.players[player].noueplayers) - 1] := noueplayer;
      datah.players[player].noueplayersoc := False;

    end;

end;

procedure remnoueplayer(noueplayer, player: Cardinal);
var
  temparray: TPrimitiveObjectArray;
  i: Cardinal;

begin
  if not datah.players[player].online then
    Exit;

  if not isnoueplayer(noueplayer, player) then
    Exit;

  if Length(datah.players[player].noueplayers) > 0 then
    begin
      while datah.players[player].noueplayersoc = True do
        Sleep(1);

      datah.players[player].noueplayersoc := True;
      SetLength(temparray, 0);
      for i := 0 to Length(datah.players[player].noueplayers) - 1 do
        if datah.players[player].noueplayers[i] <> noueplayer then
          begin
            SetLength(temparray, Length(temparray) + 1);
            temparray[Length(temparray) - 1] := datah.players[player].noueplayers[i];

          end;

      datah.players[player].setnoueplayerslen(Length(temparray));
      datah.players[player].noueplayers := temparray;
      datah.players[player].noueplayersoc := False;

    end;

end;

function isnoueplayer(playeriq, player: Cardinal): Boolean;
var
  i: Cardinal;

begin
  if not datah.players[player].online then
    begin
      Result := False;
      Exit;

    end;

  if Length(datah.players[player].noueplayers) > 0 then
    for i := 0 to Length(datah.players[player].noueplayers) - 1 do
      if datah.players[player].noueplayers[i] = playeriq then
        begin
          Result := True;
          Exit;

        end;

  Result := False;

end;

procedure addnouitem(nouitem, player: Cardinal);
begin
  if not datah.players[player].online then
    Exit;

  if not isnouitem(nouitem, player) then
    begin
      while datah.players[player].nouitemsoc = True do
        Sleep(1);

      datah.players[player].nouitemsoc := True;
      datah.players[player].setnouitemslen(Length(datah.players[player].nouitems) + 1);
      datah.players[player].nouitems[Length(datah.players[player].nouitems) - 1] := nouitem;
      datah.players[player].nouitemsoc := False;

    end;

end;

procedure remnouitem(nouitem, player: Cardinal);
var
  temparray: TPrimitiveObjectArray;
  i: Cardinal;

begin
  if not datah.players[player].online then
    Exit;

  if not isnouitem(nouitem, player) then
    Exit;

  if Length(datah.players[player].nouitems) > 0 then
    begin
      while datah.players[player].nouitemsoc = True do
        Sleep(1);

      datah.players[player].nouitemsoc := True;
      SetLength(temparray, 0);
      for i := 0 to Length(datah.players[player].nouitems) - 1 do
        if datah.players[player].nouitems[i] <> nouitem then
          begin
            SetLength(temparray, Length(temparray) + 1);
            temparray[Length(temparray) - 1] := datah.players[player].nouitems[i];

          end;

      datah.players[player].setnouitemslen(Length(temparray));
      datah.players[player].nouitems := temparray;
      datah.players[player].nouitemsoc := False;

    end;

end;

function isnouitem(itemiq, player: Cardinal): Boolean;
var
  i: Cardinal;

begin
  if not datah.players[player].online then
    begin
      Result := False;
      Exit;

    end;

  if Length(datah.players[player].nouitems) > 0 then
    for i := 0 to Length(datah.players[player].nouitems) - 1 do
      if datah.players[player].nouitems[i] = itemiq then
        begin
          Result := True;
          Exit;

        end;

  Result := False;

end;

procedure finishlogout(player: Cardinal);
var
  objarray: TPrimitiveObjectArray;
  i: Cardinal;

begin
  SetLength(objarray, 0);
  if not IsServerActive then
    Exit;

  objarray := PrimitiveListObjectsNearLocation(OTPLAYER, datah.players[player].x,
                                               datah.players[player].y, 16);
  if Length(objarray) > 0 then
    for i := 0 to Length(objarray) - 1 do
      if datah.players[objarray[i]].online and (player <> objarray[i]) and ((datah.players[player].hidden = 0) or
         (datah.players[objarray[i]].privileged = 1)) then
        delobj(OTPLAYER, objarray[i], player);

  datah.players[player].client := nil;
  datah.players[player].online := False;
  datah.players[player].inreq := False;
  datah.players[player].inreqres := '';
  while datah.players[player].nouenpcsoc do
    Sleep(1);

  datah.players[player].nouenpcsoc := True;
  datah.players[player].setnouenpcslen(0);
  datah.players[player].nouenpcsoc := False;
  while datah.players[player].noueplayersoc do
    Sleep(1);

  datah.players[player].noueplayersoc := True;
  datah.players[player].setnoueplayerslen(0);
  datah.players[player].noueplayersoc := False;
  while datah.players[player].nouitemsoc do
    Sleep(1);

  datah.players[player].nouitemsoc := True;
  datah.players[player].setnouitemslen(0);
  datah.players[player].nouitemsoc := False;
  while datah.players[player].ococ do
    Sleep(1);

  datah.players[player].ococ := True;
  datah.players[player].setopencontslen(0);
  datah.players[player].ococ := False;
  while bgthread.isprinting do
    Sleep(20);

  printsm(10, 'Player logged out: '+ datah.players[player].name);

end;

procedure printsm(ms: Cardinal; smstr: String);
begin
  bgthread.psmstrslock.Acquire;
  bgthread.printsmstrs.Add(smstr);
  bgthread.psmstrslock.Release;
  if ms > 0 then
    Sleep(ms);

end;

procedure printatlsm(ms: Cardinal; atlsmstr: String);
begin
  bgthread.patlsmstrslock.Acquire;
  bgthread.printatlsmstrs.Add(atlsmstr);
  bgthread.patlsmstrslock.Release;
  if ms > 0 then
    Sleep(ms);

end;

procedure kickop;
var
  playerarray: TPrimitiveObjectArray;
  i: Integer;

begin
  SetLength(playerarray, 0);
  if iskickingop then
    Exit;

  kickingoplock.Acquire;
  kickingop := True;
  kickingoplock.Release;
  printsm(10, 'Kicking online players...');
  playerarray := PrimitiveListOnlinePlayers;
  if Length(playerarray) > 0 then
    for i := 0 to Length(playerarray) - 1 do
      begin
        PrimitiveKick(playerarray[i]);
        while datah.players[playerarray[i]].online do
          Sleep(100);

      end;

  printsm(10, '...done.');
  kickingoplock.Acquire;
  kickingop := False;
  kickingoplock.Release;

end;

procedure listop;
var
  playerarray: TPrimitiveObjectArray;
  tempstr: String;
  i: Integer;

begin
  SetLength(playerarray, 0);
  if islistingop then
    Exit;

  listingoplock.Acquire;
  listingop := True;
  listingoplock.Release;
  playerarray := PrimitiveListOnlinePlayers;
  tempstr := 'Online players ('+ IntToStr(Length(playerarray)) +'): ';
  if Length(playerarray) > 0 then
    for i := 0 to Length(playerarray) - 1 do
      if i = Length(playerarray) - 1 then
        tempstr := tempstr + datah.players[playerarray[i]].name +' (ID: '+ IntToStr(datah.players[playerarray[i]].id) +').'

      else
        tempstr := tempstr + datah.players[playerarray[i]].name +' (ID: '+ IntToStr(datah.players[playerarray[i]].id) +'), ';

  printsm(10, tempstr);
  listingoplock.Acquire;
  listingop := False;
  listingoplock.Release;

end;

procedure TForm1.Button3Click(Sender: TObject);
var
  threadid: Cardinal;

begin
  if isshuttingdown then
    ShowMessage('Server is shutting down.')

  else if issaving then
    ShowMessage('Server is already saving world state.')

  else if isstarting then
    ShowMessage('Server is starting.')

  else
    if IsServerActive then
      BeginThread(nil, 0, Addr(savedata), nil, 0, threadid)

    else
      ShowMessage('Server is not active.');

end;

procedure TForm1.Button4Click(Sender: TObject);
var
  threadid: Cardinal;

begin
  if isshuttingdown then
    ShowMessage('Server is shutting down.')

  else if issaving then
    ShowMessage('Server is saving world state.')

  else if isstarting then
    ShowMessage('Server is starting.')

  else
    if IsServerActive then
      BeginThread(nil, 0, Addr(kickop), nil, 0, threadid)

    else
      ShowMessage('Server is not active.');

end;

procedure TForm1.Button5Click(Sender: TObject);
var
  threadid: Cardinal;

begin
  if isshuttingdown then
    ShowMessage('Server is shutting down.')

  else if issaving then
    ShowMessage('Server is saving world state.')

  else if isstarting then
    ShowMessage('Server is starting.')

  else
    if IsServerActive then
      BeginThread(nil, 0, Addr(listop), nil, 0, threadid)

    else
      ShowMessage('Server is not active.');

end;

function addsthread(handle: Integer): Integer;
var
  i, index: Integer;

begin
  sthreadslock.Acquire;
  index := Length(sthreads);
  if Length(sthreads) > 0 then
    for i := 0 to Length(sthreads) - 1 do
      if sthreads[i] = 0 then
        begin
          index := i;
          Break;

        end;

  if index = Length(sthreads) then
    SetLength(sthreads, index + 1);

  sthreads[index] := handle;
  sthreadslock.Release;
  Result := index;

end;

procedure remsthread(index: Integer);
begin
  sthreadslock.Acquire;
  sthreads[index] := 0;
  if index = Length(sthreads) - 1 then
    SetLength(sthreads, Length(sthreads) - 1);
    
  sthreadslock.Release;

end;

procedure terminatesthreads;
var
  i: Integer;

begin
  sthreadslock.Acquire;
  if Length(sthreads) > 0 then
    for i := 0 to Length(sthreads) - 1 do
      if sthreads[i] <> 0 then
        TerminateThread(sthreads[i], 0);

  sthreadslock.Release;

end;

function addglobalstr(globalstr: String; var sstr: String): Cardinal;
var
  parser: TIfPascalParser;
  errec: TIFParserError;
  p: Cardinal;

begin
  parser := TIfPascalParser.Create;
  parser.SetText(sstr, errec);
  for p := 1 to Length(sstr) do
    begin
      parser.CurrTokenPos := p;
      if parser.CurrTokenID = CSTII_const then
        Break

      else if parser.CurrTokenID = CSTII_var then
        Break

      else if parser.CurrTokenID = CSTII_function then
        Break

      else if parser.CurrTokenID = CSTII_type then
        Break

      else if parser.CurrTokenID = CSTII_begin then
        Break;

    end;

  Insert(globalstr, sstr, p + 1);
  parser.Free;
  Result := p;

end;

function getrealmsgpos(msgpos, globalstrinspos: Cardinal; globalstr: String): Integer;
var
  len: Cardinal;

begin
  len := Length(globalstr);
  if msgpos >= globalstrinspos then
    Result := msgpos - len

  else
    Result := msgpos;

end;

procedure showscripted(erscriptfn: String; erscripterpos: Cardinal);
begin
  showsed := True;
  sseerscriptfn := erscriptfn;
  sseerscripterpos := erscripterpos;

end;

procedure equchanged(objid, player: Cardinal);
var
  pbuf: Array of Byte;
  tempcard: Cardinal;

begin
  SetLength(pbuf, 18);
  pbuf[0] := $FE;
  pbuf[1] := $A8;
  pbuf[2] := $00;
  pbuf[3] := $09;
  tempcard := swapdword(objid);
  Move(tempcard, pbuf[4], 4);
  pbuf[8] := 1;
  pbuf[9] := $FE;
  pbuf[10] := $A8;
  pbuf[11] := $00;
  pbuf[12] := $09;
  Move(tempcard, pbuf[13], 4);
  pbuf[17] := 0;
  try
    datah.players[player].client.Send(Addr(pbuf[0]), 18);
    datah.players[player].client.Flush;

  except
    try
      datah.players[player].client.Shutdown(0);

    finally
    end;

  end;

end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  HttpServer1.Stop;
  if httpconnslock <> nil then
    httpconnslock.Free;  

  bgthread.Terminate;
  serveractivelock.Free;
  startinglock.Free;
  savinglock.Free;
  shuttingdownlock.Free;
  kickingoplock.Free;
  listingoplock.Free;
  sdscriptdonelock.Free;

end;

function isstarting: Boolean;
begin
  startinglock.Acquire;
  Result := starting;
  startinglock.Release;

end;

function issaving: Boolean;
begin
  savinglock.Acquire;
  Result := saving;
  savinglock.Release;

end;

function isshuttingdown: Boolean;
begin
  shuttingdownlock.Acquire;
  Result := shuttingdown;
  shuttingdownlock.Release;

end;

function iskickingop: Boolean;
begin
  kickingoplock.Acquire;
  Result := kickingop;
  kickingoplock.Release;

end;

function islistingop: Boolean;
begin
  listingoplock.Acquire;
  Result := listingop;
  listingoplock.Release;

end;

function issdscriptdone: Boolean;
begin
  sdscriptdonelock.Acquire;
  Result := sdscriptdone;
  sdscriptdonelock.Release;

end;

procedure TForm1.HttpServer1GetDocument(Sender, Client: TObject;
  var Flags: THttpGetFlag);
var
  scriptname: String;
  i: Cardinal;
  screxists, lenchange: Boolean;

begin
  scriptname := Copy((Client as thttpconn).Path, 2, Length((Client as thttpconn).Path) - 1);
  if scriptname = '' then
    Exit;

  screxists := False;
  if Length(httpscripts) > 0 then
    for i := 0 to Length(httpscripts) - 1 do
      if httpscripts[i].name = scriptname then
        begin
          screxists := True;
          Break;

        end;

  if not screxists then
    begin
      if httpservlog then
        printsm(10, 'The script "'+ scriptname +'" (HTTP) does not exist (IP: '+ (Client as thttpconn).PeerAddr +')!')

    end

  else
    begin
      Flags := hgWillSendMySelf;
      httpconnslock.Acquire;
      i := 0;
      lenchange := True;
      if Length(httpconns) > 0 then
        for i := 0 to Length(httpconns) - 1 do
          if httpconns[i] = nil then
            begin
              lenchange := False;
              Break;

            end;

      if lenchange then
        begin
          i := Length(httpconns);
          SetLength(httpconns, Length(httpconns) + 1);

        end;

      httpconns[i] := (Client as thttpconn);
      httpconns[i].lock := TCriticalSection.Create;
      starthttpscript(scriptname, IntToStr(i));
      httpconnslock.Release;

    end;

end;

procedure freelockdelayed(lock: TCriticalSection);
begin
  Sleep(10000);
  lock.Acquire;
  lock.Free;

end;

procedure writehtmlerr(HTTPConnection: Cardinal; HTML: String);
begin
  printsm(10, 'Non-HTTP script called "WriteHTML".');

end;

function queryparamerr(HTTPConnection: Cardinal; Name: String): String;
begin
  printsm(10, 'Non-HTTP script called "QueryParameter".');
  Result := '';

end;

function queryiperr(HTTPConnection: Cardinal): String;
begin
  printsm(10, 'Non-HTTP script called "QueryIP".');
  Result := '';

end;

end.
