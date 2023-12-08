import 'package:flutter/material.dart';

class HelpAndSupport extends StatelessWidget{
  const HelpAndSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help and Support"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Frequently Asked Questions',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20.0),
              // List of frequently asked questions
              FAQItem(
                question: 'How do I find the nearest charging station?',
                answer:
                'You can easily find the nearest charging station by opening the app and tapping on the "Find Charging Stations" option. The app will show you a list of nearby stations along with their details and navigation options.',
              ),
              FAQItem(
                question: 'How can I reserve a charging slot?',
                answer:
                'To reserve a charging slot, go to the station details page and tap on the "Reserve Slot" button. You can choose your preferred time slot, and the slot will be reserved for you.',
              ),
              FAQItem(
                question: 'How can I pay for charging services?',
                answer:
                'You can pay for charging services through the app using your preferred payment method. We accept credit cards, PayPal, and other secure payment options. Simply add your payment details in the app settings.',
              ),
              FAQItem(
                question: 'What if I encounter a problem at a charging station?',
                answer:
                'If you encounter any issues at a charging station, such as a malfunctioning charger or any safety concerns, please report it immediately through the app. We will take prompt action to address the problem and ensure a smooth charging experience.',
              ),
              FAQItem(
                question: 'Can I charge multiple electric vehicles at once?',
                answer:
                'Our charging stations are designed to accommodate one electric vehicle at a time. If you need to charge multiple vehicles, you will need to use separate charging sessions and slots.',
              ),
              FAQItem(
                question: 'Is my personal information secure?',
                answer:
                'We take your privacy and security seriously. Your personal information is encrypted and stored securely. We do not share your data with third parties without your consent. For more information, please refer to our Privacy Policy.',
              ),
              FAQItem(
                question: 'What should I do if I forget my password?',
                answer:
                'If you forget your password, you can easily reset it by clicking on the "Forgot Password" link on the login page. Follow the instructions provided to reset your password and regain access to your account.',
              ),
              FAQItem(
                  question: 'How can I provide feedback or suggestions?',
                  answer:
                  "We value your feedback and suggestions. You can provide feedback directly through the app's settings or by reaching out to our support team. Your input helps us improve our services and enhance your experience.",
              ),
              SizedBox(height: 30.0),
              Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'If you have any other questions or need assistance, please feel free to reach out to us. We are here to help!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.email, color: Colors.blue),
                  SizedBox(width: 10.0),
                  Text(
                    'support@swapcharge.com',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.phone, color: Colors.blue),
                  SizedBox(width: 10.0),
                  Text(
                    '+1 (123) 456-7890',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  const FAQItem({
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(
          fontSize: 16,
          // fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            answer,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

}