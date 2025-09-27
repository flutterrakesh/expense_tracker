import 'package:expense_app/screens/spalsh_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'routes/routes.dart';
import 'routes/routes_generator.dart';

void main() {
  String initialRoute = Routes.splash;
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
  ));
  runApp( MyApp(initialRoute));
}
Object? args;
class MyApp extends StatelessWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();

  final String initialRoute;
  const MyApp(this.initialRoute,{super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: MyApp.navigatorKey,
      theme: ThemeData(
        useMaterial3: false,
        highlightColor: Colors.transparent,
        applyElevationOverlayColor: false,
        primaryColor: Colors.transparent,
        secondaryHeaderColor: Colors.transparent,
        fontFamily: "Poppins",
      ),
      initialRoute: Routes.splash,
      navigatorObservers: [ClearFocusOnPush()],
      onGenerateRoute: RoutesGenerator.generateRoute,
      onGenerateInitialRoutes: (String initialRouteName) {
        return [
          RoutesGenerator.generateRoute(RouteSettings(name: initialRoute, arguments: args)),
        ];
      },
    );
  }
}
class ClearFocusOnPush extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    final focus = FocusManager.instance.primaryFocus;
    focus?.unfocus();
  }
}