import 'package:flutter/material.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:superb/registration/password_dialog.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId:
        "YOUR_CLIENT_ID_FOR_WEB_APPLICATION",
  );

  Future<void> signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    try {if (googleUser == null) {
      debugPrint("Login canceled!");
      return;
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final String backendUrl = "http://10.0.2.2:8000/api/auth/google/";

    final response = await http.post(
      Uri.parse(backendUrl),
      body: jsonEncode({
        "access_token": googleAuth.accessToken,
        "id_token": googleAuth.idToken,
      }),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      debugPrint("Account created successfully!");

      final Map<String, dynamic> data = jsonDecode(response.body);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", data['access']);
      await prefs.setBool("isLoggedIn", true);

      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/onboarding');
      }
    } else {
      debugPrint("Erroe code: ${response.statusCode}");
      debugPrint("Erroe text: ${response.body}");

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("There was an error logging in!")),
        );
      }
    }
    } catch (e) {
      debugPrint("System error: $e");
    }
  }

  Future<void> signInWithGitHub(BuildContext context) async {
    const String clientId = "YOUR_CLIENT_ID";
    const String redirectUrl = "superb://callback";

    try {
      final result = await FlutterWebAuth2.authenticate(
        url:
            "https://github.com/login/oauth/authorize"
            "?client_id=$clientId"
            "&redirect_uri=$redirectUrl"
            "&scope=user:email",
        callbackUrlScheme: "superb",
      );

      if (!context.mounted) return;

      final code = Uri.parse(result).queryParameters["code"];

      if (code != null) {
        await sendGitHubCodeToDjango(context, code);
      }
    } catch (e) {
      debugPrint("System error: $e");
    }
  }

  Future<void> sendGitHubCodeToDjango(
    BuildContext context,
    String? code, {
    String? password,
    String? tempId,
  }) async {
    final response = await http.post(
      Uri.parse("http://10.0.2.2:8000/api/auth/github/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"code": code, "password": password, "temp_id": tempId}),
    );

    if (!context.mounted) return;

    final data = jsonDecode(response.body);

    if (data["status"] == "need_password") {
      showGithubPasswordDialog(context, data["temp_id"], data["email"]);
    } else if (data["status"] == "login_success" ||
        data["status"] == "created") {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool("isLoggedIn", true);
      if (!context.mounted) return;

      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil("/onboarding", (route) => false);
    }
  }

  void showGithubPasswordDialog(
    BuildContext context,
    String tempId,
    String email,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PasswordDialog(
        email: email,
        providerName: "Github",
        onConfirm: (password) {
          sendGitHubCodeToDjango(
            context,
            null,
            password: password,
            tempId: tempId,
          );
        },
      ),
    );
  }

  Future<void> signUpWithEmail(
    BuildContext context,
    String username,
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/signup/"),
        body: jsonEncode({
          "username": username,
          "email": email,
          "password": password,
        }),
        headers: {"Content-Type": "application/json"},
      );

      if (!context.mounted) return;

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        await prefs.setString("token", data['access'] ?? "");
        await prefs.setBool("isLoggedIn", true);

        if (!context.mounted) return;

        Navigator.pushReplacementNamed(context, "/onboarding");
      } else {
        final errorData = jsonDecode(response.body);
        _showError(context, errorData['detail'] ?? "Registration failed");
      }
    } catch (e) {
      if (!context.mounted) return;
      _showError(context, "System error: $e");
    }
  }

  Future<void> signInWithEmail(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/login/"),
        body: jsonEncode({"username": email, "password": password}),
        headers: {"Content-Type": "application/json"},
      );

      if (!context.mounted) return;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        await prefs.setString("token", data['access']);
        await prefs.setBool("isLoggedIn", true);

        if (!context.mounted) return;
        Navigator.pushReplacementNamed(context, '/onboarding');
      } else {
        _showError(context, "Invalid email or password");
      }
    } catch (e) {
      if (!context.mounted) return;
      _showError(context, "System error: $e");
    }
  }

  Future<void> deleteAccount(BuildContext context) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");

      final response = await http.delete(
        Uri.parse("http://10.0.2.2:8000/delete/"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        await prefs.clear();
        await _googleSignIn.signOut();

        try {
          await _googleSignIn.disconnect();
        } catch (_) {}

        if (context.mounted) {
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil('/signup', (route) => false);
        }
      } else {
        if (context.mounted) {
          _showError(context, "Error: ${response.statusCode}");
        }
      }
    } catch (e) {
      if (context.mounted) {
        _showError(context, "Sytem error: $e");
      }
    }
  }

  Future<void> logout(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/signup');
    }
  }

  void _showError(BuildContext context, String msg) {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.red));
    }
  }
}
