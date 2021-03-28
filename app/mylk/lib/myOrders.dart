import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mylk/report.dart';

class MyOrders extends StatefulWidget {
  MyOrders();

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  final User user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
  }

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
          actions: <Widget>[
            PopupMenuButton<String>(
              icon: Icon(Entypo.dots_three_vertical, color: Color(0xFF545D68)),
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'Report'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(FontAwesome.exclamation_triangle,
                            color: Color(0xFF545D68)),
                        Text(choice),
                      ],
                    ),
                  );
                }).toList();
              },
            ),
          ],
          // actions: [
          //   IconButton(
          //     icon: Icon(Icons.remove_shopping_cart, color: Color(0xFF545D68)),
          //     onPressed: () {},
          //   )
          // ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('My Orders',
                  style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 20.0,
                      color: Color(0xFF545D68))),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(Entypo.documents, color: Color(0xFF545D68)),
              )
            ],
          ),
        ),
        body: Container(
            child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("orders")
              .where('uid', isEqualTo: user.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return new Text("No orders to see here");
            return Padding(
              padding: const EdgeInsets.only(left: 0, right: 0),
              child: new ListView(children: getOrders(snapshot)),
            );
          },
        )));
  }

  void handleClick(String value) {
    switch (value) {
      case 'Report':
        Get.to(() => SubmitReport());
        break;
      case 'Settings':
        break;
    }
  }

  Widget orderCard(doc, index) {
    DateTime dateTime = DateTime.parse(doc['createdAt'].toString());

    final f = new DateFormat(' hh:mm yyyy-MM-dd');

    // print(outputDate);

    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15),
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
              color: getColor(doc['status']),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 15, left: 15, right: 15, bottom: 15),
                child: ExpandablePanel(
                  theme: ExpandableThemeData(
                      iconPlacement: ExpandablePanelIconPlacement.right,
                      iconPadding: EdgeInsets.only(top: 70)),
                  header: Container(
                      child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Order ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            Row(
                              children: [
                                Icon(FontAwesome.rupee, size: 14),
                                Text(
                                  doc['total'].toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(children: [
                          Icon(AntDesign.clockcircleo, size: 14),
                          Text(f.format(dateTime).substring(0, 6))
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(children: [
                          Icon(FontAwesome.calendar, size: 14),
                          Text(f.format(dateTime).substring(6))
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(),
                        child: Row(children: [
                          Icon(AntDesign.questioncircleo, size: 14),
                          Text(' Status : ' + doc['status'].toUpperCase())
                        ]),
                      ),
                      doc['status'] == 'placed'
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ButtonTheme(
                                  height: 25,
                                  child: RaisedButton(
                                    color: Colors.red,

                                    highlightColor: Colors.red,
                                    // highlightedBorderColor: Colors.red,
                                    focusColor: Colors.red,
                                    // borderSide: BorderSide(
                                    //   color: Colors.red,
                                    // ),
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .collection("orders")
                                          .doc(doc.id)
                                          .set({'status': 'canceled'},
                                              SetOptions(merge: true));
                                    },
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  )),
                  expanded: Column(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Flexible(
                      //   child: Column(
                      //     children: [

                      //          Text('Address : ' + doc['address']),
                      //         // overflow: TextOverflow.clip,
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      DataTable(
                        dataRowHeight: 27,
                        // columnSpacing: 10,
                        // horizontalMargin: 10,

                        columns: <DataColumn>[
                          DataColumn(
                            label: Text('Name',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal)),
                          ),
                          DataColumn(
                            label: Text('Quantity',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal)),
                          ),
                          DataColumn(
                            label: Text('Price',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal)),
                          ),
                        ],
                        rows: List.generate(doc['items'].length,
                            (index) => _getDataRow(doc['items'][index])),
                      ),
                      // Row(children: [Text('Status : ' + doc['status'])])
                    ],
                  ),
                ),
                // tapHeaderToExpand: true,
                // hasIcon: true,
              )),
        ),
      ),
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 0, left: 300),
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(f.format(dateTime)),
                  Text(' Total : ' + doc['total'].toInt().toString()),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(' Total : ' + doc['total'].toString()),
                ],
              )
            ],
          ),
        ),
      ),
    );

    return ListTile(
        title: new Text(doc["total"].toString()),
        subtitle: new Text(doc["items"].toString()));
  }

  Color getColor(String status) {
    if (status == 'accepted') {
      return Colors.green;
    } else if (status == "placed") {
      return Colors.yellow;
    } else if (status == "canceled") {
      return Colors.red;
    } else if (status == "completed") {
      return Colors.white;
    } else {
      return Colors.white;
    }
  }

  DataRow _getDataRow(doc) {
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(
          doc['name'],
          style: TextStyle(fontSize: 10),
          overflow: TextOverflow.ellipsis,
        )),
        DataCell(Text(doc['quantity'].toString())),
        DataCell(Text(doc["price"].toString())),
      ],
    );
  }

  getOrders(AsyncSnapshot<QuerySnapshot> snapshot) {
    // int index = snapshot.data.docs.length + 1;
    int index = 0;
    return snapshot.data.docs.map((doc) {
      index++;
      return orderCard(doc, index);
    }).toList();
    // .reversed
    // .toList();
  }

  getItems(doc) {
    for (var x in doc) {
      print('found');
    }
  }

  Widget itemsList(doc) {
    return ListTile(
        title: new Text(doc.toString()), subtitle: new Text(doc.toString()));
  }
}
