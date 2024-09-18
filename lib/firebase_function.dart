import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseFunction {
  static Future<Either<String, dynamic>> signIn(
      String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user?.uid != null) {
        return Right(credential);
      }
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return const Left("Wrong Mail or Password");
    }
  }

  static Future<Either<String, UserCredential>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return Right(
          await FirebaseAuth.instance.signInWithCredential(credential));
    } catch (e) {
      return Left(e.toString());
    }
  }
}
