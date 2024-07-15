import 'package:flutter/material.dart';
import 'package:shiftverse/models/navigation_destination.dart';

class SideNavRail extends StatefulWidget {
  const SideNavRail({super.key});

  @override
  State<SideNavRail> createState() => _SideNavRailState();
}

class _SideNavRailState extends State<SideNavRail> {
  int selectedPage = 0;
  List<Destination> navigationDestinations = navDestinations;
  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      destinations: navigationDestinations.map((navigationDestination) {
        return NavigationRailDestination(
            selectedIcon: navigationDestination.activeIcon,
            icon: navigationDestination.icon,
            label: Text(navigationDestination.label));
      }).toList(),
      selectedIndex: selectedPage,
      onDestinationSelected: (value) {
        setState(() {
          selectedPage = value;
        });
      },
    );
  }
}
