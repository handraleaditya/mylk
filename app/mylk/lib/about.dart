import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          iconTheme: IconThemeData(color: Color(0xFF545D68)),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "About",
            style: TextStyle(color: Colors.grey[800]),
          )),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: ListView(
          children: [
            Image(
                image: AssetImage(
              'assets/images/cow_3.jpeg',
            )),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Text(
                "We provide 100% pure milk products without adding any preservatives or other mixing ingredients,we ensure each our product go through hygiene packaging and safety.",
                style: TextStyle(color: Colors.grey[900], fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Image(
                  image: AssetImage(
                'assets/images/gotha1.jpeg',
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28.0, bottom: 100),
              child: Image(
                  image: AssetImage(
                'assets/images/gotha2.jpeg',
              )),
            ),
          ],
        ),
      ),
    );
  }
}
