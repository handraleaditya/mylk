import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:get/get.dart';
import 'package:mylk/cart.dart';
import 'package:mylk/models/models.dart';

class ItemDetail extends StatefulWidget {
  // var imageUrl, price, name, description;
  Item item;

  ItemDetail({this.item});

  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  num quantity;
  Widget buttonText;

  @override
  void initState() {
    super.initState();
    quantity = 1;
  }

  FlutterCart cart = FlutterCart();

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
        title: Text('Details',
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 20.0,
                color: Color(0xFF545D68))),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart_rounded, color: Color(0xFF545D68)),
            onPressed: () {
              Get.to(() => Cart());
            },
          ),
        ],
      ),
      body: ListView(children: [
        SizedBox(height: 15.0),
        Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(widget.item.name,
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF575E67))),
        ),
        SizedBox(height: 45.0),
        Hero(
          tag: widget.item.imageUrl ?? "http://",
          child: Image.network(
            widget.item.imageUrl ?? "http://",
            height: 180,
            // height: 100.0,
            // height: 100.0,
            fit: BoxFit.contain,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes
                      : null,
                ),
              );
            },
          ),
        ),
        //  CachedNetworkImage(
        //     imageUrl: imageUrl,
        //     // placeholder: (context, url) => CircularProgressIndicator(),
        //     height: 150.0,
        //     width: 100.0,
        //     fit: BoxFit.contain)),
        SizedBox(height: 20.0),
        Center(
          child: Text('\₹' + widget.item.price.toString(),
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF575E67))),
        ),
        SizedBox(height: 10.0),
        Center(
          child: Text(widget.item.name,
              style: TextStyle(
                  color: Color(0xFF575E67),
                  fontFamily: 'Varela',
                  fontSize: 24.0)),
        ),
        SizedBox(height: 20.0),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 50.0,
            child: Text(widget.item.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 16.0,
                    color: Color(0xFFB4B8B9))),
          ),
        ),
        // SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            width: double.infinity,
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_incrementButton()],
              ),
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 30),
          child: SizedBox(
            width: double.infinity,
            child: RaisedButton(
              padding:
                  EdgeInsets.only(top: 15, bottom: 15, left: 30, right: 30),
              textColor: Colors.white,
              color: Colors.grey[900],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getButtonText(),
                  Icon(Icons.add_shopping_cart_rounded),
                ],
              ),
              onPressed: () async {
                // addToCart(widget.item);
                // Get.to(() => Otp());
                // Get.to(() => Home());

                // await verifyPhone('+91' + phoneController.text);
              },
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(25.0),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Text getButtonText() {
    if (quantity == 1) {
      return Text("Add " + " to cart");
    } else {
      return Text("Add " + (quantity.toString()) + " to cart");
    }
  }

  Widget _incrementButton() {
    return Container(
      child: Row(
        children: [
          Container(
            height: 40,
            child: FloatingActionButton(
              child: Icon(Icons.remove, color: Colors.black87),
              backgroundColor: Colors.white,
              onPressed: () {
                decrementQuantity();
              },
            ),
          ),
          Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(quantity.toString() ?? '1')),
          Container(
            height: 40,
            child: FloatingActionButton(
              child: Icon(Icons.add, color: Colors.black87),
              backgroundColor: Colors.white,
              onPressed: () {
                // setState(() {
                incrementQuantity();
                // });
              },
            ),
          ),
        ],
      ),
    );
  }

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
    print(quantity);
  }

  decrementQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
    print(quantity);
  }

  void addToCart(Item item) {
    cart.addToCart(
        productId: item.reference, unitPrice: item.price, quantity: 1);

    print('--043-69-0560-456-----------CART HAS' +
        cart.cartItem.first.productId.toString());
  }
}
