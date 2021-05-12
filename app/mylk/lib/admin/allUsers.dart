import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mylk/models/dataRepository.dart';
import 'package:mylk/models/itemModel.dart';
import 'package:intl/intl.dart';

class AllUsers extends StatefulWidget {
  @override
  _AllUsersState createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  DataRepository repo = DataRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: Color(0xFF545D68)),
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: Text(
              "All Users",
              style: TextStyle(color: Colors.grey[800]),
            )),
        backgroundColor: Colors.white,
        body: ListView(children: <Widget>[buildList(context)]));
  }

  Widget _buildCard(doc) {
    // DateTime dateTime = DateTime.parse(doc['createdAt'].toString());

    // final f = new DateFormat(' hh:mm yyyy-MM-dd');
    // return Text(doc.data()['name'] ?? "");
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3.0,
                blurRadius: 5.0)
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Card(
            elevation: 0,
            child: Padding(
              padding: EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
              child: ExpandablePanel(
                theme: ExpandableThemeData(
                    hasIcon: false,
                    iconPlacement: ExpandablePanelIconPlacement.right,
                    iconPadding: EdgeInsets.only(top: 70)),
                header: Container(
                  padding:
                      EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 15),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(),
                          child: Row(children: [
                            Icon(FontAwesome.user, size: 14),
                            Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Text(doc.data()['name'] ?? "Anonymous"))
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(),
                          child: Row(children: [
                            Icon(FontAwesome.phone, size: 14),
                            Padding(
                                padding: const EdgeInsets.only(
                                  left: 5.0,
                                ),
                                child: Text(doc.data()['phone'] ?? "No phone"))
                          ]),
                        ),
                      ]),
                ),
                expanded: Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Column(
                          children: [
                            Row(children: [
                              Icon(FontAwesome.building_o, size: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 6.0, bottom: 15, top: 5),
                                      child: Text(
                                        doc.data()['address'] ?? " No address ",
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ]),
                            Row(children: [
                              Icon(FontAwesome.building_o, size: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 6.0, bottom: 15, top: 10),
                                      child: Text(
                                        doc.data()['address2'] ??
                                            "Address line 2 ",
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ]),
                            Row(children: [
                              Icon(FontAwesome.whatsapp, size: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 6.0, bottom: 10, top: 5),
                                      child: Text(
                                        doc.data()['mobile2'] ??
                                            "No alternate phone",
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ]),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    return _buildCard(snapshot);

    // if (item == null) {
    //   return Container();
    // }
  }

  Widget buildList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        // stream: repo.getStream('all'),
        stream: repo.getAllUsersStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data.docs.length == 0) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    // height: 100,
                    child: Image(
                        image: AssetImage(
                  'assets/images/cart.png',
                ))),
                Text("No orders here"),
              ],
            ));
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 28.0),
            child: Container(
                // padding: EdgeInsets.only(right: 10, left: 10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ListView(
                    // physics: BouncingScrollPhysics(),
                    children: snapshot.data.docs
                        .map((data) => buildListItem(context, data))
                        .toList())),
          );

//working
          return Container(
              // padding: EdgeInsets.only(right: 10, left: 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Container(
                height: 100,
                child: GridView.count(
                  childAspectRatio: 2.1,
                  crossAxisCount: 1,
                  // primary: false,
                  // crossAxisSpacing: 10.0,
                  // mainAxisSpacing: 1.0,
                  // childAspectRatio: 1.71,
                  children: snapshot.data.docs
                      .map((data) => buildListItem(context, data))
                      .toList(),
                ),
              ));
        });
  }
}
