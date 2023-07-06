import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:workout_tracker/enums/menu_actions.dart';
import 'package:workout_tracker/services/auth/auth_services.dart';
import 'package:workout_tracker/views/dashboard_view.dart';
import 'package:workout_tracker/views/exercises_view.dart';
import 'package:workout_tracker/views/workouts_view.dart';
import '../constants/routes.dart';

class DrawerView extends StatefulWidget {
  const DrawerView({super.key});

  @override
  State<DrawerView> createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  List<ScreenHiddenDrawer> _pages = [];

  final myTextStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  @override
  void initState() {
    super.initState();

    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Dashboard",
          baseStyle: myTextStyle,
          selectedStyle: myTextStyle,
          colorLineSelected: Colors.white,
        ),
        const DashboardView(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Workouts",
          baseStyle: myTextStyle,
          selectedStyle: myTextStyle,
          colorLineSelected: Colors.white,
        ),
        const WorkoutsView(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Exercises",
          baseStyle: myTextStyle,
          selectedStyle: myTextStyle,
          colorLineSelected: Colors.white,
        ),
        const ExerciseView(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      screens: _pages,
      backgroundColorMenu: Colors.grey,
      slidePercent: 50,
      actionsAppBar: [
        PopupMenuButton<MenuAction>(
          onSelected: (value) async {
            switch (value) {
              case MenuAction.logout:
                final shouldLogout = await showLogOutDialog(context);
                if (shouldLogout) {
                  await AuthService.firebase().logOut();
                  if (context.mounted) {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(loginRoute, (route) => false);
                  }
                }
            }
          },
          itemBuilder: (context) {
            return [
              const PopupMenuItem<MenuAction>(
                value: MenuAction.logout,
                child: Text("log.out."),
              )
            ];
          },
        )
      ],
    );
  }
}
