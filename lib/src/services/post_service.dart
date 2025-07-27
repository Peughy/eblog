import 'package:test_django_api/src/constants/config.dart';
import 'package:test_django_api/src/models/post_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;



Future<List<PostModel>> fetchPosts() async {
  final response = await http.get(Uri.parse("${baseUrl}api/index"));

  if (response.statusCode == 200) {
    List data = convert.jsonDecode(response.body);

    final posts = data.map((map) => PostModel.fromJson(map)).toList();
    return posts;
  } else {
    throw ("Erreur de connexion");
  }
}
