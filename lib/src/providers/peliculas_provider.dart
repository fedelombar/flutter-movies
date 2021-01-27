import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:peliculas/src/pages/models/peliculas_model.dart';

class PeliculasProvider {
  String _apikey = '2662f56d12b27ecf4d6789c9388f098f';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularesPage = 0;

  List<Pelicula> _populares = new List();

  final _popularesStream = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStream.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStream.stream;

  void disposeStreams() {
    _popularesStream?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apikey, 'lenguage': _language});

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    _popularesPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'lenguage': _language,
      'page': _popularesPage.toString()
    });

    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);
    popularesSink(_populares);

    return resp;
  }
}