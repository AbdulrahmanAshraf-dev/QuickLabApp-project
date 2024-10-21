part of 'cart_cubit.dart';

class CartState {}

final class CartInitial extends CartState {}

final class AddCartLoading extends CartState {}

final class GetCartLoading extends CartState {}
final class RemoveCartLoading extends CartState {}

final class AddCartSuccessful extends CartState {}
final class RemoveCartSuccessful extends CartState {}

final class GetCartSuccessful extends CartState {
  List<ProductsData> data;
  double total;
  GetCartSuccessful(this.data,this.total);
}

final class AddCartFailure extends CartState {}
final class RemoveCartFailure extends CartState {
  String error;

  RemoveCartFailure(this.error);
}

final class GetCartFailure extends CartState {
  String error;

  GetCartFailure(this.error);
}final class GetCartSuccessfulWithTotalPrice extends CartState {
  double total;

  GetCartSuccessfulWithTotalPrice(this.total);
}
