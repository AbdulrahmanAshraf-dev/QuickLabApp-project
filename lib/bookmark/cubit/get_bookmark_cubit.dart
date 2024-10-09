import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quicklab/home/cubit/scans/scans_cubit.dart';
import 'package:quicklab/home/models/products_data.dart';

import '../../home/cubit/tests/tests_cubit.dart';

part 'get_bookmark_state.dart';

class GetBookmarkCubit extends Cubit<GetBookmarkState> {
  GetBookmarkCubit() : super(GetBookmarkInitial());
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<ProductsData> bookmarkList = [];
  String? userID = FirebaseAuth.instance.currentUser?.uid;
  void getBookmark() async {
    emit(GetBookmarkLoadingState());
    try {
      DocumentSnapshot<Map<String, dynamic>> querySnapshot =
      await firestore.collection('users').doc(userID).get();
      final bookmarks = querySnapshot['bookmarked'] as List<dynamic>;

      List<ProductsData> products = await Future.wait(bookmarks.map((doc) async {
        DocumentSnapshot<Map<String, dynamic>> collectionRef = await FirebaseFirestore.instance.doc(doc.path).get();
        return ProductsData.fromJson(collectionRef.data() as Map<String, dynamic>, doc.id,doc.toString().split('/')[1] == 'tests');
      }));

      bookmarkList = products;

      emit(GetBookmarkSuccessState());
    } catch (e) {
      emit(GetBookmarkErrorState(e.toString()));
    }
  }
  Future<void> addBookmark(String item,bool isTest,bool inBookmark,BuildContext context) async {
    final DocumentReference docRef = FirebaseFirestore.instance.collection("users").doc(userID);
    DocumentReference targetDocRef = firestore.collection(isTest?'tests':"scans").doc(item);
    ProductsData.bookmarkedProducts.add(item);
    print(ProductsData.bookmarkedProducts);
    try {
      await docRef.update({
        "bookmarked": FieldValue.arrayUnion([targetDocRef])
      });
      if(inBookmark){
        context.read<ScansCubit>().getScans();
        context.read<TestsCubit>().getTests();
      }
      else{
        context.read<GetBookmarkCubit>().getBookmark();
      }

    } catch (error) {
      print("Error adding item to array: $error");
    }
  }

  Future<void> removeBookmark(String item,bool isTest,bool inBookmark,BuildContext context) async {
    final DocumentReference docRef = FirebaseFirestore.instance.collection("users").doc(userID);
    DocumentReference targetDocRef = firestore.collection(isTest?'tests':"scans").doc(item);
    ProductsData.bookmarkedProducts.remove(item);
    print(ProductsData.bookmarkedProducts);

    try {
      await docRef.update({
        'bookmarked': FieldValue.arrayRemove([targetDocRef])
      });
      if(inBookmark){
        context.read<ScansCubit>().getScans();
        context.read<TestsCubit>().getTests();
      }
      else{
        context.read<GetBookmarkCubit>().getBookmark();
      }
    } catch (error) {
      print("Error adding item to array: $error");
    }
  }
}
