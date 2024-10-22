import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quicklab/home/cubit/cart/cart_cubit.dart';

import '../../bookmark/cubit/get_bookmark_cubit.dart';
import '../../home/cubit/scans/scans_cubit.dart';
import '../../home/cubit/tests/tests_cubit.dart';
import '../../home/widget/cart_page.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());
  String? userID = FirebaseAuth.instance.currentUser?.uid;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addCheckout({
    required bool isCash,
    required bool isInHome,
    required DateTime date,
    required BuildContext context,
  }) async {
    emit(CheckoutLoadingState());
    try {
      // Get user document reference
      final DocumentReference docRef = firestore.collection("users").doc(userID);

      // Fetch bookmarked products
      final DocumentSnapshot docSnapshot = await docRef.get();
      final List<dynamic> bookmarkedProducts = docSnapshot.get("bookmarked") as List<dynamic>;

      // Update both 'appointment' and clear 'cart' in a Firestore batch
      WriteBatch batch = firestore.batch();

      // Add new appointment
      batch.update(docRef, {
        "appointment": FieldValue.arrayUnion([
          {
            "isCash": isCash,
            "isInHome": isInHome,
            "products": bookmarkedProducts,
            "date": date,
          }
        ]),
      });

      // Clear the cart
      batch.update(docRef, {
        "cart": FieldValue.delete(),
      });

      // Commit the batch
      await batch.commit();

      // Reset the total in CartPageState (handled through CartCubit)
      CartPageState.total = 0;
      // Trigger updates for related cubits
      context.read<ScansCubit>().getScans();
      context.read<TestsCubit>().getTests();
      context.read<GetBookmarkCubit>().getBookmark();
      context.read<CartCubit>().getCartItems();

      // Emit success state
      emit(CheckoutSuccessState());
    } catch (e) {
      emit(CheckoutErrorState(e.toString()));
    }
  }
}
