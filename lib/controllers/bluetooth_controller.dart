import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothController {
  FlutterBluePlus flutterBlue = FlutterBluePlus();

  Future<void> scanDevices() async {
    // Request Bluetooth permissions
    final status = await Permission.bluetooth.request();
    if (status.isDenied) {
      return;
    }
    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));
    await Future.delayed(const Duration(seconds: 10));
    FlutterBluePlus.stopScan();
  }

  Stream<List<ScanResult>> get scanResults {
    return FlutterBluePlus.scanResults;
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    await device.connect();
    List<BluetoothService> services = await device.discoverServices();
    print("Services of ${device.localName}:");
    services.forEach((service) {
      print("Service UUID: ${service.uuid}");
      service.characteristics.forEach(
            (characteristic) {
          print("Characteristic UUID: ${characteristic.uuid}");
        },
      );
      // print(service);
    });
  }
}
