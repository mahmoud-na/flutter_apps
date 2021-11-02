import 'package:todo_app/models/shop_app/shop_login_model.dart';

abstract class ShopRegisterScreenStates {}

class ShopRegisterInitialState extends ShopRegisterScreenStates {}

class ShopRegisterLoadingState extends ShopRegisterScreenStates {}

class ShopRegisterSuccessState extends ShopRegisterScreenStates {
  final ShopLoginModel loginModel;
  ShopRegisterSuccessState({required this.loginModel});
}

class ShopRegisterErrorState extends ShopRegisterScreenStates {
  final String error;

  ShopRegisterErrorState(this.error);
}

class ShopRegisterChangeVisibilityState extends ShopRegisterScreenStates {}
