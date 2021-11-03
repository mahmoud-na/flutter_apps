import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/social_app/cubit/cubit.dart';
import 'package:todo_app/models/social_app/cubit/states.dart';
import 'package:todo_app/shared/components/components.dart';

class SocialAppScreen extends StatelessWidget {
  const SocialAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("News Feed"),
          ),
          body: ConditionalBuilder(
            condition: SocialCubit.get(context).model != null,
            builder: (context) {
              var model = SocialCubit.get(context).model;
              return Column(
                children: [
                  if (!FirebaseAuth.instance.currentUser!.emailVerified)
                    Container(
                      color: Colors.amber.withOpacity(0.6),
                      height: 50.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.info_outline),
                            const SizedBox(
                              width: 15.0,
                            ),
                            const Expanded(
                              child: Text(
                                "Please verify your email",
                              ),
                            ),
                            // const Spacer(),
                            const SizedBox(
                              width: 15.0,
                            ),

                            defaultTextButton(
                              text: "Send",
                              onPressed: () {
                                FirebaseAuth.instance.currentUser!
                                    .sendEmailVerification()
                                    .then((value) {
                                      showToast(msg: 'Check your mail', state: ToastStates.SUCCESS);
                                })
                                    .catchError((error) {});
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                ],
              );
            },
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
