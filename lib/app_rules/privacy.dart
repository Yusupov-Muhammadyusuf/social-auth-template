import 'package:flutter/material.dart';

class Privacy extends StatelessWidget {
  const Privacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Privacy Policy",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            buildSectionTitle("Information We Collect"),
            buildBodyText(
              "• Account Information: If you use Google Sign-In, we receive your email, name, and profile picture. For direct registration, we collect username, email, and a hashed password.\n"
              "• Usage Data: We automatically collect technical info like IP address and browser type for security and performance analysis.",
            ),
            buildSectionTitle("How We Use Your Information"),
            buildBodyText(
              "• To allow you to write and publish articles.\n"
              "• To authenticate your identity and secure your account.\n"
              "• To prevent spam, fraud, and abuse.\n"
              "• To analyze platform usage via Google Analytics to improve user experience.",
            ),
            buildSectionTitle("Data Storage and Security"),
            buildBodyText(
              "We use industry-standard encryption (SSL/TLS). Passwords are never stored in plain text. Data is kept as long as your account is active and removed upon account deletion.",
            ),
            buildSectionTitle("Third-Party Services"),
            buildBodyText(
              "We use services like Google Analytics. These may collect info sent by your browser (cookies/IP). We do not sell or rent your personal information.",
            ),
            buildSectionTitle("User Rights"),
            buildBodyText(
              "You have the right to update your profile, delete your articles or account, and object to data processing for analytical purposes.",
            ),
            buildSectionTitle("Cookies"),
            buildBodyText(
              "We use cookies to maintain your session. You can manage them via browser settings, though some features may not work without them.",
            ),
            const SizedBox(height: 30),
            const Text(
              "© 2026 All rights reserved.",
              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
            ),
            const Text(
              "Last Updated: April 17, 2026",
              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget buildBodyText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 15, height: 1.5, color: Colors.blueGrey),
    );
  }
}
