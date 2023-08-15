import 'package:act_provider/provider/pokemon_provider.dart';
import 'package:act_provider/router/app_router.dart';
import 'package:act_provider/util/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PokemonProvider(),)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: AppRouter.initialRoute,
        routes: AppRouter.routes,
        scaffoldMessengerKey: NotificationsService.messengerKey,
        onGenerateRoute: (settings) => AppRouter.onGenerateRouter(settings),
      ),
    );
  }
}
