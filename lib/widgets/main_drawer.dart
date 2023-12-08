import 'package:battery/screens/about_and_legal.dart';
import 'package:battery/screens/feedback_and_suggestions.dart';
import 'package:battery/screens/help_and_support.dart';
import 'package:battery/screens/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatefulWidget {
  MainDrawer({super.key, required this.username, required this.email});

  String username;
  String email;

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  var currentPage = DrawerSections.dashboard;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyHeaderDrawer(),
              MyDrawerList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget MyHeaderDrawer() {
    return Container(
      color: const Color.fromRGBO(142, 143, 253, 1),
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/v1-pro-v2b.png'),
              ),
            ),
          ),
          const Text(
            "Nishant Bhandigare",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            "nishant.211083101@vcet.edu.in",
            style: TextStyle(
              color: Colors.grey[200],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Dashboard", Icons.space_dashboard_outlined, currentPage == DrawerSections.dashboard ? true : false),
          menuItem(2, "Settings", Icons.settings_outlined, currentPage == DrawerSections.settings ? true : false),
          const Divider(),
          menuItem(3, "Help And Support", Icons.help_outline_outlined, currentPage == DrawerSections.help_and_support ? true : false),
          menuItem(4, "Feedback And Suggestions", Icons.notes, currentPage == DrawerSections.feedback_and_suggestions ? true : false),
          menuItem(5, "About And Legal", Icons.info_outline_rounded, currentPage == DrawerSections.about_and_legal ? true : false,),
          const Divider(),
          menuItem(6, "Sign Out", Icons.logout, currentPage == DrawerSections.sign_out ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            if (id == 1){
              Navigator.pop(context);
            }
            else if (id == 2) {
              // currentPage = DrawerSections.settings;
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Settings(),));
            } else if (id == 3) {
              // currentPage = DrawerSections.help_and_support;
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HelpAndSupport(),));
            } else if (id == 4) {
              // currentPage = DrawerSections.feedback_and_suggestions;
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const FeedbackAndSuggestions(),));
            } else if (id == 5) {
              // currentPage = DrawerSections.about_and_legal;
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AboutAndLegal(),));
            } else if (id == 6) {
              // currentPage = DrawerSections.sign_out;
              FirebaseAuth.instance.signOut();
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 25,
                  color: Colors.black,
                ),
                // child: image,
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
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

enum DrawerSections {
  dashboard,
  settings,
  help_and_support,
  feedback_and_suggestions,
  about_and_legal,
  sign_out,
}
