import 'package:flutter/material.dart';
import 'package:dmt_movie_flutter/gen_l10n/app_localizations.dart';
import '../../../core/responsive.dart';
import '../../../core/utils/extensions.dart';
import '../../common/inputs/custom_text_field.dart';
import '../../common/buttons/primary_button.dart';
import '../../common/buttons/outline_button.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final maxWidth = Responsive.maxContentWidth(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.testScreen,
          style: TextStyle(
            fontSize: Responsive.headingFontSize(context),
          ),
        ),
        toolbarHeight: Responsive.appBarHeight(context),
      ),
      body: Center(
        child: Container(
          width: maxWidth == double.infinity ? double.infinity : maxWidth,
          child: SingleChildScrollView(
            padding: Responsive.pagePadding(context),
            child: Column(
              children: [
                CustomTextField(
                  controller: _nameController,
                  hintText: l10n.nameHint,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return l10n.nameRequired;
                    }
                    if (value.length < 2) {
                      return l10n.nameMinLength(2);
                    }
                    if (value.length > 50) {
                      return l10n.nameMaxLength(50);
                    }
                    return null;
                  },
                ),
                SizedBox(height: Responsive.spacingM(context)),
                CustomTextField(
                  controller: _emailController,
                  hintText: l10n.emailHint,
                  prefixIcon: Icons.email_outlined,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return l10n.emailRequired;
                    }
                    if (!value.isValidEmail) {
                      return l10n.emailInvalid;
                    }
                    return null;
                  },
                ),
                SizedBox(height: Responsive.spacingM(context)),
                CustomTextField(
                  controller: _passwordController,
                  hintText: l10n.passwordHint,
                  prefixIcon: Icons.lock_outlined,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return l10n.passwordRequired;
                    }
                    if (value.length < 6) {
                      return l10n.passwordMinLength(6);
                    }
                    return null;
                  },
                ),
                SizedBox(height: Responsive.spacingM(context)),
                CustomTextField(
                  controller: TextEditingController(),
                  hintText: l10n.phoneHint,
                  prefixIcon: Icons.phone_outlined,
                  validator: (value) => l10n.phoneInvalid,
                ),
                SizedBox(height: Responsive.spacingXL(context)),
                PrimaryButton(
                  title: l10n.register,
                  onPressed: () {
                    context.showSuccessSnackBar(l10n.registerSuccess);
                  },
                  height: Responsive.buttonHeight(context),
                ),
                SizedBox(height: Responsive.spacingM(context)),
                OutlineButton(
                  title: l10n.cancel,
                  onPressed: () => context.pop(),
                  height: Responsive.buttonHeight(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}