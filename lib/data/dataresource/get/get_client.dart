import 'dart:io';

import 'package:get/get.dart';

class GetClient extends GetConnect {
  late Map<String, String> headers;

  GetClient() {
    init();
  }

  init() async {
    headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
  }

  Future<Response> getApi(
    String uri,
  ) async {
    print('Header $headers');
    try {
      var response = await get(uri, headers: headers);
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> postApi(String uri, {data}) async {
    try {
      var response = await post(uri, data, headers: headers);
      print(response.bodyString);
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      print('error  $e');
      rethrow;
    }
  }
}
