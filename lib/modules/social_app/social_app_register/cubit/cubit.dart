import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/social_app/social_user_model.dart';
import 'package:todo_app/modules/social_app/social_app_register/cubit/states.dart';
import 'package:todo_app/shared/network/end_points.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterScreenStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  // late SocialLoginModel loginModel;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(
        email: email,
        name: name,
        phone: phone,
        uId: value.user!.uid,

      );
      // emit(SocialRegisterSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uId,
  }) {
    SocialUserModel userModel = SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      bio: 'write your bio ...',
      image: 'https://image.flaticon.com/icons/png/512/929/929422.png',
      cover: 'https://image.freepik.com/free-vector/hand-drawn-flat-autumn-social-media-cover-template_23-2149102174.jpg',
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  Widget suffix = const Icon(Icons.visibility_outlined);

  bool isPasswordVisible = true;

  void changePasswordVisibilityState() {
    isPasswordVisible = !isPasswordVisible;
    suffix = isPasswordVisible
        ? const Icon(Icons.visibility_outlined)
        : const Icon(Icons.visibility_off_outlined);
    emit(SocialRegisterChangeVisibilityState());
  }
}
