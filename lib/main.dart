import 'package:flutter/material.dart';
import 'package:learnify/core/network/connection_checker.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  print(await ConnectionCheckImpl().isConnected);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
