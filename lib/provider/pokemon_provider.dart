import 'dart:convert';
import 'package:act_provider/provider/util_provider.dart';
import 'package:flutter/material.dart';

class PokemonProvider extends ChangeNotifier {
  final String _urlBase = 'https://pokeapi.co/api/v2';
  PokemonProvider() {
    getPokemons();
  }

  List<dynamic> pokemons = [];

  Future getPokemons() async {
    final String url = '${_urlBase}/pokemon?limit=16&offset=50';
    final res = await UtilProvider.rtp.responsehttp(urlBase: url);
    if (res.statusCode == 200) {
      var jres = jsonDecode(res.body) as Map;
      pokemons = jres['results'];
      notifyListeners();
    }
  }
}