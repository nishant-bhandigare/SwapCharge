import 'package:flutter/material.dart';

class AboutAndLegal extends StatelessWidget {
  const AboutAndLegal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About and Legal"),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.black12,
                radius: 50,
                child: Image.asset(
                  'assets/icons/dashboard.png',
                  width: 70,
                  height: 70,
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'SwapCharge',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Transforming EV Charging',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Version 1.0.0',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Welcome to SwapCharge, your partner in the electric vehicle (EV) revolution. Our mission is to make EV charging seamless, efficient, and eco-conscious.',
                style: TextStyle(
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30.0),
              const Text(
                'Key Features:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              const ListTile(
                leading: Icon(Icons.check),
                title: Text(
                  'Find and navigate to nearby EV battery swapping stations with ease.',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.check),
                title: Text(
                  'Reserve swapping slots and track your battery percentage in real-time.',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.check),
                title: Text(
                  'Monitor your EV\'s battery health and charging performance effortlessly.',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.check),
                title: Text(
                  'Receive maintenance alerts and stay up-to-date with station statuses.',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              const SizedBox(height: 30.0),
              const Text(
                'Contact Us:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30.0),
              const Text(
                'Have questions or feedback? We\'d love to hear from you!',
                style: TextStyle(
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.email),
                  SizedBox(width: 10.0),
                  Text(
                    'contact@swapcharge.com',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.phone),
                  SizedBox(width: 10.0),
                  Text(
                    '+1 (123) 456-7890',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              const Text(
                'Legal Information:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              InkWell(
                onTap: () {
                  // Add navigation to your Privacy Policy page here
                },
                child: const Text(
                  '• Privacy Policy',
                  style: TextStyle(
                    fontSize: 15,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // Add navigation to your Terms of Service page here
                },
                child: const Text(
                  '• Terms of Service',
                  style: TextStyle(
                    fontSize: 15,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
