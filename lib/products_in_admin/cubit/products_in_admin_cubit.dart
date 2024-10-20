import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:quicklab/home/models/products_data.dart';

part 'products_in_admin_state.dart';

class ProductsInAdminCubit extends Cubit<ProductsInAdminState> {
  ProductsInAdminCubit() : super(ProductsInAdminInitial());
  List<ProductsData> products = [];
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void getProducts() async {
    emit(ProductsInAdminLoadingState());
    try {
      QuerySnapshot querySnapshot = await firestore.collection('scans').get();

      products = querySnapshot.docs.map((doc) {
        return ProductsData.fromJson(
            doc.data() as Map<String, dynamic>, doc.id, false);
      }).toList();
      querySnapshot = await firestore.collection('tests').get();
      products = querySnapshot.docs.map((doc) {
        return ProductsData.fromJson(
            doc.data() as Map<String, dynamic>, doc.id, true);
      }).toList();

      emit(ProductsInAdminSuccessState());
    } catch (e) {
      emit(ProductsInAdminErrorState(e.toString()));
    }
  }
}
