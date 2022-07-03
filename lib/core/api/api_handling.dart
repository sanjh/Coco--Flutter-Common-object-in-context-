import 'dart:convert';
import 'dart:developer';

import 'package:coco_mobile/core/errors/server_error.dart';
import 'package:http/http.dart' as http;

abstract class ApiBasic {
  Future<dynamic> post(String apiUrl, {Map<String, dynamic> body});
  Future<dynamic> put(String apiUrl, {Map<String, dynamic> body});
  Future<dynamic> get(String apiUrl);
  Future<dynamic> patch(String apiUrl, {Map<String, dynamic> body});
}

class ApiHandler implements ApiBasic {
  @override
  Future post(String url, {Map<String, dynamic> body = const {}}) async {
    // log(url, name: 'URL');
    // log(body.toString(), name: 'BODY');

    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    // log(response.statusCode.toString(), name: 'STATUS_CODE');
    // print('SanjayKC' + response.body);

    if (response.statusCode == 200) {
      return json.decode(utf8.decode(response.bodyBytes));
    } else {
      throw ServerError(
        msg: 'An Error happens while trying to fetch images',
      );
    }
  }

  @override
  Future get(String url) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future patch(String url, {Map<String, dynamic> body = const {}}) {
    // TODO: implement patch
    throw UnimplementedError();
  }

  @override
  Future put(String url, {Map<String, dynamic> body = const {}}) {
    // TODO: implement put
    throw UnimplementedError();
  }
}
