abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String error;

  SocialGetUserErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates {}

class SocialAddNewPostState extends SocialStates {}

class SocialUpdateProfileImagePickedSuccessState extends SocialStates {}

class SocialUpdateProfileImagePickedErrorState extends SocialStates {}

class SocialUpdateCoverImagePickedSuccessState extends SocialStates {}

class SocialUpdateCoverImagePickedErrorState extends SocialStates {}

class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

class SocialUploadCoverImageSuccessState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

class SocialUpdateUserLoadingState extends SocialStates {}

class SocialUpdateUserErrorState extends SocialStates {}




class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostSuccessState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}


class SocialPostImagePickedSuccessState extends SocialStates {}

class SocialPostImagePickedErrorState extends SocialStates {}


class SocialRemovePostImageState extends SocialStates {}