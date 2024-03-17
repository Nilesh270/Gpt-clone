import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpt_flutter/features/app/splash_screen/splash_screen.dart';
import 'package:gpt_flutter/features/user_auth/presentation/pages/login_page.dart';
import 'package:gpt_flutter/features/user_auth/presentation/pages/sign_up_page.dart';
import 'package:gpt_flutter/features/user_auth/presentation/pages/home_page.dart';
import 'package:gpt_flutter/providers/active_theme_provider.dart';
import 'screens/chat_screen.dart';
import 'constants/themes.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase',
      theme: lightTheme, // Set the light theme
      darkTheme: darkTheme, // Set the dark theme
      themeMode: ref.watch(activeThemeProvider) == Themes.dark
          ? ThemeMode.dark
          : ThemeMode.light, // Use theme based on activeThemeProvider
      home: SplashScreen(
        // Decide whether to show the LoginPage or HomePage based on user authentication
        child: user != null ? const ChatScreen() : LoginPage(),
      ),
      routes: {
        '/login': (context) => LoginPage(),
        '/signUp': (context) => SignUpPage(),
        '/home': (context) => const ChatScreen(),
      },
    );
  }
}
