import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> updateAttributeInBatches() async {
  try {
    // Reference to the "batteries" collection
    CollectionReference batteriesCollection = _firestore.collection(
        'batteries');

    // Query the collection and order it if needed
    QuerySnapshot batterySnapshot = await batteriesCollection.get();

    // Split the documents into batches of 10
    final List<List<DocumentSnapshot>> batches = [];
    for (var i = 0; i < batterySnapshot.docs.length; i += 10) {
      final start = i;
      final end = (i + 10 < batterySnapshot.docs.length)
          ? i + 10
          : batterySnapshot.docs.length;
      final batch = batterySnapshot.docs.sublist(start, end);
      batches.add(batch);
    }

    // Iterate through the batches and update the attribute
    for (var batch in batches) {
      WriteBatch writeBatch = _firestore.batch();

      for (var doc in batch) {
        // Update the specific attribute for each document in the batch
        writeBatch.update(doc.reference, {'your_attribute': 'new_value'});
      }

      // Commit the batch update
      await writeBatch.commit();
    }

    print('Attribute updated in batches successfully');
  } catch (e) {
    print('Error updating attribute: $e');
  }
}
