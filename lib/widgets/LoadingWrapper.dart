import 'package:corona_project/const/material_white.dart';
import 'package:flutter/material.dart';


class LoadingWrapper extends StatelessWidget {
  bool isLoading;
  Widget child;

  LoadingWrapper({Key key, this.isLoading, this.child}): super(key: key);


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,

        // loading circle
        (isLoading == false)? SizedBox():
        Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: white,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.pinkAccent)
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class _Loading extends StatefulWidget {
  @override
  __LoadingState createState() => __LoadingState();
}

class __LoadingState extends State<_Loading> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
