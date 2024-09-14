import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:main/controllers/settings_controller.dart';

class SettingsNotifair extends InheritedWidget {
  final SettingsController settingsController;

  const SettingsNotifair({
    super.key,
    required super.child,
    required this.settingsController,
  });

  @override
  bool updateShouldNotify(covariant SettingsNotifair oldWidget) {
    return oldWidget.settingsController != settingsController;
  }

  static SettingsController of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SettingsNotifair>()!.settingsController;
  }
}
