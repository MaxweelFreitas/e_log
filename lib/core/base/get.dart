import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

import 'e_log.dart';
import 'mem.dart';

// Definir a estrutura POINT
// base class POINT extends Struct {
//   @Int32()
//   external int x;

//   @Int32()
//   external int y;

//   POINT(int i, int j);
// }

int getXLparam(int lParam) {
  return lParam & 0xFFFF; // Extrai os 16 bits inferiores (LOWORD)
}

int getYLparam(int lParam) {
  return (lParam >> 16) & 0xFFFF; // Extrai os 16 bits superiores (HIWORD)
}

// GetCursorPos
typedef GetCursorPosC = Int32 Function(Pointer<POINT> lpPoint);
typedef GetCursorPosDart = int Function(Pointer<POINT> lpPoint);
typedef ScreenToClientC = Int32 Function(IntPtr hwnd, Pointer<POINT> lpPoint);
typedef ScreenToClientDart = int Function(int hwnd, Pointer<POINT> lpPoint);

//windowSize
typedef GetClientRectC = Int32 Function(IntPtr hwnd, Pointer<RECT> lpRect);
typedef GetClientRectDart = int Function(int hwnd, Pointer<RECT> lpRect);

//ProcessId
typedef GetWindowThreadProcessIdC = Uint32 Function(
    Int32 hWnd, Pointer<Uint32> lpdwProcessId);
typedef GetWindowThreadProcessIdDart = int Function(
    int hWnd, Pointer<Uint32> lpdwProcessId);

class Get {
  Get() {
    _initialize();
  }
  static List<int> foundWindows = [];
  static late List<String> currentFilter;
  static late DynamicLibrary user32;
  static late GetWindowThreadProcessIdDart getWindowThreadProcessId;

  // Inicialização estática
  static void _initialize() {
    user32 = DynamicLibrary.open('user32.dll');
    getWindowThreadProcessId = user32.lookupFunction<GetWindowThreadProcessIdC,
        GetWindowThreadProcessIdDart>('GetWindowThreadProcessId');
  }

  /// Retrieves the process ID from a window handle (HWND).
  ///
  /// This method calls the Windows API function `GetWindowThreadProcessId` to extract
  /// the process ID associated with a window handle.
  ///
  /// Example usage:
  /// ```dart
  /// int processId = GET.pIDFromHwnd(hwnd);
  /// ```
  static int pIDFromHwnd(int hwnd) {
    _initialize(); // Garantir que as variáveis estáticas estejam inicializadas
    final processId = calloc<Uint32>();
    try {
      getWindowThreadProcessId(hwnd, processId);
      return processId.value;
    } finally {
      calloc.free(processId);
    }
  }

  static int _enumProc(int hwnd, int lParam) {
    final length = GetWindowTextLength(hwnd);
    final buffer = calloc<Uint16>(length + 1);

    GetWindowText(hwnd, buffer.cast<Utf16>(), length + 1);
    final windowTitle = buffer.cast<Utf16>().toDartString();

    if (windowTitle.isNotEmpty && currentFilter.any(windowTitle.contains)) {
      foundWindows.add(hwnd);
    }

    calloc.free(buffer);
    return 1;
  }

  static List<int> getHwnd(List<String> filterWords) {
    List<int> listWindowTitles(List<String> filterWords) {
      foundWindows.clear();
      currentFilter = filterWords;

      final enumProcPtr = Pointer.fromFunction<WNDENUMPROC>(_enumProc, 0);
      EnumWindows(enumProcPtr, 0);

      return foundWindows;
    }

    return listWindowTitles(filterWords);
  }

  static int hwndByName(List<int> hwnds, {String targetName = ''}) {
    if (targetName.isEmpty) {
      return 0;
    }
    for (var hwnd in hwnds) {
      final processId = Get.pIDFromHwnd(hwnd);
      if (processId == 0) continue;

      final mem = Mem(processId);
      final name = mem.readString(0x00400000 + 0x00DEAAA0, offsets: [0x384]);

      if (name == targetName) {
        return hwnd;
      }
    }
    return 0;
  }

