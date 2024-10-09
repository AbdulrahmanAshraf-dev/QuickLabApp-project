part of 'tests_cubit.dart';

@immutable
sealed class TestsState {}

final class TestsInitial extends TestsState {}

final class TestsLoadingState extends TestsState {}

final class TestsErrorState extends TestsState {
  final String message;

  TestsErrorState(this.message);
}

final class TestsSuccessState extends TestsState {}
