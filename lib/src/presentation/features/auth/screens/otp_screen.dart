import 'package:flutter/material.dart';
import 'package:dmt_movie_flutter/gen_l10n/app_localizations.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/responsive.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/extensions.dart';
import '../../../common/inputs/custom_text_field.dart';
import '../../../common/buttons/primary_button.dart';
import '../widgets/auth_widgets.dart';

class OtpScreen extends StatefulWidget {
  final String? email;

  const OtpScreen({super.key, this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);

    if (mounted) {
      final l10n = AppLocalizations.of(context)!;
      context.showSuccessSnackBar(l10n.otpVerified);
    }
  }

  void _handleResendOtp() {
    final l10n = AppLocalizations.of(context)!;
    context.showSnackBar(l10n.otpResent);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? AppColors.authBackgroundDark : AppColors.authBackgroundLight,
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
                      AuthBackground(isDark: isDark),
                      Expanded(
                        child: Container(
                          color: isDark ? AppColors.authBackgroundDark : AppColors.authBackgroundLight,
                          child: Transform.translate(
                            offset: Offset(0, Responsive.authHeaderOffset(context)),
                            child: Padding(
                              padding: Responsive.horizontalPadding(context),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  _buildHeader(l10n, isDark),
                                  SizedBox(height: Responsive.spacingXL(context)),
                                  _buildOtpForm(l10n, isDark),
                                  const Spacer(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      _buildBackButton(l10n, isDark),
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
          l10n.otpTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isDark ? Colors.white : AppColors.textPrimary,
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
          widget.email != null
              ? l10n.otpSubtitle(widget.email!)
              : l10n.otpSubtitle('email của bạn'),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isDark 
              ? Colors.white.withOpacity(0.8)
              : AppColors.textSecondary,
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

  Widget _buildOtpForm(AppLocalizations l10n, bool isDark) {
    return AuthCard(
      isDark: isDark,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.otpCode,
              style: TextStyle(
                color: isDark ? Colors.white : AppColors.textPrimary,
                fontSize: Responsive.bodyFontSize(context),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: Responsive.spacingS(context)),
            CustomTextField(
              controller: _otpController,
              hintText: l10n.otpHint,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.otpRequired;
                }
                if (value.length != AppConstants.otpLength) {
                  return l10n.otpInvalid(AppConstants.otpLength);
                }
                return null;
              },
              maxLength: AppConstants.otpLength,
            ),
            TextButton(
              onPressed: _handleResendOtp,
              child: Text(
                l10n.resendOtp,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: Responsive.bodyFontSize(context),
                  decoration: TextDecoration.underline,
                ),
              ),
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

  Widget _buildBackButton(AppLocalizations l10n, bool isDark) {
    return GestureDetector(
      onTap: () => context.pop(),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          Responsive.spacingL(context),
          0,
          Responsive.spacingL(context),
          Responsive.spacingL(context),
        ),
        child: Text(
          l10n.backToLogin,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isDark 
              ? Colors.white.withOpacity(0.8)
              : AppColors.textSecondary,
            fontSize: Responsive.captionFontSize(context),
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}