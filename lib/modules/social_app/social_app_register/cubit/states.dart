import 'package:todo_app/models/shop_app/shop_login_model.dart';

abstract class SocialRegisterScreenStates {}

class SocialRegisterInitialState extends SocialRegisterScreenStates {}

class SocialRegisterLoadingState extends SocialRegisterScreenStates {}

class SocialRegisterSuccessState extends SocialRegisterScreenStates {}

class SocialRegisterErrorState extends SocialRegisterScreenStates {
  final String error;

  SocialRegisterErrorState(this.error);
}

class SocialRegisterChangeVisibilityState extends SocialRegisterScreenStates {}


class SocialCreateUserSuccessState extends SocialRegisterScreenStates {}

class SocialCreateUserErrorState extends SocialRegisterScreenStates {
  final String error;

  SocialCreateUserErrorState(this.error);
}
