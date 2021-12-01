import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/shop_app/cubit/states.dart';
import 'package:todo_app/models/shop_app/categories_model.dart';
import 'package:todo_app/models/shop_app/change_favorites_model.dart';
import 'package:todo_app/models/shop_app/favorites_model.dart';
import 'package:todo_app/models/shop_app/shop_app_home_model.dart';
import 'package:todo_app/models/shop_app/shop_login_model.dart';
import 'package:todo_app/modules/shop_app/categories/categories_screen.dart';
import 'package:todo_app/modules/shop_app/favorites/favorites_screen.dart';
import 'package:todo_app/modules/shop_app/products/products_screen.dart';
import 'package:todo_app/modules/shop_app/settings_screen/settings_screen.dart';
import 'package:todo_app/shared/components/constants.dart';
import 'package:todo_app/shared/network/end_points.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screensList = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingsScreen(),
  ];

  List<BottomNavigationBarItem> navBarIconsList = [];

  void changeBottomNavBarState(int index) {
    currentIndex = index;
    emit(ChangeShopBottomNavIndexState());
  }

  HomeModel? homeModel;
  Map<int, bool>? favorites = {};

  void getHomeData() {
    emit(ShopHomeDataLoadingState());
    DioHelper.getData(
      url: HOME,
      authorization: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data.products.forEach((element) {
        favorites!.addAll({
          element.id!: element.inFavorites!,
        });
      });
      print("Favorites List: ${favorites.toString()}");

      emit(ShopHomeDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopHomeDataErrorState(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoryData() {
    emit(ShopCategoriesDataLoadingState());

    DioHelper.getData(
      url: GET_CATEGORIES,
      authorization: '',
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopCategoriesDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopCategoriesDataErrorState(error.toString()));
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites![productId] = !(favorites![productId])!;
    emit(ShopFavoritesChangeState());
    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      authorization: token!,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (!(changeFavoritesModel!.status)!) {
        favorites![productId] = !(favorites![productId])!;
      } else {
        getFavoritesData();
      }
      emit(ShopFavoritesChangeSuccessState(changeFavoritesModel!));
    }).catchError((error) {
      favorites![productId] = !(favorites![productId])!;
      emit(ShopFavoritesChangeErrorState(error.toString()));
    });
  }

  FavoritesModel? favoritesModel;

  void getFavoritesData() {
    emit(ShopGetFavoritesDataLoadingState());
    print(token);
    DioHelper.getData(
      url: FAVORITES,
      authorization: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopGetFavoritesDataSuccessState());
    }).catchError((error) {
      print(error);
      emit(ShopGetFavoritesDataErrorState(error.toString()));
    });
  }

  ShopLoginModel? profileModel;

  void getProfileData() {
    emit(ShopGetProfileDataLoadingState());
    DioHelper.getData(
      url: PROFILE,
      authorization: token,
    ).then((value) {
      profileModel = ShopLoginModel.fromJson(value.data);
      emit(ShopGetProfileDataSuccessState(profileModel!));
    }).catchError((error) {
      print(error);
      emit(ShopGetProfileDataErrorState(error.toString()));
    });
  }

  void updateProfileData({
    required name,
    required phone,
    required email,
  }) {
    emit(ShopUpdateProfileDataLoadingState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      authorization: token!,
      data: {
        'name': name,
        'phone': phone,
        'email': email,
      },
    ).then((value) {
      profileModel = ShopLoginModel.fromJson(value.data);
      emit(ShopUpdateProfileDataSuccessState(profileModel!));
    }).catchError((error) {
      print(error);
      emit(ShopUpdateProfileDataErrorState(error.toString()));
    });
  }
}
