import 'package:dmt_movie_flutter/src/presentation/features/auth/widgets/auth_background.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/app_colors.dart';
import '../../../common/inputs/custom_text_field.dart';
import '../../../common/buttons/primary_button.dart';
import '../widgets/auth_card.dart';

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
      context.showSuccessSnackBar('otpVerified'.tr());
    }
  }

  void _handleResendOtp() {
    context.showSnackBar('otpResent'.tr());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    
    return Scaffold(
      backgroundColor: isDark ? Colors.black : const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        child: SizedBox(
          height: context.screenHeight,
          child: Column(
            children: [
              const AuthBackground(),
              Expanded(
                child: Container(
                  color: isDark ? Colors.black : const Color(0xFFF8F9FA),
                  child: Transform.translate(
                    offset: const Offset(0, -150),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingL,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildHeader(isDark),
                          AppDimensions.spacingXL.heightBox,
                          _buildOtpForm(isDark),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              _buildBackButton(isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return Column(
      children: [
        Text(
          'otpTitle'.tr(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isDark ? Colors.white : const Color(0xFF1A1A1A),
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            shadows: isDark ? [
              const Shadow(color: Colors.black87, blurRadius: 20),
            ] : [
              Shadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
        AppDimensions.spacingS.heightBox,
        Text(
          widget.email != null
              ? 'otpSubtitle'.tr(args: [widget.email!])
              : 'otpSubtitle'.tr(args: ['email của bạn']),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isDark 
              ? Colors.white.withOpacity(0.8)
              : const Color(0xFF666666),
            fontSize: 15,
            shadows: isDark ? [
              const Shadow(color: Colors.black87, blurRadius: 15),
            ] : [],
          ),
        ),
      ],
    );
  }

  Widget _buildOtpForm(bool isDark) {
    return AuthCard(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'otpCode'.tr(),
              style: TextStyle(
                color: isDark ? Colors.white : const Color(0xFF1A1A1A),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            AppDimensions.spacingS.heightBox,
            CustomTextField(
              controller: _otpController,
              hintText: 'otpHint'.tr(),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'otpRequired'.tr();
                }
                if (value.length != AppConstants.otpLength) {
                  return 'otpInvalid'.tr(args: [AppConstants.otpLength.toString()]);
                }
                return null;
              },
              maxLength: AppConstants.otpLength,
            ),
            TextButton(
              onPressed: _handleResendOtp,
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  vertical: AppDimensions.spacingS,
                ),
              ),
              child: Text(
                'resendOtp'.tr(),
                style: TextStyle(
                  color: isDark ? Colors.blue.shade300 : AppColors.primary,
                  decoration: TextDecoration.underline,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            AppDimensions.spacingL.heightBox,
            PrimaryButton(
              title: 'continueLabel'.tr(),
              onPressed: _handleSubmit,
              isLoading: _isLoading,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton(bool isDark) {
    return GestureDetector(
      onTap: () => context.pop(),
      child: Container(
        color: isDark ? Colors.black : const Color(0xFFF8F9FA),
        padding: EdgeInsets.fromLTRB(
          AppDimensions.paddingL,
          0,
          AppDimensions.paddingL,
          AppDimensions.paddingL,
        ),
        child: Text(
          'backToLogin'.tr(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isDark 
              ? Colors.white.withOpacity(0.8)
              : const Color(0xFF666666),
            fontSize: 13,
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}