import 'package:battery/screens/battery_station.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/map2.png"), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 250,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.room,
                        size: 50,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BatteryStationScreen(sid: "0OvYHUaegRAlVkqHAP9a",)));
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Fort Width\nSwapping Station",
                        textAlign: TextAlign.center),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 40),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.room,
                        size: 50,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BatteryStationScreen(sid: "E6BM4N6LLhORLc3N5YMp",)));
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Brentwood\nSwapping Station",
                        textAlign: TextAlign.center),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 100,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.room,
                        size: 50,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BatteryStationScreen(sid: "gQ89PuW6pHFcjBSIAoSi",)));
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Scottsdale\nSwapping Station",
                        textAlign: TextAlign.center),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 250,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.room,
                        size: 50,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BatteryStationScreen(sid: "hCB4lij49D7NuZdEUc3v",)));
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Springfield\nSwapping Station",
                        textAlign: TextAlign.center),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 40,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.room,
                        size: 50,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BatteryStationScreen(sid: "q0HH9P66avdQNumK4jfI",)));
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Fairfield\nSwapping Station",
                        textAlign: TextAlign.center),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
  }
}
