import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? get currentUser => _auth.currentUser;
  bool get isSignedIn => currentUser != null;

  Future<void> signInAnonymously() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      print("Signed in with temporary account: ${userCredential.user?.uid}");
    } catch (e) {
      print("Failed to sign in anonymously: $e");
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google sign in was aborted');
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      print("Signed in with Google: ${userCredential.user?.uid}");
    } catch (e) {
      print("Failed to sign in with Google: $e");
      throw e;
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      print("Signed out successfully");
    } catch (e) {
      print("Failed to sign out: $e");
    }
  }

  Future<bool> get hasSavedPlan async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('savedPlan');
  }
}
