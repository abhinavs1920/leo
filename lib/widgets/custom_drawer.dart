import 'package:flutter/material.dart';
import 'package:leo/models/auth.model.dart';
import 'package:leo/services/auth.service.dart';
import 'package:leo/services/user.service.dart';
import 'package:leo/utils/constants.dart';
import 'package:leo/utils/routes.dart';
import 'package:leo/utils/string_utility.dart';
import 'package:provider/provider.dart';

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
    final auth = Provider.of<AuthModel?>(context);
    return Drawer(
      child: StreamBuilder(
        stream: UserService(uid: auth?.uid ?? '').user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final user = snapshot.data;
            return ListView(
              // Important: Remove any padding from the ListView.
              padding: const EdgeInsets.all(defaultPadding),
              children: [
                const SizedBox(
                  height: 50,
                ),
                ListTile(
                  title: Text(
                    user?.name ?? '',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  subtitle: Text(
                    user?.designation.toCapitalized() ?? '',
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
                    Navigator.of(context)
                        .pushReplacementNamed(RouteEnums.getStarted);
                  },
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
