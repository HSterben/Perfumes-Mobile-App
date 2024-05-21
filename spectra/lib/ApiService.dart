import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'models.dart';

class ApiService {
  static const String baseUrl = "https://jsonplaceholder.typicode.com/";
  static const String usersEndPoint = "comments?_limit=10"; // Limiting the results to 10

  Future<List<Comment>?> getComments() async {
    try {
      var url = Uri.parse(baseUrl + usersEndPoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return commentFromJson(response.body);
      }
      return null;
    } catch (e) {
      log('Failed to fetch comments: ${e.toString()}');
      return null;
    }
  }
}
