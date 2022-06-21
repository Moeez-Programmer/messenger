import 'package:firebase_auth/firebase_auth.dart';
import 'package:messenger/services/database.dart';

class AuthService {
  FirebaseAuth instance = FirebaseAuth.instance;
  Users userStore = Users();

  dynamic registerWithEmailPassword(email, password, name) async {
    try {
      UserCredential user = await instance.createUserWithEmailAndPassword(
          email: email, password: password);
      Messages msg = Messages();
      return await userStore.createUser(name, email, user.user!.uid);
    } catch (e) {
      int errorIndex = e.toString().indexOf("]") + 1;
      String errorMsg = e.toString().substring(errorIndex);
      return errorMsg;
    }
  }

  dynamic signInWithEmailPassword(email, password) async {
    try {
      UserCredential user = await instance.signInWithEmailAndPassword(
          email: email, password: password);
      return user;
    } catch (e) {
      int errorIndex = e.toString().indexOf("]") + 1;
      String errorMsg = e.toString().substring(errorIndex);
      return errorMsg;
    }
  }

  signOut() async {
    return await instance.signOut();
  }

  Stream<User?> get user {
    return instance.authStateChanges();
  }
}
