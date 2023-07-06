// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:workout_tracker/constants/routes.dart';

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Log Out"),
        content: const Text("are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text("Cancel."),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text("Yes."),
          )
        ],
      );
    },
  ).then((value) => value ?? false);
}

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(
      //   title: const Text("Dashboard"),
      //   actions: [
      //     PopupMenuButton<MenuAction>(
      //       onSelected: (value) async {
      //         switch (value) {
      //           case MenuAction.logout:
      //             final shouldLogout = await showLogOutDialog(context);
      //             if (shouldLogout) {
      //               await FirebaseAuth.instance.signOut();
      //               if (context.mounted) {
      //                 Navigator.of(context).pushNamedAndRemoveUntil(
      //                     loginRoute, (route) => false);
      //               }
      //             }
      //         }
      //       },
      //       itemBuilder: (context) {
      //         return [
      //           const PopupMenuItem<MenuAction>(
      //             value: MenuAction.logout,
      //             child: Text("log.out."),
      //           )
      //         ];
      //       },
      //     )
      //   ],
      // ),
      // body: const SafeArea(
      //   child: Text("Hello"),
      // ),
    );
  }
}
