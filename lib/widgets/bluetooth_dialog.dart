import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:battery/controllers/bluetooth_controller.dart';

class BluetoothDialog extends StatefulWidget {
  @override
  _BluetoothDialogState createState() => _BluetoothDialogState();
}

class _BluetoothDialogState extends State<BluetoothDialog> {
  final BluetoothController controller = BluetoothController();

  @override
  void initState() {
    super.initState();
    _startBluetoothScan();
  }

  Future<void> _startBluetoothScan() async {
    // Request Bluetooth permissions
    final status = await Permission.bluetooth.request();
    if (status.isDenied) {
      Navigator.of(context).pop(); // Close the dialog
      return;
    }

    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));

    // Delay the stopScan call
    await Future.delayed(const Duration(seconds: 10));

    FlutterBluePlus.stopScan();
  }

  @override
  void dispose() {
    super.dispose();
    FlutterBluePlus.stopScan(); // Stop scanning when the dialog is disposed
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nearby Bluetooth Devices'),
      content: Container(
        height: 200,
        decoration: const BoxDecoration(
        ),
        width: double.maxFinite,
        child: StreamBuilder<List<ScanResult>>(
          stream: controller.scanResults,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final result = snapshot.data![index];
                  return Card(
                    elevation: 2,
                    child: ListTile(
                      title: Text(result.device.platformName ?? 'Unknown'),
                      subtitle: Text(result.device.remoteId.str),
                      trailing: Text(result.rssi.toString()),
                      onTap: () {
                        Navigator.of(context).pop(); // Close the dialog
                        controller.connectToDevice(result.device); // Connect to the selected device
                      },
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(), // Show loading indicator while scanning
              );
            }
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Close'),
        ),
      ],
    );
  }


}
