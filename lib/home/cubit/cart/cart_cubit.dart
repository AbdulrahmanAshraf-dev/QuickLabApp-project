
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quicklab/home/models/products_data.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addToCart(ProductsData data) async {
    emit(AddCartLoading());
    DocumentReference productDoc = fireStore
        .collection("cart")
        .doc(_auth.currentUser!.uid)
        .collection("products")
        .doc();
    try {
      ProductsData productsData = ProductsData(id: productDoc.id,
          name: data.name,
          image: data.image,
          description: data.description,
          isBookmarked: data.isBookmarked,
          isTest: data.isTest,
          price: data.price);
      await productDoc.set(productsData.toMap());
      emit(AddCartSuccessful());
    } on Exception catch (e) {
      emit(AddCartFailure());
    }
  }
  Future<void> getCart() async {
    emit(GetCartLoading());
    try {
      QuerySnapshot snapshot = await fireStore
          .collection("cart")
          .doc(_auth.currentUser!.uid)
          .collection("products")
          .get();
      List<ProductsData> productsData = snapshot.docs.map((doc) {
        return ProductsData.fromJson(doc.data() as Map<String, dynamic>,doc.id,false);
      }).toList();
      double totalPrice = 0.0;
      snapshot.docs.map((doc) {
        var data = ProductsData.fromJson(doc.data() as Map<String, dynamic>,doc.id,false);
        totalPrice += data.price!+50;
        return data;
      }).toList();
      emit(GetCartSuccessful(productsData,totalPrice));
    } on Exception catch (e) {
      emit(GetCartFailure(e.toString()));
    }
  }
  Future<void> removeFromCart(String productId) async {
    emit(RemoveCartLoading());
    try {
      if (productId.isNotEmpty) {
        await fireStore
            .collection("cart")
            .doc(_auth.currentUser!.uid)
            .collection("products")
            .doc(productId)
            .delete();
        emit(RemoveCartSuccessful());
        getCart();
      } else {
        throw Exception("Product =ID is empty");
      }
    } on FirebaseException catch (e) {
      print("Firebase error: ${e.message}");
      emit(RemoveCartFailure(e.message ?? "Unknown Firebase error"));
    } catch (e) {
      print("General error: $e");
      emit(RemoveCartFailure(e.toString()));
    }
  }



}
