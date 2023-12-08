import 'package:flutter/material.dart';

import '../widgets/gauge.dart';
import '../widgets/link_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const double distanceTravelled = 13.45;
  static const double distanceToEmpty = 102.5;
  static const double battery1 = 90;
  static const double battery2 = 90;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    return Column(
      children: [
        Container(
          height: screenHeight * 0.08,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            // gradient: const LinearGradient(
            //   colors: [
            //     Color.fromRGBO(0, 169, 255, 1),
            //     Color.fromRGBO(137, 207, 243, 1),
            //   ],
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            // ),
            color: Color.fromRGBO(199, 229, 255, 1.0),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hey Nishant",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text("Where are you heading?"),
                ],
              ),
              Spacer(),
              LinkButton(),
              SizedBox(width: 20),
            ],
          ),
        ),
        Expanded(
          child: Image.asset(
            "assets/images/v1-right-front-three-quarter-8-removebg.png",
            width: 400,
          ),
        ),
        Container(
          margin: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatCard(screenHeight, screenWidth, distanceTravelled,
                      "Distance Travelled"),
                  _buildStatCard(screenHeight, screenWidth, distanceToEmpty,
                      "Distance to Empty"),
                ],
              ),
              const SizedBox(height: 10),
              _buildBatteryGaugeSection(screenHeight, battery1, battery2),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
      double screenHeight, double screenWidth, double value, String label) {
    return Flexible(
      flex: 1,
      child: Container(
        height: screenHeight * 0.16,
        width: screenWidth * 0.45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // gradient: const LinearGradient(
          //   colors: [
          //     // Colors.cyan,
          //     // Colors.cyanAccent,
          //     Color.fromRGBO(0, 169, 255, 1),
          //     Color.fromRGBO(137, 207, 243, 1),
          //   ],
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          // ),
          color: Color.fromRGBO(25, 139, 255, 1.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/icons/distance.png",
                width: 25,
              ),
              Text(
                "$value km",
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                label,
                style: const TextStyle(fontSize: 13, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBatteryGaugeSection(
      double screenHeight, double battery1, double battery2) {
    return Container(
      height: screenHeight * 0.14,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        // gradient: const LinearGradient(
        //   colors: [
        //     // Colors.cyan,
        //     // Colors.cyanAccent,
        //     Color.fromRGBO(0, 169, 255, 1),
        //     Color.fromRGBO(137, 207, 243, 1),
        //   ],
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        // ),
        color: Color.fromRGBO(25, 139, 255, 1.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Gauge(percentage: battery1),
          Gauge(percentage: battery2),
        ],
      ),
    );
  }
}
