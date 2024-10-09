import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';
class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  void signUpWithEmailPassword(String email, String password, String name, String phoneNum) async {
    try {
      emit(SignupLoadingState());

      // Corrected to create a user instead of signing in
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        try {
          // Adding user details to Firestore
          await _firestore.collection('users').doc(value.user?.uid).set({
            'name': name,
            'phone_number': phoneNum,
            'email': email,
            'createdAt': FieldValue.serverTimestamp(),
          });
          emit(SignupSuccessState());
        } catch (e) {
          emit(SignupErrorState(e.toString()));
        }
        return value;
      }).catchError((e) {
        emit(SignupErrorState(e.toString()));
      });
    } catch (e) {
      emit(SignupErrorState(e.toString()));
    }
  }
}
