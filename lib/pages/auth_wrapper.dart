import 'package:flutter/material.dart';
import 'package:leo/pages/login.dart';
import 'package:leo/services/auth.service.dart';
import 'package:leo/widgets/custom_appbar.dart';
import 'package:leo/widgets/custom_bottom_nav.dart';
import 'package:leo/widgets/custom_drawer.dart';
import 'package:leo/widgets/events_list.dart';
import 'package:leo/widgets/posts_list.dart';
import 'package:leo/widgets/unauthenticated_drawer.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  int _bottomNavIndex = 0;

  static List<Widget> _pages = <Widget>[
    EventsList(date: DateTime.now()),
    PostsList(),
  ];

  static const List<Map<String, dynamic>> iconsList = [
    {
      'icon': Icons.event,
      'title': 'Events',
    },
    {
      'icon': Icons.notes,
      'title': 'Posts',
    },
  ];

  dynamic _onItemTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().user,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: CustomAppBar(
              title: "Events",
            ),
            endDrawer:
                snapshot.data?.uid == null ? UnAuthDrawer() : CustomDrawer(),
            bottomNavigationBar: CustomBottomNavBar(
              bottomNavIndex: _bottomNavIndex,
              iconsList: iconsList,
              onItemTapped: _onItemTapped,
            ),
            body: snapshot.data == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : IndexedStack(
                    index: _bottomNavIndex,
                    children: _pages,
                  ),
          );
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
