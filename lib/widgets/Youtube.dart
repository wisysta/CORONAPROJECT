import 'package:cached_network_image/cached_network_image.dart';
import 'package:corona_project/widgets/LoadingWrapper.dart';
import 'package:corona_project/widgets/YoutubeWebPage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

class Youtube extends StatefulWidget {
  Youtube({Key key}) : super(key: key);

  @override
  _YoutubeState createState() => _YoutubeState();
}

class _YoutubeState extends State<Youtube> {
  List<Post> _posts = [];
  bool _isLoading = false;


  void _fetchPosts() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final response =
          await http.get('https://corona-7ecb3.firebaseio.com/youtube.json');
      final List<Post> parsedResponse = jsonDecode(response.body)
          .map<Post>((json) => Post.fromJSON(json))
          .toList();
      setState(() {
        _posts.clear();
        _posts.addAll(parsedResponse);
        _isLoading = false;
      });
    } catch (e) {}
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
        body: Center(
          child: ListView.builder(
            itemCount: this._posts.length,
            itemBuilder: (context, index) {
              final post = this._posts[index];
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: MaterialButton(
                  child: CachedNetworkImage(
                    imageUrl: post.thumbnail,
                  ),
                  onPressed: () async {
                    // await Navigator.pushNamed(context, '/main');
                    await Navigator.push(
                        // pushNamed 대신 push
                        context,
                        MaterialPageRoute(
                            // 이름으로 넣지 않고, MaterialPageRoute 를 만들어서 넣음
                            builder: (context) =>
                                YoutubeWebPage(pageLink: post.link)));
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class Post {
  final String link;
  final String thumbnail;

  Post({this.link, this.thumbnail});

  factory Post.fromJSON(Map<String, dynamic> json) {
    return Post(link: json['link'], thumbnail: json['thumbnail']);
  }
}
