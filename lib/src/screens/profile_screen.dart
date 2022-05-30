import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/config/app_theme.dart';
import 'package:flutter_news_app/src/blocs/blocs.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    void toggleSwitch(bool value) {
      setState(() {
        context.read<ThemeCubit>().switchTheme();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            children: [
              user.photoURL != null
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.network("${user.photoURL}"),
                    )
                  : Image.asset(
                      "assets/icons/profile_icon.png",
                      width: 150,
                      height: 150,
                    ),
              const SizedBox(
                height: 10,
              ),
              user.displayName != null
                  ? Text(
                      "${user.displayName}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w400),
                    )
                  : const Text(
                      'Your name',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Email: \n ${user.email}',
                style: const TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Sign Out'),
                onPressed: () {
                  context.read<AuthBloc>().add(SignOutRequested());
                },
              ),
              const Divider(),
              Row(
                children: [
                  const Text('Change theme mode',
                      style: TextStyle(fontSize: 20)),
                  const Spacer(),
                  Switch.adaptive(
                      activeColor: Colors.grey,
                      value: context.read<ThemeCubit>().state ==
                              AppThemes.lightTheme
                          ? true
                          : false,
                      onChanged: toggleSwitch),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
