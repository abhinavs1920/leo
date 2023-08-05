import 'package:flutter/material.dart';
import 'package:leo/models/auth.model.dart';
import 'package:leo/services/auth.service.dart';
import 'package:leo/services/user.service.dart';
import 'package:leo/utils/constants.dart';
import 'package:leo/utils/routes.dart';
import 'package:leo/utils/string_utility.dart';
import 'package:leo/widgets/unauthenticated_drawer.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
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
                UnAuthDrawer(),
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
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
