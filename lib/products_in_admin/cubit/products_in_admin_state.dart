part of 'products_in_admin_cubit.dart';

@immutable
sealed class ProductsInAdminState {}

final class ProductsInAdminInitial extends ProductsInAdminState {}

final class ProductsInAdminLoadingState extends ProductsInAdminState {}

final class ProductsInAdminSuccessState extends ProductsInAdminState {}

final class ProductsInAdminErrorState extends ProductsInAdminState {
  final String message;

  ProductsInAdminErrorState(this.message);
}
