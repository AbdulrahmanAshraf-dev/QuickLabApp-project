part of 'login_cubit.dart';

 class LoginState {}

final class LoginInitial extends LoginState {}
final class LoginLoading extends LoginState {}
final class LoginFailure extends LoginState { String error;

LoginFailure(this.error);
}
final class LoginSuccessful extends LoginState {
  dynamic result;
  LoginSuccessful(this.result);
}

