import 'package:Carros/pages/carro/carro.dart';
import 'package:flutter/material.dart';

class CarroPage extends StatelessWidget {
  Carro carro;
  CarroPage(this.carro);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(carro.nome),
        //centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.place),
            onPressed: _onClickMapa),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: _onClickVideo),
          PopupMenuButton<String>(
            onSelected: (String value) => _onClickPopupMenu(value),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(value: "Editar", child: Text("Editar")),
                PopupMenuItem(value: "Excluir", child: Text("Excluir")),
                PopupMenuItem(value: "Share", child: Text("Share"))
              ];
            }),
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(/*50*/16),
      child: Image.network(carro.urlFoto),
      
      );
    
  }

  void _onClickMapa() {
    print("Mapa");
  }

  void _onClickVideo() {
    print("Cam");
  }

  _onClickPopupMenu(String value) {
    switch(value){
      case "Editar":
        print("Editar !!");
        break;
      case "Excluir":
        print("Excluir !!");
        break;
      case "Share":
        print("Share !!");
        break;
    }
  }
}