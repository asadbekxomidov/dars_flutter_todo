import 'package:flutter/material.dart';
import 'package:main/utils/app_contants.dart';
import 'package:main/utils/routnames.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.purple.shade400,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      RouteNames.homeRoute,
                    );
                  },
                  leading: Icon(
                    Icons.home,
                    size: AppConstants.drawerIconSize,
                  ),
                  title: Text(
                    AppLocalizations.of(context)!.home,
                    style: TextStyle(
                      fontSize: AppConstants.drawerTextSize,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      RouteNames.settingsRoute,
                    );
                  },
                  leading: Icon(
                    Icons.settings,
                    size: AppConstants.drawerIconSize,
                  ),
                  title: Text(
                    AppLocalizations.of(context)!.settings,
                    style: TextStyle(
                      fontSize: AppConstants.drawerTextSize,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      RouteNames.todoRoute,
                    );
                  },
                  leading: Icon(
                    Icons.toll_outlined,
                    size: AppConstants.drawerIconSize,
                  ),
                  title: Text(
                    AppLocalizations.of(context)!.todo,
                    style: TextStyle(
                      fontSize: AppConstants.drawerTextSize,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      RouteNames.noteRoute,
                    );
                  },
                  leading: Icon(
                    Icons.note,
                    size: AppConstants.drawerIconSize,
                  ),
                  title: Text(
                    AppLocalizations.of(context)!.note,
                    style: TextStyle(
                      fontSize: AppConstants.drawerTextSize,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      RouteNames.courseRoute,
                    );
                  },
                  leading: Icon(
                    Icons.golf_course,
                    size: AppConstants.drawerIconSize,
                  ),
                  title: Text(
                    AppLocalizations.of(context)!.course,
                    style: TextStyle(
                      fontSize: AppConstants.drawerTextSize,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      RouteNames.lessonRoute,
                    );
                  },
                  leading: Icon(
                    Icons.play_lesson,
                    size: AppConstants.drawerIconSize,
                  ),
                  title: Text(
                    AppLocalizations.of(context)!.lesson,
                    style: TextStyle(
                      fontSize: AppConstants.drawerTextSize,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      RouteNames.quizRoute,
                    );
                  },
                  leading: Icon(
                    Icons.quiz,
                    size: AppConstants.drawerIconSize,
                  ),
                  title: Text(
                    AppLocalizations.of(context)!.quiz,
                    style: TextStyle(
                      fontSize: AppConstants.drawerTextSize,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      RouteNames.loginRoute,
                    );
                  },
                  leading: Icon(
                    Icons.login,
                    size: AppConstants.drawerIconSize,
                  ),
                  title: Text(
                    AppLocalizations.of(context)!.login,
                    style: TextStyle(
                      fontSize: AppConstants.drawerTextSize,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
