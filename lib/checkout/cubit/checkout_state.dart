part of 'checkout_cubit.dart';

@immutable
sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

final class CheckoutLoadingState extends CheckoutState {}

final class CheckoutSuccessState extends CheckoutState {}

final class CheckoutErrorState extends CheckoutState {
  final String error;

  CheckoutErrorState(this.error);
}
