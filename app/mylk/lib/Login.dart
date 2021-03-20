import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mylk/Auth.dart';
import 'package:mylk/Otp.dart';
import 'package:mylk/home.dart';

import 'package:get/get.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  User user;
  String verificationId, error;
  TextEditingController phoneController = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(50),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 0),
                  child: Text("Welcome to mylk",
                      style: TextStyle(
                          color: Colors.grey[900],
                          fontWeight: FontWeight.w900,
                          fontSize: 40)),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 01),
                  child: Text("Please enter your mobile number",
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w900,
                          fontSize: 15)),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  autofocus: true,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixText: "+91",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey[100]),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: "",
                      prefixIcon: IconTheme(
                        child: Icon(Icons.phone),
                        data: IconThemeData(color: Colors.grey[800]),
                      )),
                  onTap: () {},
                  controller: phoneController,
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    padding: EdgeInsets.only(
                        top: 15, bottom: 15, left: 30, right: 30),
                    textColor: Colors.white,
                    color: Colors.grey[900],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Next"), Icon(Icons.chevron_right)],
                    ),
                    onPressed: () async {
                      print(phoneController.text);
                      // Get.to(() => Otp());
                      Get.to(() => Home());

                      // await verifyPhone('+91' + phoneController.text);
                    },
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(13.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Future<dynamic> verifyPhone(String phone) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      return AuthController().signIn(context, authResult, () {});
    };

    final PhoneVerificationFailed verificationfailed =
        (FirebaseAuthException authException) {
      debugPrint(authException.toString());
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      verificationId = verId;

      Get.to(() => Otp(verificationId: verId));
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      verificationId = verId;
    };

    return await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}
