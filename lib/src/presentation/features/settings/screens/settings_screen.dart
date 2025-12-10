import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/responsive.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/app_colors.dart';
import '../../../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _showLogoutDialog(BuildContext context) {    
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          'logout'.tr(),
          style: TextStyle(
            fontSize: Responsive.headingFontSize(context),
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'confirmLogout'.tr(),
          style: TextStyle(
            fontSize: Responsive.bodyFontSize(context),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              'cancel'.tr(),
              style: TextStyle(
                fontSize: Responsive.bodyFontSize(context),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.pushNamedAndRemoveUntil(RouteNames.login);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: Text(
              'logout'.tr(),
              style: TextStyle(
                fontSize: Responsive.bodyFontSize(context),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final maxWidth = Responsive.maxContentWidth(context);
    final isDark = context.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'settingsTitle'.tr(),
          style: TextStyle(fontSize: Responsive.headingFontSize(context)),
        ),
        toolbarHeight: Responsive.appBarHeight(context),
      ),
      body: Center(
        child: Container(
          width: maxWidth == double.infinity ? double.infinity : maxWidth,
          child: ListView(
            padding: Responsive.pagePadding(context),
            children: [
              // Nút xem profile
              Container(
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
                    onTap: () => context.pushNamed(RouteNames.selectProfile),
                    child: Padding(
                      padding: Responsive.cardPadding(context),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(Responsive.spacingS(context)),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(Responsive.radiusS(context)),
                            ),
                            child: Icon(
                              Icons.person_outline,
                              color: AppColors.primary,
                              size: Responsive.size24(context),
                            ),
                          ),
                          SizedBox(width: Responsive.spacingM(context)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'selectProfile'.tr(),
                                  style: TextStyle(
                                    fontSize: Responsive.bodyFontSize(context),
                                    fontWeight: FontWeight.w600,
                                    color: isDark ? Colors.white : AppColors.textPrimary,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'manageProfile'.tr(),
                                  style: TextStyle(
                                    fontSize: Responsive.captionFontSize(context),
                                    color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                            size: Responsive.size16(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: Responsive.spacingM(context)),
              
              _SettingsTile(
                title: 'language'.tr(),
                child: DropdownButton<String>(
                  value: settings.locale?.languageCode ?? '',
                  hint: Text(
                    'languageSystem'.tr(),
                    style: TextStyle(
                      fontSize: Responsive.bodyFontSize(context),
                    ),
                  ),
                  items: [
                    DropdownMenuItem(
                      value: 'en',
                      child: Text(
                        'languageEnglish'.tr(),
                        style: TextStyle(
                          fontSize: Responsive.bodyFontSize(context),
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'vi',
                      child: Text(
                        'languageVietnamese'.tr(),
                        style: TextStyle(
                          fontSize: Responsive.bodyFontSize(context),
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: '',
                      child: Text(
                        'languageSystem'.tr(),
                        style: TextStyle(
                          fontSize: Responsive.bodyFontSize(context),
                        ),
                      ),
                    ),
                  ],
                  onChanged: (v) => settings.setLocaleCode(v == '' ? null : v),
                ),
              ),
              SizedBox(height: Responsive.spacingS(context)),
              _SettingsTile(
                title: 'theme'.tr(),
                child: DropdownButton<ThemeMode>(
                  value: settings.themeMode,
                  items: [
                    DropdownMenuItem(
                      value: ThemeMode.system,
                      child: Text(
                        'themeSystem'.tr(),
                        style: TextStyle(
                          fontSize: Responsive.bodyFontSize(context),
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Text(
                        'themeLight'.tr(),
                        style: TextStyle(
                          fontSize: Responsive.bodyFontSize(context),
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Text(
                        'themeDark'.tr(),
                        style: TextStyle(
                          fontSize: Responsive.bodyFontSize(context),
                        ),
                      ),
                    ),
                  ],
                  onChanged: (m) => settings.setThemeMode(m ?? ThemeMode.system),
                ),
              ),
              
              SizedBox(height: Responsive.spacingXL(context)),
              
              // Nút đăng xuất
              Container(
                decoration: BoxDecoration(
                  color: isDark ? AppColors.cardDark : AppColors.cardLight,
                  borderRadius: BorderRadius.circular(Responsive.radiusM(context)),
                  border: Border.all(
                    color: AppColors.error.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(Responsive.radiusM(context)),
                    onTap: () => _showLogoutDialog(context),
                    child: Padding(
                      padding: Responsive.cardPadding(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.logout,
                            color: AppColors.error,
                            size: Responsive.size20(context),
                          ),
                          SizedBox(width: Responsive.spacingS(context)),
                          Text(
                            'logout'.tr(),
                            style: TextStyle(
                              fontSize: Responsive.bodyFontSize(context),
                              fontWeight: FontWeight.w600,
                              color: AppColors.error,
                            ),
                          ),
                        ],
                      ),
                    ),
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

class _SettingsTile extends StatelessWidget {
  final String title;
  final Widget child;

  const _SettingsTile({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: Responsive.cardPadding(context),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: Responsive.bodyFontSize(context),
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white : AppColors.textPrimary,
            ),
          ),
          child,
        ],
      ),
    );
  }
}