import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  Future<dynamic> getRequest(String url) {
    return http.get(url).then((http.Response response) {
      final result = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return json.decode(result);
    });
  }
}
