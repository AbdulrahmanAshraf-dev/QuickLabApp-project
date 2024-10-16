part of 'edit_profile_cubit.dart';

class EditProfileState {}

final class EditProfileInitial extends EditProfileState {}
final class ProfileLoading extends EditProfileState {}

final class EditProfileSuccessful extends EditProfileState {

}
final class EditProfileFailure extends EditProfileState {
  String error ;

  EditProfileFailure(this.error);
}
