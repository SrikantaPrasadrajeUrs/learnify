import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnify/data/routes/route_constants.dart';

import '../sign_in_bloc/sign_in_bloc.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    // Dispatch the SignInRequired event when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SignInBloc>().add(SignInRequired(
        'user@example.com',
        'securePassword123',
      ));
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Welcome")),
      body: BlocListener<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            // Navigate to the next screen or show a success message
            Navigator.pushNamed(context, RouteConstants.home);
          } else if (state is SignInFailure) {
            // Show an error message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Sign-in failed")),
            );
          }
        },
        child: const Center(
          child: Text("Welcome to the App!"),
        ),
      ),
    );
  }
}
