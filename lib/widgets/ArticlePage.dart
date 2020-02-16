import 'package:corona_project/const/coronaFont12pink_italic.dart';
import 'package:corona_project/const/coronaFont14Black.dart';
import 'package:corona_project/const/coronaFont16Pink.dart';
import 'package:corona_project/widgets/LoadingWrapper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

class ArticlePage extends StatefulWidget {
  ArticlePage({Key key}) : super(key: key);

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  List<Post> _posts = [];
  bool _isLoading = false;

  Future<List<Post>> _fetchPosts() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final response =
          await http.get('https://corona-7ecb3.firebaseio.com/article.json');
      return jsonDecode(response.body)
          .map<Post>((json) => Post.fromJSON(json))
          .toList();
    } catch (e) {}
  }

  @override
  void initState() {
    _refreshData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingWrapper(
      isLoading: _isLoading,
      child: Scaffold(
        body: ListView.builder(
          itemCount: this._posts.length,
          itemBuilder: (context, index) {
            return Container(
                padding: EdgeInsets.all(28), child: _postItem(index));
          },
        ),
      ),
    );
  }

  Column _postItem(int index) {
    final post = this._posts[index];
    int line = post._line;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          post.source.toString(),
          style: coronaFont12pink_italic,
        ),
        SizedBox(
          height: 8,
        ),
        _postHeader(post.title.toString()),
        SizedBox(
          height: 24,
        ),
        Container(
          child: RichText(
            maxLines: line,
            textAlign: TextAlign.left,
            text: TextSpan(
              style: coronaFont14Black,
              text: post.contents.toString(),
            ),
          ),
        ),
        Center(
          child: IconButton(
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.pink,
              ),
              onPressed: () {
                setState(() {
                  int ll = (line == 2) ? 100: 2;
                  post.line = ll;
                });
              }),
        ),
      ],
    );
  }

  Row _postHeader(String username) {
    return Row(
      children: <Widget>[
        Expanded(
            child: Text(
          username,
          style: coronaFont16Black,
        ))
      ],
    );
  }

  void _refreshData() async {
    final parsedResponse = await _fetchPosts();
    setState(() {
      _posts.clear();
      _posts.addAll(parsedResponse);
      _isLoading = false;
    });
  }
}

class Post {
  final String contents;
  final String title;
  final String source;
  int _line = 2;

  Post({this.contents, this.title, this.source});

  set line(int value) => {
    _line = value

  };

  factory Post.fromJSON(Map<String, dynamic> json) {
    return Post(
        contents: json['contents'],
        title: json['title'],
        source: json['source']);
  }
}
