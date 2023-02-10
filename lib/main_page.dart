import 'package:firebase_auth/firebase_auth.dart';
import '/home_page.dart';
import 'package:flutter/material.dart';
import 'authorisation//auth_page.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>
        (stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if (snapshot.hasData){
            return Home();
          } else {
            return const AuthPage();
          }
        },
      ),
    );
  }
}
