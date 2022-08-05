import 'package:http/http.dart' as http;

class ApiClient {
  static final _singleton = ApiClient._internal();

  ApiClient._internal();

  factory ApiClient() => _singleton;

  final client = http.Client();
}