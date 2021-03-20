import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylk/Auth.dart';

class Otp extends StatefulWidget {
  Otp({
    Key key,
    this.verificationId,
  }) : super(key: key);
  final String verificationId;
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  TextEditingController smsController = new TextEditingController();
  TextEditingController yesController = new TextEditingController();

  String smsCode, verificationId;
  FirebaseAuth auth = FirebaseAuth.instance;

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
                  child: Text("\n",
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
                  child: Text("Please enter the OTP",
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w900,
                          fontSize: 15)),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey[100]),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: "OTP",
                      prefixIcon: IconTheme(
                        child: Icon(Icons.message),
                        data: IconThemeData(color: Colors.grey[800]),
                      )),
                  onTap: () {},
                  // initialValue: "+91",
                  controller: smsController,
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
                      smsCode = smsController.text;
                      try {
                        await AuthController().signInWithOTP(
                            context, smsCode, widget.verificationId, () {
                          print('sign in success');
                          
                        });
                      }
                      // If otp entered was incorrect
                      catch (e) {
                        debugPrint(
                            '[LOG] Incorrect OTP entered' + e.toString());
                      }
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
}
