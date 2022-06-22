import 'package:cpyd03/screens/home.dart';
import 'package:cpyd03/screens/login.dart';
import 'package:cpyd03/themes.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isAuthenticated = false;

  // ignore: unused_element
  void _checkAuthentication() {
    // Do some work here

    setState(() => _isAuthenticated = true);
  }

  @override
  Widget build(BuildContext context) {
    return _isAuthenticated ? HomeScreen() : const LoginScreen();
  }
}
