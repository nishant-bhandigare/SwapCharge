import 'package:battery/screens/auth.dart';
import 'package:battery/screens/tabs.dart';
import 'package:battery/screens/test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';

final theme = ThemeData(
  useMaterial3: true,
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Map<String, dynamic> userData = {}; // Define userData here

  runApp(
    MaterialApp(
      theme: theme,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            print("\nData\n");
            print(snapshot.data);
            final user = snapshot.data;

            if (user != null) {
              userData = {
                "uid" : user.uid,
                "displayName": user.displayName,
                "email": user.email,
                // "phoneNumber": user.phoneNumber,
                // "photoUrl": user.photoURL,
              };
            }

            return TabsScreen(userData: userData);
          }
          return const AuthScreen();
        },
      ),
    ),
  );
}
