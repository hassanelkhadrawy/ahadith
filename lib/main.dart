import 'package:ahadith/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AhadithApp(AppRouter()));
}

class AhadithApp extends StatelessWidget {
  // This widget is the root of your application.
  late final AppRouter app_router;

  AhadithApp(this.app_router);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: app_router.genrateRoute,
    );
  }
}
