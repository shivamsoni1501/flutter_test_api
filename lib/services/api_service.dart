import 'package:flutter_test_api/models/api_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class APIService {
  static const String URI = 'https://api.github.com/orgs/octokit/repos';

  static Future<List<APIModel>> retriveApiData() async {
    try {
      var uri = Uri.parse(URI);
      var response = await http.get(uri);
      List<APIModel> repos = [];
      if (response.statusCode != 404) {
        var res = jsonDecode(response.body) as List;
        for (var element in res) {
          var repo = APIModel.fromMap(element);
          APIModel.repos[repo.id] = repo;

          if (repo.haspages == false) {
            repos.add(repo.copy());
          }
        }
        return repos;
      }
    } catch (e) {}
    return List.empty();
  }
}
