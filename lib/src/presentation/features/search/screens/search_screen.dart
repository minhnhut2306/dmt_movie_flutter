import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/responsive.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final maxWidth = Responsive.maxContentWidth(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'searchTitle'.tr(),
          style: TextStyle(
            fontSize: Responsive.headingFontSize(context),
          ),
        ),
        toolbarHeight: Responsive.appBarHeight(context),
      ),
      body: Center(
        child: Container(
          width: maxWidth == double.infinity ? double.infinity : maxWidth,
          child: Center(
            child: Text(
              'searchContent'.tr(),
              style: TextStyle(
                fontSize: Responsive.bodyFontSize(context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}