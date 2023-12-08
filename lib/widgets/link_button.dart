import 'package:battery/controllers/bluetooth_controller.dart';
import 'package:battery/widgets/bluetooth_dialog.dart';
import 'package:flutter/material.dart';

class LinkButton extends StatefulWidget {
  const LinkButton({super.key});

  @override
  State<LinkButton> createState() => _LinkButtonState();
}

class _LinkButtonState extends State<LinkButton> {

  final BluetoothController controller = BluetoothController();

  bool isConnected = false;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: InkWell(
        onTap: () {
          setState(() {
            if (isConnected == false){
              isConnected = !isConnected;
              // controller.scanDevices();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return BluetoothDialog(); // Use your custom dialog widget here
                },
              );
            }
            else{
              isConnected = !isConnected;
            }
          });
        },
        child: Image.asset(
          isConnected
              ? "assets/icons/link (1).png"
              : "assets/icons/broken-chain.png",
          width: 30,
        ),
      ),
    );
  }
}
