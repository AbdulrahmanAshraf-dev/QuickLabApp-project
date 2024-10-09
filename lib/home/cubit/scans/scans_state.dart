part of 'scans_cubit.dart';

@immutable
sealed class ScansState {}

final class ScansInitial extends ScansState {}

final class ScansErrorState extends ScansState {
  final String message;

  ScansErrorState(this.message);
}

final class ScansLoadingState extends ScansState {}

final class ScansSuccessState extends ScansState {}
