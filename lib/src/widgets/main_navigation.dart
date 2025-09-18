import 'dart:ui';
import 'package:dmt_movie_flutter/gen_l10n/app_localizations.dart';
import 'package:dmt_movie_flutter/src/screens/home_screen.dart';
import 'package:dmt_movie_flutter/src/screens/search_screen.dart';
import 'package:dmt_movie_flutter/src/screens/settings_screen.dart';
import 'package:flutter/material.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation>
    with SingleTickerProviderStateMixin {
  int _index = 0;

  final List<Widget> _tabs = const [
    HomeScreen(),
    SearchScreen(),
    SettingsScreen(),
  ];

  void _onTabTapped(int i) {
    setState(() => _index = i);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      extendBody: true,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: _tabs[_index],
      ),
      bottomNavigationBar: _CustomBottomNavBar(
        selectedIndex: _index,
        onTabTapped: _onTabTapped,
        theme: theme,
        localizations: t,
      ),
    );
  }
}

class _CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabTapped;
  final ThemeData theme;
  final AppLocalizations localizations;

  const _CustomBottomNavBar({
    required this.selectedIndex,
    required this.onTabTapped,
    required this.theme,
    required this.localizations,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 90,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background blur
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.07),
                        blurRadius: 24,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Navigation items
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Home tab
                _NavItem(
                  icon: Icons.home_outlined,
                  selectedIcon: Icons.home_rounded,
                  label: localizations.tabHome,
                  isSelected: selectedIndex == 0,
                  onTap: () => onTabTapped(0),
                ),
                // Search tab center, style lớn, nổi bật
                SizedBox(width: 24),
                _CenterNavItem(
                  isSelected: selectedIndex == 1,
                  onTap: () => onTabTapped(1),
                ),
                SizedBox(width: 24),
                // Profile tab
                _NavItem(
                  icon: Icons.person_outline,
                  selectedIcon: Icons.person,
                  label: 'Profile',
                  isSelected: selectedIndex == 2,
                  onTap: () => onTabTapped(2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? const Color(0xFF6366F1) : Colors.black54;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? selectedIcon : icon,
              color: color,
              size: 28,
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _CenterNavItem extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;

  const _CenterNavItem({
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Đẩy nút này lên cao hơn một chút
    return Transform.translate(
      offset: const Offset(0, -22),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF6366F1),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6366F1).withOpacity(0.18),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
            border: Border.all(
              color: Colors.white,
              width: 6,
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.search,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
      ),
    );
  }
}