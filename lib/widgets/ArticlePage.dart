import 'package:corona_project/const/coronaFont15Black.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';



class ArticlePage extends StatefulWidget {
  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {

  List<Post> _posts = [];

  void _fetchPosts() async {
    final response = await http.get('https://jsonplaceholder.typicode.com/posts');
    final List<Post> parsedResponse = jsonDecode(response.body)
        .map<Post>((json) => Post.fromJSON(json))
        .toList();
    setState(() {
      _posts.clear();
      _posts.addAll(parsedResponse);
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
      body: Center(
        child: ListView.builder(
          itemCount: this._posts.length,
          itemBuilder: (context, index) {
            return _postItem(index);
          },
        ),
      ),
    );
  }

  Column _postItem(int index) {
    final post = this._posts[index];
    return Column(
      children: <Widget>[
        _postHeader('코로나 기사 ${post.id}'),
        Text(post.title),
        Text(post.content),
      ],
    );
  }

  Row _postHeader(String username) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: CircleAvatar(
            backgroundImage: null,
            radius: 16,
          ),
        ),
        Expanded(
            child: Text(
              username,
              style: coronaFont12Black,
            )),
        IconButton(
          icon: Icon(Icons.more_horiz, color: Colors.black87),
          onPressed: null,
        )
      ],
    );
  }
}



class Post {
  final int id;
  final String title;
  final String content;

  Post({
    this.id,
    this.title,
    this.content,
  });

  factory Post.fromJSON(Map<String, dynamic> json) {
    return Post(id: json['id'], title: json['title'], content: json['body']);
  }
}
