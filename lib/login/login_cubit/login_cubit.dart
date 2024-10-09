import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quicklab/firebase_function.dart';


import '../../helpers/hive_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  GlobalKey<FormState> key = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  UserCredential? currantUser ;

  login() async {
    emit(LoginLoading());
    var response = await FirebaseFunction.signIn(
        emailController.text, passwordController.text);
    response.fold((error) => (emit(LoginFailure(error))),
        (user) {
          HiveHelper.setId(user?.user!.uid??"");
          currantUser = user ;
          emit(LoginSuccessful(user));
        });

  }

  signInWithGoogle() async {
    emit(LoginLoading());
    var response = await FirebaseFunction.signInWithGoogle();
    response.fold((error) => emit(LoginFailure(error)), (user) {
      emit(LoginSuccessful(user.user!.uid));
      currantUser = user ;
      HiveHelper.setId(user.user!.uid);
    });

  }

  signInWithFaceBook() async {
    emit(LoginLoading());
    var response = await FirebaseFunction.signInWithFacebook();
    response.fold((error) => emit(LoginFailure(error)), (user) {
      emit(LoginSuccessful(user.user!.uid));
      currantUser = user ;
      HiveHelper.setId(user.user!.uid);
    });
  }
}
