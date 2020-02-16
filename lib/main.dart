
import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'const/material_white.dart';
import 'main_page.dart';

void main() {
  Admob.initialize(getAppId());
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
      title: 'Corona Terminator',
      theme: ThemeData(
        primarySwatch: white,
      ),
    );
  }
}

String getAppId() {
  if (Platform.isIOS) {
    return 'cca-app-pub-3596109534448842~4370710492';
  } else if (Platform.isAndroid) {
    return 'cca-app-pub-3596109534448842~4370710492';
  }
  return null;
}

