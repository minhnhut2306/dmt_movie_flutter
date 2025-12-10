import 'package:flutter/material.dart';
import 'package:dmt_movie_flutter/gen_l10n/app_localizations.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/extensions.dart';
import '../../../common/inputs/custom_text_field.dart';
import '../../../common/buttons/primary_button.dart';
import '../widgets/auth_background.dart';
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
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SizedBox(
          height: context.screenHeight,
          child: Column(
            children: [
              const AuthBackground(),
              Expanded(
                child: Container(
                  color: Colors.black,
                  child: Transform.translate(
                    offset: const Offset(0, -150),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingL,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildHeader(l10n),
                          AppDimensions.spacingXL.heightBox,
                          _buildOtpForm(l10n),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              _buildBackButton(l10n),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n) {
    return Column(
      children: [
        Text(
          l10n.otpTitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            shadows: [
              Shadow(color: Colors.black87, blurRadius: 20),
            ],
          ),
        ),
        AppDimensions.spacingS.heightBox,
        Text(
          widget.email != null
              ? l10n.otpSubtitle(widget.email!)
              : l10n.otpSubtitle('email của bạn'),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 15,
            shadows: const [
              Shadow(color: Colors.black87, blurRadius: 15),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOtpForm(AppLocalizations l10n) {
    return AuthCard(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.otpCode,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            AppDimensions.spacingS.heightBox,
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
                style: const TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            AppDimensions.spacingL.heightBox,
            PrimaryButton(
              title: l10n.continueLabel,
              onPressed: _handleSubmit,
              isLoading: _isLoading,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton(AppLocalizations l10n) {
    return GestureDetector(
      onTap: () => context.pop(),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppDimensions.paddingL,
          0,
          AppDimensions.paddingL,
          AppDimensions.paddingL,
        ),
        child: Text(
          l10n.backToLogin,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 13,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}