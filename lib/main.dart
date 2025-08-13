import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'src/app.dart';
import 'package:provider/provider.dart';
import 'package:study_buddy/src/services/firebase_service.dart';
import 'package:study_buddy/src/services/firestore_service.dart';
import 'package:study_buddy/src/services/barra_inferior_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (create) => FirebaseService()),
        ChangeNotifierProvider(create: (create) => FirestoreService()),
        ChangeNotifierProvider(create: (create) => BottomBarProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
