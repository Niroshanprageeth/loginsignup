import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginsignup/loginpage.dart';
import 'package:loginsignup/services/firebase_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black38,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey.shade900,
          title: const Text('LoggedIn'),
          centerTitle: true,
          actions: [
            TextButton(
              child: const Text(
                'LogOut',
                style: TextStyle(
                  color: Colors.lightBlue,
                ),
              ),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                FirebaseAuth.instance.signOut().then((value) {
                  print("Sign Out");

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Loginpage()));
                });
              },
            )
          ],
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Image.network(FirebaseAuth.instance.currentUser!.photoURL!),
              SizedBox(
                height: 20,
              ),
              // Text("${FirebaseAuth.instance.currentUser!.displayName}"),
              SizedBox(
                height: 20,
              ),
              // Text("${FirebaseAuth.instance.currentUser!.email}"),
            ],
          ),
        ));
  }
}
