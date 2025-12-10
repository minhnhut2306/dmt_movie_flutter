import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
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
    final maxWidth = Responsive.maxContentWidth(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'testScreen'.tr(),
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
                  hintText: 'nameHint'.tr(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'nameRequired'.tr();
                    }
                    if (value.length < 2) {
                      return 'nameMinLength'.tr(args: ['2']);
                    }
                    if (value.length > 50) {
                      return 'nameMaxLength'.tr(args: ['50']);
                    }
                    return null;
                  },
                ),
                SizedBox(height: Responsive.spacingM(context)),
                CustomTextField(
                  controller: _emailController,
                  hintText: 'emailHint'.tr(),
                  prefixIcon: Icons.email_outlined,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'emailRequired'.tr();
                    }
                    if (!value.isValidEmail) {
                      return 'emailInvalid'.tr();
                    }
                    return null;
                  },
                ),
                SizedBox(height: Responsive.spacingM(context)),
                CustomTextField(
                  controller: _passwordController,
                  hintText: 'passwordHint'.tr(),
                  prefixIcon: Icons.lock_outlined,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'passwordRequired'.tr();
                    }
                    if (value.length < 6) {
                      return 'passwordMinLength'.tr(args: ['6']);
                    }
                    return null;
                  },
                ),
                SizedBox(height: Responsive.spacingM(context)),
                CustomTextField(
                  controller: TextEditingController(),
                  hintText: 'phoneHint'.tr(),
                  prefixIcon: Icons.phone_outlined,
                  validator: (value) => 'phoneInvalid'.tr(),
                ),
                SizedBox(height: Responsive.spacingXL(context)),
                PrimaryButton(
                  title: 'register'.tr(),
                  onPressed: () {
                    context.showSuccessSnackBar('registerSuccess'.tr());
                  },
                  height: Responsive.buttonHeight(context),
                ),
                SizedBox(height: Responsive.spacingM(context)),
                OutlineButton(
                  title: 'cancel'.tr(),
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