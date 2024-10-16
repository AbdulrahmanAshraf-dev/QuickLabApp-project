part of 'sub_login_cubit.dart';

class SubLoginState {}

final class SubLoginInitial extends SubLoginState {}
final class SubLoginLoading extends SubLoginState {}
final class SubLoginSuccessful extends SubLoginState {}
final class SubLoginFailure extends SubLoginState {
  String error;

  SubLoginFailure(this.error);
}
