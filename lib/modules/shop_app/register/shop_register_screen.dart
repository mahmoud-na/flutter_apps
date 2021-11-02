import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/shop_app/shop_app_layout.dart';
import 'package:todo_app/modules/shop_app/login/cubit/cubit.dart';
import 'package:todo_app/modules/shop_app/login/cubit/states.dart';
import 'package:todo_app/modules/shop_app/register/cubit/states.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/components/constants.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/network/local/cache_helper.dart';

import 'cubit/cubit.dart';

class ShopRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterScreenStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status == true) {
              print('=======================================');
              print(state.loginModel.data?.token);
              print('=======================================');
              print(state.loginModel.message);
              print('=======================================');

              showToast(
                msg: '${state.loginModel.message}',
                state: ToastStates.SUCCESS,
              );
              CacheHelper.saveData(
                key: "token",
                value: state.loginModel.data?.token,
              ).then((value) {
                token = state.loginModel.data!.token!;
                navigateAndReplace(context, const ShopLayout());
              });

            } else {
              print('=======================================');
              print(state.loginModel.message);
              print('=======================================');
              showToast(
                msg: '${state.loginModel.message}',
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    AppCubit.get(context).changeAppThemeMode();
                  },
                  icon: const Icon(
                    Icons.dark_mode,
                  ),
                ),
              ],
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          textEditingController: nameController,
                          textInputType: TextInputType.name,
                          labelText: 'Name',
                          onFieldSubmitted: (value) {},
                          prefixIcon: const Icon(Icons.person),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Name is too short';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          textEditingController: phoneController,
                          textInputType: TextInputType.phone,
                          labelText: 'Phone',
                          onFieldSubmitted: (value) {},
                          prefixIcon: const Icon(Icons.phone),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Phone is too short';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          textEditingController: emailController,
                          textInputType: TextInputType.emailAddress,
                          labelText: 'Email Address',
                          prefixIcon: const Icon(Icons.email_outlined),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email Address must be not empty';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          textEditingController: passwordController,
                          textInputType: TextInputType.visiblePassword,
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              ShopRegisterCubit.get(context)
                                  .changePasswordVisibilityState();
                            },
                            icon: ShopRegisterCubit.get(context).suffix,
                          ),
                          enableInteractiveSelection: true,
                          onFieldSubmitted: (value) {},
                          obscureText:
                              ShopRegisterCubit.get(context).isPasswordVisible,
                          prefixIcon: const Icon(Icons.lock_outline),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password is too short';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          // condition: state is! ShopLoginLoadingState,
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => defaultButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                );
                              }
                            },
                            text: 'Register',
                            isUpperCase: true,
                          ),
                          fallback: (BuildContext context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
