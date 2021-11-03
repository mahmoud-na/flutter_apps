import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/shop_app/cubit/cubit.dart';
import 'package:todo_app/models/shop_app/search_model.dart';
import 'package:todo_app/modules/shop_app/search/cubit/states.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/styles/colors.dart';

import 'cubit/cubit.dart';

class ShopAppSearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  var formKey =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopSearchCubit(),
      child: BlocConsumer<ShopSearchCubit, ShopSearchScreenStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: defaultFormField(
                      textEditingController: searchController,
                      textInputType: TextInputType.text,
                      onChanged: (value) {
                        ShopSearchCubit.get(context).getSearchResult(value);
                      },
                      labelText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Text to search';
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  if(state is ShopSearchLoadingState)
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: LinearProgressIndicator(),
                    ),
                  if(state is ShopSearchSuccessState)
                  // if((ShopSearchCubit.get(context).searchModel !=null))
                    Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => favoritesItemBuilder(
                          ShopSearchCubit.get(context)
                              .searchModel!
                              .data!
                              .data[index],
                          context),
                      separatorBuilder: (context, index) => myDivider(),
                      itemCount: ShopSearchCubit.get(context)
                          .searchModel!
                          .data!
                          .data.length,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget favoritesItemBuilder(SearchProduct model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 120.0,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model.image!),
                    width: 120.0,
                    height: 120.0,
                  ),
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
                        model.name!,
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
                          model.price.toString(),
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: defaultColor,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            // ShopCubit.get(context)
                            //     .changeFavorites(model.product!.id!);
                          },
                          icon: (model.inFavorites)!
                              ?
                              // (ShopCubit.get(context).favorites![model.product!.id!])! ?
                              const Icon(
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
