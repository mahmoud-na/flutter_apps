import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/shop_app/search_model.dart';
import 'package:todo_app/modules/shop_app/search/cubit/states.dart';
import 'package:todo_app/shared/components/constants.dart';
import 'package:todo_app/shared/network/end_points.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';

class ShopSearchCubit extends Cubit<ShopSearchScreenStates> {
  ShopSearchCubit() : super(ShopSearchInitialState());

  static ShopSearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void getSearchResult(String text) {
    emit(ShopSearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      authorization: token!,
      data: {
        'text': text,
      },
    ).then((value) {
      emit(ShopSearchSuccessState());
      searchModel = SearchModel.fromJson(value.data);
    }).catchError((error) {
      print(error.toString());
      emit(ShopSearchErrorState(error.toString()));
    });
  }
}
