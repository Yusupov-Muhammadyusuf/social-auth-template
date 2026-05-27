import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:superb/auth_service.dart';
import 'package:superb/registration/signup_email.dart';
import 'package:superb/registration/login.dart';
import 'package:superb/app_rules/privacy.dart';
import 'package:superb/app_rules/terms.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late TapGestureRecognizer termsRecognizer;
  late TapGestureRecognizer privacyRecognizer;
  late TapGestureRecognizer signupRecognizer;
  late TapGestureRecognizer loginRecognizer;

  bool isPasswordObscure = true;
  bool showEyeIcon = false;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    termsRecognizer = TapGestureRecognizer()..onTap = handleTermsTap;
    privacyRecognizer = TapGestureRecognizer()..onTap = handlePrivacyTap;
    signupRecognizer = TapGestureRecognizer()..onTap = handleSignupTap;
    loginRecognizer = TapGestureRecognizer()..onTap = handleLoginTap;
  }

  @override
  void dispose() {
    termsRecognizer.dispose();
    privacyRecognizer.dispose();
    loginRecognizer.dispose();
    super.dispose();
  }

  void handleTermsTap() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Terms()),
    );
  }

  void handlePrivacyTap() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Privacy()),
    );
  }

  void handleSignupTap() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignupEmail()),
    );
  }

  void handleLoginTap() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Center(
                child: Image.asset("assets/images/Superb.png", height: 150),
              ),
              const Text(
                "Start your \nstory today.",
                style: TextStyle(fontSize: 50, height: 0),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                "Superb is even better in community. \nSo let's get firendly.",
                style: TextStyle(fontSize: 18, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              OutlinedButton(
                onPressed: () {
                  AuthService().signInWithGoogle(context);
                },
                style: OutlinedButton.styleFrom(
                  fixedSize: const Size(double.infinity, 50),
                  side: BorderSide(color: Colors.black, width: 1.2),
                  overlayColor: Colors.grey,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/google.png", height: 25),
                    const SizedBox(width: 15),
                    const Text(
                      "Sign up with Google",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  AuthService().signInWithGitHub(context);
                },
                style: OutlinedButton.styleFrom(
                  fixedSize: const Size(double.infinity, 50),
                  side: BorderSide(color: Colors.black, width: 1.2),
                  overlayColor: Colors.grey,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/github.png", height: 25),
                    const SizedBox(width: 15),
                    const Text(
                      "Sign up with GitHub",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: handleSignupTap,
                style: OutlinedButton.styleFrom(
                  fixedSize: const Size(double.infinity, 50),
                  side: BorderSide(color: Colors.black, width: 1.2),
                  overlayColor: Colors.grey,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.email_outlined, size: 25),
                    const SizedBox(width: 15),
                    const Text(
                      "Sign up with Email",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100),
              Center(
                child: Text.rich(
                  TextSpan(
                    style: const TextStyle(color: Colors.grey, fontSize: 15),
                    children: [
                      const TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      TextSpan(
                        text: "Sign in",
                        recognizer: loginRecognizer,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        style: const TextStyle(
                          color: Color(0xFF8E8E8E),
                          fontSize: 13,
                          height: 1.4,
                        ),
                        children: [
                          const TextSpan(
                            text: "By signing up, you agree to our ",
                            style: TextStyle(
                              color: Color.fromARGB(140, 0, 0, 0),
                              fontSize: 18,
                            ),
                          ),
                          TextSpan(
                            text: "Terms of Service",
                            recognizer: termsRecognizer,
                            style: TextStyle(
                              color: Color.fromARGB(140, 0, 0, 0),
                              fontSize: 18,
                              decoration: TextDecoration.underline,
                              decorationColor: Color.fromARGB(140, 0, 0, 0),
                            ),
                          ),
                          const TextSpan(
                            text: " and acknowledge that our ",
                            style: TextStyle(
                              color: Color.fromARGB(140, 0, 0, 0),
                              fontSize: 18,
                            ),
                          ),
                          TextSpan(
                            text: "Privacy Policy",
                            recognizer: privacyRecognizer,
                            style: TextStyle(
                              color: Color.fromARGB(140, 0, 0, 0),
                              fontSize: 18,
                              decoration: TextDecoration.underline,
                              decorationColor: Color.fromARGB(140, 0, 0, 0),
                            ),
                          ),
                          const TextSpan(
                            text: " applies to you.",
                            style: TextStyle(
                              color: Color.fromARGB(140, 0, 0, 0),
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
