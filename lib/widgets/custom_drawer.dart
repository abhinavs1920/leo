import 'package:flutter/material.dart';
import 'package:leo/services/auth.service.dart';
import 'package:leo/utils/constants.dart';
import 'package:leo/utils/routes.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  static const TextStyle textStyle = TextStyle(
    fontSize: 16,
  );
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: const EdgeInsets.all(defaultPadding),
        children: [
          const SizedBox(
            height: 50,
          ),
          ListTile(
            title: Text(
              "Kunal Jain",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            subtitle: Text(
              "President",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const Divider(
            color: primaryColor,
          ),
          const ListTile(
            leading: Icon(
              Icons.download,
            ),
            title: Text(
              'Club Manual',
              style: textStyle,
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
            ),
            title: const Text(
              'Signout',
              style: textStyle,
            ),
            onTap: () {
              AuthService().signout();
              Navigator.of(context).pushReplacementNamed(RouteEnums.getStarted);
            },
          ),
        ],
      ),
    );
  }
}
