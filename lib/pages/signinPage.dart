import 'package:donor2/Services/api_services.dart';
import 'package:donor2/config.dart';
import 'package:donor2/models/login_request_model.dart';
import 'package:donor2/reusable_widgets/circular_container.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  bool isAPIcallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? username;
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
                child: _loginUI(context),
              )),
        ),
      ),
    );
  }

  Widget _loginUI(BuildContext context) {
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
              padding: const EdgeInsets.all(50.0),
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
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 25.0, top: 15),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Forget Password ?',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {}),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: FormHelper.submitButton(
              "Login",
              fontWeight: FontWeight.bold,
              () {
                if (validateAndSave()) {
                  setState(() {
                    isAPIcallProcess = true;
                  });

                  login_request_model model = login_request_model(
                    username: username!,
                    password: password!,
                  );
                  APIServices.login(model).then((response) {
                    setState(() {
                      isAPIcallProcess = false;
                    });
                    if (response) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/home', (route) => false);
                    }
                  });
                } else {
                  FormHelper.showSimpleAlertDialog(
                    context,
                    Config.appName,
                    "Invalid Username/Password",
                    "OK",
                    () {
                      Navigator.pop(context);
                    },
                  );
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
                      text: "Don\'t have an account ?  ",
                    ),
                    TextSpan(
                      text: 'Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, "/register");
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
