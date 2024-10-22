import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../helpers/hive_helper.dart';
import '../cubit/profile_cubit.dart';
import '../profile_model.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());



  Future<void> updateUserProfile(
      ProfileModel profile, BuildContext context) async {
    emit(ProfileLoading());
    try {
      if (HiveHelper.getId() == null) {
        emit(EditProfileFailure('No user is currently signed in.'));
        return;
      }
      await FirebaseFirestore.instance
          .collection('users')
          .doc(HiveHelper.getId())
          .update(ProfileModel(
                  image: context.read<ProfileCubit>().image,
                  age: context.read<ProfileCubit>().age,
                  gender: context.read<ProfileCubit>().gender,
                  check: true,
                  name: profile.name,
                  email: profile.email,
                  phoneNumber: profile.phoneNumber)
              .toJson());
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(HiveHelper.getId())
          .get();

      if (userDoc.exists) {
        if (context.mounted) {
          context.read<ProfileCubit>().fetchUserProfile();
          emit(EditProfileSuccessful());
        }
      } else {
        emit(EditProfileFailure('User data not found.'));
      }
    } catch (e) {
      emit(EditProfileFailure('Failed to fetch user profile: $e'));
    }
  }
}
