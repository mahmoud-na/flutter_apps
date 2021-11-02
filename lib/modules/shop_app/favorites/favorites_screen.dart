import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/shop_app/cubit/cubit.dart';
import 'package:todo_app/layout/shop_app/cubit/states.dart';
import 'package:todo_app/models/shop_app/favorites_model.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopGetFavoritesDataLoadingState,
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => favoritesItemBuilder(
                ShopCubit.get(context).favoritesModel!.data!.data[index],
                context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: ShopCubit.get(context).favoritesModel!.data!.data.length,
          ),
          fallback: (context) => const CircularProgressIndicator(),
        );
      },
    );
  }

  Widget favoritesItemBuilder(FavoritesData model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 120.0,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model.product!.image!),
                    width: 120.0,
                    height: 120.0,
                  ),
                  if (model.product!.discount! != 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5.0,
                      ),
                      color: Colors.red,
                      child: const Text(
                        'DISCOUNT',
                        style: TextStyle(
                          fontSize: 8.0,
                          color: Colors.white,
                        ),
                      ),
                    )
                ],
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 37.0,
                      child: Text(
                        model.product!.name!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14.0,
                          height: 1.3,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          model.product!.price.toString(),
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: defaultColor,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        if ((model.product!.discount!) != 0)
                          Text(
                            model.product!.oldPrice.toString(),
                            style: const TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context)
                                .changeFavorites(model.product!.id!);
                          },
                          icon: (ShopCubit.get(context)
                                  .favorites![model.product!.id!])!
                              ? const Icon(
                                  Icons.favorite,
                                  size: 20.0,
                                  color: Colors.red,
                                )
                              : const Icon(
                                  Icons.favorite_border,
                                  size: 20.0,
                                ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