  /// Retrieves the cursor's position relative to a specified window,
  /// adjusting for DPI scaling.
  ///
  /// This method continuously monitors the cursor position and waits for a
  /// left mouse button click. Upon detecting the click, it converts the
  /// global cursor coordinates to window-relative coordinates and returns
  /// the position.
  ///
  /// The method prints the cursor's global position and the converted
  /// window-relative position when a click is detected.
  ///
  /// This function blocks execution until a mouse click is detected and the
  /// position is successfully retrieved.
  ///
  /// Parameters:
  /// - [hwnd]: The handle to the window (HWND) whose client area is used to
  ///   convert the cursor position.
  ///
  /// Returns:
  /// - A [POINT] structure containing the cursor's position relative to the
  ///   specified window.
  ///
  /// Throws:
  /// - If the Win32 API calls fail, an exception is thrown.
  static POINT getCursorPos(int hwnd) {
    final user32 = DynamicLibrary.open('user32.dll');
    final GetCursorPosDart getCursorPos =
        user32.lookupFunction<GetCursorPosC, GetCursorPosDart>('GetCursorPos');
    final ScreenToClientDart screenToClient = user32
        .lookupFunction<ScreenToClientC, ScreenToClientDart>('ScreenToClient');

    // Alocar memória para armazenar as coordenadas do cursor
    final point = calloc<POINT>();

    eLog('Aguardando clique...');

    // Loop de captura de clique
    while (true) {
      // Obter a posição do cursor global
      if (getCursorPos(point) != 0) {
        final x = point.ref.x;
        final y = point.ref.y;

        // Detectar se o botão do mouse foi clicado
        if (GetAsyncKeyState(0x01) & 0x8000 != 0) {
          // 0x01 é o código para o botão esquerdo do mouse
          eLog('Clique detectado!');
          eLog('Posição do clique na tela: X=$x, Y=$y');

          // Converter para coordenadas relativas ao HWND da janela
          final result = screenToClient(hwnd, point);
          if (result != 0) {
            eLog(
                'Posição do clique relativa à janela: X=${point.ref.x}, Y=${point.ref.y}');
            break; // Encerra o loop após o clique
          } else {
            eLog('Erro ao converter as coordenadas para a janela');
          }
        }
      }

      // Atraso para evitar uso excessivo de CPU
      Sleep(100);
    }

    // Liberar memória alocada
    calloc.free(point);

    return point.ref;
  }

  static POINT windowSize(int hwnd) {
    var width = 0;
    var height = 0;
    final user32 = DynamicLibrary.open('user32.dll');
    final getClientRect = user32
        .lookupFunction<GetClientRectC, GetClientRectDart>('GetClientRect');

    final rect = calloc<RECT>();
    final success = getClientRect(hwnd, rect);

    if (success != 0) {
      width = rect.ref.right - rect.ref.left;
      height = rect.ref.bottom - rect.ref.top;

      // eLog('Largura: $width, Altura: $height');
    } else {
      eLog('Falha ao obter as dimensões da janela');
    }
    calloc.free(rect); // Libera a memória alocada
    final point = calloc<POINT>();
    point.ref.x = width;
    point.ref.y = height;
    calloc.free(point);
    return point.ref;
  }

  static WindowSize currentWindowSize() {
    // Encontra a janela do VSCode pela classe
    final hwnd = FindWindow('Chrome_WidgetWin_1'.toNativeUtf16(), nullptr);

    if (hwnd == 0) {
      eLog('Janela do VSCode não encontrada.');
      return WindowSize(0, 0);
    }

    final rect = calloc<RECT>();
    WindowSize result = WindowSize(0, 0);

    if (GetWindowRect(hwnd, rect) != 0) {
      result = WindowSize(
        rect.ref.right - rect.ref.left,
        rect.ref.bottom - rect.ref.top,
      );
    } else {
      eLog('Falha ao obter as dimensões.');
    }

    calloc.free(rect);

    return result;
  }

  static String windowTitle(int hwnd) {
    // Buffer para armazenar o título da janela
    final buffer = calloc.allocate<Uint16>(
        256 * sizeOf<Uint16>()); // Uint16 é o tipo base para Utf16

    try {
      // Chama a API GetWindowText para obter o título
      final length = GetWindowText(hwnd, buffer.cast<Utf16>(), 256);

      if (length > 0) {
        // Converte o buffer para uma string Dart e retorna
        return buffer.cast<Utf16>().toDartString();
      } else {
        return 'Título não encontrado (ou janela sem título)';
      }
    } finally {
      // Libera o buffer alocado
      calloc.free(buffer);
    }
  }

  static double getScaleFactor() {
    final dpi = GetDpiForSystem();
    return dpi / 96.0; // Converte DPI para fator de escala
  }
}

void main() {
  // final hwnd = Get.getHwnd(['Talisman Online |']).first;
  // Get.getCursorPos(hwnd);
  final size = Get.currentWindowSize();
  eLog('Width: ${size.width}, Height: ${size.height}');
}

class CursorPosition {
  int x;
  int y;

  CursorPosition({this.x = 0, this.y = 0});
}

class WindowSize {
  final int width;
  final int height;

  WindowSize(this.width, this.height);
}
