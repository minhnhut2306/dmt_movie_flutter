import 'package:dmt_movie_flutter/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../../../core/app_assets.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/utils/extensions.dart';
class ProfileManagementScreen extends StatelessWidget {
  const ProfileManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    final profiles = [
      {'name': l10n.user, 'color': Colors.teal, 'image': AppImages.thu},
      {'name': l10n.kids, 'color': Colors.orange, 'image': AppImages.treen},
    ];

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text(
          l10n.selectProfile,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(AppDimensions.paddingL),
              child: Column(
                children: [
                  ...profiles.map(
                    (profile) => _ProfileItem(
                      name: profile['name'] as String,
                      color: profile['color'] as Color,
                      image: profile['image'] as String,
                      onTap: () {
                        context.showSnackBar(
                          l10n.editProfileTitle(profile['name'] as String)
                        );
                      },
                    ),
                  ),
                  _AddProfileButton(
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
    );
  }
}

class _ProfileItem extends StatelessWidget {
  final String name;
  final Color color;
  final String image;
  final VoidCallback onTap;

  const _ProfileItem({
    required this.name,
    required this.color,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isKidsProfile = name.toLowerCase() == l10n.kids.toLowerCase();

    return Container(
      margin: EdgeInsets.only(bottom: AppDimensions.spacingM),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingM,
              vertical: AppDimensions.paddingS + 4,
            ),
            child: Row(
              children: [
                Container(
                  width: AppDimensions.avatarS,
                  height: AppDimensions.avatarS,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: AppDimensions.spacingS + 4),
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                if (!isKidsProfile)
                  Text(
                    l10n.editProfile,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                SizedBox(width: AppDimensions.spacingS),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white54,
                  size: 16,
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
  final VoidCallback onTap;

  const _AddProfileButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingM,
              vertical: AppDimensions.paddingS + 4,
            ),
            child: Row(
              children: [
                Container(
                  width: AppDimensions.avatarS,
                  height: AppDimensions.avatarS,
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                SizedBox(width: AppDimensions.spacingS + 4),
                Expanded(
                  child: Text(
                    l10n.addNewProfile,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
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