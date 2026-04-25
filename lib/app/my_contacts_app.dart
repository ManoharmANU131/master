import 'package:flutter/material.dart';
import 'package:my_contacts_app/app/router/route_config.dart';
import 'package:my_contacts_app/core/helpers/bloc_provider_helper.dart';
import 'package:my_contacts_app/core/theme/app_theme.dart';

class MyContactsApp extends StatelessWidget {
  const MyContactsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProviderHelper.getAllProvider(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        routerConfig: RouteConfig.router,
      ),
    );
  }
}
