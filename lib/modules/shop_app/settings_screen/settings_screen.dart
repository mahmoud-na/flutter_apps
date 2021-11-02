import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/shop_app/cubit/cubit.dart';
import 'package:todo_app/layout/shop_app/cubit/states.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).profileModel;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;

        return ConditionalBuilder(
          condition: (ShopCubit.get(context).profileModel) != null,
          builder: (context) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is ShopUpdateProfileDataLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      textEditingController: nameController,
                      textInputType: TextInputType.name,
                      labelText: 'Name',
                      prefixIcon: const Icon(Icons.person),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name must be not empty';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      textEditingController: emailController,
                      textInputType: TextInputType.emailAddress,
                      labelText: 'Email Address',
                      prefixIcon: const Icon(Icons.email),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email Address must be not empty';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      textEditingController: phoneController,
                      textInputType: TextInputType.phone,
                      labelText: 'Phone Number',
                      prefixIcon: const Icon(Icons.phone),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Phone Number must be not empty';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          ShopCubit.get(context).updateProfileData(
                            email: emailController.text,
                            name: nameController.text,
                            phone: phoneController.text,
                          );
                        }
                      },
                      text: "Update Profile",
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                      onPressed: () {
                        signOut(context);
                      },
                      text: "Logout",
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
