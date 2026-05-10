import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vivek_technical_assignment/features/auth/login_page.dart';
import 'package:vivek_technical_assignment/features/auth/register_page.dart';
import 'package:vivek_technical_assignment/features/notes/home_page.dart';
import 'package:vivek_technical_assignment/providers/notes/note_provider.dart';
import 'package:vivek_technical_assignment/services/firebase_auth_service.dart';
import 'package:vivek_technical_assignment/services/firestore_service.dart';

final router = GoRouter(
  initialLocation: '/',
  redirectLimit: 1,
  redirect: (context, state) {
    final authService = context.read<FirebaseAuthService>();
    final isLoggedIn = authService.isUserLoggedIn();
    final isAuthRoute = state.matchedLocation == '/login' || state.matchedLocation == '/register';

    if (!isLoggedIn && !isAuthRoute) {
      return '/login';
    }

    if (isLoggedIn && isAuthRoute) {
      return '/';
    }

    return null;
  },
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(path: '/register', builder: (context, state) => const RegisterPage()),
    GoRoute(
      path: '/',
      builder: (context, state) {
        return ChangeNotifierProvider<NoteProvider>(
          create: (context) => NoteProvider(context.read<FirestoreService>())..listenToNotes(),
          builder: (context, child) => HomePage(),
        );
      },
    ),
  ],
);
