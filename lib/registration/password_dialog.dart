import 'dart:math';
import 'package:flutter/material.dart';

class PasswordDialog extends StatefulWidget {
  final String email;
  final Function(String password) onConfirm;

  const PasswordDialog({
    super.key,
    required this.email,
    required this.onConfirm, required String providerName,
  });

  @override
  State<PasswordDialog> createState() => _PasswordDialogState();
}

class _PasswordDialogState extends State<PasswordDialog> {
  final TextEditingController passController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();
  bool isObscure = true;
  String? errorText;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      if (mounted) {
        passwordFocusNode.requestFocus();
      }
    });

    passwordFocusNode.addListener(() {
      if (passwordFocusNode.hasFocus && passController.text.isEmpty) {
        final generated = _generateRandomPassword();
        setState(() {
          passController.text = generated;
          isObscure = false;
          passController.selection = TextSelection(
            baseOffset: 0,
            extentOffset: generated.length,
          );
        });
      }
    });
  }

  String _generateRandomPassword() {
    const chars =
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()";
    return List.generate(
      10,
      (i) => chars[Random().nextInt(chars.length)],
    ).join();
  }

  @override
  void dispose() {
    passController.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  void _validateAndSubmit() {
    if (passController.text.length < 8) {
      setState(() {
        errorText = "Password must be at least 8 characters long";
      });
    } else {
      setState(() {
        errorText = null;
      });
      widget.onConfirm(passController.text);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text(
        "Set Password",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "To finish signing up with GitHub, please set a password for ${widget.email}.",
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passController,
              focusNode: passwordFocusNode,
              obscureText: isObscure,
              autofocus: true,
              autofillHints: null,
              enableSuggestions: false,
              autocorrect: false,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: const TextStyle(color: Colors.black54),
                errorText: errorText,
                errorStyle: const TextStyle(color: Colors.redAccent),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    isObscure ? Icons.visibility_off : Icons.visibility,
                    color: Colors.black54,
                  ),
                  onPressed: () => setState(() => isObscure = !isObscure),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: _validateAndSubmit,
          child: const Text("Create"),
        ),
      ],
    );
  }
}
