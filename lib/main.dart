import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constants/processes.dart';
import 'package:shop_app/constants/styles.dart';
import 'package:shop_app/layout/cubit/app_cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'file:///D:/Flutter_CV/shop_app/lib/layout/main_screen.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/network/cache_helper.dart';
import 'modules/onBoarding/on_boarding_screen.dart';
import 'my_bloc_observer.dart';
import 'network/remote/remote.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget startWidget;
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print(token);

  if (onBoarding != null) {
    if (token != null) {
      startWidget = HomeScreen();
    } else {
      startWidget = LoginScreen();
    }
  } else {
    startWidget = OnBoardingScreen();
  }

  runApp(ShopApp(
    startWidget: startWidget,
  ));
}

class ShopApp extends StatelessWidget {
  final Widget startWidget;

  const ShopApp({this.startWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getHomeData()..getCategoriesData()..getFavourites()..getUserData(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: startWidget,
            theme: lightTheme,
          );
        },
      )
    );
  }
}
