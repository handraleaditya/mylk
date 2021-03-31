import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mylk/cart.dart';
import 'package:mylk/models/dataRepository.dart';
import 'package:mylk/models/itemModel.dart';
import 'package:intl/intl.dart';

class NewOrders extends StatefulWidget {
  final String category;
  NewOrders({Key key, this.category}) : super(key: key);
  @override
  _NewOrdersState createState() => _NewOrdersState();
}

class _NewOrdersState extends State<NewOrders> {
  final ScrollController _scrollController = ScrollController();

  DataRepository repo = DataRepository();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: getColor(),
      child: ListView(physics: const AlwaysScrollableScrollPhysics(), // new
          children: <Widget>[buildList(context)]),
    );
  }

  Widget _buildCard(doc) {
    DateTime dateTime = DateTime.parse(doc['createdAt'].toString());

    final f = new DateFormat(' hh:mm yyyy-MM-dd');

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
                    iconPlacement: ExpandablePanelIconPlacement.right,
                    iconPadding: EdgeInsets.only(top: 70)),
                header: Container(
                  padding:
                      EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Order ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8, top: 5),
                        child: Row(children: [
                          Icon(FontAwesome.rupee, size: 14),
                          Text(
                            doc['total'].toInt().toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          )
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(children: [
                          Icon(AntDesign.clockcircleo, size: 14),
                          Padding(
                              padding: const EdgeInsets.only(left: 2.0),
                              child: Text(f.format(dateTime).substring(0, 6)))
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
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(children: [
                          Icon(AntDesign.user, size: 14),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(doc['name']),
                          )
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(children: [
                          Icon(AntDesign.phone, size: 14),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(doc['phone']),
                          )
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(),
                        child: Row(children: [
                          Icon(AntDesign.questioncircleo, size: 14),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text('Status : ' +
                                doc['status'].toString().toUpperCase()),
                          )
                        ]),
                      ),
                    ],
                  ),
                ),
                expanded: Container(
                  padding: EdgeInsets.only(bottom: 15, top: 10),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(children: [
                          Icon(FontAwesome.building_o, size: 14),
                          Expanded(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    doc['address'] + '\n' + doc['address2'],
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]),
                      ),
                      doc['note'] != ''
                          ? Padding(
                              padding: const EdgeInsets.only(left: 20, top: 10),
                              child: Row(children: [
                                Icon(FontAwesome.sticky_note, size: 14),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 0),
                                        child: Text(
                                          doc['note'],
                                          overflow: TextOverflow.visible,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ]),
                            )
                          : Container(),
                      returnButtonBar(doc),
                      DataTable(
                        dataRowHeight: 27,
                        // columnSpacing: 10,
                        // horizontalMargin: 10,

                        columns: <DataColumn>[
                          DataColumn(
                            label: Text('Name',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal)),
                          ),
                          DataColumn(
                            label: Text('Quantity',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal)),
                          ),
                          DataColumn(
                            label: Text('Price',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal)),
                          ),
                        ],
                        rows: List.generate(doc['items'].length,
                            (index) => _getDataRow(doc['items'][index])),
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

  DataRow _getDataRow(doc) {
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(
          doc['name'],
          style: TextStyle(fontSize: 10),
          overflow: TextOverflow.ellipsis,
        )),
        DataCell(Text(doc['quantity'].toString())),
        DataCell(Text((doc["price"] * doc['quantity']).toInt().toString())),
      ],
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
        stream: returnStream(),
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

          return Container(
              height: MediaQuery.of(context).size.height + 200,
              child: Padding(
                  padding: const EdgeInsets.only(left: 0, right: 0),
                  child: new ListView(
                      controller: _scrollController,
                      physics: NeverScrollableScrollPhysics(),

                      // physics: const AlwaysScrollableScrollPhysics(), // new

                      children: snapshot.data.docs
                          .map((data) => buildListItem(context, data))
                          .toList())));

