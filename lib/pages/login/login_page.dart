import 'dart:async';

import 'package:Carros/pages/api_response.dart';
import 'package:Carros/pages/carro/carro.dart';
import 'package:Carros/pages/carro/home_page.dart';
import 'package:Carros/pages/login/login_api.dart';
import 'package:Carros/pages/login/login_bloc.dart';
import 'package:Carros/pages/login/user.dart';
import 'package:Carros/utils/alert.dart';
import 'package:Carros/utils/nav.dart';
import 'package:Carros/widgets/app_button.dart';
import 'package:Carros/widgets/app_text.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _tLogin = TextEditingController();

  final _bloc = LoginBLoc();

  final _tsenha = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _focusSenha = FocusNode();

  
  
  @override
  void initState(){
    super.initState();

    Future<Usuario> future = Usuario.get();
    future.then((Usuario user) {
     if(user != null){
       setState(() {
        //_tLogin.text = user.login;
     });
     //login automático = push(context, Homepage(), replace: true);
     }
    });

  }

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
          child: Container(
        padding: EdgeInsets.all(17),
        child: ListView(
           children: <Widget>[
             AppText(
               "Login", 
               "Digite seu usuário", 
               controller: _tLogin, 
               validator: _validateUser, 
               keyboardType: TextInputType.emailAddress, 
               textInputAction: TextInputAction.next, 
               nextFocus: _focusSenha
               ),
             SizedBox(
               height:17,
              ),
             AppText(
             "Senha", 
             "Digite sua senha ",
             pwd: true, 
             controller: _tsenha,
             validator: _validatePwd, 
             keyboardType: TextInputType.number, 
             focusNode: _focusSenha
             ),
             SizedBox(
               height:50,
              ),
            StreamBuilder<bool>(
              stream: _bloc.stream,
              builder: (context, snapshot) {
                return AppButton("Login", onPressed: _onClickLogin, showProgress: snapshot.data  ?? false);
              }
            )
           ],
          ),
      ),
    );
  }

  void _onClickLogin() async{
    if(! _formKey.currentState.validate()){
      return;
    }
    String login = _tLogin.text;
    String senha = _tsenha.text;
    print("Login: $login, Senha: $senha");

   

    
    ApiResponse response = await _bloc.Login(login, senha);
    
    if(response.ok){
      Usuario usuario = response.result;

      print(">>> $response");

      push(context, HomePage(), replace: true);
    }else{
      alert(context, response.msg);
    }

  }



  String _validateUser(String text) {
     if(text.isEmpty){
          return "Digite seu usuário";
        }
        return null;
      }

  String _validatePwd(String text) {
     if(text.isEmpty){
          return "Digite sua senha";
        }
     if(text.length < 3){
       return "A senha precisa ter no mínimo 3 caracteres";
     }
        return null;

      }

@override 
void dispose(){
    _bloc.dispose();
  }
}

