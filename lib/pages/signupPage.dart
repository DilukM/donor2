import 'package:donor2/Services/api_services.dart';
import 'package:donor2/config.dart';
import 'package:donor2/models/register_request_model.dart';
import 'package:donor2/reusable_widgets/circular_container.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isAPIcallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? username;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Color.fromARGB(255, 208, 8, 68),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: RadialGradient(colors: [
              Color.fromARGB(255, 250, 80, 131),
              Color.fromARGB(255, 208, 8, 68),
              Color.fromARGB(255, 158, 1, 48),
            ], center: Alignment.topCenter, radius: 1.6),
          ),
          child: ProgressHUD(
              key: UniqueKey(),
              inAsyncCall: isAPIcallProcess,
              opacity: 0.3,
              child: Form(
                key: globalFormKey,
                child: _registerUI(context),
              )),
        ),
      ),
    );
  }

  Widget _registerUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
            decoration: BoxDecoration(
              boxShadow: [
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
              borderRadius: BorderRadius.only(
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
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Text(
                "Register",
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontWeight: FontWeight.normal,
                  fontSize: 45,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          FormHelper.inputFieldWidget(
            context,
            showPrefixIcon: true,
            prefixIconColor: Colors.white,
            prefixIcon: const Icon(Icons.person),
            "Username",
            "Enter Your Username Here",
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "Username can\'t be empty";
              }
              return null;
            },
            (onSavedVal) {
              username = onSavedVal;
            },
            borderFocusColor: Colors.white,
            borderColor: Colors.white,
            textColor: Colors.white,
            hintColor: Colors.white38,
          ),
          SizedBox(
            height: 20,
          ),
          FormHelper.inputFieldWidget(
            context,
            showPrefixIcon: true,
            prefixIconColor: Colors.white,
            prefixIcon: const Icon(Icons.email),
            "Email",
            "Enter Your Email Here",
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "Email can\'t be empty";
              }
              return null;
            },
            (onSavedVal) {
              email = onSavedVal;
            },
            borderFocusColor: Colors.white,
            borderColor: Colors.white,
            textColor: Colors.white,
            hintColor: Colors.white38,
          ),
          SizedBox(
            height: 20,
          ),
          FormHelper.inputFieldWidget(
            context,
            showPrefixIcon: true,
            prefixIconColor: Colors.white,
            prefixIcon: const Icon(Icons.lock),
            "Password",
            "Enter Your Password Here",
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "Password can\'t be empty";
              }
              return null;
            },
            (onSavedVal) {
              password = onSavedVal;
            },
            borderFocusColor: Colors.white,
            borderColor: Colors.white,
            textColor: Colors.white,
            hintColor: Colors.white38,
            obscureText: hidePassword,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  hidePassword = !hidePassword;
                });
              },
              color: Colors.white.withOpacity(0.7),
              icon: Icon(
                hidePassword ? Icons.visibility_off : Icons.visibility,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FormHelper.inputFieldWidget(
            context,
            showPrefixIcon: true,
            prefixIconColor: Colors.white,
            prefixIcon: const Icon(Icons.lock),
            "Re-Password",
            "Reenter Your Password Here",
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "Password can\'t be empty";
              }
              return null;
            },
            (onSavedVal) {
              password = onSavedVal;
            },
            borderFocusColor: Colors.white,
            borderColor: Colors.white,
            textColor: Colors.white,
            hintColor: Colors.white38,
            obscureText: hidePassword,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  hidePassword = !hidePassword;
                });
              },
              color: Colors.white.withOpacity(0.7),
              icon: Icon(
                hidePassword ? Icons.visibility_off : Icons.visibility,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: FormHelper.submitButton(
              "Register",
              fontWeight: FontWeight.bold,
              () {
                if (validateAndSave()) {
                  setState(() {
                    isAPIcallProcess = true;
                  });

                  register_request_model model = register_request_model(
                    username: username!,
                    password: password!,
                    email: email!,
                  );
                  APIServices.register(model).then((response) {
                    setState(() {
                      isAPIcallProcess = false;
                    });
                    if (response.data != null) {
                      FormHelper.showSimpleAlertDialog(
                        context,
                        Config.appName,
                        "Registration Successfull",
                        "OK",
                        () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/login', (route) => false);
                        },
                      );
                    } else {
                      FormHelper.showSimpleAlertDialog(
                        context,
                        Config.appName,
                        response.message!,
                        "OK",
                        () {
                          Navigator.pop(context);
                        },
                      );
                    }
                  });
                }
              },
              btnColor: Colors.white,
              txtColor: Colors.red,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              "OR",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0, top: 8),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                      color: const Color.fromARGB(255, 212, 212, 212),
                      fontSize: 14),
                  children: <TextSpan>[
                    TextSpan(
                      text: "Already have an account ?  ",
                    ),
                    TextSpan(
                      text: 'Sign In',
                      style: TextStyle(
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
          Padding(
            padding: const EdgeInsets.only(top: 90),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Powerd by Manusath Derana",
                  style: TextStyle(color: Colors.white.withOpacity(0.6)),
                )),
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
