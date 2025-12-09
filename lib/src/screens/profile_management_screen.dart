import 'package:flutter/material.dart';
import 'package:dmt_movie_flutter/src/core/app_assets.dart';

class ProfileManagementScreen extends StatelessWidget {
  const ProfileManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> profiles = [
      {'name': 'Người dùng', 'color': Colors.teal, 'image': AppImages.thu},
      {'name': 'Trẻ em', 'color': Colors.orange, 'image': AppImages.treen},
    ];

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Ai đang xem?',
          style: TextStyle(
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
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Danh sách profiles
                  ...profiles.map(
                    (profile) => _buildProfileItem(
                      context,
                      name: profile['name'],
                      color: profile['color'],
                      image: profile['image'],
                    ),
                  ),

                  // Nút thêm hồ sơ mới
                  _buildAddProfileButton(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem(
    BuildContext context, {
    required String name,
    required Color color,
    required String image,
  }) {
    final bool isKidsProfile = name.toLowerCase() == 'trẻ em';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            // Xử lý chọn profile
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                // Avatar - nhỏ hơn
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Tên profile
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

                // Text "Sửa hồ sơ" thay vì icon mũi tên
                if (!isKidsProfile)
                  const Text(
                    'Sửa hồ sơ',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                // Icon mũi tên
                const SizedBox(width: 8),
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

  Widget _buildAddProfileButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            // Xử lý thêm profile mới
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                // Icon add - nhỏ hơn
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 12),

                // Text thêm hồ sơ
                const Expanded(
                  child: Text(
                    'Thêm hồ sơ mới',
                    style: TextStyle(
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
