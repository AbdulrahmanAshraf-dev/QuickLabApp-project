import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../user_profile/profile_model.dart';

part 'users_in_admin_state.dart';

class UsersInAdminCubit extends Cubit<UsersInAdminState> {
  UsersInAdminCubit() : super(UsersInAdminInitial());
  List<ProfileModel> users = [];
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void getUsers() async {
    emit(UsersInAdminLoadingState());
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('users')
          .get();

      users = querySnapshot.docs.map((doc) {
        return ProfileModel.fromJson(
            doc.data() as Map<String, dynamic>, doc.id);
      }).toList();

      emit(UsersInAdminSuccessState());
    } catch (e) {
      emit(UsersInAdminErrorState(e.toString()));
    }
  }
}
