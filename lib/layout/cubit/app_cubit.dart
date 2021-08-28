import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constants/processes.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favourites_model.dart';
import 'package:shop_app/models/favourites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favourites/favourite_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/network/endpoints.dart';
import 'package:shop_app/network/remote/remote.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomNavBarItems = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouriteScreen(),
    SettingScreen(),
  ];

  void changeBottomNavBarScreen(index) {
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }

  HomeModel homeModel;
  Map<int, bool> favourites = {};

  void getHomeData() {
    emit(
      HomeDataLoadingState(),
    );
    DioHelper.getData(
      url: HOME_ENDPOINT,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel.data.products.forEach((element) {
        favourites.addAll({element.id: element.inFavorites});
      });
      // print(favourites.toString());
      emit(
        HomeDataSuccessState(),
      );
    }).catchError((error) {
      print(error.toString());
      emit(
        HomeDataFailureState(),
      );
    });
  }

  CategoriesModel categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(
      url: GET_CATEGORIES_ENDPOINT,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(
        CategoriesDataSuccessState(),
      );
    }).catchError((error) {
      print(error.toString());
      emit(
        CategoriesDataFailureState(),
      );
    });
  }

  ChangeFavouritesModel changeFavouritesModel;

  void changeFavourites(int productId) {
    favourites[productId] = !favourites[productId];
    emit(ChangeFavouritesState());
    DioHelper.postData(
      url: FAVOURITES_ENDPOINT,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavouritesModel = ChangeFavouritesModel.fromJson(value.data);
      if (!changeFavouritesModel.status) {
        favourites[productId] = !favourites[productId];
      } else {
        getFavourites();
      }
      emit(ChangeFavouritesSuccessState(changeFavouritesModel));
    }).catchError((error) {
      favourites[productId] = !favourites[productId];
      emit(ChangeFavouritesFailureState());
    });
  }

  FavouritesModel favouritesModel;

  void getFavourites() {
    emit(
      GrtFavouritesLoadingState(),
    );
    DioHelper.getData(
      url: FAVOURITES_ENDPOINT,
      token: token,
    ).then((value) {
      favouritesModel = FavouritesModel.fromJson(value.data);
      emit(
        GrtFavouritesSuccessState(),
      );
    }).catchError((error) {
      print(error.toString());
      emit(
        GetFavouritesFailureState(),
      );
    });
  }

  LoginModel userData;

  void getUserData() {
    emit(GetUserDataLoadingState());

    DioHelper.getData(
      url: PROFILE_ENDPOINT,
      token: token,
    ).then(
      (value) {
        userData = LoginModel.fromJson(value.data);
        emit(
          GetUserDataSuccessState(userData),
        );
      },
    ).catchError(
      (error) {
        print(error.toString());
        emit(
          GetUserDataFailureState(),
        );
      },
    );
  }

  void updateUserData({
    @required String name,
    @required String email,
    @required String phone,
  }) {
    emit(UpdateUserDataLoadingState());

    DioHelper.putData(
      url: UPDATE_PROFILE_ENDPOINT,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then(
      (value) {
        userData = LoginModel.fromJson(value.data);
        emit(
          UpdateUserDataSuccessState(userData),
        );
      },
    ).catchError(
      (error) {
        print(error.toString());
        emit(
          UpdateUserDataFailureState(),
        );
      },
    );
  }
}
