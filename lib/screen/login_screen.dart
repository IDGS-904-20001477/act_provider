import 'package:act_provider/provider/util_provider.dart';
import 'package:act_provider/util/util.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/login_provider.dart';
import '../theme/app_theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
         const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Image(image: AssetImage('assets/pokemon.png')),
          ),
          MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => LoginFormProvider(),
              ),
            ],
            child: const Login(),
          ),
        ],
      ),
    ));
  }
}

class Login extends StatelessWidget {
  const Login({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final pkProvider = Provider.of<LoginFormProvider>(context);
    return SingleChildScrollView(
          
      child: Form(
        key: pkProvider.formkey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.text,
              decoration: AppTheme.baseInput(
                  hintText: 'Ingresa tu usuario', labelText: 'usuario'),
              onChanged: (value) => print(pkProvider.user = value),
              validator: (value) {
                return (value != null && value.length >= 5)
                    ? null
                    : 'Usuario debe de tener tres caracteres minimo';
              },
            ),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.text,
              decoration: AppTheme.baseInput(
                  hintText: 'Contraseña', labelText: 'contraseña'),
              obscureText: true,
              onChanged: (value) => print(pkProvider.password = value),
              validator: (value) {
                return (value != null && value.length >= 5)
                    ? null
                    : 'Contraseña debe de tener tres caracteres minimo';
              },
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
  onPressed: () async {
    FocusScope.of(context).unfocus();

    if (!pkProvider.isValidForm()) return;
    pkProvider.isLoading = true;
    await Future.delayed(const Duration(seconds: 3));

    if (pkProvider.user != null && pkProvider.password != null) {
      final isSuccessful = await UtilProvider.rtp.loginApi(
        email: pkProvider.user,
        password: pkProvider.password,
      );

      if (isSuccessful) {
        NotificationsService.toasMessage(msg: 'msg');
        // ignore: use_build_context_synchronously
        Dialogos.msgDialog(
          context: context,
          texto: 'Bienvenido',
          dgt: DialogType.error,
          onPress: () {
            NotificationsService.showSnackBar(message: 'Bienvenido');

            // Aquí debes redirigir a la pantalla correspondiente según el rol
            if (UtilProvider.rtp.isAdmin) {
              Navigator.pushNamed(context, '/HomeScreen');
            } else if (UtilProvider.rtp.isCustomer) {
              Navigator.pushNamed(context, '/');
            }
          },
        ).show();
      }
    }
    pkProvider.isLoading = false;
  },
  child: Text(pkProvider.isLoading ? 'Cargando...' : 'Ingresar'),
)

          ],
        ),
      )),
    );
  }
}