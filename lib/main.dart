import 'package:flutter/material.dart';
import 'package:insults_album/providers/auth_provider.dart';
import 'package:insults_album/screens/login.dart';
import 'package:insults_album/screens/cards.dart';
import 'package:insults_album/screens/profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        initialRoute: "/",
        routes: {
          "/": (context) => LoginPage(),
          "/cards": (context) => CardsPage(),
          "/profile": (context) => ProfilePage(),
        },
      ),
    );
  }
}
