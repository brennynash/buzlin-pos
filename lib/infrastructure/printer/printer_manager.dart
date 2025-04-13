import 'dart:io';

import 'printer.dart';
import 'connectors/bluetooth.dart';
import 'connectors/tcp.dart';
import 'connectors/usb.dart';
import 'models/printer_device.dart';

enum PrinterType { bluetooth, usb, network }

class PrinterManager {
  final bluetoothPrinterConnector = BluetoothPrinterConnector.instance;
  final tcpPrinterConnector = TcpPrinterConnector.instance;
  final usbPrinterConnector = UsbPrinterConnector.instance;

  PrinterManager._();

  static final PrinterManager _instance = PrinterManager._();

  static PrinterManager get instance => _instance;

  Stream<PrinterDevice> discovery({required PrinterType type, bool isBle = false, TcpPrinterInput? model}) {
    if (type == PrinterType.bluetooth && (Platform.isIOS || Platform.isAndroid)) {
      return bluetoothPrinterConnector.discovery(isBle: isBle);
    } else if (type == PrinterType.usb && (Platform.isAndroid || Platform.isWindows)) {
      return usbPrinterConnector.discovery();
    } else {
      return tcpPrinterConnector.discovery(model: model);
    }
  }

  Future<bool> connect({required PrinterType type, required BasePrinterInput model}) async {
    if (type == PrinterType.bluetooth && (Platform.isIOS || Platform.isAndroid)) {
      try {
        var conn = await bluetoothPrinterConnector.connect(model as BluetoothPrinterInput);
        return conn;
      } catch (e) {
        throw Exception('model must be type of BluetoothPrinterInput');
      }
    } else if (type == PrinterType.usb && (Platform.isAndroid || Platform.isWindows)) {
      try {
        var conn = await usbPrinterConnector.connect(model as UsbPrinterInput);
        return conn;
      } catch (e) {
        throw Exception('model must be type of UsbPrinterInput');
      }
    } else {
      try {
        var conn = await tcpPrinterConnector.connect(model as TcpPrinterInput);
        return conn;
      } catch (e) {
        throw Exception('model must be type of TcpPrinterInput');
      }
    }
  }

  Future<bool> disconnect({required PrinterType type, int? delayMs}) async {
    if (type == PrinterType.bluetooth && (Platform.isIOS || Platform.isAndroid)) {
      return await bluetoothPrinterConnector.disconnect();
    } else if (type == PrinterType.usb && (Platform.isAndroid || Platform.isWindows)) {
      return await usbPrinterConnector.disconnect(delayMs: delayMs);
    } else {
      return await tcpPrinterConnector.disconnect();
    }
  }

  Future<bool> send({required PrinterType type, required List<int> bytes}) async {
    if (type == PrinterType.bluetooth && (Platform.isIOS || Platform.isAndroid)) {
      return await bluetoothPrinterConnector.send(bytes);
    } else if (type == PrinterType.usb && (Platform.isAndroid || Platform.isWindows)) {
      return await usbPrinterConnector.send(bytes);
    } else {
      return await tcpPrinterConnector.send(bytes);
    }
  }

  Stream<BTStatus> get stateBluetooth => bluetoothPrinterConnector.currentStatus.cast<BTStatus>();
  Stream<USBStatus> get stateUSB => usbPrinterConnector.currentStatus.cast<USBStatus>();

  BTStatus get currentStatusBT => bluetoothPrinterConnector.status;
  USBStatus get currentStatusUSB => usbPrinterConnector.status;
}
