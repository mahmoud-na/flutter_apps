import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/social_app/cubit/states.dart';

import 'package:todo_app/models/social_app/social_user_model.dart';
import 'package:todo_app/modules/shop_app/settings_screen/settings_screen.dart';
import 'package:todo_app/modules/social_app/chats/chats_screen.dart';
import 'package:todo_app/modules/social_app/feeds/feeds_screen.dart';
import 'package:todo_app/modules/social_app/new_post/new_post_screen.dart';
import 'package:todo_app/modules/social_app/settings/settings_screen.dart';
import 'package:todo_app/modules/social_app/users/users_screen.dart';
import 'package:todo_app/shared/components/constants.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);
  SocialUserModel? userModel;

  void getUserData() {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = SocialUserModel.fromJson(value.data()!);
      print(value.data());
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    const SocialFeedsScreen(),
    const SocialChatsScreen(),
    const NewPostScreen(),
    const SocialUsersScreen(),
    const SocialSettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'NewPost',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index) {
    if (index == 2) {
      emit(SocialAddNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }
}