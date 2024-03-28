import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidePassword = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final RegExp _emailRegExp =
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  Future<void> login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      const String url = 'http://192.168.1.163:5001/donors/login';

      final Map<String, String> body = {
        'email': emailController.text,
        'password': passwordController.text,
      };

      final response = await http.post(Uri.parse(url), body: body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String token = responseData['token'];

        // Store token locally
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        // Navigate to home screen
        print("sign in success");
        Navigator.pushReplacementNamed(context, '/navbar');
      } else {
        // Handle login failure
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String errorMessage = responseData['message'];

        // Show error message to the user
        Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        // if (mounted) {
        //   showDialog(
        //     context: context,
        //     builder: (context) => AlertDialog(
        //       title: const Text('Login Failed'),
        //       content: Text(errorMessage),
        //       actions: [
        //         TextButton(
        //           onPressed: () => Navigator.pop(context),
        //           child: const Text('OK'),
        //         ),
        //       ],
        //     ),
        //   );
        // }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: RadialGradient(colors: [
                Color.fromARGB(255, 250, 80, 131),
                Color.fromARGB(255, 208, 8, 68),
                Color.fromARGB(255, 158, 1, 48),
              ], center: Alignment.topCenter, radius: 1.6),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 4,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(100, 0, 0, 0),
                        offset: Offset(0, 2),
                        blurRadius: 25,
                        spreadRadius: 1,
                      )
                    ],
                    gradient: RadialGradient(colors: [
                      Colors.white,
                      Colors.white.withOpacity(0.8),
                    ], center: Alignment.topCenter, radius: 1),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(200),
                      bottomRight: Radius.circular(200),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          "lib/images/donation.png",
                          width: 150,
                          fit: BoxFit.contain,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(50.0),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontFamily: 'Pacifico',
                                fontWeight: FontWeight.normal,
                                fontSize: 45,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!_emailRegExp.hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          style: const TextStyle(color: Colors.white),
                          controller: emailController,
                          decoration: const InputDecoration(
                              labelText: 'Email',
                              prefixIconColor: Colors.white54,
                              prefixIcon: Icon(Icons.person),
                              labelStyle: TextStyle(color: Colors.white54),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              errorStyle: TextStyle(color: Colors.orange),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orange)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            } else if (value.length < 5) {
                              return 'Password must have atleast 8 digits';
                            }
                            return null;
                          },
                          style: const TextStyle(color: Colors.white),
                          controller: passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            focusColor: Colors.white,
                            prefixIconColor: Colors.white54,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              color: Colors.white.withOpacity(0.7),
                              icon: Icon(
                                hidePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            prefixIcon: const Icon(Icons.lock),
                            labelStyle: const TextStyle(color: Colors.white54),
                            errorStyle: const TextStyle(color: Colors.orange),
                            focusedErrorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange)),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          obscureText: hidePassword,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 25.0, top: 15),
                            child: RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 14),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Forget Password ?',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {}),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll<Color>(
                                    Colors.white)),
                            onPressed: () => login(context),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.red),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Center(
                          child: Text(
                            "OR",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              color: Colors.white54,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15.0, top: 8),
                            child: RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 212, 212, 212),
                                    fontSize: 14),
                                children: <TextSpan>[
                                  const TextSpan(
                                    text: "Don't have an account ?  ",
                                  ),
                                  TextSpan(
                                    text: 'Register',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushNamed(
                                            context, "/register");
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
