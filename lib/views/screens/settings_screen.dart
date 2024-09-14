import 'package:flutter/material.dart';
import 'package:main/utils/app_contants.dart';
import 'package:main/views/widgets/custom_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.appBarColor,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.settings,
          style: TextStyle(
            fontSize: AppConstants.appBarTextSize,
            color: AppConstants.appBarTextColor,
          ),
        ),
      ),
      drawer: const AppDrawer(),
    );
  }
}
