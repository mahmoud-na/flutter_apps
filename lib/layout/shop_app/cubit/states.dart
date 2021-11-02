import 'package:todo_app/models/shop_app/change_favorites_model.dart';

abstract class ShopStates {}


class ShopInitialState extends ShopStates {}

class ShopBottomNavState extends ShopStates {}

class ChangeShopBottomNavIndexState extends ShopStates {}



class ShopHomeDataLoadingState extends ShopStates{}
class ShopHomeDataSuccessState extends ShopStates{}
class ShopHomeDataErrorState extends ShopStates{
  final String error;
  ShopHomeDataErrorState(this.error);
}

class ShopCategoriesDataLoadingState extends ShopStates{}
class ShopCategoriesDataSuccessState extends ShopStates{}
class ShopCategoriesDataErrorState extends ShopStates{
  final String error;
  ShopCategoriesDataErrorState(this.error);
}



class ShopFavoritesChangeState extends ShopStates{}
class ShopFavoritesChangeSuccessState extends ShopStates{
  final ChangeFavoritesModel model;
  ShopFavoritesChangeSuccessState(this.model);
}
class ShopFavoritesChangeErrorState extends ShopStates{
  final String error;
  ShopFavoritesChangeErrorState(this.error);
}



class ShopGetFavoritesDataLoadingState extends ShopStates{}
class ShopGetFavoritesDataSuccessState extends ShopStates{}
class ShopGetFavoritesDataErrorState extends ShopStates{
  final String error;
  ShopGetFavoritesDataErrorState(this.error);
}




