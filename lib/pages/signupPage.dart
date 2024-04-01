import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool hidePassword = true;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cpasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final RegExp _emailRegExp =
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  Future<void> login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      const String url = 'http://192.168.1.163:5001/donors/add';

      final Map<String, String> body = {
        'name': nameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
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
        Fluttertoast.showToast(
          msg: "sign up success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Color.fromARGB(121, 0, 0, 0),
          textColor: Colors.white,
        );
        print("sign up success");
        Navigator.pushReplacementNamed(context, '/navbar');
      } else {
        // Handle login failure
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String errorMessage = responseData['error'];

        // Show error message to the user
        Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Color.fromARGB(121, 0, 0, 0),
          textColor: Colors.white,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: RadialGradient(colors: [
              Color.fromARGB(255, 250, 80, 131),
              Color.fromARGB(255, 208, 8, 68),
              Color.fromARGB(255, 158, 1, 48),
            ], center: Alignment.topCenter, radius: 1.6),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 6,
                  decoration: const BoxDecoration(
                    gradient: RadialGradient(colors: [
                      Colors.white,
                      Colors.white,
                    ], center: Alignment.topCenter, radius: 1),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          "lib/images/donation.png",
                          width: 100,
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
                            padding: EdgeInsets.only(top: 30, bottom: 40),
                            child: Text(
                              "Sign up",
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
                              return 'Please enter your name';
                            }

                            return null;
                          },
                          style: const TextStyle(color: Colors.white),
                          controller: nameController,
                          decoration: const InputDecoration(
                              labelText: 'Name',
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
                          height: 10,
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
                              prefixIcon: Icon(Icons.email),
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
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }

                            return null;
                          },
                          style: const TextStyle(color: Colors.white),
                          controller: phoneController,
                          decoration: const InputDecoration(
                              labelText: 'Phone',
                              prefixIconColor: Colors.white54,
                              prefixIcon: Icon(Icons.phone),
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
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            } else if (value.length < 6) {
                              return 'Password must have atleast 6 digits';
                            } else if (passwordController !=
                                cpasswordController) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          style: const TextStyle(color: Colors.white),
                          controller: cpasswordController,
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
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please re-enter your password';
                            } else if (value.length < 6) {
                              return 'Password must have atleast 6 digits';
                            } else if (passwordController !=
                                cpasswordController) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          style: const TextStyle(color: Colors.white),
                          controller: passwordController,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
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
                        const SizedBox(height: 30.0),
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll<Color>(
                                    Colors.white)),
                            onPressed: () => login(context),
                            child: const Text(
                              'Sign up',
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
                                    text: "Already have an account ?  ",
                                  ),
                                  TextSpan(
                                    text: 'Sign in',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushNamed(context, "/signin");
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        )
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
