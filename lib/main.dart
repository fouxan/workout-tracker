import 'package:flutter/material.dart';
import 'package:workout_tracker/constants/routes.dart';
import 'package:workout_tracker/services/auth/auth_services.dart';
import 'package:workout_tracker/views/hidden_drawer.dart';
import 'package:workout_tracker/views/register_view.dart';
import 'package:workout_tracker/views/verify_email_view.dart';
import 'views/login_view.dart';
import 'views/dashboard_view.dart';

void main() {
  runApp(MaterialApp(
    title: 'Work.Out.',
    theme: ThemeData(
      fontFamily: 'Varela',
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Colors.white,
        onPrimary: Colors.black,
        secondary: Colors.black,
        onSecondary: Colors.white,
        error: Colors.red,
        onError: Colors.black,
        background: Colors.black,
        onBackground: Colors.white,
        surface: Colors.black,
        onSurface: Colors.white,
      ),
      useMaterial3: true,
    ),
    home: const HomePage(),
    routes: {
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      dashboardRoute: (context) => const DashboardView(),
      verifyEmailRoute: (context) => const VerifyEmailView(),
      drawerRoute: (context) => const DrawerView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AuthService.firebase().initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = AuthService.firebase().currentUser;
              if (user != null) {
                if (user.isEmailVerified) {
                  return const DrawerView();
                } else {
                  return const VerifyEmailView();
                }
              }
              return const LoginView();
            default:
              return const CircularProgressIndicator();
          }
        });
  }
}
