import 'package:corona_project/widgets/LoadingWrapper.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class YoutubeWebPage extends StatefulWidget {
  String pageLink;

  YoutubeWebPage({Key key, this.pageLink}) : super(key: key);

  @override
  _YoutubeWebPageState createState() => _YoutubeWebPageState();
}

class _YoutubeWebPageState extends State<YoutubeWebPage> {
  var pageLink;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 22,
            color: Colors.pink,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        )),
        body: LoadingWrapper(
          isLoading: _isLoading,
          child: Column(
            children: <Widget>[
              Expanded(
                child: WebView(
                    onPageStarted: (e) {
                      setState(() {
                        _isLoading = true;
                      });
                    },
                    onPageFinished: (e) {
                      setState(() {
                        _isLoading = false;
                      });
                    },
                    initialUrl: widget.pageLink,
                    javascriptMode: JavascriptMode.unrestricted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
