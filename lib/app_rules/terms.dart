import 'package:flutter/material.dart';

class Terms extends StatelessWidget {
  const Terms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Terms of Service",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            buildSectionTitle("Account Registration"),
            buildBodyText(
              "• To use the platform, you must sign in via supported methods (e.g., Google Sign-In) or create an account.\n"
              "• You are responsible for maintaining the confidentiality of your account and for all activities that occur under your account.\n"
              "• You must be at least 13 years old (or the legal age in your country) to use this service.",
            ),
            buildSectionTitle("User Content and Rights"),
            buildBodyText(
              "• Ownership: You retain all ownership rights to the articles, text, and images you publish on the platform.\n"
              "• License to Platform: By publishing content, you grant [Project Name] a worldwide, non-exclusive, royalty-free license to host, store, reproduce, and display your content to other users.\n"
              "• Responsibility: You are solely responsible for the content you post. You guarantee that your content does not violate any third-party copyrights.",
            ),
            buildSectionTitle("Prohibited Activities"),
            buildBodyText(
              "Users are strictly prohibited from:\n"
              "• Posting illegal, hateful, or harmful content.\n"
              "• Using automated systems (bots, scrapers) to extract data.\n"
              "• Distributing viruses or malicious code.\n"
              "• Impersonating other individuals or entities.",
            ),
            buildSectionTitle("Content Removal"),
            buildBodyText(
              "We reserve the right to remove any content that violates these terms without prior notice and suspend accounts of repeat violators.",
            ),
            buildSectionTitle("Limitation of Liability"),
            buildBodyText(
              "Superb is provided 'as is'. We do not guarantee that the service will be uninterrupted. Use of any content found on the platform is at your own risk.",
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
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
