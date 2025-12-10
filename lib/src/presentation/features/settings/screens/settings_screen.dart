import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dmt_movie_flutter/gen_l10n/app_localizations.dart';
import '../../../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final settings = context.watch<SettingsProvider>();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        children: [
          ListTile(
            title: Text(l10n.language),
            trailing: DropdownButton<String>(
              value: settings.locale?.languageCode ?? '',
              hint: Text(l10n.languageSystem),
              items: [
                DropdownMenuItem(value: 'en', child: Text(l10n.languageEnglish)),
                DropdownMenuItem(value: 'vi', child: Text(l10n.languageVietnamese)),
                DropdownMenuItem(value: '', child: Text(l10n.languageSystem)),
              ],
              onChanged: (v) => settings.setLocaleCode(v == '' ? null : v),
            ),
          ),
          ListTile(
            title: Text(l10n.theme),
            trailing: DropdownButton<ThemeMode>(
              value: settings.themeMode,
              items: [
                DropdownMenuItem(value: ThemeMode.system, child: Text(l10n.themeSystem)),
                DropdownMenuItem(value: ThemeMode.light, child: Text(l10n.themeLight)),
                DropdownMenuItem(value: ThemeMode.dark, child: Text(l10n.themeDark)),
              ],
              onChanged: (m) => settings.setThemeMode(m ?? ThemeMode.system),
            ),
          ),
        ],
      ),
    );
  }
}