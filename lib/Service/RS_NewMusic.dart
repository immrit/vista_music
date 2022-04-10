import 'dart:convert';

import 'package:http/http.dart' as http;
import 'Post.dart';

Future<Post> fetchPost() async {
  final response = await http.get(
      Uri.parse('https://mrtehran-scraper.herokuapp.com/musics/all?page=1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Post.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load songs');
  }
}
