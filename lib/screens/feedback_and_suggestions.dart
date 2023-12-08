import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji_feedback/flutter_emoji_feedback.dart';
import 'package:uuid/uuid.dart';

class FeedbackAndSuggestions extends StatefulWidget {
  const FeedbackAndSuggestions({super.key});

  @override
  State<FeedbackAndSuggestions> createState() => _FeedbackAndSuggestionsState();
}

class _FeedbackAndSuggestionsState extends State<FeedbackAndSuggestions> {

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    bool isRatingSelected = false;
    var rating;
    var message = "";

    void _showSuccessDialog() {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Feedback Recorded Successfully'),
          content: const Text('Thank you for your valuable time.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
    }

    void _showErrorDialog(String message) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Apologies...'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('OK'),
            )
          ],
        ),
      );
    }

    void submit() async {
      final isValid = formKey.currentState!.validate();
      if (!isRatingSelected || !isValid) {
        _showErrorDialog("Please Select a Rating and Enter the Message");
        return;
      }
      formKey.currentState!.save();

      try {
        const uuid = Uuid();
        await FirebaseFirestore.instance
            .collection('feedback')
            .doc(uuid.v4())
            .set({
          'username': 'username',
          'email': 'email',
          'rating': rating,
          'message': message,
        });

        _showSuccessDialog();

      } on FirebaseException catch (e) {
        // Handle Firebase exceptions, which may contain more specific error details
        print('Firebase Exception: ${e.message}');
      } catch (e) {
        // Handle other exceptions that may occur
        print('Error: $e');
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Feedback And Suggestions")),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                  "Give Feedback",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                const Text(
                  "What do you think about our app?",
                ),
                const SizedBox(height: 15),
                EmojiFeedback(
                  elementSize: 50,
                  animDuration: const Duration(milliseconds: 300),
                  curve: Curves.bounceIn,
                  inactiveElementScale: .5,
                  onChanged: (value) {
                    rating = value;
                    isRatingSelected = true;
                  },
                ),
                const SizedBox(height: 15),
                const Text("Do you have any thoughts you'd like to share?"),
                const SizedBox(height: 10),
                TextFormField(
                  maxLength: 100,
                  maxLines: 6,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintText: "Message",
                    hintStyle: TextStyle(color: Colors.grey[500]),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1 ||
                        value.trim().length > 100) {
                      return 'Must be between 1 and 100 characters.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    message = value!;
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    InkWell(
                      onTap: submit,
                      child: Container(
                        width: 160,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Center(
                          child:
                              Text("Send", style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          width: 160,
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Center(
                            child: Text("Cancel"),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

