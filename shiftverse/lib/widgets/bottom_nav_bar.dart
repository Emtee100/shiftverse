// import 'package:flutter/material.dart';
// import 'package:shiftverse/models/navigation_destination.dart';

// class BottomNavBar extends StatefulWidget {
//   const BottomNavBar({super.key, required this.selectedPage, required this.navigationDestinations});
//   final ValueChanged<int> selectedPage;
//   final List<Destination>navigationDestinations;

//   @override
//   State<BottomNavBar> createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar> {
//   @override
//   Widget build(BuildContext context) {
//     return NavigationBar(
//         selectedIndex: widget.selectedPage,
//         onDestinationSelected: (value) {
//           setState(() {
//             widget.selectedPage = value;
//           });
//         },
//         destinations: widget.navigationDestinations.map((navigationDestination) {
//           return NavigationDestination(
//               selectedIcon: navigationDestination.activeIcon,
//               icon: navigationDestination.icon,
//               label: navigationDestination.label);
//         }).toList());
//   }
// }
