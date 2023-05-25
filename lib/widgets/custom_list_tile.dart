import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  const CustomListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      contentPadding: const EdgeInsets.all(8),
      subtitle: Text(
        subtitle,
      ),
      leading: SizedBox(
        height: double.infinity,
        child: Icon(icon),
      ),
      minLeadingWidth: 0,
    );
  }
}
