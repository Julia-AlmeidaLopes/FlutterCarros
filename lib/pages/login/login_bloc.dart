import 'dart:async';

import 'package:Carros/pages/api_response.dart';
import 'package:Carros/pages/login/login_api.dart';
import 'package:Carros/pages/login/user.dart';

class LoginBLoc{
  final _streamController = StreamController<bool>();
  
  get stream => _streamController.stream;

  Future<ApiResponse<Usuario>> Login(String login, String senha) async {
     _streamController.add(true);

    ApiResponse response = await LoginApi.Login(login, senha);

      _streamController.add(false);

    return response;
  }

  void dispose(){
    _streamController.close();
  }
}