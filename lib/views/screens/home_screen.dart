import 'package:flutter/material.dart';
import 'package:main/utils/theme_provider.dart';
import 'package:main/views/screens/note_screen.dart';
import 'package:main/views/screens/todo_screen.dart';
import 'package:main/views/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.home),
        actions: [
          Switch(
            value: Provider.of<ThemeProvider>(context).isDarkMode,
            onChanged: (value) {
              Provider.of<ThemeProvider>(context, listen: false)
                  .toggleTheme(value);
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotesScreens()),
              );
            },
            child: Text(AppLocalizations.of(context)!.note),
          ),
          SizedBox(
            width: 180,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TodoAppScreens()),
              );
            },
            child: Text(AppLocalizations.of(context)!.todo),
          ),
        ],
      ),
    );
  }
}
