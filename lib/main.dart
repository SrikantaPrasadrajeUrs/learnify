import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnify/core/network/connection_checker.dart';
import 'package:bloc/bloc.dart';
import 'package:learnify/data/routes/routes.dart';
import 'package:learnify/features/auth/repository/auth_repository.dart';
import 'package:learnify/features/auth/sign_in_bloc/sign_in_bloc.dart';
import 'package:learnify/simple_bloc_observer.dart';

import 'features/auth/presentation/welcome.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: routes,
      home: MultiBlocProvider(
          providers: [
            BlocProvider(
                create:(context)=> SignInBloc(AuthRepositoryImpl())
            )
          ],
          child: Welcome()
      ),
    );
  }
}
