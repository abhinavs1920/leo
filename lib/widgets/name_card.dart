import 'package:flutter/material.dart';
import 'package:leo/utils/constants.dart';

class NameCard extends StatelessWidget {
  final String name;
  final String message;
  final String? imageUrl;

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
          imageUrl ??
              'https://firebasestorage.googleapis.com/v0/b/leo-nepal.appspot.com/o/appImages%2Fmessage_profile_placeholder.jpg?alt=media&token=cd94f1d7-6170-43d5-82d1-5ba10153b5ac',
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
