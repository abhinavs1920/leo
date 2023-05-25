import 'package:flutter/material.dart';
import 'package:leo/utils/constants.dart';

class NameCard extends StatelessWidget {
  final String name;
  final String message;
  final String imageUrl;

  const NameCard({
    super.key,
    required this.name,
    required this.message,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(defaultCircularBordeRadius),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          height: 50,
          width: 50,
        ),
      ),
      title: Text(
        name,
      ),
      subtitle: Text(
        message,
      ),
    );
  }
}
