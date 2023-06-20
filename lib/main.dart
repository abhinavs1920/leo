import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:leo/models/auth.model.dart';
import 'package:leo/pages/add_event.dart';
import 'package:leo/pages/auth_wrapper.dart';
import 'package:leo/pages/events.dart';
import 'package:leo/pages/get_started.dart';
import 'package:leo/pages/login.dart';
import 'package:leo/services/auth.service.dart';
import 'package:leo/utils/routes.dart';
import 'package:leo/utils/theme.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<AuthModel?>(
          initialData: null,
          create: (_) => AuthService().user,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Leo',
        theme: lightThemeData,
        routes: {
          RouteEnums.authWrapper: (context) => const AuthWrapper(),
          RouteEnums.getStarted: (context) => const GetStartedPage(),
          RouteEnums.login: (context) => const LoginPage(),
          RouteEnums.eventsPage: (context) => const EventsPage(),
          RouteEnums.addEventPage: (context) => const AddEventPage()
        },
      ),
    );
  }
}
