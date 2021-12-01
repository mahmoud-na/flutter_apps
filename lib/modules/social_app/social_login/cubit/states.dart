
abstract class SocialLoginScreenStates {}

class SocialLoginInitialState extends SocialLoginScreenStates {}

class SocialLoginLoadingState extends SocialLoginScreenStates {}

class SocialLoginSuccessState extends SocialLoginScreenStates {
final String uid;
  SocialLoginSuccessState(this.uid);
}

class SocialLoginErrorState extends SocialLoginScreenStates {
  final String error;

  SocialLoginErrorState(this.error);
}

class SocialLoginChangeVisibilityState extends SocialLoginScreenStates {}
