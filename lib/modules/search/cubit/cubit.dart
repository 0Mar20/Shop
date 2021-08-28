import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constants/processes.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/network/endpoints.dart';
import 'package:shop_app/network/remote/remote.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel searchModel;

  void search({
    @required String text,
  }) {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: SEARCH_ENDPOINT,
      data: {
        text: text,
      },
      token: token
    ).then(
      (value) {
        searchModel = SearchModel.fromJson(value.data);
        emit(SearchSuccessState());
      },
    ).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
