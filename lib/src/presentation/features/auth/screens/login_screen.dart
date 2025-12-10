import 'package:flutter/material.dart';
import 'package:dmt_movie_flutter/gen_l10n/app_localizations.dart';
import '../../../../core/responsive.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/utils/extensions.dart';
import '../../../common/inputs/custom_text_field.dart';
import '../../../common/buttons/primary_button.dart';
import '../widgets/auth_widgets.dart';

class LoginRegisterScreen extends StatefulWidget {
  const LoginRegisterScreen({super.key});

  @override
  State<LoginRegisterScreen> createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isChecked = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);

    if (mounted) {
      context.pushNamed(RouteNames.otp, arguments: _emailController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = Responsive.maxContentWidth(context);

          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(
                child: Container(
                  width: maxWidth == double.infinity ? double.infinity : maxWidth,
                  child: Column(
                    children: [
                      const AuthBackground(),
                      Expanded(
                        child: Container(
                          color: isDark ? Colors.black : Colors.white,
                          child: Transform.translate(
                            offset: Offset(0, Responsive.authHeaderOffset(context)),
                            child: Padding(
                              padding: Responsive.horizontalPadding(context),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  _buildHeader(l10n, isDark),
                                  SizedBox(height: Responsive.spacingXL(context)),
                                  _buildLoginForm(l10n, isDark),
                                  const Spacer(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      _buildTermsCheckbox(l10n, isDark),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n, bool isDark) {
    return Column(
      children: [
        Text(
          l10n.loginTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontSize: Responsive.titleFontSize(context),
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            height: Responsive.lineHeight12(context),
            shadows: isDark ? [
              Shadow(
                color: Colors.black87,
                blurRadius: Responsive.shadowBlur(context),
              ),
            ] : [],
          ),
        ),
        SizedBox(height: Responsive.spacingS(context)),
        Text(
          l10n.loginSubtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isDark 
              ? Colors.white.withOpacity(0.8)
              : Colors.black87.withOpacity(0.7),
            fontSize: Responsive.bodyFontSize(context),
            height: Responsive.lineHeight14(context),
            shadows: isDark ? [
              Shadow(
                color: Colors.black87,
                blurRadius: Responsive.textBlur(context),
              ),
            ] : [],
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm(AppLocalizations l10n, bool isDark) {
    return AuthCard(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.email,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: Responsive.bodyFontSize(context),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: Responsive.spacingS(context)),
            CustomTextField(
              controller: _emailController,
              hintText: l10n.emailHint,
              keyboardType: TextInputType.emailAddress,
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
            SizedBox(height: Responsive.spacingL(context)),
            PrimaryButton(
              title: l10n.continueLabel,
              onPressed: _handleSubmit,
              isLoading: _isLoading,
              height: Responsive.buttonHeight(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTermsCheckbox(AppLocalizations l10n, bool isDark) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        Responsive.spacingL(context),
        0,
        Responsive.spacingL(context),
        Responsive.spacingL(context),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform.scale(
            scale: Responsive.isMobile(context) ? 0.9 : 1.0,
            child: Checkbox(
              value: _isChecked,
              onChanged: (v) => setState(() => _isChecked = v!),
              activeColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Responsive.radiusXS(context)),
              ),
            ),
          ),
          SizedBox(width: Responsive.spacingXS(context)),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: Responsive.spacingS(context) + 4),
              child: Text.rich(
                TextSpan(
                  text: l10n.termsAccept,
                  style: TextStyle(
                    color: isDark 
                      ? Colors.white.withOpacity(0.8)
                      : Colors.black87.withOpacity(0.7),
                    fontSize: Responsive.captionFontSize(context),
                    height: Responsive.lineHeight14(context),
                  ),
                  children: [
                    TextSpan(
                      text: l10n.termsText,
                      style: const TextStyle(
                        color: Colors.orange,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}