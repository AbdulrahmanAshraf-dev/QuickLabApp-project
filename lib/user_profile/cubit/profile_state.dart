part of 'profile_cubit.dart';
class ProfileState {}

final class ProfileInitial extends ProfileState {}
final class ProfileLoading extends ProfileState {}

final class ProfileSuccessful extends ProfileState {
  final ProfileModel userData;

  ProfileSuccessful(this.userData);
}
final class ProfileFailure extends ProfileState {
  String error ;

  ProfileFailure(this.error);
}
final class EditProfileLoading extends ProfileState {}
final class EditProfileSuccessful extends ProfileState {
}
final class EditProfileFailure extends ProfileState {
  String error ;

  EditProfileFailure(this.error);
}