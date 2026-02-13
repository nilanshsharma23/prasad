import 'package:flutter/material.dart';
import 'package:prasad/l10n/app_localizations.dart';

class MainNavigationBar extends StatelessWidget {
  const MainNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final int selectedIndex;
  final void Function(int index) onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: onDestinationSelected,
      indicatorColor: Theme.of(context).colorScheme.onSurface,
      selectedIndex: selectedIndex,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      indicatorShape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16),
      ),
      destinations: [
        NavigationDestination(
          icon: Icon(Icons.home_outlined, size: 32),
          label: "Home",
          selectedIcon: Icon(
            size: 32,
            Icons.home,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        NavigationDestination(
          icon: Icon(Icons.add_outlined, size: 32),
          label: AppLocalizations.of(context)!.host,
          selectedIcon: Icon(
            size: 32,
            Icons.add,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        NavigationDestination(
          icon: Icon(Icons.view_comfortable_outlined, size: 32),
          label: AppLocalizations.of(context)!.myBhandaras,
          selectedIcon: Icon(
            Icons.view_comfortable,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 32,
          ),
        ),
        NavigationDestination(
          icon: Icon(Icons.store_outlined, size: 32),
          label: AppLocalizations.of(context)!.myBhandaras,
          selectedIcon: Icon(
            Icons.store,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 32,
          ),
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline, size: 32),
          label: "Profile",

          selectedIcon: Icon(
            Icons.person,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 32,
          ),
        ),
      ],
    );
  }
}
