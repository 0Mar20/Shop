import 'package:shop_app/models/login_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {

  final LoginModel loginModel;

  RegisterSuccessState(this.loginModel);

}

class RegisterFailureState extends RegisterStates {

  final String error;

  RegisterFailureState(this.error);

}

class PasswordVisibilityState extends RegisterStates {}
