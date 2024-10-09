import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../helpers/hive_helper.dart';
import '../../user_profile/profile_model.dart';

part 'sub_login_state.dart';

class SubLoginCubit extends Cubit<SubLoginState> {
  SubLoginCubit() : super(SubLoginInitial());
  String selectedGender = 'Male';
  String? selectedAge;
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController phoneEditingController = TextEditingController();

  Future<void> updateUserProfile() async {
    emit(SubLoginLoading());
    try {
      if (HiveHelper.getId() == null) {
        emit(SubLoginFailure('No user is currently signed in.'));
        return;
      }
      await FirebaseFirestore.instance
          .collection('users')
          .doc(HiveHelper.getId())
          .set(ProfileModel(
                  name: nameEditingController.text,
                  phone_number: phoneEditingController.text,
                  age: selectedAge,
                  gender: selectedGender)
              .toJson());
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(HiveHelper.getId())
          .get();
      if (userDoc.exists) {
        emit(SubLoginSuccessful());
      } else {
        emit(SubLoginFailure('User data not found.'));
      }
    } catch (e) {
      emit(SubLoginFailure('Failed to fetch user profile: $e'));
    }
  }
}
