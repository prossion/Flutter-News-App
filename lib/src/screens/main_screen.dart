import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/src/blocs/blocs.dart';
import 'package:flutter_news_app/src/screens/screens.dart';
import 'package:flutter_news_app/src/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  static const List<Widget> screens = <Widget>[
    NewsScreen(),
    // SearchScreen(),
    ProfileScreen()
  ];
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
          title:
              const Text('Flutter News', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                showSearch(context: context, delegate: CustomSearchDelegate());
              },
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.search),
            //   label: 'Search',
            // ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
