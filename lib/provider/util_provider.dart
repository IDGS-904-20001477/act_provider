import 'dart:convert';
import 'dart:js';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class UtilProvider extends ChangeNotifier{
  static final UtilProvider rtp = UtilProvider._();
  UtilProvider._();
  
final storage = const FlutterSecureStorage();

  Future responsehttp({required String urlBase}) async{
    var response = await http.get(Uri.parse(urlBase));
    return response;
  }

  Future checkSession() async {
    Map<String, String> allValues = await storage.readAll();
    return allValues['inSesion'] == '1' ? 1 : 0;
  }

  Future clearSession() async {
    await storage.deleteAll();
  }

  Future<bool> loginApi({required String email, required String password}) async {
    try {
      print('Si entro');
      final response = await http.post(
        Uri.parse('https://localhost:7088/api/Auth/Login'),
        body: {
          'user': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        print('Entro al primer if');
        final jsonResponse = json.decode(response.body);
        final bool success = jsonResponse['success'];

        if (success) {
          final String rol = jsonResponse['rol'];
          await saveStorage(usuario: email, password: password, rol: rol);
          return true;
        }
      }
      print('se lo salto');

      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> saveStorage({required String usuario, required String password, required String rol}) async {
    await storage.write(key: 'Usuario', value: usuario);
    await storage.write(key: 'psw', value: password);
    await storage.write(key: 'inSesion', value: '1');
    await storage.write(key: 'role', value: rol);
  }

  bool get isAdmin => storage.read(key: 'rol') == 'Admin';

  bool get isCustomer => storage.read(key: 'rol') == 'Customer';
}

