import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/social_app/social_app_layout.dart';
import 'package:todo_app/modules/social_app/social_app_register/social_register_screen.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/network/local/cache_helper.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialLoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginScreenStates>(
        listener: (context, state) {

          if(state is SocialLoginErrorState){
            showToast(
              msg: state.error,
              state: ToastStates.ERROR,
            );
          }
          if(state is SocialLoginSuccessState){
            CacheHelper.saveData(
              key: "uId",
              value: state.uid,
            ).then((value) {
              navigateAndReplace(context, const SocialAppScreen());
            });
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
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Login now to communicate with friends',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(
                          height: 30.0,
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
                              SocialLoginCubit.get(context)
                                  .changePasswordVisibilityState();
                            },
                            icon: SocialLoginCubit.get(context).suffix,
                          ),
                          enableInteractiveSelection: true,
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              SocialLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          obscureText:
                              SocialLoginCubit.get(context).isPasswordVisible,
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
                          condition: state is! SocialLoginLoadingState,
                          builder: (context) => defaultButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                SocialLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: 'login',
                            isUpperCase: true,
                          ),
                          fallback: (BuildContext context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account?',
                            ),
                            defaultTextButton(
                              text: 'Register',
                              onPressed: () {
                                navigateTo(
                                  context,
                                  SocialRegisterScreen(),
                                );
                              },
                            )
                          ],
                        )
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
