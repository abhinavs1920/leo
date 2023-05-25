import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:leo/pages/events.dart';
import 'package:leo/pages/get_started.dart';
import 'package:leo/services/auth.service.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().ideTokenChanges,
      builder: (context, snapshot) {
        print('hellooooo: ${snapshot.data}');
        if (snapshot.hasData) {
          return const EventsPage();
        } else {
          return const GetStartedPage();
        }
      },
    );
  }
}
