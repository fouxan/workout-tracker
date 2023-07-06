import 'package:flutter/material.dart';
import 'package:workout_tracker/constants/routes.dart';
import 'package:workout_tracker/services/auth/auth_services.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify email."),
      ),
      body: Column(
        children: [
          const SizedBox(height: 100, width: double.infinity),
          const Text(
            "An email with a verification link has been sent to your email account. Please verify your account to login.",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50, width: double.infinity),
          const Text(
            "If you haven't received a link yet, press the button below to get another email.",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 25, width: double.infinity),
          OutlinedButton(
            onPressed: () async {
              AuthService.firebase().sendEmailVerification();
            },
            child: const Text("verify email."),
          ),
          const SizedBox(height: 50, width: double.infinity),
          const Text(
            "If you have already verified your email, press the button below to login again.",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 25, width: double.infinity),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginRoute, (route) => false);
            },
            child: const Text("back to login."),
          )
        ],
      ),
    );
  }
}
