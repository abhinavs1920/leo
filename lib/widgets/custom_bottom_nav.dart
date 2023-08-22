import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int bottomNavIndex;
  final List<Map<String, dynamic>> iconsList;
  final Function(int) onItemTapped;
  const CustomBottomNavBar({
    super.key,
    required this.bottomNavIndex,
    required this.iconsList,
    required this.onItemTapped,
  });

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      fixedColor: Colors.indigo,
      currentIndex: widget.bottomNavIndex,
      onTap: widget.onItemTapped,
      items: widget.iconsList.map<BottomNavigationBarItem>((item) {
        return BottomNavigationBarItem(
          icon: Icon(item['icon']),
          activeIcon: Icon(
            item['icon'],
            color: Colors.indigo,
          ),
          label: item['title'],
        );
      }).toList(),
    );
  }
}
