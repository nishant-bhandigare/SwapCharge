import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();

  var _isLogin = true;
  var _enteredEmail = '';
  var _enteredPassword = '';
  var _enteredUsername = '';
  var _enteredContact = '';
  var _enteredCity = '';
  var _enteredCountry = '';

  // sign user in method
  // void _submit() async {
  //   final isValid = _form.currentState!.validate();
  //
  //   if (!isValid) {
  //     return;
  //   }
  //
  //   _form.currentState!.save();
  //
  //   try {
  //     if (_isLogin) {
  //       final userCredentials = await _firebase.signInWithEmailAndPassword(email: _enteredEmail, password: _enteredPassword);
  //       print(userCredentials);
  //     } else {
  //       final userCredentials = await _firebase.createUserWithEmailAndPassword(email: _enteredEmail, password: _enteredPassword);
  //
  //       await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(userCredentials.user!.uid)
  //           .set({
  //         'username': _enteredUsername,
  //         'email': _enteredEmail,
  //         'contact': _enteredContact,
  //         'city': _enteredCity,
  //         'country': _enteredCountry,
  //       });
  //
  //
  //
  //     }
  //   } on FirebaseAuthException catch (error) {
  //     if (error.code == 'email-already-in-use') {
  //       // ...
  //     }
  //     ScaffoldMessenger.of(context).clearSnackBars();
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(error.message ?? 'Authentication failed.'),
  //       ),
  //     );
  //   }
  // }

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }

    _form.currentState!.save();

    try {
      if (_isLogin) {
        final userCredentials = await _firebase.signInWithEmailAndPassword(email: _enteredEmail, password: _enteredPassword);
        print(userCredentials);
      } else {
        final userCredentials = await _firebase.createUserWithEmailAndPassword(email: _enteredEmail, password: _enteredPassword);

        // Set display name and phone number
        await userCredentials.user!.updateDisplayName(_enteredUsername); // Set display name
        // await userCredentials.user!.updatePhoneNumber(_enteredContact); // Set phone number

        // Send a verification email
        await userCredentials.user!.sendEmailVerification();

        // Check if the email is verified
        if (userCredentials.user!.emailVerified) {
          print('Email verification sent to ${userCredentials.user!.email}');
        } else {
          print('Email verification sent, please check your email to verify.');
        }

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredentials.user!.uid)
            .set({
          'username': _enteredUsername,
          'email': _enteredEmail,
          'contact': _enteredContact,
          'city': _enteredCity,
          'country': _enteredCountry,
        });

        // // You can access the updated display name and phone number as userCredentials.user!.displayName and userCredentials.user!.phoneNumber.
        //
        // // Send a verification email
        // await userCredentials.user!.sendEmailVerification();
        //
        // // Check if the email is verified
        // if (userCredentials.user!.emailVerified) {
        //   print('Email verification sent to ${userCredentials.user!.email}');
        // } else {
        //   print('Email verification sent, please check your email to verify.');
        // }

      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        // ...
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authentication failed.'),
        ),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // welcome back, you've been missed!
                  Text(
                    _isLogin ? 'Welcome back!' : "Create New Account",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    _isLogin
                        ? 'Please sign in to your account '
                        : "Please fill in the form to continue",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // username textfield
                  if (!_isLogin)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                        // controller: usernameController,
                        obscureText: false,
                        enableSuggestions: false,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: "Username",
                          hintStyle: TextStyle(color: Colors.grey[500]),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.trim().length < 4) {
                            return 'Please enter at least 4 characters.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enteredUsername = value!;
                        },
                      ),
                    ),
                  const SizedBox(height: 10),

                  // email textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      // controller: usernameController,
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.grey[500]),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            !value.contains('@')) {
                          return 'Please enter a valid email address.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredEmail = value!;
                      },
                    ),
                  ),

                  const SizedBox(height: 10),

                  // password textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      // controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.grey[500]),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().length < 6) {
                          return 'Password must be at least 6 characters long.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredPassword = value!;
                      },
                    ),
                  ),

                  const SizedBox(height: 10),

                  // contact textfield
                  if (!_isLogin)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                        // controller: usernameController,
                        obscureText: false,
                        enableSuggestions: false,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: "Contact",
                          hintStyle: TextStyle(color: Colors.grey[500]),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.trim().length < 10) {
                            return 'Please enter at least 10 digits.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enteredContact = value!;
                        },
                      ),
                    ),
                  const SizedBox(height: 10),

                  // city textfield
                  if (!_isLogin)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                        // controller: usernameController,
                        obscureText: false,
                        enableSuggestions: false,
                        autocorrect: false,
                        // textCapitalization: TextCapitalization.none,
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: "City",
                          hintStyle: TextStyle(color: Colors.grey[500]),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.trim().length < 4) {
                            return 'Please enter at least 4 characters.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enteredCity = value!;
                        },
                      ),
                    ),
                  const SizedBox(height: 10),

                  // country textfield
                  if (!_isLogin)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                        // controller: usernameController,
                        obscureText: false,
                        enableSuggestions: false,
                        autocorrect: false,
                        // textCapitalization: TextCapitalization.none,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: "Country",
                          hintStyle: TextStyle(color: Colors.grey[500]),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.trim().length < 4) {
                            return 'Please enter at least 4 characters.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enteredCountry = value!;
                        },
                      ),
                    ),

                  const SizedBox(height: 25),

                  // sign in button
                  GestureDetector(
                    onTap: _submit,
                    child: Container(
                      padding: const EdgeInsets.all(25),
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          _isLogin ? "Sign In" : "Sign Up",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _isLogin ? 'Not a member?' : "Have an Account?",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(
                          _isLogin ? 'Register Now' : "Sign In",
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
