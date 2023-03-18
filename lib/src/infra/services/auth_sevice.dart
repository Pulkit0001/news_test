import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_test/src/data/models/user_data_mode.dart';

class AuthService {
  Future<UserData> googleSignIn() async {
    try {
      await GoogleSignIn().signOut();
      var res = await GoogleSignIn().signIn();
      if (res != null) {
        UserData userData =
            UserData(name: res.email, email: res.displayName ?? "");
        return userData;
      } else {
        throw Exception("Sign In Failed");
      }
    } catch (e) {
      rethrow;
    }
  }
}
