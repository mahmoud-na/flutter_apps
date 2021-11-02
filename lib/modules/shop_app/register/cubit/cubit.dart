import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/shop_app/shop_login_model.dart';
import 'package:todo_app/modules/shop_app/login/cubit/states.dart';
import 'package:todo_app/modules/shop_app/register/cubit/states.dart';
import 'package:todo_app/shared/network/end_points.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterScreenStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  late ShopLoginModel loginModel;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,
      },
    ).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      print('=======================================');
      print(loginModel.message);
      print('=======================================');
      print(loginModel.data?.token);
      print('=======================================');
      print(loginModel.data?.name);
      print('=======================================');
      print(loginModel.data?.phone);
      print('=======================================');
      print(loginModel.data?.email);
      print('=======================================');

      emit(ShopRegisterSuccessState(
        loginModel: loginModel,
      ));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  Widget suffix = const Icon(Icons.visibility_outlined);

  bool isPasswordVisible = true;

  void changePasswordVisibilityState() {
    isPasswordVisible = !isPasswordVisible;
    suffix = isPasswordVisible
        ? const Icon(Icons.visibility_outlined)
        : const Icon(Icons.visibility_off_outlined);
    emit(ShopRegisterChangeVisibilityState());
  }
}
