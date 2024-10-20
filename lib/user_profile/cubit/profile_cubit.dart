import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quicklab/helpers/hive_helper.dart';
import 'package:quicklab/user_profile/profile_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  TextEditingController nameEditingController = TextEditingController();
  TextEditingController? emailEditingController = TextEditingController();
  TextEditingController phoneEditingController = TextEditingController();
  String? gender='Male';
  String? age;
  String? image;

  Future<void> fetchUserProfile() async {
    emit(ProfileLoading());
    String? id=HiveHelper.getId();
    try {
      if (HiveHelper.getId() == null) {
        emit(ProfileFailure('No user is currently signed in.'));
        return;
      }
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .get();
      nameEditingController.text = userDoc.get("name");
      emailEditingController?.text = userDoc.get("email") ?? "";
      phoneEditingController.text = userDoc.get("phone_number");
      gender = userDoc.get("gender");
      age = userDoc.get("age");
      image=userDoc.get("image");
      if (userDoc.exists) {
        emit(ProfileSuccessful(
            ProfileModel.fromJson(userDoc.data() as Map<String, dynamic>, id)));
      } else {
        emit(ProfileFailure('User data not found.'));
      }
    } catch (e) {
      emit(ProfileFailure('Failed to fetch user profile: $e'));
    }
  }




}
