import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/src/blocs/auth/auth_bloc.dart';
import 'package:flutter_news_app/src/blocs/auth/auth_events.dart';
import 'package:flutter_news_app/src/blocs/auth/auth_state.dart';
import 'package:flutter_news_app/src/screens/sign_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UnAuthState) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const SignIn()),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('News'),
          actions: [
            IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(SignOutRequested());
              },
              icon: const Icon(Icons.logout_outlined),
            ),
          ],
        ),
        body: const Center(
          child: Text('here will have a newsed'),
        ),
      ),
    );
  }
}
