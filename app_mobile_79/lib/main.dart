import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskify/pages/home.dart';
import 'package:taskify/pages/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget _currentPage = const Scaffold();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('tokenAuth') ?? '';
    setState(() {
      if (accessToken.isNotEmpty) {
        Map<String, dynamic> decodedToken = Jwt.parseJwt(accessToken);
        String name = decodedToken['firstName'];
        _currentPage = HomePage(
          name: name,
        );
      } else {
        _currentPage = LoginPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentPage,
    );
  }
}
