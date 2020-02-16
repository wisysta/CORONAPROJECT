import 'package:admob_flutter/admob_flutter.dart';
import 'package:corona_project/const/coronaFont12Black.dart';
import 'package:corona_project/const/coronaFont12Pink.dart';
import 'package:corona_project/const/text_style2.dart';
import 'package:corona_project/const/text_style3.dart';
import 'package:corona_project/widgets/LoadingWrapper.dart';
import 'package:flutter/material.dart';
import "package:corona_project/const/text_style.dart";
import 'dart:convert';
import 'package:http/http.dart' as http;

class Statement extends StatefulWidget {

  Statement({Key key}) : super(key: key);

  @override
  _StatementState createState() => _StatementState();
}

class _StatementState extends State<Statement> {
  List<dynamic> _scoreList = [{},{}];

  bool _isLoading = false;

  void _fetchPosts() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final res =
          await http.get('https://corona-7ecb3.firebaseio.com/basic.json');
      final jsonBody = jsonDecode(res.body);
      this.setState(() {
        _scoreList.clear();
        _scoreList = jsonBody;
      });
      _isLoading = false;
    } catch (e) {

    }
  }

  @override
  void initState() {
    _fetchPosts();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return LoadingWrapper(
      isLoading: _isLoading,
      child: Scaffold(
          body: ListView(children: <Widget>[
        Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('코로나 현황', style: coronaFont),
                SizedBox(height: 24),
                _scoreBox(),
                SizedBox(
                  height: 48,
                ),
              ],
            ))
      ])),
    );
  }

  Container _scoreBox() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(style: BorderStyle.none),
      ),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Card(
            elevation: 4,
            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Container(
              height: 640,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 4,
                  ),
                  _buildScoreBoard(),
                  SizedBox(height: 28)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column _buildScoreBoard() {
    final t1 = this._scoreList[0];
    final t2 = this._scoreList[1];

    return Column(
      children: <Widget>[
        Text(
          '전세계',
          style: coronaFont3,
        ),
        SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(t1['a1'].toString(), style: coronaFont2),
                        Text(t1['a2'].toString(), style: coronaFont12Pink),
                        Text('감염자(확진)', style: coronaFont12Black),
                        SizedBox(height: 16),
                        Text(t1['c1'].toString(), style: coronaFont2),
                        Text('', style: coronaFont12Pink),
                        Text('유증상', style: coronaFont12Black)
                      ],
                    ),
                    SizedBox(
                      width: 92,
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          t1['b1'].toString(),
                          style: coronaFont2,
                        ),
                        Text(t1['b2'].toString(), style: coronaFont12Pink),
                        Text('사망자', style: coronaFont12Black),
                        SizedBox(height: 16),
                        Text(t1['d1'].toString(), style: coronaFont2),
                        Text(t1['d2'].toString(), style: coronaFont12Pink),
                        Text(
                          '발생국',
                          style: coronaFont12Black,
                        )
                      ],
                    ),
                  ],
                )
              ],
            )
          ],
        ),
        SizedBox(
          height: 40,
        ),
        Text(
          '대한민국',
          style: coronaFont3,
        ),
        SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(t2['a1'].toString(), style: coronaFont2),
                        Text(t2['a2'].toString(), style: coronaFont12Pink),
                        Text('감염자(확진)', style: coronaFont12Black),
                        SizedBox(height: 16),
                        Text(t2['c1'].toString(), style: coronaFont2),
                        Text(t2['c2'].toString(), style: coronaFont12Pink),
                        Text('완치', style: coronaFont12Black),
                        SizedBox(height: 16),
                        Text(t2['e1'].toString(), style: coronaFont2),
                        Text(t2['e2'].toString(), style: coronaFont12Pink),
                        Text('검사중', style: coronaFont12Black),
                      ],
                    ),
                    SizedBox(
                      width: 92,
                    ),
                    Column(
                      children: <Widget>[
                        Text(t2['b1'].toString(), style: coronaFont2),
                        Text(t2['b2'].toString(), style: coronaFont12Pink),
                        Text('사망자', style: coronaFont12Black),
                        SizedBox(height: 16),
                        Text(t2['d1'].toString(), style: coronaFont2),
                        Text(t2['d2'].toString(), style: coronaFont12Pink),
                        Text('유증상자', style: coronaFont12Black),
                        SizedBox(height: 16),
                        Text(t2['f1'].toString(), style: coronaFont2),
                        Text(t2['f2'].toString(), style: coronaFont12Pink),
                        Text('격리해제', style: coronaFont12Black),
                      ],
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}
