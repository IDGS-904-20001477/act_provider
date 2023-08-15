import 'package:act_provider/provider/util_provider.dart';
import 'package:act_provider/theme/app_theme.dart';
import 'package:act_provider/widget/logo_widget.dart';
import 'package:flutter/material.dart';

class CheckSessionScreen extends StatelessWidget {
  const CheckSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.secondary,
      body: FutureBuilder(
        future: UtilProvider.rtp.checkSession(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(!snapshot.hasData){
            return LogoWidget();
          }
          if(snapshot.data == 1){
            Future.microtask(() => Navigator.pushReplacementNamed(context, '/HomeScreen'));
          }else{
            Future.microtask(() => Navigator.pushReplacementNamed(context, '/LoginScreen'));
          }
          return LogoWidget();
        },
      ),
    );
  }
}
