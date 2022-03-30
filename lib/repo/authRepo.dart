import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthRepo {
  String url = 'https://api.castvotegh.com';

  Future<dynamic> authLogin(dynamic authParams) async {
    var headers = {"Content-Type": "application/json;charset=UTF-8"};
    var encode = jsonEncode(authParams);

    try {
      dynamic res = await http.post(Uri.parse('$url/authenticate_user'),
          headers: headers, body: encode);
      return jsonDecode(res.body);
    } catch (e) {
      rethrow;
    }
  }
}
