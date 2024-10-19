import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:quicklab/helpers/hive_helper.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String selectedGender = 'Male';
  String? selectedAge;

  void signUpWithEmailPassword(String email, String password, String name, String phoneNum) async {
    emit(SignupLoadingState());

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'gender': selectedGender,
        'age': selectedAge,
        'name': name,
        'phone_number': phoneNum,
        'email': email,
        'isAdmin': false,
      });

      HiveHelper.setId(userCredential.user!.uid);
      emit(SignupSuccessState());
    } catch (e) {
      emit(SignupErrorState(e.toString()));
    }
  }
}
