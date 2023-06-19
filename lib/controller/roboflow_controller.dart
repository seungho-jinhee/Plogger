import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:plogger/util/constant.dart';

class RoboflowController {
  static Future<dynamic> detect(String imagePath) async {
    http.Response response = await http.post(
      Uri.https(
        'detect.roboflow.com',
        '/recyclable-items/3',
        {'api_key': ROBOFLOW_API_KEY},
      ),
      body: base64.encode((await File(imagePath).readAsBytes())),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    );

    return jsonDecode(response.body);
  }
}
