import 'package:flutter/material.dart';
import 'package:workout_tracker/constants/routes.dart';
import 'package:workout_tracker/services/auth/auth_exceptions.dart';
import 'package:workout_tracker/services/auth/auth_services.dart';
import 'package:workout_tracker/utilities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            const SizedBox(height: 100, width: double.infinity),
            const Text(
              "Work.out.",
              style: TextStyle(
                  fontFamily: "Bemirs", fontSize: 60, color: Colors.white),
            ),
            const SizedBox(height: 100, width: double.infinity),
            SizedBox(
              width: 250,
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: _email,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'email.',
                ),
              ),
            ),
            const SizedBox(height: 50, width: double.infinity),
            SizedBox(
              width: 250,
              child: TextField(
                obscureText: true,
                controller: _password,
                decoration: const InputDecoration(
                  fillColor: Colors.black87,
                  border: OutlineInputBorder(),
                  labelText: 'password.',
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text("forgot password?"),
            ),
            const SizedBox(height: 25, width: double.infinity),
            OutlinedButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                try {
                  await AuthService.firebase().logIn(
                    email: email,
                    password: password,
                  );
                  final user = AuthService.firebase().currentUser;
                  if (user?.isEmailVerified ?? false) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      drawerRoute,
                      (route) => false,
                    );
                  } else {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      verifyEmailRoute,
                      (route) => false,
                    );
                  }
                } on WrongPasswordException {
                  await showErrorDialog(
                    context,
                    "Wrong password.",
                  );
                } on UserNotFoundException {
                  await showErrorDialog(
                    context,
                    "User not found.",
                  );
                } on GenericAuthException {
                  await showErrorDialog(
                    context,
                    "Authentication Error.",
                  );
                }
              },
              child: const Text("login."),
            ),
            const SizedBox(height: 25, width: double.infinity),
            OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    registerRoute,
                    (route) => false,
                  );
                },
                child: const Text("or register?"))
          ],
        )),
      ),
    );
  }
}
