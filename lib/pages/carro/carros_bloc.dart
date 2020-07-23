import 'dart:async';

import 'package:Carros/pages/carro/carro.dart';
import 'package:Carros/pages/carro/carros_api.dart';

class CarrosBloc{
  final _streamController = StreamController<List<Carro>>();
  get stream => _streamController.stream;

  loadCarros(String tipo) async {
    try {
      List<Carro> carros = await CarrosApi.getCarros(tipo);
      _streamController.add(carros);
    }catch (a) {
      _streamController.addError(a);
    }
    
    
  }

void dispose() {
  _streamController.close();
   }
}