import 'package:cloud_firestore/cloud_firestore.dart';

void generate_station() async {
  try {
    final DocumentReference documentReference = await FirebaseFirestore.instance.collection('stations').add({});
    final String documentID = documentReference.id;

    Map<String, dynamic> station = {
      'sid': documentID,
      'name': 'Springfield Swapping Station',
      'address': '4187 Chandler Drive, Springfield, Missouri',
      'no_slots': 10,
      'no_available': 10,
      'ready': 5,
      'half': 5,
    };

    await FirebaseFirestore.instance.collection('stations').doc(documentID).set(station);

  } catch (e) {
    print('Error adding document: $e');
  }
}
