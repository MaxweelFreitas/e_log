class Keys {
  static const int esc = 0x1B; // 27
  static const int f1 = 0x70; // 112
  static const int f2 = 0x71; // 113
  static const int f3 = 0x72; // 114
  static const int f4 = 0x73; // 115
  static const int f5 = 0x74; // 116
  static const int f6 = 0x75; // 117
  static const int f7 = 0x76; // 118
  static const int f8 = 0x77; // 119
  static const int f9 = 0x78; // 120
  static const int f10 = 0x79; // 121
  static const int f11 = 0x7A; // 122
  static const int f12 = 0x7B; // 123
  static const int printScreen = 0x2C; // 44
  static const int scrollLock = 0x91; // 145
  static const int pauseBreak = 0x13; // 19
  static const int backtick = 0xC0; // 192
  static const int key1 = 0x31; // 49
  static const int key2 = 0x32; // 50
  static const int key3 = 0x33; // 51
  static const int key4 = 0x34; // 52
  static const int key5 = 0x35; // 53
  static const int key6 = 0x36; // 54
  static const int key7 = 0x37; // 55
  static const int key8 = 0x38; // 56
  static const int key9 = 0x39; // 57
  static const int key0 = 0x30; // 48
  static const int minus = 0xBD; // 189
  static const int equals = 0xBB; // 187
  static const int backspace = 0x08; // 8
  static const int tab = 0x09; // 9
  static const int q = 0x51; // 81
  static const int w = 0x57; // 87
  static const int e = 0x45; // 69
  static const int r = 0x52; // 82
  static const int t = 0x54; // 84
  static const int y = 0x59; // 89
  static const int u = 0x55; // 85
  static const int i = 0x49; // 73
  static const int o = 0x4F; // 79
  static const int p = 0x50; // 80
  static const int openBracket = 0xDB; // 219
  static const int closeBracket = 0xDD; // 221
  static const int backslash = 0xDC; // 220
  static const int capsLock = 0x14; // 20
  static const int a = 0x41; // 65
  static const int s = 0x53; // 83
  static const int d = 0x44; // 68
  static const int f = 0x46; // 70
  static const int g = 0x47; // 71
  static const int h = 0x48; // 72
  static const int j = 0x4A; // 74
  static const int k = 0x4B; // 75
  static const int l = 0x4C; // 76
  static const int cedilha = 0xBA; // 186
  static const int semicolon = 0xBA; // 186
  static const int apostrophe = 0xDE; // 222
  static const int enter = 0x0D; // 13
  static const int leftShift = 0x10; // 16
  static const int z = 0x5A; // 90
  static const int x = 0x58; // 88
  static const int c = 0x43; // 67
  static const int v = 0x56; // 86
  static const int b = 0x42; // 66
  static const int n = 0x4E; // 78
  static const int m = 0x4D; // 77
  static const int comma = 0xBC; // 188
  static const int period = 0xBE; // 190
  static const int slash = 0xBF; // 191
  static const int rightShift = 0x10; // 16
  static const int leftCtrl = 0x11; // 17
  static const int leftAlt = 0x12; // 18
  static const int space = 0x20; // 32
  static const int altGr = 0xE1; // 225
  static const int rightCtrl = 0x11; // 17
  static const int arrowUp = 0x26; // 38
  static const int arrowDown = 0x28; // 40
  static const int arrowLeft = 0x25; // 37
  static const int arrowRight = 0x27; // 39
  static const int insert = 0x2D; // 45
  static const int home = 0x24; // 36
  static const int pageUp = 0x21; // 33
  static const int delete = 0x2E; // 46
  static const int end = 0x23; // 35
  static const int pageDown = 0x22; // 34
  static const int numLock = 0x90; // 144
  static const int numpad0 = 0x60; // 96
  static const int numpad1 = 0x61; // 97
  static const int numpad2 = 0x62; // 98
  static const int numpad3 = 0x63; // 99
  static const int numpad4 = 0x64; // 100
  static const int numpad5 = 0x65; // 101
  static const int numpad6 = 0x66; // 102
  static const int numpad7 = 0x67; // 103
  static const int numpad8 = 0x68; // 104
  static const int numpad9 = 0x69; // 105
  static const int numpadDivide = 0x6F; // 111
  static const int numpadMultiply = 0x6A; // 106
  static const int numpadMinus = 0x6D; // 109
  static const int numpadPlus = 0x6B; // 107
  static const int numpadPeriod = 0x6E; // 110
  static const int numpadEnter = 0x0D; // 13
  static const int menu = 0x5D; // 93
  static const int fn = 0xFF; // 255
  static const int windows = 0x5B; // 91

  Map<String, int> keyMapping = {
    'Keys.esc': Keys.esc,
    'Keys.f1': Keys.f1,
    'Keys.f2': Keys.f2,
    'Keys.f3': Keys.f3,
    'Keys.f4': Keys.f4,
    'Keys.f5': Keys.f5,
    'Keys.f6': Keys.f6,
    'Keys.f7': Keys.f7,
    'Keys.f8': Keys.f8,
    'Keys.f9': Keys.f9,
    'Keys.f10': Keys.f10,
    'Keys.f11': Keys.f11,
    'Keys.f12': Keys.f12,
    'Keys.printScreen': Keys.printScreen,
    'Keys.scrollLock': Keys.scrollLock,
    'Keys.pauseBreak': Keys.pauseBreak,
    'Keys.backtick': Keys.backtick,
    'Keys.key1': Keys.key1,
    'Keys.key2': Keys.key2,
    'Keys.key3': Keys.key3,
    'Keys.key4': Keys.key4,
    'Keys.key5': Keys.key5,
    'Keys.key6': Keys.key6,
    'Keys.key7': Keys.key7,
    'Keys.key8': Keys.key8,
    'Keys.key9': Keys.key9,
    'Keys.key0': Keys.key0,
    'Keys.minus': Keys.minus,
    'Keys.equals': Keys.equals,
    'Keys.backspace': Keys.backspace,
    'Keys.tab': Keys.tab,
    'Keys.q': Keys.q,
    'Keys.w': Keys.w,
    'Keys.e': Keys.e,
    'Keys.r': Keys.r,
    'Keys.t': Keys.t,
    'Keys.y': Keys.y,
    'Keys.u': Keys.u,
    'Keys.i': Keys.i,
    'Keys.o': Keys.o,
    'Keys.p': Keys.p,
    'Keys.openBracket': Keys.openBracket,
    'Keys.closeBracket': Keys.closeBracket,
    'Keys.backslash': Keys.backslash,
    'Keys.capsLock': Keys.capsLock,
    'Keys.a': Keys.a,
    'Keys.s': Keys.s,
    'Keys.d': Keys.d,
    'Keys.f': Keys.f,
    'Keys.g': Keys.g,
    'Keys.h': Keys.h,
    'Keys.j': Keys.j,
    'Keys.k': Keys.k,
    'Keys.l': Keys.l,
    'Keys.cedilha': Keys.cedilha,
    'Keys.semicolon': Keys.semicolon,
    'Keys.apostrophe': Keys.apostrophe,
    'Keys.enter': Keys.enter,
    'Keys.leftShift': Keys.leftShift,
    'Keys.z': Keys.z,
    'Keys.x': Keys.x,
    'Keys.c': Keys.c,
    'Keys.v': Keys.v,
    'Keys.b': Keys.b,
    'Keys.n': Keys.n,
    'Keys.m': Keys.m,
    'Keys.comma': Keys.comma,
    'Keys.period': Keys.period,
    'Keys.slash': Keys.slash,
    'Keys.rightShift': Keys.rightShift,
    'Keys.leftCtrl': Keys.leftCtrl,
    'Keys.leftAlt': Keys.leftAlt,
    'Keys.space': Keys.space,
    'Keys.altGr': Keys.altGr,
    'Keys.rightCtrl': Keys.rightCtrl,
    'Keys.arrowUp': Keys.arrowUp,
    'Keys.arrowDown': Keys.arrowDown,
    'Keys.arrowLeft': Keys.arrowLeft,
    'Keys.arrowRight': Keys.arrowRight,
    'Keys.insert': Keys.insert,
    'Keys.home': Keys.home,
    'Keys.pageUp': Keys.pageUp,
    'Keys.delete': Keys.delete,
    'Keys.end': Keys.end,
    'Keys.pageDown': Keys.pageDown,
    'Keys.numLock': Keys.numLock,
    'Keys.numpad0': Keys.numpad0,
    'Keys.numpad1': Keys.numpad1,
    'Keys.numpad2': Keys.numpad2,
    'Keys.numpad3': Keys.numpad3,
    'Keys.numpad4': Keys.numpad4,
    'Keys.numpad5': Keys.numpad5,
    'Keys.numpad6': Keys.numpad6,
    'Keys.numpad7': Keys.numpad7,
    'Keys.numpad8': Keys.numpad8,
    'Keys.numpad9': Keys.numpad9,
    'Keys.numpadDivide': Keys.numpadDivide,
    'Keys.numpadMultiply': Keys.numpadMultiply,
    'Keys.numpadMinus': Keys.numpadMinus,
    'Keys.numpadPlus': Keys.numpadPlus,
    'Keys.numpadPeriod': Keys.numpadPeriod,
    'Keys.numpadEnter': Keys.numpadEnter,
    'Keys.menu': Keys.menu,
    'Keys.fn': Keys.fn,
    'Keys.windows': Keys.windows,
  };
}
