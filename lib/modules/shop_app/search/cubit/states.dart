abstract class ShopSearchScreenStates {}

class ShopSearchInitialState extends ShopSearchScreenStates {}

class ShopSearchLoadingState extends ShopSearchScreenStates {}

class ShopSearchSuccessState extends ShopSearchScreenStates {}

class ShopSearchErrorState extends ShopSearchScreenStates {
  final String error;

  ShopSearchErrorState(this.error);
}
