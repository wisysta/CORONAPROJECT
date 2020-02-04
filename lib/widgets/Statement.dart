import 'package:corona_project/const/coronaFont15Black.dart';
import 'package:corona_project/const/coronaFont15Pink.dart';
import 'package:corona_project/const/text_style2.dart';
import 'package:corona_project/const/text_style2_2.dart';
import 'package:corona_project/const/text_style3.dart';
import 'package:flutter/material.dart';
import "package:corona_project/const/text_style.dart";
import 'dart:convert';
import 'package:http/http.dart' as http;

class Statement extends StatefulWidget {
  @override
  _StatementState createState() => _StatementState();
}

class _StatementState extends State<Statement> {
  Post _post = Post();

  void _fetchPosts() async {
    final res = await http.get('https://corona-7ecb3.firebaseio.com/basic.json');

    final jsonBody = jsonDecode(res.body);
    this.setState(() {
      _post = Post.fromJSON(jsonBody);
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Text('코로나 지도', style: coronaFont),
              SizedBox(
                height: 24,
              ),
              _mapBox()
            ],
          ))
    ]));
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
              height: 540,
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
    final post = this._post;
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
                        Text(post.korInfect.toString(), style: coronaFont2),
                        Text('(+2,300)', style: coronaFont12Pink),
                        Text('감염자(확진)', style: coronaFont12Black),
                        SizedBox(height: 16),
                        Text('2.10%', style: coronaFont2),
                        Text('(+1.6%)', style: coronaFont12Pink),
                        Text('치사율', style: coronaFont12Black)
                      ],
                    ),
                    SizedBox(
                      width: 92,
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          '305',
                          style: coronaFont2_2,
                        ),
                        Text('(+46)', style: coronaFont12Pink),
                        Text('사망자', style: coronaFont12Black),
                        SizedBox(height: 16),
                        Text('27', style: coronaFont2),
                        Text('(+0)', style: coronaFont12Pink),
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
      ],
    );
  }
}

Container _mapBox() {
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
            height: 400,
          ),
        ),
      ],
    ),
  );
}

class Post {
  final int korInfect;
  final String deadRate;

  Post({this.korInfect, this.deadRate});

  factory Post.fromJSON(Map<String, dynamic> json) {
    return Post(korInfect: json['Kor_infect'], deadRate: json['dead_rate']);
  }
}
