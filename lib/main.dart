// import 'package:flutter/material.dart';
// import 'package:main/utils/card_provider.dart';
// import 'package:main/utils/routes.dart';
// import 'package:main/utils/theme.dart';
// import 'package:main/utils/theme_provider.dart';
// import 'package:main/views/screens/home_screen.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';

// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => CartProvider()),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => ThemeProvider(),
//       child: Consumer<ThemeProvider>(
//         builder: (context, themeProvider, child) {
//           return MaterialApp(
//             themeMode: themeProvider.themeMode,
//             theme: AppThemes.lightTheme,
//             darkTheme: AppThemes.darkTheme,
//             initialRoute: '/',
//             routes: AppRoutes.routes,
//             debugShowCheckedModeBanner: false,
//             localizationsDelegates: [
//               GlobalMaterialLocalizations.delegate,
//               GlobalWidgetsLocalizations.delegate,
//               GlobalCupertinoLocalizations.delegate,
//             ],
//             supportedLocales: [
//               Locale('uz'),
//               Locale('en'),
//               Locale('ru'),
//             ],
//             home: HomeScreen(),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:main/utils/card_provider.dart';
import 'package:main/utils/routes.dart';
import 'package:main/utils/theme.dart';
import 'package:main/utils/theme_provider.dart';
import 'package:main/views/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            themeMode: themeProvider.themeMode,
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            initialRoute: '/',
            routes: AppRoutes.routes,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Locale('ru'),
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}
