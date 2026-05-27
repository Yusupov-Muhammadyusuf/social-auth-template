import 'package:flutter/material.dart';
import 'package:superb/home.dart';
import './registration/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const Superb());
}

class Superb extends StatelessWidget {
  const Superb({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "Ubuntu",
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const AuthGate(),
      routes: {
        '/signup': (context) => const Signup(),
        '/home': (context) => const Home(),
      },
    );
  }
}

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  Future<Map<String, bool>> _checkStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      "isLoggedIn": prefs.getBool("isLoggedIn") ?? false,
      "onboardingDone": prefs.getBool("onboardingDone") ?? false,
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, bool>>(
      future: _checkStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final bool isLoggedIn = snapshot.data?["isLoggedIn"] ?? false;
        final bool onboardingDone = snapshot.data?["onboardingDone"] ?? false;

        if (isLoggedIn) {
          if (onboardingDone) {
            return const Home();
          }
        }

        return const Signup();
      },
    );
  }
}
