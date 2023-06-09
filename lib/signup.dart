import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginsignup/reusable_widgets/resusable_widget.dart';
import 'package:loginsignup/homescreen.dart';
import 'package:email_validator/email_validator.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _confirmpasswordTextController =
      TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();
  bool isPasswordType = false;
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 10, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                reusableTextFeild(
                  "Enter  UserName",
                  Icons.person_outline,
                  false,
                  _userNameTextController,
                ),
                const SizedBox(
                  height: 30,
                ),
                reusableTextFeild(
                  "Enter  Email ID",
                  Icons.person_outline,
                  false,
                  _emailTextController,
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  autofocus: false,
                  controller: _passwordTextController,
                  obscureText: !isPasswordType,
                  cursorColor: Colors.white,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password is required";
                    }
                    if (!regex.hasMatch(value)) {
                      return "Please enter the valid password";
                    }
                  },
                  onSaved: (value) {
                    _passwordTextController.text = value!;
                  },
                  style: TextStyle(color: Colors.white.withOpacity(0.9)),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordType
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white70,
                        ),
                        onPressed: () {
                          setState(() {
                            isPasswordType = !isPasswordType;
                          });
                        }),
                    labelText: "Enter  Password",
                    labelStyle: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                    ),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.white.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none),
                    ),
                  ),
                  keyboardType: isPasswordType
                      ? TextInputType.visiblePassword
                      : TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  autofocus: false,
                  controller: _confirmpasswordTextController,
                  obscureText: !isPasswordType,
                  cursorColor: Colors.white,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password is required";
                    }
                    if (!regex.hasMatch(value)) {
                      return "Please enter the valid password";
                    }
                  },
                  onSaved: (value) {
                    _passwordTextController.text = value!;
                  },
                  style: TextStyle(color: Colors.white.withOpacity(0.9)),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordType
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white70,
                        ),
                        onPressed: () {
                          setState(() {
                            isPasswordType = !isPasswordType;
                          });
                        }),
                    labelText: "Enter Confirm Password",
                    labelStyle: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                    ),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.white.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none),
                    ),
                  ),
                  keyboardType: isPasswordType
                      ? TextInputType.visiblePassword
                      : TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 30,
                ),
                signInSignupButton(context, false, () {
                  if (_emailTextController.text.isEmpty ||
                      _passwordTextController.text.isEmpty) {
                    // Show an error message to the user.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Please enter all required fields.",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w100,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: Colors.blueGrey,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    return;
                  }

                  if (!isValidPassword(_passwordTextController.text)) {
                    // Show an error message to the user.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Password Shold Conatin at leat Capital letter,Simple letters,number and special characters",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w200,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.blueGrey,
                      ),
                    );
                    return;
                  }

                  // Check if the email address is valid.
                  bool isValidEmail =
                      EmailValidator.validate(_emailTextController.text);

                  // If the email address is not valid, show an error message to the user.
                  if (!isValidEmail) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "The Email address is invalid.",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w200,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.blueGrey,
                      ),
                    );
                    return;
                  }

                  String password = _passwordTextController.text;
                  String reEnteredPassword =
                      _confirmpasswordTextController.text;
                  if (password == reEnteredPassword) {
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text)
                        .then((value) {
                      print("Create New Account");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    }).onError((error, stackTrace) {
                      print("Error ($error.toString())");
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "The Passwords are deosn't match.",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Colors.white),
                        ),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.blueGrey,
                      ),
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
