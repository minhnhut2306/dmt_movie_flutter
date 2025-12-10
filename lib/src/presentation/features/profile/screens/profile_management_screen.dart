import 'package:dmt_movie_flutter/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../../../core/app_assets.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/responsive.dart';
import '../../../../core/utils/extensions.dart';

class ProfileManagementScreen extends StatelessWidget {
  const ProfileManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.isDarkMode;
    final maxWidth = Responsive.maxContentWidth(context);
    
    final profiles = [
      {'name': l10n.user, 'color': Colors.teal, 'image': AppImages.thu},
      {'name': l10n.kids, 'color': Colors.orange, 'image': AppImages.treen},
    ];

    return Scaffold(
      backgroundColor: isDark ? AppColors.profileBackgroundDark : AppColors.profileBackgroundLight,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: isDark ? AppColors.darkBackgroundLight : AppColors.backgroundLight,
        elevation: 0,
        toolbarHeight: Responsive.appBarHeight(context),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : AppColors.textPrimary,
            size: Responsive.size24(context),
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          l10n.selectProfile,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: Responsive.headingFontSize(context),
            color: isDark ? Colors.white : AppColors.textPrimary,
          ),
        ),
      ),
      body: Center(
        child: Container(
          width: maxWidth == double.infinity ? double.infinity : maxWidth,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: Responsive.pagePadding(context),
                  child: Column(
                    children: [
                      ...profiles.map(
                        (profile) => _ProfileItem(
                          name: profile['name'] as String,
                          color: profile['color'] as Color,
                          image: profile['image'] as String,
                          isDark: isDark,
                          onTap: () {
                            context.showSnackBar(
                              l10n.editProfileTitle(profile['name'] as String)
                            );
                          },
                        ),
                      ),
                      _AddProfileButton(
                        isDark: isDark,
                        onTap: () {
                          context.showSnackBar(l10n.addNewProfile);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileItem extends StatelessWidget {
  final String name;
  final Color color;
  final String image;
  final bool isDark;
  final VoidCallback onTap;

  const _ProfileItem({
    required this.name,
    required this.color,
    required this.image,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isKidsProfile = name.toLowerCase() == l10n.kids.toLowerCase();
    final avatarSize = Responsive.avatarSmall(context);

    return Container(
      margin: EdgeInsets.only(bottom: Responsive.spacingM(context)),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(Responsive.radiusM(context)),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.border,
          width: 1,
        ),
        boxShadow: isDark ? [] : [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(Responsive.radiusM(context)),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.spacingM(context),
              vertical: Responsive.spacingS(context) + 4,
            ),
            child: Row(
              children: [
                Container(
                  width: avatarSize,
                  height: avatarSize,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: Responsive.spacingS(context) + 4),
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      color: isDark ? Colors.white : AppColors.textPrimary,
                      fontSize: Responsive.bodyFontSize(context),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                if (!isKidsProfile)
                  Text(
                    l10n.editProfile,
                    style: TextStyle(
                      color: isDark ? Colors.white54 : AppColors.textTertiary,
                      fontSize: Responsive.captionFontSize(context),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                SizedBox(width: Responsive.spacingS(context)),
                Icon(
                  Icons.arrow_forward_ios,
                  color: isDark ? Colors.white54 : AppColors.textTertiary,
                  size: Responsive.size16(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AddProfileButton extends StatelessWidget {
  final bool isDark;
  final VoidCallback onTap;

  const _AddProfileButton({
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final avatarSize = Responsive.avatarSmall(context);

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(Responsive.radiusM(context)),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.border,
          width: 1,
        ),
        boxShadow: isDark ? [] : [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(Responsive.radiusM(context)),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.spacingM(context),
              vertical: Responsive.spacingS(context) + 4,
            ),
            child: Row(
              children: [
                Container(
                  width: avatarSize,
                  height: avatarSize,
                  decoration: BoxDecoration(
                    color: isDark 
                      ? AppColors.darkSurfaceVariant 
                      : AppColors.surfaceVariant,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add,
                    color: isDark ? Colors.white70 : AppColors.textSecondary,
                    size: Responsive.size24(context),
                  ),
                ),
                SizedBox(width: Responsive.spacingS(context) + 4),
                Expanded(
                  child: Text(
                    l10n.addNewProfile,
                    style: TextStyle(
                      color: isDark ? Colors.white70 : AppColors.textSecondary,
                      fontSize: Responsive.bodyFontSize(context),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}