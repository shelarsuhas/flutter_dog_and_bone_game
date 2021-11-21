import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/service_locator.dart' as service_locator;
import 'ui/feature/game_screeen/screens/game_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await service_locator.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GameScreen(),
      navigatorKey: StackedService.navigatorKey,
    );
  }
}
