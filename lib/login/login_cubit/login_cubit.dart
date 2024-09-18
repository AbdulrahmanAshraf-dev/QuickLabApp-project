import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quicklab/firebase_function.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  GlobalKey<FormState> key = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  login() async {
    emit(LoginLoading());
    var response = await FirebaseFunction.signIn(
        emailController.text, passwordController.text);
    response.fold(
        (error) => (emit(LoginFailure(error))), (user) => emit(LoginSuccessful()));
  }

  signInWithGoogle()async{
    emit(LoginLoading());
    var response = await FirebaseFunction.signInWithGoogle();
    response.fold((error)=>emit(LoginFailure(error)), (user)=>emit(LoginSuccessful()));
  }  signInWithFaceBook()async{
    emit(LoginLoading());
    var response = await FirebaseFunction.signInWithFacebook();
    response.fold((error)=>emit(LoginFailure(error)), (user)=>emit(LoginSuccessful()));
  }

}
