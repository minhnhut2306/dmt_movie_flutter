import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dmt_movie_flutter/gen_l10n/app_localizations.dart';
import '../../../../core/responsive.dart';
import '../../../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final settings = context.watch<SettingsProvider>();
    final maxWidth = Responsive.maxContentWidth(context);

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
                  onChanged:
                      (m) => settings.setThemeMode(m ?? ThemeMode.system),
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
    return Container(
      padding: Responsive.cardPadding(context),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Responsive.radiusM(context)),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: Responsive.bodyFontSize(context),
              fontWeight: FontWeight.w500,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
