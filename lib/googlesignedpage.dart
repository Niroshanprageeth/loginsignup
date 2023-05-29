import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginsignup/homescreen.dart';
import 'package:loginsignup/signup.dart';

class GoogleSignedPage extends StatelessWidget {
  const GoogleSignedPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
            else if (snapshot.hasData) {
              return HomeScreen();
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Something Went Wrong!'),
              );
            } else {
              return SignUpPage();
            }
          },
        ),
      );
}
