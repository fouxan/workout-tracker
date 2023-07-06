import 'package:flutter/material.dart';
import 'package:workout_tracker/constants/routes.dart';
import 'package:workout_tracker/services/auth/auth_exceptions.dart';
import 'package:workout_tracker/services/auth/auth_services.dart';
import 'package:workout_tracker/utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
            const SizedBox(height: 25, width: double.infinity),
            OutlinedButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                try {
                  await AuthService.firebase().createUser(
                    email: email,
                    password: password,
                  );
                  await AuthService.firebase().sendEmailVerification();
                  if (context.mounted) {
                    Navigator.of(context).pushNamed(verifyEmailRoute);
                  }
                } on EmailInUseException {
                  showErrorDialog(
                    context,
                    "Email already in use.",
                  );
                } on WeakPasswordException {
                  showErrorDialog(
                    context,
                    "Weak Password",
                  );
                } on GenericAuthException {
                  showErrorDialog(
                    context,
                    "Authentication Error.",
                  );
                }
              },
              child: const Text("register."),
            ),
            const SizedBox(height: 25, width: double.infinity),
            OutlinedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(loginRoute, (route) => false);
                },
                child: const Text("or login?"))
          ],
        )),
      ),
    );
  }
}
