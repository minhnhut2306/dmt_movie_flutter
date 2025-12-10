import 'package:dmt_movie_flutter/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../../../core/app_assets.dart';
import '../../../../core/responsive.dart';
import '../../../../core/utils/extensions.dart';

class ProfileManagementScreen extends StatelessWidget {
  const ProfileManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final maxWidth = Responsive.maxContentWidth(context);
    
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
        toolbarHeight: Responsive.appBarHeight(context),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: Responsive.size24(context),
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          l10n.selectProfile,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: Responsive.headingFontSize(context),
            color: Colors.white,
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
        ),
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
    final avatarSize = Responsive.avatarSmall(context);

    return Container(
      margin: EdgeInsets.only(bottom: Responsive.spacingM(context)),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(Responsive.radiusM(context)),
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
                      color: Colors.white,
                      fontSize: Responsive.bodyFontSize(context),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                if (!isKidsProfile)
                  Text(
                    l10n.editProfile,
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: Responsive.captionFontSize(context),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                SizedBox(width: Responsive.spacingS(context)),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white54,
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
  final VoidCallback onTap;

  const _AddProfileButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final avatarSize = Responsive.avatarSmall(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(Responsive.radiusM(context)),
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
                    color: Colors.grey[700],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: Responsive.size24(context),
                  ),
                ),
                SizedBox(width: Responsive.spacingS(context) + 4),
                Expanded(
                  child: Text(
                    l10n.addNewProfile,
                    style: TextStyle(
                      color: Colors.white70,
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