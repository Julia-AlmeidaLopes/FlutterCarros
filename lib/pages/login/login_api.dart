import 'dart:convert';
import 'package:Carros/pages/api_response.dart';
import 'package:Carros/pages/login/user.dart';
import 'package:http/http.dart' as http;

class LoginApi{
  static Future<ApiResponse<Usuario>> Login(String login, String senha) async {

    try {
      var url = 'https://carros-springboot.herokuapp.com/api/v2/login';
    Map<String,String> headers = {
      "Content-Type": "application/json"
    };

    Map params = {
      'username': login, 
      'password': senha
      };

    String s = json.encode(params); //json.encode tranforma em json

    var response = await http.post(url, body: s, headers: headers);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
 
    Map mapResponse =  json.decode(response.body); 

   
  if(response.statusCode == 200){
    final user = Usuario.fromJson(mapResponse);

    user.save();

    return ApiResponse.ok(user);
  }
    return ApiResponse.error(mapResponse["error"]);
    }catch (error, exception){
      print("Erro no login $error > $exception");
      return ApiResponse.error("Não foi possível fazer o login");
    }
  }
}

