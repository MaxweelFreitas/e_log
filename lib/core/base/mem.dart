import 'dart:ffi';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

import 'e_log.dart';

typedef ReadProcessMemoryC = Int32 Function(
    Int32 hProcess,
    Pointer<Void> lpBaseAddress,
    Pointer<Void> lpBuffer,
    Uint32 nSize,
    Pointer<Uint32> lpNumberOfBytesRead);
typedef ReadProcessMemoryDart = int Function(
    int hProcess,
    Pointer<Void> lpBaseAddress,
    Pointer<Void> lpBuffer,
    int nSize,
    Pointer<Uint32> lpNumberOfBytesRead);

typedef OpenProcessC = Int32 Function(
    Uint32 dwDesiredAccess, Int32 bInheritHandle, Uint32 dwProcessId);
typedef OpenProcessDart = int Function(
    int dwDesiredAccess, int bInheritHandle, int dwProcessId);

typedef GetLastErrorC = Uint32 Function();
typedef GetLastErrorDart = int Function();

/// A class for reading memory from a process on Windows using the Windows API.
///
/// This class uses `kernel32.dll` and `user32.dll` to interact with processes and read memory.
/// It provides functions to open processes, read memory, and handle offsets to locate memory addresses.
///
/// Example usage:
/// ```dart
/// final mem = Mem();
///
/// // Get process ID from window handle (HWND)
/// int processId = mem.getPIDFromHwnd(hwnd);
/// print('Process ID: $processId');
///
/// // Open a process handle with read and query access permissions
/// int processHandle = mem.openProcessHandle(processId);
///
/// // Read memory from the process
/// int baseAddress = 0x12345678;  // Example base address
/// List<int> offsets = [0x10, 0x20];  // Example offsets
/// List<int>? memory = mem.read(processHandle, baseAddress, offsets: offsets);
/// print('Read memory: $memory');
///
/// // Read an integer from memory
/// int intValue = mem.readInt(processHandle, baseAddress);
/// print('Integer value: $intValue');
///
/// // Read a string from memory
/// String? stringValue = mem.readString(processHandle, baseAddress);
/// print('String value: $stringValue');
/// ```
class Mem {
  /// Creates a new instance of the [Mem] class.
  ///
  /// This constructor loads the necessary Windows libraries (`kernel32.dll` and `user32.dll`)
  /// and initializes the required functions to interact with processes and read memory.
  Mem(this.pid) {
    // Primeiro, inicializar a DLL e as funções
    kernel32 = DynamicLibrary.open('kernel32.dll');

    openProcess =
        kernel32.lookupFunction<OpenProcessC, OpenProcessDart>('OpenProcess');
    readProcessMemory =
        kernel32.lookupFunction<ReadProcessMemoryC, ReadProcessMemoryDart>(
            'ReadProcessMemory');
    getLastError = kernel32
        .lookupFunction<GetLastErrorC, GetLastErrorDart>('GetLastError');

    // Depois, abrir o handle do processo
    processHandle = openProcessHandle(pid);

    if (processHandle == 0) {
      eLog('Falha ao abrir o processo.');
      return;
    }
  }
  final int pid;
  late DynamicLibrary kernel32;
  late ReadProcessMemoryDart readProcessMemory;
  late OpenProcessDart openProcess;
  late GetLastErrorDart getLastError;
  late int processHandle;

  /// Opens a process with the specified permissions and returns the process handle.
  ///
  /// This method calls the Windows API function `OpenProcess` to open a process
  /// with `PROCESS_VM_READ` and `PROCESS_QUERY_INFORMATION` permissions.
  ///
  /// Example usage:
  /// ```dart
  /// int processHandle = mem.openProcessHandle(processId);
  /// ```
  int openProcessHandle(int processId) {
    return openProcess(
      PROCESS_VM_READ | PROCESS_QUERY_INFORMATION,
      0,
      processId,
    );
  }

  /// Reads memory from the specified process handle at a given base address.
  ///
  /// This method uses `ReadProcessMemory` to read a block of memory from the target process.
  /// Optionally, you can provide offsets to navigate through memory.
  ///
  /// Returns the read memory as a `Uint8List` or `null` in case of failure.
  ///
  /// Example usage:
  /// ```dart
  /// List<int>? memory = mem.read(processHandle, baseAddress, offsets: [0x10, 0x20]);
  /// ```
  Uint8List? read(int baseAddress, {int size = 64, List<int>? offsets}) {
    int finalAddress = baseAddress;

    if (offsets != null && offsets.isNotEmpty) {
      for (final offset in offsets) {
        final buffer = calloc<Int32>();
        final bytesRead = calloc<Uint32>();

        try {
          final result = readProcessMemory(
            processHandle,
            Pointer.fromAddress(finalAddress),
            buffer.cast<Void>(),
            sizeOf<Int32>(),
            bytesRead,
          );

          if (result == 0) {
            return null;
          }

          finalAddress = buffer.value + offset;
        } finally {
          calloc.free(buffer);
          calloc.free(bytesRead);
        }
      }
    }

    final buffer = calloc<Uint8>(size);
    final bytesRead = calloc<Uint32>();

    try {
      final result = readProcessMemory(
        processHandle,
        Pointer.fromAddress(finalAddress),
        buffer.cast<Void>(),
        size,
        bytesRead,
      );

      if (result == 0) {
        return null;
      }

      return Uint8List.fromList(buffer.asTypedList(size));
    } finally {
      calloc.free(buffer);
      calloc.free(bytesRead);
    }
  }

  /// Reads an integer value from the specified memory address.
  ///
  /// This method calls `read` to retrieve the raw memory data and then
  /// interprets the first 4 bytes as an integer.
  ///
  /// Example usage:
  /// ```dart
  /// int intValue = mem.readInt(processHandle, baseAddress);
  /// ```
  int readInt(int baseAddress, {int size = 64, List<int>? offsets}) {
    final memory = read(baseAddress, size: size, offsets: offsets);
    if (memory == null) {
      return 0;
    }
    return memory.buffer.asByteData().getInt32(0, Endian.little);
  }

  /// Reads a null-terminated string from the specified memory address.
  ///
  /// This method calls `read` to retrieve the raw memory data and then
  /// searches for the null terminator (`\0`) to extract the string.
  ///
  /// Example usage:
  /// ```dart
  /// String? stringValue = mem.readString(processHandle, baseAddress);
  /// ```
  String? readString(int baseAddress, {int size = 50, List<int>? offsets}) {
    final memory = read(baseAddress, size: size, offsets: offsets);
    if (memory == null) return null;

    try {
      final nullTerminatorIndex = memory.indexOf(0);
      final validBytes = nullTerminatorIndex == -1
          ? memory
          : memory.sublist(0, nullTerminatorIndex);
      return String.fromCharCodes(validBytes);
    } on Exception catch (e) {
      eLog(e.toString());
      return null;
    }
  }

  /// Reads a float (32-bit) value from the specified memory address.
  ///
  /// This method calls `read` to retrieve the raw memory data and then
  /// interprets the first 4 bytes as a single-precision floating-point number.
  ///
  /// Example usage:
  /// ```dart
  /// double floatValue = mem.readFloat(baseAddress);
  /// ```
  double readFloat(int baseAddress, {int size = 4, List<int>? offsets}) {
    final memory = read(baseAddress, size: size, offsets: offsets);
    if (memory == null || memory.length < size) {
      return 0.0;
    }
    return memory.buffer.asByteData().getFloat32(0, Endian.little);
  }
}

Future<void> main() async {}
