import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:superb/app_rules/privacy.dart';
import 'package:superb/app_rules/terms.dart';
import 'package:superb/auth_service.dart';
import 'package:superb/registration/login_email.dart';
import 'package:superb/registration/signup_email.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TapGestureRecognizer termsRecognizer;
  late TapGestureRecognizer privacyRecognizer;
  late TapGestureRecognizer signupRecognizer;
  late TapGestureRecognizer singinRecognizer;
  late TapGestureRecognizer onboardingRecognizer;

  bool isPasswordObscure = true;
  bool showEyeIcon = false;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    termsRecognizer = TapGestureRecognizer()..onTap = handleTermsTap;
    privacyRecognizer = TapGestureRecognizer()..onTap = handlePrivacyTap;
    signupRecognizer = TapGestureRecognizer()..onTap = handleSignupTap;
    singinRecognizer = TapGestureRecognizer()..onTap = handleSigninTap;
  }

  @override
  void dispose() {
    termsRecognizer.dispose();
    privacyRecognizer.dispose();
    signupRecognizer.dispose();
    singinRecognizer.dispose();
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

  void handleSigninTap() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginEmail()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              const Text(
                "Welcome to \ninformed",
                style: TextStyle(fontSize: 40),
              ),
              const SizedBox(height: 5),
              const Text(
                "Log in to discover a wide range of insightful articles and the latest stories from top-tier publishers around the world.",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 50),
              SocialLoginButton(
                label: "Sign in with Google",
                icon: Image.asset("assets/images/google.png", height: 24),
                onPressed: () {
                  AuthService().signInWithGoogle(context);
                },
              ),
              const SizedBox(height: 20),
              SocialLoginButton(
                label: "Sign in with GitHub",
                icon: Image.asset("assets/images/github.png", height: 24),
                onPressed: () {
                  AuthService().signInWithGitHub(context);
                },
              ),
              const SizedBox(height: 20),
              SocialLoginButton(
                label: "Sign in with Telegram",
                icon: const Icon(
                  Icons.telegram,
                  size: 28,
                  color: Color(0xFF24A1DE),
                ),
                onPressed: () {},
              ),
              const SizedBox(height: 20),
              SocialLoginButton(
                label: "Sign in with Email",
                icon: Icon(Icons.email_outlined, size: 28),
                onPressed: handleSigninTap,
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isChecked = !isChecked;
                    });
                  },
                  child: Row(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: isChecked
                              ? const Color(0xFF1A8917)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 2,
                            color: isChecked
                                ? const Color(0xFF1A8917)
                                : Colors.grey.shade400,
                          ),
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: isChecked
                              ? const Icon(
                                  Icons.check,
                                  key: ValueKey("check"),
                                  color: Colors.white,
                                  size: 23,
                                )
                              : const SizedBox.shrink(),
                        ),
                      ),
                      const SizedBox(width: 15),
                      const Text(
                        "Remeber me for faster sign in",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: Text.rich(
                  TextSpan(
                    style: const TextStyle(color: Colors.grey, fontSize: 15),
                    children: [
                      const TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      TextSpan(
                        text: "Sign up",
                        recognizer: signupRecognizer,
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

class SocialLoginButton extends StatelessWidget {
  final String label;
  final Widget icon;
  final VoidCallback onPressed;

  const SocialLoginButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        fixedSize: const Size(double.infinity, 50),
        side: const BorderSide(color: Colors.black, width: 1.2),
        overlayColor: Colors.grey.withValues(alpha: 0.1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: 15),
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
