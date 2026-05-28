# social-auth-template

This repository provides a comprehensive, ready-to-use frontend architecture specifically designed to facilitate seamless Google and GitHub OAuth2 social authentication for Flutter mobile applications. Built on top of Flutter, this template securely communicates with the Django REST Framework backend to handle OAuth token verification, automate user registration/profile creation, and manage secure session authentication using `shared_preferences`. It eliminates the boilerplate code usually required to establish a secure communication bridge between Flutter's frontend social sign-in flows and a Django-based backend ecosystem, making it an ideal starting point for secure, scalable mobile applications.

Open Source Backend Part: The server-side logic and API configurations for this project are hosted in a separate repository. You can find it here: [social-auth-backend](https://github.com/Yusupov-Muhammadyusuf/social-auth-backend)

## Security Note
**WARNING:** Never push your actual `serverClientId` or GitHub `clientId` keys written directly inside the code to GitHub, GitLab, or any other open-source platforms. This can expose your application to authentication spoofing. Always clear these fields and leave them as placeholders before making your repository public.

## Configuration
To run this project successfully, other developers must configure the social authentication client keys inside the `AuthService` class located in the frontend files:

### 1. Google and GitHub Auth Settings
Open `lib/services/auth_service.dart` and replace the following placeholder variables with your own credentials:

* Google OAuth2: Enter the Web Application Client ID obtained from the Google Cloud Console into the `serverClientId` field.
* GitHub OAuth2: Enter the Client ID obtained from the GitHub Developer Settings into the `clientId` constant.

```dart
class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId: "YOUR_CLIENT_ID_FOR_WEB_APPLICATION",
  );

  Future<void> signInWithGitHub(BuildContext context) async {
    const String clientId = "YOUR_CLIENT_ID";
    const String redirectUrl = "superb://callback"; 
    // ...
  }
}
```

# How to Run the Frontend (recommended part)
Ensuring a clean package cache and verifying your Flutter environment is highly recommended to prevent dependency conflicts and ensure a smooth installation:

```bash
git clone [https://github.com/Yusupov-Muhammadyusuf/social-auth-template.git](https://github.com/Yusupov-Muhammadyusuf/social-auth-template.git)
cd social-auth-template

flutter pub cache clean
flutter pub get
flutter doctor
flutter run
```
