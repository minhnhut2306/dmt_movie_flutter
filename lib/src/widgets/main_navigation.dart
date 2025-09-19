import 'dart:ui';
import 'package:dmt_movie_flutter/gen_l10n/app_localizations.dart';
import 'package:dmt_movie_flutter/src/core/app_colors.dart';
import 'package:dmt_movie_flutter/src/core/app_text_styles.dart';
import 'package:dmt_movie_flutter/src/core/responsive.dart';
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
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      extendBody: true,
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
      body: AnimatedSwitcher(
        duration: Responsive.animationDuration(context, isLong: true),
        child: _tabs[_index],
      ),
      bottomNavigationBar: _CustomBottomNavBar(
        selectedIndex: _index,
        onTabTapped: _onTabTapped,
        isDark: isDark,
        localizations: t,
      ),
    );
  }
}

class _CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabTapped;
  final bool isDark;
  final AppLocalizations localizations;

  const _CustomBottomNavBar({
    required this.selectedIndex,
    required this.onTabTapped,
    required this.isDark,
    required this.localizations,
  });

  @override
  Widget build(BuildContext context) {
    final navHeight = Responsive.bottomNavHeight(context);
    final navMargin = Responsive.bottomNavMargin(context);
    final navBorderRadius = Responsive.bottomNavBorderRadius(context);
    final blurIntensity = Responsive.blurIntensity(context);
    final shadowBlurRadius = Responsive.shadowBlurRadius(context);
    final shadowOffset = Responsive.shadowOffset(context);

    return Container(
      margin: EdgeInsets.all(navMargin),
      height: navHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(navBorderRadius),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: blurIntensity,
                  sigmaY: blurIntensity,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color:
                        isDark
                            ? AppColors.glassDark.withOpacity(0.8)
                            : AppColors.glassLight.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(navBorderRadius),
                    border: Border.all(
                      color:
                          isDark
                              ? AppColors.darkNavBorder
                              : AppColors.navBorder,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color:
                            isDark
                                ? AppColors.shadowDark
                                : AppColors.shadowLight,
                        blurRadius: shadowBlurRadius,
                        offset: shadowOffset,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _NavItem(
                  icon: Icons.home_outlined,
                  selectedIcon: Icons.home_rounded,
                  label: localizations.tabHome,
                  isSelected: selectedIndex == 0,
                  onTap: () => onTabTapped(0),
                  isDark: isDark,
                ),
                _NavItem(
                  icon: Icons.home_outlined,
                  selectedIcon: Icons.home_rounded,
                  label: localizations.tabHome,
                  isSelected: selectedIndex == 0,
                  onTap: () => onTabTapped(0),
                  isDark: isDark,
                ),

                SizedBox(
                  width: Responsive.responsive<double>(
                    context,
                    mobile: 24,
                    tablet: 28,
                    largeTablet: 32,
                  ),
                ),

                _CenterNavItem(
                  isSelected: selectedIndex == 1,
                  onTap: () => onTabTapped(1),
                  isDark: isDark,
                ),

                SizedBox(
                  width: Responsive.responsive<double>(
                    context,
                    mobile: 24,
                    tablet: 28,
                    largeTablet: 32,
                  ),
                ),
                _NavItem(
                  icon: Icons.person_outline,
                  selectedIcon: Icons.person,
                  label: localizations.tabSettings,
                  isSelected: selectedIndex == 2,
                  onTap: () => onTabTapped(2),
                  isDark: isDark,
                ),

                _NavItem(
                  icon: Icons.person_outline,
                  selectedIcon: Icons.person,
                  label: localizations.tabSettings,
                  isSelected: selectedIndex == 2,
                  onTap: () => onTabTapped(2),
                  isDark: isDark,
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
  final bool isDark;

  const _NavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final iconSize = Responsive.iconSize(context, isSelected: isSelected);
    final animationDuration = Responsive.animationDuration(context);

    final color =
        isSelected
            ? AppColors.primary
            : (isDark ? AppColors.darkTextSecondary : AppColors.textSecondary);

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: animationDuration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: animationDuration,
                child: Icon(
                  isSelected ? selectedIcon : icon,
                  color: color,
                  size: iconSize,
                  key: ValueKey(isSelected),
                ),
              ),
              SizedBox(
                height: Responsive.responsive<double>(
                  context,
                  mobile: 6,
                  tablet: 8,
                  largeTablet: 10,
                ),
              ),
              AnimatedDefaultTextStyle(
                duration: animationDuration,
                style: AppTextStyles.getNavLabelStyle(
                  isSelected: isSelected,
                  isTablet: Responsive.isTabletOrLarger(context),
                  isDark: isDark,
                ),
                child: Text(label, textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CenterNavItem extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDark;

  const _CenterNavItem({
    required this.isSelected,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final containerSize = Responsive.centerIconContainerSize(context);
    final iconSize = Responsive.centerIconSize(context);
    final animationDuration = Responsive.animationDuration(context);

    final offsetY = Responsive.responsive<double>(
      context,
      mobile: -22,
      tablet: -24,
      largeTablet: -26,
    );

    return Transform.translate(
      offset: Offset(0, offsetY),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: animationDuration,
          width: containerSize,
          height: containerSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: Responsive.shadowBlurRadius(context),
                offset: Offset(0, Responsive.shadowOffset(context).dy + 4),
              ),
            ],
            border: Border.all(
              color:
                  isDark ? AppColors.darkBackground : AppColors.backgroundLight,
              width: Responsive.responsive<double>(
                context,
                mobile: 6,
                tablet: 7,
                largeTablet: 8,
              ),
            ),
          ),
          child: AnimatedScale(
            duration: animationDuration,
            scale: isSelected ? 1.1 : 1.0,
            child: Center(
              child: Icon(Icons.search, color: Colors.white, size: iconSize),
            ),
          ),
        ),
      ),
    );
  }
}
