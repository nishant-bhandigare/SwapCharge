import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<void>(
        future: fetchData(),
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
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildProfileHeader(),
                    const SizedBox(height: 15),
                    _buildProfileItem("Username", username),
                    _buildProfileItem("Email", email),
                    _buildProfileItem("Contact no.", contact),
                    _buildProfileItem("City", city),
                    _buildProfileItem("Country", country),
                  ],
                ),
              ),
            );
          }
        },
      ),

      // body: Padding(
      //         padding: const EdgeInsets.all(15.0),
      //         child: SingleChildScrollView(
      //           child: Column(
      //             children: [
      //               _buildProfileHeader(),
      //               const SizedBox(height: 15),
      //               _buildProfileItem("Username", username),
      //               _buildProfileItem("Email", email),
      //               _buildProfileItem("Contact no.", contact),
      //               _buildProfileItem("City", city),
      //               _buildProfileItem("Country", country),
      //             ],
      //           ),
      //         ),
      //       ),
    );
  }

  String username = "";
  String email = "";
  String contact = "";
  String city = "";
  String country = "";

  Future<void> fetchData() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user != null) {
      final DocumentReference documentRef =
      FirebaseFirestore.instance.collection('users').doc(user.uid);
      final DocumentSnapshot documentSnapshot = await documentRef.get();
      username = documentSnapshot['username'];
      email = documentSnapshot['email'];
      contact = documentSnapshot['contact'];
      city = documentSnapshot['city'];
      country = documentSnapshot['country'];
    }
  }

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      height: 200,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset("assets/images/profile.png", width: 100),
          Text(
            username,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem(String label, String value) {
    return Container(
      // height: 100,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 15),
            ),
            Text(
              value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
