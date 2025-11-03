import 'package:dmt_movie_flutter/src/core/app_assets.dart';
import 'package:dmt_movie_flutter/src/widgets/custom_component/custom_profile_card.dart';
import 'package:dmt_movie_flutter/src/widgets/custom_component/custom_button.dart';
import 'package:flutter/material.dart';

class SelectProfileScreen extends StatefulWidget {
  const SelectProfileScreen({super.key});

  @override
  State<SelectProfileScreen> createState() => _SelectProfileScreenState();
}

class _SelectProfileScreenState extends State<SelectProfileScreen> {
  static const int maxProfiles = 6;

  List<Map<String, dynamic>> profiles = [
    {'name': 'Người dùng', 'color': Colors.teal, 'image': AppImages.thu},
    {'name': 'Trẻ em', 'color': Colors.orange, 'image': AppImages.treen},
  ];

  Widget _buildAddButton() {
    return Column(
      children: [
        InkWell(
          onTap: () {
            // Xử lý ở nơi khác
          },
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.add, color: Colors.black, size: 40),
          ),
        ),
        SizedBox(height: 12),
        Text('Thêm', style: TextStyle(color: Colors.black, fontSize: 16)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final showAddButton = profiles.length < maxProfiles;
    final totalItems = showAddButton ? profiles.length + 1 : profiles.length;
    final totalRows = (totalItems / 2).ceil();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Ai đang xem?',
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(totalRows, (rowIndex) {
                      final startIndex = rowIndex * 2;
                      final itemsInRow = <Widget>[];

                      if (startIndex < profiles.length) {
                        itemsInRow.add(
                          CustomProfileCard(
                            name: profiles[startIndex]['name'] as String,
                            color: profiles[startIndex]['color'] as Color,
                            imageUrl: profiles[startIndex]['image'] as String,
                            onTap: () {
                              print('Nhấn vào ${profiles[startIndex]['name']}');
                            },
                          ),
                        );
                      } else if (showAddButton) {
                        itemsInRow.add(_buildAddButton());
                      }

                      final secondIndex = startIndex + 1;
                      if (secondIndex < profiles.length) {
                        itemsInRow.add(
                          CustomProfileCard(
                            name: profiles[secondIndex]['name'] as String,
                            color: profiles[secondIndex]['color'] as Color,
                            imageUrl: profiles[secondIndex]['image'] as String,
                            onTap: () {
                              print(
                                'Nhấn vào ${profiles[secondIndex]['name']}',
                              );
                            },
                          ),
                        );
                      } else if (secondIndex == profiles.length &&
                          showAddButton) {
                        itemsInRow.add(_buildAddButton());
                      }
                      if (itemsInRow.isEmpty) {
                        return SizedBox.shrink();
                      }
                      final isSingleItem = itemsInRow.length == 1;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (isSingleItem)
                              itemsInRow[0]
                            else ...[
                              itemsInRow[0],
                              SizedBox(width: 40),
                              itemsInRow[1],
                            ],
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: CustomButton(
              title: 'Quản lý hồ sơ',
              icon: Icons.manage_accounts,
              backgroundColor: Colors.grey[300],
              textColor: Colors.black,
              isSmall: true, 
              onPress: () {
                print('Quản lý hồ sơ');
              },
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}