//working
          return Container(
              // padding: EdgeInsets.only(right: 10, left: 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Container(
                height: 200,
                child: GridView.count(
                  childAspectRatio: 1,
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

  Stream<QuerySnapshot> returnStream() {
    if (widget.category == "placed") {
      return repo.getNewOrderStream();
    } else if (widget.category == 'accepted') {
      return repo.getAcceptedOrderstream();
    } else if (widget.category == 'completed') {
      return repo.getCompletedOrderStream();
    } else if (widget.category == 'cancelled') {
      return repo.getCancelledOrderStream();
    } else {
      print('failedcat');
    }
  }

  Color getColor() {
    if (widget.category == "accepted") {
      return Colors.green;
    } else if (widget.category == "cancelled") {
      return Colors.red;
    } else if (widget.category == "placed") {
      return Colors.yellow;
    }
  }

  ButtonBar returnButtonBar(var doc) {
    if (widget.category == "placed") {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        buttonPadding: EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        children: [
          OutlineButton(
              borderSide: BorderSide(
                color: Colors.yellow,
              ),
              highlightedBorderColor: Colors.yellow,
              highlightColor: Colors.yellow,
              textColor: Colors.black,
              child: Row(children: [
                Icon(MaterialCommunityIcons.check_all, size: 14),
                Text(
                  ' Complete',
                  style: TextStyle(fontSize: 12),
                )
              ]),
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection("orders")
                    .doc(doc.id)
                    .set({'status': 'completed'}, SetOptions(merge: true));
              }),
          OutlineButton(
              borderSide: BorderSide(color: Colors.red),
              highlightedBorderColor: Colors.red,
              highlightColor: Colors.red,
              textColor: Colors.black,
              child: Row(children: [
                Icon(MaterialIcons.cancel, size: 14),
                Text(
                  ' Cancel',
                  style: TextStyle(fontSize: 12),
                )
              ]),
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection("orders")
                    .doc(doc.id)
                    .set({'status': 'canceled'}, SetOptions(merge: true));
              }),
          OutlineButton(
              highlightedBorderColor: Colors.green,
              highlightColor: Colors.green,
              textColor: Colors.black,
              borderSide: BorderSide(color: Colors.green),
              child: Row(children: [
                Icon(MaterialIcons.check_circle, size: 14),
                Text(
                  ' Accept',
                  style: TextStyle(fontSize: 12),
                )
              ]),
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection("orders")
                    .doc(doc.id)
                    .set({'status': 'accepted'}, SetOptions(merge: true));
              }),
        ],
      );
    } else if (widget.category == 'accepted') {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        buttonPadding: EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        children: [
          OutlineButton(
              borderSide: BorderSide(
                color: Colors.yellow,
              ),
              highlightedBorderColor: Colors.yellow,
              highlightColor: Colors.yellow,
              textColor: Colors.black,
              child: Row(children: [
                Icon(MaterialCommunityIcons.check_all, size: 14),
                Text(
                  ' Complete',
                  style: TextStyle(fontSize: 12),
                )
              ]),
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection("orders")
                    .doc(doc.id)
                    .set({'status': 'completed'}, SetOptions(merge: true));
              }),
          OutlineButton(
              borderSide: BorderSide(color: Colors.red),
              highlightedBorderColor: Colors.red,
              highlightColor: Colors.red,
              textColor: Colors.black,
              child: Row(children: [
                Icon(MaterialIcons.cancel, size: 14),
                Text(
                  ' Cancel',
                  style: TextStyle(fontSize: 12),
                )
              ]),
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection("orders")
                    .doc(doc.id)
                    .set({'status': 'canceled'}, SetOptions(merge: true));
              }),
        ],
      );
    } else if (widget.category == 'completed' ||
        widget.category == 'cancelled') {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        buttonPadding: EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        children: [],
      );
    }
  }
}
