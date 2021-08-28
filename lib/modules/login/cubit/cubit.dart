import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constants/processes.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/network/endpoints.dart';
import 'package:shop_app/network/remote/remote.dart';

class LoginCubit extends Cubit<LoginStates> {
  //initial state must be assigned in the beginning of the Cubit .....
  LoginCubit() : super(LoginInitialState());

  //have an object of ur cubit to make it easy to use .....
  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel loginModel;

  void userLogin({
    @required String email,
    @required String password,
  }) {
    emit(LoginLoadingState());

    DioHelper.postData(
      url: LOGIN_ENDPOINT,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value);
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(
        LoginFailureState(
          error.toString(),
        ),
      );
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibilityState() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(PasswordVisibilityState());
  }
}
