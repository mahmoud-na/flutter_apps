import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/social_app/chats/chats_screen.dart';
import 'package:todo_app/modules/social_app/feeds/feeds_screen.dart';
import 'package:todo_app/modules/social_app/settings/settings_screen.dart';
import 'package:todo_app/modules/social_app/social_login/cubit/states.dart';
import 'package:todo_app/modules/social_app/users/users_screen.dart';
import 'package:todo_app/shared/components/constants.dart';
import 'package:todo_app/shared/network/end_points.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';

class SocialLoginCubit extends Cubit<SocialLoginScreenStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  // late SocialLoginModel loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      uId = value.user!.uid;
      emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((error) {
      print(error.toString());
      emit(SocialLoginErrorState(error.toString()));
    });
  }

  Widget suffix = const Icon(Icons.visibility_outlined);

  bool isPasswordVisible = true;

  void changePasswordVisibilityState() {
    isPasswordVisible = !isPasswordVisible;
    suffix = isPasswordVisible
        ? const Icon(Icons.visibility_outlined)
        : const Icon(Icons.visibility_off_outlined);
    emit(SocialLoginChangeVisibilityState());
  }
}
