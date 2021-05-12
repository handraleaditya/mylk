import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  // YoutubePlayerController _controller = YoutubePlayerController(
  //   initialVideoId: 'iLnmTe5Q2Qw',

  // );
  //
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'HFxz9WN8lI4',
    params: YoutubePlayerParams(
        showControls: true, showFullscreenButton: true, autoPlay: true),
  );

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
            "About us",
            style: TextStyle(color: Colors.grey[800]),
          )),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: ListView(
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: YoutubePlayerBuilder(
            //     player: YoutubePlayer(
            //       controller: _controller,
            //     ),
            //     builder: (context, player) {
            //       return Column(
            //         children: [
            //           // some widgets
            //           player,
            //           //some other widgets
            //         ],
            //       );
            //     },
            //   ),
            // ),
            // YoutubePlayer(
            //   controller: _controller,
            //   showVideoProgressIndicator: true,
            // ),
            //
            //
            //

            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 40.0),
              child: YoutubePlayerIFrame(
                controller: _controller,
                aspectRatio: 16 / 9,
              ),
            ),

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
              padding: const EdgeInsets.only(top: 28.0),
              child: Image(
                  image: AssetImage(
                'assets/images/gotha2.jpeg',
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Image(
                  image: AssetImage(
                'assets/images/cow_4.jpeg',
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28.0, bottom: 30),
              child: Image(
                  image: AssetImage(
                'assets/images/cow_5.jpeg',
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Image(
                  image: AssetImage(
                'assets/images/promo3.jpeg',
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Image(
                  image: AssetImage(
                'assets/images/promo2.jpeg',
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Image(
                  image: AssetImage(
                'assets/images/promo1.jpeg',
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Image(
                  image: AssetImage(
                'assets/images/promo4.jpeg',
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Image(
                  image: AssetImage(
                'assets/images/promo5.jpeg',
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 38.0, bottom: 100),
              child: Image(
                  image: AssetImage(
                'assets/images/promo6.jpeg',
              )),
            ),
          ],
        ),
      ),
    );
  }
}
