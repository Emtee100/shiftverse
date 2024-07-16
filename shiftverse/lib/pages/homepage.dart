import 'package:flutter/material.dart';
import 'package:shiftverse/models/navigation_destination.dart';
import 'package:shiftverse/pages/home.dart';
import 'package:shiftverse/pages/profile.dart';
import 'package:shiftverse/pages/reports.dart';
import 'package:shiftverse/pages/shifts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Widget> pages = const [HomeScreen(), Reports(), Shifts(), Profile()];

  int selectedPage = 0;
  List<Destination> navigationDestinations = navDestinations;
  @override
  Widget build(BuildContext context) {
    bool useSideNavRail = MediaQuery.sizeOf(context).width >= 600;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          centerTitle: true,
          title: Text(
            'ShiftVerse',
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
        body: pages[selectedPage],
        bottomNavigationBar: useSideNavRail
            ? null
            : NavigationBar(
                selectedIndex: selectedPage,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedPage = value;
                  });
                },
                destinations:
                    navigationDestinations.map((navigationDestination) {
                  return NavigationDestination(
                      selectedIcon: navigationDestination.activeIcon,
                      icon: navigationDestination.icon,
                      label: navigationDestination.label);
                }).toList()));
  }
}
