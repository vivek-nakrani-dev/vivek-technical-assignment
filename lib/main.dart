import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:vivek_technical_assignment/providers/auth/login_provider.dart';
import 'package:vivek_technical_assignment/providers/auth/register_provider.dart';
import 'package:vivek_technical_assignment/providers/notes/note_provider.dart';
import 'package:vivek_technical_assignment/routes/routes.dart';
import 'package:vivek_technical_assignment/services/firebase_auth_service.dart';
import 'package:vivek_technical_assignment/services/firestore_service.dart';
import 'package:vivek_technical_assignment/theme/app_theme.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<User?> _authSubscription;

  @override
  void initState() {
    super.initState();
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        router.go('/login');
      } else {
        router.go('/');
      }
    });
  }

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthService>(create: (_) => FirebaseAuthService()),
        Provider<FirestoreService>(create: (_) => FirestoreService()),
        ChangeNotifierProvider<LoginProvider>(create: (context) => LoginProvider(context.read<FirebaseAuthService>())),
        ChangeNotifierProvider<RegisterProvider>(
          create: (context) => RegisterProvider(context.read<FirebaseAuthService>()),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) {
          return OKToast(
            animationCurve: Curves.easeIn,
            animationDuration: const Duration(milliseconds: 300),
            duration: const Duration(seconds: 3),
            child: MaterialApp.router(
              title: 'Notes App',
              theme: AppTheme.lightTheme,
              debugShowCheckedModeBanner: false,
              routerConfig: router,
            ),
          );
        },
      ),
    );
  }
}
