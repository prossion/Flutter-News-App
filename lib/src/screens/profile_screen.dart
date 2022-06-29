import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/config/app_theme.dart';
import 'package:flutter_news_app/src/blocs/blocs.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String country = '';

  Future initStateCustome() async {
    SharedPreferences prefs = await _prefs;
    country = prefs.getString('country')!;
  }

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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CachedNetworkImage(
                  imageUrl: '${user.photoURL}',
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Image(
                    image: AssetImage('assets/icons/profile_icon.png'),
                    width: 100,
                    height: 100,
                  ),
                ),
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
              const Padding(
                padding: EdgeInsets.only(top: 8.0, left: 5.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('Settings',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Row(
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
              ),
              const Divider(),
              ListTile(
                title:
                    const Text('News country', style: TextStyle(fontSize: 20)),
                trailing: Text(country),
                onTap: () => showPickerArray(context),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }

  showPickerArray(BuildContext context) async {
    SharedPreferences prefs = await _prefs;
    String country = prefs.getString('country') ?? '';
    int selected = 0;
    Color? textStyle = Theme.of(context).brightness == Brightness.dark
        ? Colors.white54
        : Colors.grey[800];
    Color? backgroundColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey[800]
        : Colors.white54;

    if (country == 'USA') {
      selected = 0;
    } else if (country == 'United Kingdom') {
      selected = 1;
    } else if (country == 'Germany') {
      selected = 2;
    } else if (country == 'France') {
      selected = 3;
    } else if (country == 'Ukraine') {
      selected = 4;
    } else if (country == 'Poland') {
      selected = 5;
    }

    Picker(
        selecteds: [selected],
        textStyle: TextStyle(color: textStyle, fontSize: 24),
        backgroundColor: backgroundColor,
        adapter: PickerDataAdapter<String>(
            pickerdata: const JsonDecoder().convert(pickerCountry),
            isArray: true),
        hideHeader: true,
        title: const Text("Please Select"),
        onConfirm: (Picker picker, List value) {
          prefs.setString(
              'country',
              picker
                  .getSelectedValues()
                  .toString()
                  .replaceAll('[', '')
                  .replaceAll(']', ''));
        }).showDialog(context);
  }
}

const pickerCountry = '''
[
    [ 
        "USA",
        "United Kingdom",
        "Germany",
        "France",
        "Ukraine",
        "Poland"
    ]
]
    ''';
