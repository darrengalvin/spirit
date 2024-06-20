import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDgbvvPeMGaEfJirW-vsYStKCHu7sFtdcE",
            authDomain: "spiritaeg-hj9gti.firebaseapp.com",
            projectId: "spiritaeg-hj9gti",
            storageBucket: "spiritaeg-hj9gti.appspot.com",
            messagingSenderId: "437968038949",
            appId: "1:437968038949:web:db763e8d4f4b7ffd9363cc"));
  } else {
    await Firebase.initializeApp();
  }
}
