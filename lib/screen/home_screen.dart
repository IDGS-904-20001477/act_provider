import 'dart:convert';
import 'package:act_provider/provider/pokemon_provider.dart';
import 'package:act_provider/widget/widget.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../provider/login_provider.dart';
import '../provider/util_provider.dart';
import '../theme/app_theme.dart';
import '../util/util.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<PokemonProvider>(context, listen: false).getPokemons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pkprovider = Provider.of<PokemonProvider>(context);
    List<dynamic> pokemons = pkprovider.pokemons;
    print(pokemons);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppTheme.primary,
            expandedHeight: 260,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Container(
                alignment: Alignment.bottomCenter,
                width: double.infinity,
                child: const Text(
                  'Pokedex',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              background: const FadeInImage(
                fit: BoxFit.contain,
                placeholder: AssetImage('assets/cargando-xd.gif'),
                image: AssetImage('assets/pokemon.png'),
              ),
            ),
          ),
          SliverGrid(
            delegate: SliverChildListDelegate(
              [
                ...pokemons.map((pokemon) => PokemonsCardWidget(
                      pokemon: fetchPokemon(url: pokemon['url']),
                    ))
              ],
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
          ),
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          FocusScope.of(context).unfocus();
          await Future.delayed(
            const Duration(seconds: 2),
          );
          await UtilProvider.rtp.clearSession();
          // Aquí puedes agregar la navegación hacia la pantalla de inicio de sesión o cualquier otra lógica que desees después de cerrar la sesión.
          // Por ejemplo, para navegar a la pantalla de inicio de sesión, puedes usar:
          Navigator.pushNamed(context, '/LoginScreen');
        },
        child: const Text('Salir'),
      ),
    );
  }
}

Future<dynamic> fetchPokemon({url}) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // Si la llamada al servidor fue exitosa, analiza el JSON
    return jsonDecode(response.body) as Map;
  } else {
    // Si la llamada no fue exitosa, lanza un error.
    throw Exception('Fallo en la carga');
  }
}
