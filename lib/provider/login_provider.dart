import 'dart:core';
import 'package:flutter/cupertino.dart';

class LoginFormProvider extends ChangeNotifier { 
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  
  String user = '';
  String password = '';
  bool _isLoading = false; 

  bool get isLoading => _isLoading; 
  
  set isLoading (bool value) {
    _isLoading = value; 
    notifyListeners();

  }

  bool isValidForm() {
    return formkey.currentState?.validate() ?? false;
  }
}