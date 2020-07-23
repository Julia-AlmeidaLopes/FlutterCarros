

import 'package:Carros/pages/carro/carro.dart';
import 'package:Carros/pages/carro/loripsum_api.dart';
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
            onSelected:  _onClickPopupMenu,
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
      child: ListView(
        children: <Widget>[
          Image.network(carro.urlFoto),
          _bloco1(),
          Divider(color: Colors.black54),
          _bloco2()
        ],
      ),
      
      );
    
  }

  Row _bloco1() {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(carro.nome, style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold)),
                Text(carro.tipo, style: TextStyle(color: Colors.black45, fontSize: 17, fontWeight: FontWeight.bold)),
              ],
            ),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.favorite, color: Colors.red, size: 35,),
                  onPressed: _onClickFavortito),
                IconButton(
                  icon: Icon(Icons.share, color: Colors.black,),
                  onPressed: _onClickShare),
              ]
            )
          ]
        );
  }
  _bloco2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(carro.descricao, style: TextStyle(color: Colors.black87, fontSize:20)),
        FutureBuilder<String>(
          future: LoripsumApi.getLoripsum(),
          builder: (context, snapshot){
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator(),);
            }
            return Text(snapshot.data, style: TextStyle(color: Colors.black87, fontSize:20));
          },
        ),
      ],
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

  void _onClickFavortito() {
    print("favorito");
  }

  void _onClickShare() {
    print("compartilhar");
  }

  
}