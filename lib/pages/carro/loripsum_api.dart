import 'dart:async';
import 'package:http/http.dart' as http;

class LoripsumApi {
  static Future<String> getLoripsum() async {
    var url = 'https://lori.net/api';
    print("get > $url");
    var response = await http.get(url);

    String text = response.body;
    text = text.replaceAll("<p>", "");
    text = text.replaceAll("</p>", "");
    return text;
  }
  
}