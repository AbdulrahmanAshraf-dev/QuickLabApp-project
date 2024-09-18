import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFunction {


 static Future<Either<String, dynamic>> signIn(String email,String password)async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      if (credential.user?.uid!=null){
        return Right(credential);
      }
      return const Right(null);
    } on FirebaseAuthException catch (e) {
     return const Left("Wrong Mail or Password");
    }
  }

}