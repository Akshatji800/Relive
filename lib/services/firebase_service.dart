import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mental_health/services/user_model.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  FirebaseService();

  Future<UserModel> getUser() async {
    var firebaseUser = _auth.currentUser!;
    return UserModel(firebaseUser.uid, displayName: firebaseUser.email!);
  }

  Future<String?> signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<UserModel> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    var authresult = await _auth.signInWithEmailAndPassword(email: email, password: password);
    
    return UserModel(authresult.user!.uid, displayName: authresult.user!.displayName.toString());
  }

  Future<void> signOutFromGoogle() async{
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}