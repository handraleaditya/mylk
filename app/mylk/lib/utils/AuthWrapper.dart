import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mylk/Login.dart';
import 'package:mylk/home.dart';
import 'package:mylk/main.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User userData = Provider.of<User>(context);
    User user = context.watch<User>();

    if (user == null) {
      return Login();
    } else if (user != null) {
    } else
      return MyApp();
  }
}
