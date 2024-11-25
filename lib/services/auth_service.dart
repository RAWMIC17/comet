import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  //google sign i
  signInWithGoogle() async {
    //begin interactive sign in proces
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    //obtain auth details from reques
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    //create a new credential for use
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    //finally, lets sign i
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
