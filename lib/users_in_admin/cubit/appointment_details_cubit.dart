import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:quicklab/users_in_admin/model/appointment_model.dart';

part 'appointment_details_state.dart';

class AppointmentDetailsCubit extends Cubit<AppointmentDetailsState> {
  AppointmentDetailsCubit() : super(AppointmentDetailsInitial());

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<AppointmentModel> appointments = [];

  void getAppointmentDetails(String userID) async {
    emit(AppointmentDetailsLoadingState());
    try {
      DocumentSnapshot<Map<String, dynamic>> querySnapshot =
      await firestore.collection('users').doc(userID).get();
      if (querySnapshot.data() != null && querySnapshot.data()!['appointment'] is List) {
        List<dynamic> appointmentData = querySnapshot.data()!['appointment'];

        appointments = appointmentData.map((e) {
          return AppointmentModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        emit(AppointmentDetailsSuccessState( appointments));
      } else {
        emit(AppointmentDetailsErrorState('No appointments found.'));
      }
    } catch (e) {
      emit(AppointmentDetailsErrorState(e.toString()));
    }
  }
}
