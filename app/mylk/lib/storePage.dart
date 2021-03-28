import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylk/Otp.dart';
import 'package:mylk/login.dart';
import 'package:mylk/models/dataRepository.dart';
import 'package:mylk/models/itemController.dart';
import 'package:mylk/models/itemModel.dart';
import 'package:mylk/itemDetail.dart';

class StorePage extends StatefulWidget {
  final String category;

  StorePage({Key key, this.category}) : super(key: key);

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  DataRepository repo = DataRepository();
  bool isLoading = true;

  getProducts() {
    print("getting categories");
    ItemController x = new ItemController(id: "hi");
    x.getProducts(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: data()
        // body: ListView(
        // children: <Widget>[
        //   data(),
        //   SizedBox(height: 20),
        //   Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Text('Made with <3 from Amravati',
        //           style: TextStyle(color: Colors.grey[300])),
        //     ],
        //   ),
        //   SizedBox(height: 120),
        // ],
        );
  }

  Widget data() {
    return StreamBuilder<QuerySnapshot>(
        stream: repo.getStream(widget.category),
        builder: (context, snapshot) {
          // Item item = Item.fromSnapshot(snapshot.data);
          // dynamic d = snapshot.data
          // print(item);
          // return Text('hi');
          if (!snapshot.hasData) return Container();
          return buildList(context, snapshot.data.docs);
        });
  }

  Widget buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    // return Text('hi');
    return GridView.count(
      padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 20),
      shrinkWrap: true,
      crossAxisCount: 2,
      primary: false,
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 15.0,
      childAspectRatio: 0.83,
      children: snapshot.map((data) => buildListItem(context, data)).toList(),
    );
  }

  Widget buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    final item = Item.fromSnapshot(snapshot);
    return _buildCard(item, false, false, context);

    if (item == null) {
      return Container();
    }
  }

  Widget _buildCard(Item item, bool added, bool isFavorite, context) {
    return Container(
      child: Padding(
          padding: EdgeInsets.only(top: 5.0, bottom: 10, left: 5.0, right: 5.0),
          child: InkWell(
              onTap: () {
                Get.to(() => ItemDetail(
                      item: item,
                    ));
              },
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 3.0,
                            blurRadius: 5.0)
                      ],
                      color: Colors.white),
                  child: Column(children: [
                    Padding(
                        padding: EdgeInsets.only(top: 25.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // isFavorite
                              //     ? Icon(Icons.favorite, color: Color(0xFFEF7532))
                              //     : Icon(Icons.favorite_border,
                              //         color: Color(0xFFEF7532))
                            ])),
                    Hero(
                      tag: item.reference ?? item.imageUrl,
                      child: Container(
                        height: 80.0,
                        width: 80.0,
                        child: Image.network(
                          item.imageUrl ?? "assets/images/white.jpg",
                          fit: BoxFit.contain,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Text(item.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color(0xFF575E67),
                            fontFamily: 'Varela',
                            fontSize: 16.0,
                          )),
                    ),
                    Text('\₹' + item.price.toString(),
                        style: TextStyle(
                            color: Color(0xFF575E67),
                            fontFamily: 'Varela',
                            fontSize: 14.0)),
                    Padding(
                        padding: EdgeInsets.only(top: 10, left: 0),
                        child:
                            Container(color: Color(0xFFEBEBEB), height: 1.0)),
                    Padding(
                        padding: EdgeInsets.only(left: 1.0, right: 0.0),
                        child: Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // if (!added) ...[
                                // Icon(Icons.shopping_basket,
                                //     color: Color(0xFFD17E50), size: 12.0),
                                Padding(
                                  padding: EdgeInsets.only(top: 10, bottom: 0),
                                  child: Text('View',
                                      style: TextStyle(
                                          fontFamily: 'Varela',
                                          color: Color(0xFF575E67),
                                          fontSize: 14.0)),
                                ),

                                // ],
                                // if (added != false) ...[
                                //   Icon(Icons.remove_circle_outline,
                                //       color: Color(0xFFD17E50), size: 12.0),
                                //   Text('3',
                                //       style: TextStyle(
                                //           fontFamily: 'Varela',
                                //           color: Color(0xFFD17E50),
                                //           fontWeight: FontWeight.bold,
                                //           fontSize: 12.0)),
                                //   Icon(Icons.add_circle_outline,
                                //       color: Color(0xFFD17E50), size: 12.0),
                                // ]
                              ]),
                        )),
                  ])))),
    );
  }
}
