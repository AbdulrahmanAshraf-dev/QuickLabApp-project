part of 'users_in_admin_cubit.dart';

@immutable
sealed class UsersInAdminState {}

final class UsersInAdminInitial extends UsersInAdminState {}

final class UsersInAdminLoadingState extends UsersInAdminState {}

final class UsersInAdminErrorState extends UsersInAdminState {
  final String message;

  UsersInAdminErrorState(this.message);
}

final class UsersInAdminSuccessState extends UsersInAdminState {}
