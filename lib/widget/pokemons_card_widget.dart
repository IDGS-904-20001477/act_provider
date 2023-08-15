import 'package:act_provider/theme/app_theme.dart';
import 'package:flutter/material.dart';

class PokemonsCardWidget extends StatelessWidget {
  const PokemonsCardWidget({super.key, required this.pokemon});

  final Future<dynamic> pokemon;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: pokemon,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var pokemon = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    FadeInImage.assetNetwork(
                      fit: BoxFit.cover,
                      placeholder: 'assets/cargando-xd.gif',
                      image: pokemon['sprites']['front_default'],
                    ),
                    Text(
                      pokemon['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "N.° ${pokemon['id'].toString().padLeft(4, '0')}",
                      style: const TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...pokemon['types'].map((type) => Padding(
                              padding: const EdgeInsets.all(4),
                              child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                    foregroundColor: AppTheme.secondary,
                                    side:
                                        BorderSide(color: AppTheme.secondary)),
                                child: Text(type['type']['name']),
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            );
          } else {
            return const Text('Fallo en la carga');
          }
        });
  }
}
