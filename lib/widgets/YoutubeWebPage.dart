import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';



class YoutubeWebPage extends StatelessWidget {
  var pageLink;

  YoutubeWebPage({Key key, @required this.pageLink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios,
              size: 22,color: Colors.pink,),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        body: Column(
          children: <Widget>[
            Expanded(
              child: WebView(
                  initialUrl: pageLink,
                  javascriptMode: JavascriptMode.unrestricted),
            ),
          ],
        ),
      ),
    );
  }
}

