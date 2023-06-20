import 'package:flutter/material.dart';
import 'package:leo/pages/events.dart';
import 'package:leo/pages/get_started.dart';
import 'package:leo/services/auth.service.dart';
import 'package:leo/widgets/custom_appbar.dart';
import 'package:leo/widgets/custom_drawer.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().user,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == null) {
            return const Scaffold(
              appBar: CustomAppBar(
                title: "Events",
              ),
              endDrawer: CustomDrawer(),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return const EventsPage();
        } else {
          return const GetStartedPage();
        }
      },
    );
  }
}
