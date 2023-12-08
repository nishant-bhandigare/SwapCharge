import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class BatteryStationScreen extends StatefulWidget {
  const BatteryStationScreen({super.key, required this.sid,});
  final String sid;
  @override
  State<BatteryStationScreen> createState() => _BatteryStationScreenState();
}

class _BatteryStationScreenState extends State<BatteryStationScreen> {

  var address = "";
  var name = "";
  var no_available = 0;
  var no_slots = 0;
  var ready = 0;
  var half = 0;

  @override
  Widget build(BuildContext context) {

    Future<void> retrieveData() async {
      try {
        DocumentReference documentRef = FirebaseFirestore.instance.collection('stations').doc(widget.sid);
        DocumentSnapshot documentSnapshot = await documentRef.get();
        if (documentSnapshot.exists) {
          Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

          address = documentSnapshot['address'];
          name = documentSnapshot['name'];
          no_available = documentSnapshot['no_available'];
          no_slots = documentSnapshot['no_slots'];
          ready = documentSnapshot['ready'];
          half = documentSnapshot['half'];
        } else {
          print('Document does not exist.');
        }
      } catch (e) {
        print('Error fetching data: $e');
      }
    }

    return Scaffold(
      body: FutureBuilder<void>(
        future: retrieveData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 350,
                      decoration: const BoxDecoration(color: Colors.cyanAccent),
                      child: Image.asset(
                        "assets/images/charging_station.jpg",
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 15),
                          const Row(
                            children: [
                              Icon(Icons.electric_bolt_outlined),
                              Text("Open 24 Hours"),
                              SizedBox(width: 10),
                              Icon(Icons.history),
                              Text("Updated 2 min ago"),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.pin_drop_outlined),
                              Text(address),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Divider(
                            color: Colors.black38,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            widget.sid,
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "$no_available Battery Slots Available",
                            style: const TextStyle(fontSize: 12, color: Colors.black38),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2.5,
                                height: 150,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text("Ready",style: TextStyle(fontSize: 15)),
                                    Text(ready.toString(),style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                                    const Text(">80%",style: TextStyle(fontSize: 15)),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                width: MediaQuery.of(context).size.width / 2.5,
                                height: 150,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text("Half",style: TextStyle(fontSize: 15)),
                                    Text(half.toString(),style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                                    const Text("50-80%",style: TextStyle(fontSize: 15)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          // Spacer(),
                          const SizedBox(
                            height: 40,
                          ),
                          const Divider(
                            color: Colors.black38,
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap : (){},
                                child: Container(
                                  height: 45,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.cyanAccent,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Center(child: Text("Book Now")),
                                ),
                              ),
                              const SizedBox(width: 10,),
                              GestureDetector(
                                onTap : (){},
                                child: Container(
                                  height: 45,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.cyanAccent,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Center(child: Text("Get Directions")),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
