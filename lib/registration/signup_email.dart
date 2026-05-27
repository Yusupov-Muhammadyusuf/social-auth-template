import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:superb/auth_service.dart';
import 'package:superb/app_rules/privacy.dart';
import 'package:superb/app_rules/terms.dart';
import 'dart:math';

class SignupEmail extends StatefulWidget {
  const SignupEmail({super.key});

  @override
  State<SignupEmail> createState() => _SignupEmailState();
}

class _SignupEmailState extends State<SignupEmail> {
  late TapGestureRecognizer termsRecognizer;
  late TapGestureRecognizer privacyRecognizer;

  final formKey = GlobalKey<FormState>();
  final FocusNode passwordFocusNode = FocusNode();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordObscure = true;
  bool showEyeIcon = false;

  @override
  void initState() {
    super.initState();
    termsRecognizer = TapGestureRecognizer()..onTap = handleTermsTap;
    privacyRecognizer = TapGestureRecognizer()..onTap = handlePrivacyTap;
    usernameController.addListener(validate);
    emailController.addListener(validate);
    passwordController.addListener(validate);
    passwordFocusNode.addListener(() {
      if (passwordFocusNode.hasFocus && passwordController.text.isEmpty) {
        final generated = generateRandomPassword();

        setState(() {
          passwordController.text = generated;
          isPasswordObscure = false;

          passwordController.selection = TextSelection(
            baseOffset: 0,
            extentOffset: generated.length,
          );
        });
      }
    });
  }

  void validate() {
    setState(() {
      showEyeIcon = passwordController.text.isNotEmpty;
    });
  }

  String generateRandomPassword() {
    const chars =
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()";
    return List.generate(
      10,
      (i) => chars[Random().nextInt(chars.length)],
    ).join();
  }

  @override
  void dispose() {
    termsRecognizer.dispose();
    privacyRecognizer.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordFocusNode.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const Text("Create your account", style: TextStyle(fontSize: 30)),
              const SizedBox(height: 50),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Username",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      autofocus: true,
                      controller: usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your username";
                        }
                        if (value.length < 5) {
                          return "Username must be at least 5 characters";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "nickname",
                        filled: true,
                        fillColor: const Color(0xFFF2F2F2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        errorStyle: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),
                    const Text(
                      "Your email",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a valid email adress";
                        }
                        if (!RegExp(
                          r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                        ).hasMatch(value)) {
                          return "This input for only email address";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "example@gmail.com",
                        filled: true,
                        fillColor: const Color(0xFFF2F2F2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        errorStyle: const TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),
                    const Text(
                      "Your password",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: passwordController,
                      obscureText: isPasswordObscure,
                      focusNode: passwordFocusNode,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        }
                        if (value.length < 8) {
                          return "Password must be at least 8 characters!";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Enter your password",
                        filled: true,
                        fillColor: const Color(0xFFF2F2F2),
                        suffixIcon: showEyeIcon
                            ? IconButton(
                                icon: Icon(
                                  isPasswordObscure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isPasswordObscure = !isPasswordObscure;
                                  });
                                },
                              )
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        errorStyle: const TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            AuthService().signUpWithEmail(
                              context,
                              usernameController.text.trim(),
                              emailController.text.trim(),
                              passwordController.text.trim(),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          overlayColor: Colors.white.withValues(alpha: 0.2),
                        ),
                        child: Text(
                          "Create account",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 90),
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
                                    color: Colors.black,
                                    fontSize: 19,
                                  ),
                                ),
                                TextSpan(
                                  text: "Terms of Service",
                                  recognizer: termsRecognizer,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 19,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.black,
                                  ),
                                ),
                                const TextSpan(
                                  text: " and acknowledge that our ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 19,
                                  ),
                                ),
                                TextSpan(
                                  text: "Privacy Policy",
                                  recognizer: privacyRecognizer,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 19,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.black,
                                  ),
                                ),
                                const TextSpan(
                                  text: " applies to you.",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 19,
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
            ],
          ),
        ),
      ),
    );
  }
}
