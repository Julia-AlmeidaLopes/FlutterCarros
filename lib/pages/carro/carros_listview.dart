import 'dart:async';

import 'package:Carros/pages/carro/carro.dart';
import 'package:Carros/pages/carro/carro_page.dart';
import 'package:Carros/pages/carro/carros_api.dart';
import 'package:Carros/pages/carro/carros_bloc.dart';
import 'package:Carros/utils/nav.dart';
import 'package:Carros/widgets/text_error.dart';
import 'package:flutter/material.dart';

class CarrosListView extends StatefulWidget {
  String tipo;
  CarrosListView(this.tipo);

  @override
  _CarrosListViewState createState() => _CarrosListViewState();
}

class _CarrosListViewState extends State<CarrosListView>
    with AutomaticKeepAliveClientMixin<CarrosListView> {
  List<Carro> carros;

  final _bloc = CarrosBloc();
  

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _bloc.loadCarros(widget.tipo);
  }

  

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder(
        stream: _bloc.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
           return TextError("Não foi possível buscar os carros");
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black12)),
            );
          }
          List<Carro> carros = snapshot.data;
          return _listView(carros);
        });
  }


Container _listView(List<Carro> carros) {
  return Container(
    padding: EdgeInsets.all(10),
    child: ListView.builder(
        itemCount: carros != null ? carros.length : 0,
        itemBuilder: (context, index) {
          Carro c = carros[index];

          return Card(
            color: Colors.yellow[100],
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                        child: c.urlFoto != null
                            ? Image.network(
                                c.urlFoto,
                                width: 200,
                              )
                            : Image.network(
                                "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/luxo/Mercedes_McLaren.png",
                                width: 200,
                              )),
                    Text("${c.nome}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 22, color: Colors.black)),
                    Text("descrição..",
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                    ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: const Text(
                            'DETALHES',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () => _onClickCarro(context, c),
                        ),
                        FlatButton(
                          child: const Text('SHARE',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          onPressed: () {
                            print("clicks");
                          },
                        ),
                      ],
                    ),
                  ]),
            ),
          );
        }),
  );
}

void _onClickCarro(context, Carro c) {
  push(context, CarroPage(c));
}

@override
void dispose() {
  super.dispose();
  _bloc.dispose();
   }
}
