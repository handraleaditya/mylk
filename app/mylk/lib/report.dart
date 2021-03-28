import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mylk/home.dart';

class SubmitReport extends StatefulWidget {
  @override
  _SubmitReportState createState() => _SubmitReportState();
}

class _SubmitReportState extends State<SubmitReport> {
  final _formKey = GlobalKey<FormState>();
  final key = new GlobalKey<ScaffoldState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Report problem',
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 18.0,
                color: Color(0xFF545D68))),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Text(
              "We're really sorry :(",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Text(
              "Please describe your issue here and we will get in touch as soon as possible.",
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Container(
                  child: Form(
                      key: _formKey,
                      child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20, top: 30),
                          child: Column(children: <Widget>[
                            TextField(
                              autofocus: true,

                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.grey[100]),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[100],
                                  hintText: "Title",
                                  prefixIcon: IconTheme(
                                    child: Icon(
                                        FontAwesome.exclamation_triangle,
                                        color: Color(0xFF545D68)),
                                    data:
                                        IconThemeData(color: Colors.grey[800]),
                                  )),
                              onTap: () {},
                              controller: titleController,
                              // validator: (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return 'Please enter your name';
                              //   }
                              //   return null;
                              // },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 100,
                              child: TextFormField(
                                maxLines: 5,
                                autofocus: true,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: Colors.grey[100]),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[100],
                                    hintText: "\n Describe your issue",
                                    contentPadding: EdgeInsets.all(10),
                                    isDense: true,
                                    prefixIcon: IconTheme(
                                      child: Icon(MaterialIcons.description,
                                          color: Color(0xFF545D68)),
                                      data: IconThemeData(),
                                    )),
                                controller: descriptionController,
                                onTap: () {},
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your address';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ]))))),
          Padding(
            padding: EdgeInsets.only(left: 42, right: 40, top: 20),
            child: Text(
              "Please contact +919421541817, for further details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30),
            child: ProceedButton(context),
          ),
        ],
      ),
    );
  }

  Widget ProceedButton(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.only(top: 15, bottom: 15, left: 30, right: 30),
      textColor: Colors.white,
      color: Colors.grey[900],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Report problem"),
          Icon(Icons.chevron_right),
        ],
      ),
      onPressed: () async {
        createReport();
        Fluttertoast.showToast(
          msg: "Report submitted successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
          // backgroundColor: "#e74c3c",
          // textColor: '#ffffff'
        );
        Get.to(() => Home());
      },
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(25.0),
      ),
    );
  }

  void createReport() async {
    User currentUser = await FirebaseAuth.instance.currentUser;

    await FirebaseFirestore.instance.collection("reports").doc().set({
      'title': titleController.text,
      'description': descriptionController.text,
      'phone': currentUser.phoneNumber.toString(),
      'createdAt': DateTime.now().toString(),
      'status': 'new'
    }, SetOptions(merge: true));
  }
}
