import 'package:win32/win32.dart';

class SendEvents {
  void click(int hwnd, {int x = 0, int y = 0, int time = 100}) {
    // Verifica se o hwnd é válido
    if (hwnd == 0) {
      throw ArgumentError('Handle da janela inválido.');
    }

    // Função auxiliar para criar o valor lParam (combinação das coordenadas X e Y)
    int makeLParam(int low, int high) {
      return (high << 16) | (low & 0xFFFF);
    }

    // Simula o movimento do mouse para a posição desejada
    PostMessage(hwnd, WM_MOUSEMOVE, 0, makeLParam(x, y));
    Sleep(time); // Pequeno intervalo para garantir a entrega do evento

    // Simula o evento de ativação da janela ao clicar
    PostMessage(
        hwnd, WM_MOUSEACTIVATE, hwnd, (HTCLIENT << 16) | WM_LBUTTONDOWN);
    Sleep(time);

    // Envia a mensagem de posicionamento do cursor
    PostMessage(hwnd, WM_SETCURSOR, hwnd, (HTCLIENT << 16) | WM_LBUTTONDOWN);
    Sleep(time);
    // Simula o pressionamento do botão esquerdo do mouse
    PostMessage(hwnd, WM_LBUTTONDOWN, 0x0001, makeLParam(x, y));
    Sleep(time);

    // Simula o movimento do mouse enquanto o botão está pressionado (opcional)
    PostMessage(hwnd, WM_MOUSEMOVE, 0x0001, makeLParam(x, y));
    Sleep(time);

    // Simula a liberação do botão esquerdo do mouse
    PostMessage(hwnd, WM_LBUTTONUP, 0, makeLParam(x, y));
    Sleep(time);

    // Envia a mensagem de posicionamento do cursor após o movimento
    PostMessage(hwnd, WM_SETCURSOR, hwnd, (HTCLIENT << 16) | WM_MOUSEMOVE);
    Sleep(time);
  }

  void rClick(int hwnd, {int x = 0, int y = 0, int time = 100}) {
    // Verifica se o hwnd é válido
    if (hwnd == 0) {
      throw ArgumentError('Handle da janela inválido.');
    }

    // Função auxiliar para criar o valor lParam (combinação das coordenadas X e Y)
    int makeLParam(int low, int high) {
      return (high << 16) | (low & 0xFFFF);
    }

    // Simula o movimento do mouse para a posição desejada
    PostMessage(hwnd, WM_MOUSEMOVE, 0, makeLParam(x, y));
    Sleep(100); // Pequeno intervalo para garantir a entrega do evento

    // Simula o evento de ativação da janela ao clicar
    PostMessage(
        hwnd, WM_MOUSEACTIVATE, hwnd, (HTCLIENT << 16) | WM_RBUTTONDOWN);
    Sleep(100);

    // Envia a mensagem de posicionamento do cursor
    PostMessage(hwnd, WM_SETCURSOR, hwnd, (HTCLIENT << 16) | WM_RBUTTONDOWN);
    Sleep(100);
    // Simula o pressionamento do botão direito do mouse
    PostMessage(hwnd, WM_RBUTTONDOWN, 0x0001, makeLParam(x, y));
    Sleep(time);

    // Simula o movimento do mouse enquanto o botão está pressionado (opcional)
    PostMessage(hwnd, WM_MOUSEMOVE, 0x0001, makeLParam(x, y));
    Sleep(100);

    // Simula a liberação do botão direito do mouse
    PostMessage(hwnd, WM_RBUTTONUP, 0, makeLParam(x, y));
    Sleep(time);

    // Envia a mensagem de posicionamento do cursor após o movimento
    PostMessage(hwnd, WM_SETCURSOR, hwnd, (HTCLIENT << 16) | WM_MOUSEMOVE);
    Sleep(100);
  }

  void dragAndDrop(int hwnd,
      {required int startX,
      required int startY,
      required int endX,
      required int endY,
      int holdTime = 100}) {
    // Verifica se o hwnd é válido
    if (hwnd == 0) {
      throw ArgumentError('Handle da janela inválido.');
    }

    // Função auxiliar para criar o valor lParam (combinação das coordenadas X e Y)
    int makeLParam(int low, int high) {
      return (high << 16) | (low & 0xFFFF);
    }

    // Move o mouse para a posição inicial
    PostMessage(hwnd, WM_MOUSEMOVE, 0, makeLParam(startX, startY));
    Sleep(100);

    // Pressiona o botão esquerdo do mouse (clica e segura)
    PostMessage(hwnd, WM_LBUTTONDOWN, 0x0001, makeLParam(startX, startY));
    Sleep(holdTime);

    // Move o mouse para a posição final enquanto o botão está pressionado
    PostMessage(hwnd, WM_MOUSEMOVE, 0x0001, makeLParam(endX, endY));
    Sleep(100);

    // Solta o botão esquerdo do mouse
    PostMessage(hwnd, WM_LBUTTONUP, 0, makeLParam(endX, endY));
    Sleep(holdTime);
  }

  void keyPressed(int hwnd, int key, {int time = 100}) {
    // Verifica se o handle da janela (hwnd) é válido
    if (hwnd == 0) {
      throw ArgumentError('Handle da janela inválido.');
    }

    // Envia a mensagem de KEYDOWN para a janela
    PostMessage(hwnd, WM_KEYDOWN, key, 0x00000001);

    // Aguarda o tempo configurado antes de simular o KEYUP
    Sleep(time);

    // Envia a mensagem de KEYUP para a janela
    PostMessage(hwnd, WM_KEYUP, key, 0xC0000001);

    // Aguarda o tempo configurado antes de finalizar
    Sleep(time);
  }

  void word(int hwnd, String word, {int time = 100}) {
    for (var char in word.split('')) {
      int vk = VkKeyScan(char.codeUnits[0]) & 0xFF;
      keyPressed(hwnd, vk, time: time);
    }
  }

  void wordCutted(int hwnd, String word, {int time = 100}) {
    // Remove todas as letras maiúsculas da primeira palavra
    String filteredWord = word
        .split(' ')
        .first
        .split('')
        .where((char) => char != char.toUpperCase())
        .join();

    // Envia os caracteres restantes
    for (var char in filteredWord.split('')) {
      int vk = VkKeyScan(char.codeUnits[0]) & 0xFF;
      keyPressed(hwnd, vk, time: time);
    }
  }
}
