import 'package:flutter/material.dart';
import 'package:dmt_movie_flutter/gen_l10n/app_localizations.dart';
import '../../../../core/app_assets.dart';
import '../../../../core/app_text_styles.dart';
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
    final l10n = AppLocalizations.of(context)!;
    _profiles = [
      {'name': l10n.user, 'color': Colors.teal, 'image': AppImages.thu},
      {'name': l10n.kids, 'color': Colors.orange, 'image': AppImages.treen},
    ];
  }

  void _handleProfileTap(int index) {
    final l10n = AppLocalizations.of(context)!;
    context.showSnackBar(l10n.profileSelected(_profiles[index]['name']));
    context.pushReplacementNamed(RouteNames.main);
  }

  void _handleAddProfile() {
    final l10n = AppLocalizations.of(context)!;
    if (_profiles.length >= AppConstants.maxProfiles) {
      context.showErrorSnackBar(
        l10n.maxProfilesReached(AppConstants.maxProfiles),
      );
      return;
    }
    context.showSnackBar(l10n.addNewProfile);
  }

  void _handleManageProfiles() {
    context.pushNamed(RouteNames.profileManagement);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final maxWidth = Responsive.maxContentWidth(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        toolbarHeight: Responsive.appBarHeight(context),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: Responsive.size24(context),
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          l10n.selectProfile,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: Responsive.headingFontSize(context),
            color: Colors.black,
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
                      child: _buildProfileGrid(l10n),
                    ),
                  ),
                ),
              ),
              _buildManageButton(l10n),
              SizedBox(height: Responsive.spacingM(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileGrid(AppLocalizations l10n) {
    final showAddButton = _profiles.length < AppConstants.maxProfiles;
    final totalItems = showAddButton ? _profiles.length + 1 : _profiles.length;
    final totalRows = (totalItems / 2).ceil();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalRows, (rowIndex) {
        return _buildRow(rowIndex, showAddButton, l10n);
      }),
    );
  }

  Widget _buildRow(int rowIndex, bool showAddButton, AppLocalizations l10n) {
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
      itemsInRow.add(_buildAddButton(l10n));
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
      itemsInRow.add(_buildAddButton(l10n));
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

  Widget _buildAddButton(AppLocalizations l10n) {
    final avatarSize = Responsive.avatarLarge(context);
    
    return GestureDetector(
      onTap: _handleAddProfile,
      child: Column(
        children: [
          Container(
            width: avatarSize,
            height: avatarSize,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.add,
              color: Colors.black,
              size: Responsive.size40(context),
            ),
          ),
          SizedBox(height: Responsive.spacingS(context)),
          Text(
            l10n.addProfile,
            style: TextStyle(
              color: Colors.black,
              fontSize: Responsive.bodyFontSize(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildManageButton(AppLocalizations l10n) {
    return Padding(
      padding: Responsive.horizontalPadding(context).add(
        Responsive.verticalPadding(context),
      ),
      child: OutlineButton(
        title: l10n.manageProfiles,
        icon: Icons.manage_accounts,
        onPressed: _handleManageProfiles,
        borderColor: Colors.grey[300],
        textColor: Colors.black,
        width: double.infinity,
        height: Responsive.buttonHeight(context),
      ),
    );
  }
}