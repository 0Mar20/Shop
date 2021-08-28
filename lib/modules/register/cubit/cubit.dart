import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/network/endpoints.dart';
import 'package:shop_app/network/remote/remote.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  //initial state must be assigned in the beginning of the Cubit .....
  RegisterCubit() : super(RegisterInitialState());

  //have an object of ur cubit to make it easy to use .....
  static RegisterCubit get(context) => BlocProvider.of(context);

  LoginModel loginModel;

  void userRegister({
    @required String name,
    @required String email,
    @required String phone,
    @required String password,
  }) {
    emit(RegisterLoadingState());

    DioHelper.postData(
      url: REGISTER_ENDPOINT,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      },
    ).then((value) {
      print(value);
      loginModel = LoginModel.fromJson(value.data);
      emit(RegisterSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(
        RegisterFailureState(
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
