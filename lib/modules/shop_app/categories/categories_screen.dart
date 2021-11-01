import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/shop_app/cubit/cubit.dart';
import 'package:todo_app/layout/shop_app/cubit/states.dart';
import 'package:todo_app/models/shop_app/categories_model.dart';
import 'package:todo_app/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => itemCategoryBuilder(
              ShopCubit.get(context).categoriesModel!.data!.data[index]),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length,
        );
      },
    );
  }

  Widget itemCategoryBuilder(CategoryModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.image!),
              width: 80.0,
              height: 80.0,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Text(
              model.name!,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      );
}
