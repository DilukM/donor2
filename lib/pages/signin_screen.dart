import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../reusable_widgets/reusablewidgets.dart';
import '../util/color_util.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    // You can add more email validation logic if needed
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    // You can add more password validation logic if needed
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("#0E2954"),
              hexStringToColor("#1F6E8C"),
              hexStringToColor("#2E8A99"),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).size.height * 0.2,
              20,
              0,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 30),
                  // Use TextFormField for email with validation
                  TextFormField(
                    controller: _emailTextController,
                    decoration: InputDecoration(
                      labelText: 'Enter Email',
                      prefixIcon:
                          Icon(Icons.person_outline, color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: 30),
                  // Use TextFormField for password with validation
                  TextFormField(
                    controller: _passwordTextController,
                    decoration: InputDecoration(
                      labelText: 'Enter Password',
                      prefixIcon: Icon(Icons.lock_outline, color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                    validator: _validatePassword,
                  ),
                  const SizedBox(height: 30),
                  forgetPassword(context),
                  signInSignUpButton(context, true, () {
                    // Validate the form before submitting
                    if (_formKey.currentState?.validate() ?? false) {
                      // Form is valid, proceed with sign-in logic
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text,
                      )
                          .then((value) {
                        print("sign in success");
                        Navigator.pushReplacementNamed(context, '/home');
                      }).onError((error, stackTrace) {
                        print("Error: ${error.toString()}");
                        // Handle sign-in error, you can display a message here
                      });
                    }
                  }),
                  signUpOption(),
                  guestSignInButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?  ",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, '/signup');
          },
          child: const Text("Sign Up",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        )
      ],
    );
  }

  Widget guestSignInButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style:
            ElevatedButton.styleFrom(textStyle: TextStyle(color: Colors.black)),
        onPressed: () {
          // Handle sign in as a guest logic
          print("Sign In as a Guest");
          Navigator.pushReplacementNamed(context, '/navbar');
        },
        child: Text("Sign In as Guest"),
      ),
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Forgot Password? ",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.right,
        ),
        onPressed: () {},
      ),
    );
  }
}
