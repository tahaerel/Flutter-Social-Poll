import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'constants.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Map<String, String> exposeUser({@required kUsername, @required kUID}) {
  return {
    kUsername: kUsername,
    kUID: kUID,
  };
}

Future<Map<String, String>> getCurrentUser() async {
  final FirebaseUser user = await _auth.currentUser();
  if (user != null) {
    return exposeUser(kUsername: user.displayName, kUID: user.uid);
  }
  return null;
}

Future<bool> isUserSignedIn() async {
  final FirebaseUser currentUser = await _auth.currentUser();
  return currentUser != null;
}

void signOut() {
  try {
    _auth.signOut();
  } catch (error) {
    print(error);
  }
}

void onAuthenticationChange(Function isLogin) {
  _auth.onAuthStateChanged.listen((FirebaseUser user) {
    if (user != null) {
      isLogin(exposeUser(kUsername: user.displayName, kUID: user.uid));
    } else {
      isLogin(null);
    }
  });
}

Future<Map<String, String>> signInAnonymously() async {
  final FirebaseUser user = (await _auth.signInAnonymously()).user;

  if (user != null) {
    return exposeUser(kUsername: '', kUID: user.uid);
  }
  return null;
}
