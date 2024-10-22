part of 'appointment_details_cubit.dart';

@immutable
sealed class AppointmentDetailsState {}

final class AppointmentDetailsInitial extends AppointmentDetailsState {}

final class AppointmentDetailsErrorState extends AppointmentDetailsState {
  final String message;

  AppointmentDetailsErrorState(this.message);
}

final class AppointmentDetailsLoadingState extends AppointmentDetailsState {}

final class AppointmentDetailsSuccessState extends AppointmentDetailsState {
  final List<AppointmentModel> appointments;

  AppointmentDetailsSuccessState(this.appointments);
}
