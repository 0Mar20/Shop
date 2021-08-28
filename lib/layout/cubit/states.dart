import 'package:shop_app/models/change_favourites_model.dart';
import 'package:shop_app/models/login_model.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class ChangeBottomNavBarState extends AppStates {}

class HomeDataLoadingState extends AppStates {}

class HomeDataSuccessState extends AppStates {}

class HomeDataFailureState extends AppStates {}

class CategoriesDataSuccessState extends AppStates {}

class CategoriesDataFailureState extends AppStates {}

class ChangeFavouritesState extends AppStates {}

class ChangeFavouritesSuccessState extends AppStates {
  final ChangeFavouritesModel changeFavouritesModel;

  ChangeFavouritesSuccessState(this.changeFavouritesModel);
}

class ChangeFavouritesFailureState extends AppStates {}

class GrtFavouritesLoadingState extends AppStates {}

class GrtFavouritesSuccessState extends AppStates {}

class GetFavouritesFailureState extends AppStates {}

class GetUserDataLoadingState extends AppStates {}

class GetUserDataSuccessState extends AppStates {
  final LoginModel loginModel;

  GetUserDataSuccessState(this.loginModel);
}

class GetUserDataFailureState extends AppStates {}

class UpdateUserDataLoadingState extends AppStates {}

class UpdateUserDataSuccessState extends AppStates {
  final LoginModel loginModel;

  UpdateUserDataSuccessState(this.loginModel);
}

class UpdateUserDataFailureState extends AppStates {}
