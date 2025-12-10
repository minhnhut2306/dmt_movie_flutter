import 'package:flutter/material.dart';
import '../../../../core/app_assets.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_dimensions.dart';
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
  final List<Map<String, dynamic>> _profiles = [
    {'name': 'Người dùng', 'color': Colors.teal, 'image': AppImages.thu},
    {'name': 'Trẻ em', 'color': Colors.orange, 'image': AppImages.treen},
  ];

  void _handleProfileTap(int index) {
    context.showSnackBar('Đã chọn ${_profiles[index]['name']}');
    context.pushReplacementNamed(RouteNames.main);
  }

  void _handleAddProfile() {
    if (_profiles.length >= AppConstants.maxProfiles) {
      context.showErrorSnackBar('Đã đạt giới hạn ${AppConstants.maxProfiles} hồ sơ');
      return;
    }
    context.showSnackBar('Thêm hồ sơ mới');
  }

  void _handleManageProfiles() {
    context.pushNamed(RouteNames.profileManagement);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Ai đang xem?',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingXL,
                  ),
                  child: _buildProfileGrid(),
                ),
              ),
            ),
          ),
          _buildManageButton(),
          SizedBox(height: AppDimensions.spacingM),
        ],
      ),
    );
  }

  Widget _buildProfileGrid() {
    final showAddButton = _profiles.length < AppConstants.maxProfiles;
    final totalItems = showAddButton ? _profiles.length + 1 : _profiles.length;
    final totalRows = (totalItems / 2).ceil();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalRows, (rowIndex) {
        return _buildRow(rowIndex, showAddButton);
      }),
    );
  }

  Widget _buildRow(int rowIndex, bool showAddButton) {
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
      itemsInRow.add(_buildAddButton());
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
      itemsInRow.add(_buildAddButton());
    }

    if (itemsInRow.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(bottom: AppDimensions.spacing2XL - 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (itemsInRow.length == 1)
            itemsInRow[0]
          else ...[
            itemsInRow[0],
            SizedBox(width: AppDimensions.spacing2XL),
            itemsInRow[1],
          ],
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: _handleAddProfile,
      child: Column(
        children: [
          Container(
            width: AppDimensions.avatarL,
            height: AppDimensions.avatarL,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.add,
              color: Colors.black,
              size: 40,
            ),
          ),
          SizedBox(height: AppDimensions.spacingS),
          const Text(
            'Thêm',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildManageButton() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingXL,
        vertical: AppDimensions.paddingXL,
      ),
      child: OutlineButton(
        title: 'Quản lý hồ sơ',
        icon: Icons.manage_accounts,
        onPressed: _handleManageProfiles,
        borderColor: Colors.grey[300],
        textColor: Colors.black,
        width: double.infinity,
      ),
    );
  }
}