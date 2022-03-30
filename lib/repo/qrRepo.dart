import 'dart:convert';

import 'package:http/http.dart' as http;

class QRRepo {
  String url = 'https://api.castvotegh.com';

  Future scan_qr(dynamic qrParams) async {
    var headers = {"Content-Type": "application/json;charset=UTF-8"};
    var encode = jsonEncode(qrParams);

    try {
      dynamic res = await http.post(Uri.parse('$url/scan_qr'),
          headers: headers, body: encode);
      return jsonDecode(res.body);
    } catch (e) {
      rethrow;
    }
  }
}
