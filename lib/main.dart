import 'package:flutter/material.dart';
import 'package:namer_app/src/store/history.store.dart';
import 'package:namer_app/src/store/favorites.store.dart';
import 'package:namer_app/src/store/image.store.dart';
import 'package:namer_app/src/app.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => FavoriteStore()),
      ChangeNotifierProvider(create: (_) => HistoryStore()),
      ChangeNotifierProvider(create: (_) => ImageStore()),
    ],
    child: Root(),
  ));
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Sandbox',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade900),
      ),
      home: App(),
    );
  }
}
