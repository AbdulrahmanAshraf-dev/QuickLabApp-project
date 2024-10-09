import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quicklab/helpers/hive_helper.dart';
import 'package:quicklab/user_profile/profile_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  TextEditingController nameEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController phoneEditingController = TextEditingController();
  TextEditingController addressEditingController = TextEditingController();



  Future<void> fetchUserProfile() async {
    emit(ProfileLoading());
    try {
      if (HiveHelper.getId() == null) {
        emit(ProfileFailure('No user is currently signed in.'));
        return;
      }
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(HiveHelper.getId())
          .get();
      if (userDoc.exists) {
        emit(ProfileSuccessful(
            ProfileModel.fromJson(userDoc.data() as Map<String, dynamic>)));
      } else {
        emit(ProfileFailure('User data not found.'));
      }
    } catch (e) {
      emit(ProfileFailure('Failed to fetch user profile: $e'));
    }
  }

  Future<void> updateUserProfile() async {
    emit(EditProfileLoading());
    try {
      if (HiveHelper.getId() == null) {
        emit(ProfileFailure('No user is currently signed in.'));
        return;
      }
      await FirebaseFirestore.instance
          .collection('users')
          .doc(HiveHelper.getId())
          .update(ProfileModel(
                  name: nameEditingController.text,
                  email: emailEditingController.text,
                  phone_number: phoneEditingController.text)
              .toJson());
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(HiveHelper.getId())
          .get();
      if (userDoc.exists) {
        fetchUserProfile();
        emit(EditProfileSuccessful());
      } else {
        emit(EditProfileFailure('User data not found.'));
      }
    } catch (e) {
      emit(EditProfileFailure('Failed to fetch user profile: $e'));
    }
  }
}
