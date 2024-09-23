import 'package:bloc/bloc.dart';

class ProfileCubit extends Cubit<Map<String, dynamic>> {
  ProfileCubit()
      : super({
    'name': 'John Doe',
    'phone': '+1234567890',
    'email': 'john.doe@example.com',
    'address': '123 Main Street, City, Country',
  });

  void updateProfile(String name, String phone, String email, String address) {
    emit({
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
    });
  }
}