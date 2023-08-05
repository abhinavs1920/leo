import 'package:flutter/material.dart';
import 'package:leo/utils/constants.dart';
import 'package:leo/widgets/unauthenticated_drawer.dart';

class UnAuthDrawerWrapper extends StatelessWidget {
  const UnAuthDrawerWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            SizedBox(height: 50),
            UnAuthDrawer(),
          ],
        ),
      ),
    );
  }
}
