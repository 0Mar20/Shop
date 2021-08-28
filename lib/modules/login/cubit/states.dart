import 'package:shop_app/models/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {

  final LoginModel loginModel;

  LoginSuccessState(this.loginModel);

}

class LoginFailureState extends LoginStates {

  final String error;

  LoginFailureState(this.error);

}

class PasswordVisibilityState extends LoginStates {}
