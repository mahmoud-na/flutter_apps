abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String error;

  SocialGetUserErrorState(this.error);
}



class SocialGetAllUsersLoadingState extends SocialStates {}

class SocialGetAllUsersSuccessState extends SocialStates {}

class SocialGetAllUsersErrorState extends SocialStates {
  final String error;

  SocialGetAllUsersErrorState(this.error);
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



class SocialGetPostsLoadingState extends SocialStates {}

class SocialGetPostsSuccessState extends SocialStates {}

class SocialGetPostsErrorState extends SocialStates {
  final String error;

  SocialGetPostsErrorState(this.error);
}


class SocialLikePostSuccessState extends SocialStates {}

class SocialLikePostErrorState extends SocialStates {
  final String error;

  SocialLikePostErrorState(this.error);
}

//chat
class SocialSendMessageSuccessState extends SocialStates {}

class SocialSendMessageErrorState extends SocialStates {}

class SocialGetMessageSuccessState extends SocialStates {}






