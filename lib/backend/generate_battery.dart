import 'package:cloud_firestore/cloud_firestore.dart';

void generate_battery() async {
  try {
    FirebaseFirestore db = FirebaseFirestore.instance;
    for(var i=1; i<=10; i++){
      final DocumentReference documentReference = await db.collection('battery').add({});
      final String documentID = documentReference.id;
      Map<String, dynamic> battery = {
        'bid': documentID,
        'current %' : 100,
        'status' : null,
        'kWh' : 3.94,

        'charge_rate' : null,
        'discharge_rate' : null,

        'cycles' : 0,

        'owner_id' : null,
        'station_id' : "0OvYHUaegRAlVkqHAP9a",

        'history' : [],
      };
      await db.collection('batteries').doc(documentID).set(battery);
    }
  } catch (e) {
    print('Error adding document: $e');
  }
}