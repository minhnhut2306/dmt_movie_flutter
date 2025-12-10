import 'package:flutter/material.dart';
import 'package:dmt_movie_flutter/gen_l10n/app_localizations.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/utils/validators.dart';
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

    return Scaffold(
      appBar: AppBar(title: Text(l10n.testScreen)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppDimensions.paddingM),
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
            AppDimensions.spacingM.heightBox,
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
            AppDimensions.spacingM.heightBox,
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
            AppDimensions.spacingM.heightBox,
            CustomTextField(
              controller: TextEditingController(),
              hintText: l10n.phoneHint,
              prefixIcon: Icons.phone_outlined,
              validator: (value) => l10n.phoneInvalid,
            ),
            AppDimensions.spacingXL.heightBox,
            PrimaryButton(
              title: l10n.register,
              onPressed: () {
                context.showSuccessSnackBar(l10n.registerSuccess);
              },
            ),
            AppDimensions.spacingM.heightBox,
            OutlineButton(
              title: l10n.cancel,
              onPressed: () => context.pop(),
            ),
          ],
        ),
      ),
    );
  }
}
