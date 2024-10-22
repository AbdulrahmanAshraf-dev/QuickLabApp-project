import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quicklab/home/cubit/scans/scans_cubit.dart';
import 'package:quicklab/home/cubit/tests/tests_cubit.dart';

import '../../models/products_data.dart';
import '../../widget/cart_page.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  String? userID = FirebaseAuth.instance.currentUser?.uid;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<ProductsData> items = [];

  void getCartItems() async {
    emit(CartLoadingState());
    try {
      DocumentSnapshot<Map<String, dynamic>> querySnapshot =
          await firestore.collection('users').doc(userID).get();
      final bookmarks = querySnapshot['cart'] as List<dynamic>;

      List<ProductsData> products =
          await Future.wait(bookmarks.map((doc) async {
        DocumentSnapshot<Map<String, dynamic>> collectionRef =
            await FirebaseFirestore.instance.doc(doc.path).get();
        return ProductsData.fromJson(
            collectionRef.data() as Map<String, dynamic>,
            doc.id,
            doc.toString().split('/')[0] ==
                    'DocumentReference<Map<String, dynamic>>(tests'
                ? true
                : false);
      }));
      items = products;
      emit(CartSuccessState());
    } catch (e) {
      emit(CartErrorState(e.toString()));
    }
  }

  Future<void> addInCart(
    String item,
    bool isTest,
    int price,
    BuildContext context,
  ) async {
    final DocumentReference docRef =
        FirebaseFirestore.instance.collection("users").doc(userID);
    DocumentReference targetDocRef =
        firestore.collection(isTest ? 'tests' : "scans").doc(item);
    CartPageState.total += price;
    ProductsData.inCartProducts.add(item);
    try {
      await docRef.update({
        "cart": FieldValue.arrayUnion([targetDocRef])
      });
      context.read<CartCubit>().getCartItems();
      isTest
          ? context.read<TestsCubit>().getTests()
          : context.read<ScansCubit>().getScans();
    } catch (error) {

    }
  }

  Future<void> removeFromCart(
    String item,
    bool isTest,
    int price,
    BuildContext context,
  ) async {
    final DocumentReference docRef =
        FirebaseFirestore.instance.collection("users").doc(userID);
    DocumentReference targetDocRef =
        firestore.collection(isTest ? 'tests' : "scans").doc(item);
    CartPageState.total -= price;
    ProductsData.inCartProducts.remove(item);
    try {
      await docRef.update({
        "cart": FieldValue.arrayRemove([targetDocRef])
      });
      context.read<CartCubit>().getCartItems();
      isTest
          ? context.read<TestsCubit>().getTests()
          : context.read<ScansCubit>().getScans();
    } catch (error) {
    }
  }
}
