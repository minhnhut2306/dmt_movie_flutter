import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/app_assets.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/responsive.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/utils/extensions.dart';
import '../../../common/cards/profile_card.dart';
import '../../../common/buttons/outline_button.dart';

class SelectProfileScreen extends StatefulWidget {
  const SelectProfileScreen({super.key});

  @override
  State<SelectProfileScreen> createState() => _SelectProfileScreenState();
}

class _SelectProfileScreenState extends State<SelectProfileScreen> {
  List<Map<String, dynamic>> _profiles = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _profiles = [
      {'name': 'user'.tr(), 'color': Colors.teal, 'image': AppImages.thu},
      {'name': 'kids'.tr(), 'color': Colors.orange, 'image': AppImages.treen},
    ];
  }

  void _handleProfileTap(int index) {
    context.showSnackBar('profileSelected'.tr(args: [_profiles[index]['name']]));
    context.pushReplacementNamed(RouteNames.main);
  }

  void _handleAddProfile() {
    if (_profiles.length >= AppConstants.maxProfiles) {
      context.showErrorSnackBar(
        'maxProfilesReached'.tr(args: [AppConstants.maxProfiles.toString()]),
      );
      return;
    }
    context.showSnackBar('addNewProfile'.tr());
  }

  void _handleManageProfiles() {
    context.pushNamed(RouteNames.profileManagement);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final maxWidth = Responsive.maxContentWidth(context);

    return Scaffold(
      backgroundColor: isDark ? AppColors.profileBackgroundDark : AppColors.profileBackgroundLight,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: isDark ? AppColors.darkBackgroundLight : AppColors.backgroundLight,
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
          'selectProfile'.tr(),
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
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: Responsive.horizontalPadding(context),
                      child: _buildProfileGrid(isDark),
                    ),
                  ),
                ),
              ),
              _buildManageButton(isDark),
              SizedBox(height: Responsive.spacingM(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileGrid(bool isDark) {
    final showAddButton = _profiles.length < AppConstants.maxProfiles;
    final totalItems = showAddButton ? _profiles.length + 1 : _profiles.length;
    final totalRows = (totalItems / 2).ceil();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalRows, (rowIndex) {
        return _buildRow(rowIndex, showAddButton, isDark);
      }),
    );
  }

  Widget _buildRow(int rowIndex, bool showAddButton, bool isDark) {
    final startIndex = rowIndex * 2;
    final itemsInRow = <Widget>[];

    if (startIndex < _profiles.length) {
      itemsInRow.add(
        ProfileCard(
          name: _profiles[startIndex]['name'] as String,
          borderColor: _profiles[startIndex]['color'] as Color,
          imageUrl: _profiles[startIndex]['image'] as String,
          onTap: () => _handleProfileTap(startIndex),
        ),
      );
    } else if (showAddButton) {
      itemsInRow.add(_buildAddButton(isDark));
    }

    final secondIndex = startIndex + 1;
    if (secondIndex < _profiles.length) {
      itemsInRow.add(
        ProfileCard(
          name: _profiles[secondIndex]['name'] as String,
          borderColor: _profiles[secondIndex]['color'] as Color,
          imageUrl: _profiles[secondIndex]['image'] as String,
          onTap: () => _handleProfileTap(secondIndex),
        ),
      );
    } else if (secondIndex == _profiles.length && showAddButton) {
      itemsInRow.add(_buildAddButton(isDark));
    }

    if (itemsInRow.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(bottom: Responsive.profileRowSpacing(context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (itemsInRow.length == 1)
            itemsInRow[0]
          else ...[
            itemsInRow[0],
            SizedBox(width: Responsive.profileGridSpacing(context)),
            itemsInRow[1],
          ],
        ],
      ),
    );
  }

  Widget _buildAddButton(bool isDark) {
    final avatarSize = Responsive.avatarLarge(context);
    
    return GestureDetector(
      onTap: _handleAddProfile,
      child: Column(
        children: [
          Container(
            width: avatarSize,
            height: avatarSize,
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurfaceVariant : AppColors.surfaceVariant,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.add,
              color: isDark ? Colors.white70 : AppColors.textSecondary,
              size: Responsive.size40(context),
            ),
          ),
          SizedBox(height: Responsive.spacingS(context)),
          Text(
            'addProfile'.tr(),
            style: TextStyle(
              color: isDark ? Colors.white70 : AppColors.textPrimary,
              fontSize: Responsive.bodyFontSize(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildManageButton(bool isDark) {
    return Padding(
      padding: Responsive.horizontalPadding(context).add(
        Responsive.verticalPadding(context),
      ),
      child: OutlineButton(
        title: 'manageProfiles'.tr(),
        icon: Icons.manage_accounts,
        onPressed: _handleManageProfiles,
        borderColor: isDark ? AppColors.darkBorder : AppColors.border,
        textColor: isDark ? Colors.white : AppColors.textPrimary,
        width: double.infinity,
        height: Responsive.buttonHeight(context),
      ),
    );
  }
}