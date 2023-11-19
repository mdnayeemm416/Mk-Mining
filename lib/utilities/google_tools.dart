import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

Future<List<String?>?> handleSignIn() async {
  try {
    final s = await googleSignIn.signIn();
    if (s == null) {
      return null;
    }
    return [s.email, s.displayName, s.id, s.photoUrl];
  } catch (error) {
    debugPrint("error in handleSignIn: $error");
    return null;
  }
}
