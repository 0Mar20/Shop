import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/network/cache_helper.dart';

void SignOut (context){
  CacheHelper.removeData('token').then((value) {
    if(value) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    }
  });
}

String token = '';