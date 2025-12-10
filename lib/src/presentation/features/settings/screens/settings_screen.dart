import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dmt_movie_flutter/gen_l10n/app_localizations.dart';
import '../../../../core/responsive.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/app_colors.dart';
import '../../../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _showLogoutDialog(BuildContext context, AppLocalizations l10n) {
    final isDark = context.isDarkMode;
    
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          'Đăng xuất',
          style: TextStyle(
            fontSize: Responsive.headingFontSize(context),
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'Bạn có chắc chắn muốn đăng xuất?',
          style: TextStyle(
            fontSize: Responsive.bodyFontSize(context),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              l10n.cancel,
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
              'Đăng xuất',
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
    final l10n = AppLocalizations.of(context)!;
    final settings = context.watch<SettingsProvider>();
    final maxWidth = Responsive.maxContentWidth(context);
    final isDark = context.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.settingsTitle,
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
                                  l10n.selectProfile,
                                  style: TextStyle(
                                    fontSize: Responsive.bodyFontSize(context),
                                    fontWeight: FontWeight.w600,
                                    color: isDark ? Colors.white : AppColors.textPrimary,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Quản lý profile của bạn',
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
                title: l10n.language,
                child: DropdownButton<String>(
                  value: settings.locale?.languageCode ?? '',
                  hint: Text(
                    l10n.languageSystem,
                    style: TextStyle(
                      fontSize: Responsive.bodyFontSize(context),
                    ),
                  ),
                  items: [
                    DropdownMenuItem(
                      value: 'en',
                      child: Text(
                        l10n.languageEnglish,
                        style: TextStyle(
                          fontSize: Responsive.bodyFontSize(context),
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'vi',
                      child: Text(
                        l10n.languageVietnamese,
                        style: TextStyle(
                          fontSize: Responsive.bodyFontSize(context),
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: '',
                      child: Text(
                        l10n.languageSystem,
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
                title: l10n.theme,
                child: DropdownButton<ThemeMode>(
                  value: settings.themeMode,
                  items: [
                    DropdownMenuItem(
                      value: ThemeMode.system,
                      child: Text(
                        l10n.themeSystem,
                        style: TextStyle(
                          fontSize: Responsive.bodyFontSize(context),
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Text(
                        l10n.themeLight,
                        style: TextStyle(
                          fontSize: Responsive.bodyFontSize(context),
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Text(
                        l10n.themeDark,
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
                    onTap: () => _showLogoutDialog(context, l10n),
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
                            'Đăng xuất',
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