import 'package:flutter/material.dart';
import 'package:dmt_movie_flutter/gen_l10n/app_localizations.dart';
import '../../../../core/responsive.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/app_text_styles.dart';
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
                          color: Colors.black,
                          child: Transform.translate(
                            offset: Offset(0, Responsive.authHeaderOffset(context)),
                            child: Padding(
                              padding: Responsive.horizontalPadding(context),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  _buildHeader(l10n),
                                  SizedBox(height: Responsive.spacingXL(context)),
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
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n) {
    return Column(
      children: [
        Text(
          l10n.otpTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: Responsive.titleFontSize(context),
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            shadows: const [
              Shadow(color: Colors.black87, blurRadius: 20),
            ],
          ),
        ),
        SizedBox(height: Responsive.spacingS(context)),
        Text(
          widget.email != null
              ? l10n.otpSubtitle(widget.email!)
              : l10n.otpSubtitle('email của bạn'),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: Responsive.bodyFontSize(context),
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
              style: TextStyle(
                color: Colors.white,
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
                  color: Colors.blue,
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

  Widget _buildBackButton(AppLocalizations l10n) {
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
            color: Colors.white.withOpacity(0.8),
            fontSize: Responsive.captionFontSize(context),
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}