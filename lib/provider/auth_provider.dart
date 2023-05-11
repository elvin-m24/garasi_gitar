import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInSignUpResult {
  final User? user;
  final String? message;

  SignInSignUpResult({this.user, this.message});
}

class AuthProvider {
  static Future<SignInSignUpResult?> registerUsingEmailPassword({
    required String email,
    required String password,
    required String username,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    String? message;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user!.updateDisplayName(username);
      await userCredential.user!.reload();
      user = auth.currentUser;
      // Set custom claim for username
      await user!.getIdToken(true);
      await FirebaseFunctions.instance.httpsCallable('setUsernameClaim').call({
        'uid': user.uid,
        'username': username,
      });
      return SignInSignUpResult(user: userCredential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      }
      return SignInSignUpResult(message: message);
    } catch (e) {
      print(e);
      return SignInSignUpResult(message: 'Failed to create account');
    }
  }

  static Future<SignInSignUpResult?> loginUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    String? message;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      return SignInSignUpResult(user: user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        message = 'Invalid email or password.';
      }
      return SignInSignUpResult(message: message);
    } catch (e) {
      print(e);
      return SignInSignUpResult(message: 'Failed to sign in');
    }
  }
}
