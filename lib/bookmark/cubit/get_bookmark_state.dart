part of 'get_bookmark_cubit.dart';

@immutable
sealed class GetBookmarkState {}

final class GetBookmarkInitial extends GetBookmarkState {}

final class GetBookmarkLoadingState extends GetBookmarkState {}

final class GetBookmarkErrorState extends GetBookmarkState {
  final String message;

  GetBookmarkErrorState(this.message);
}

final class GetBookmarkSuccessState extends GetBookmarkState {}
