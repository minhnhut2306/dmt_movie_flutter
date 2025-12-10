import 'package:dmt_movie_flutter/src/presentation/features/auth/widgets/auth_background.dart';
import 'package:dmt_movie_flutter/src/presentation/features/auth/widgets/auth_card.dart';
import 'package:flutter/material.dart';
import 'package:dmt_movie_flutter/gen_l10n/app_localizations.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/app_colors.dart';
import '../../../common/inputs/custom_text_field.dart';
import '../../../common/buttons/primary_button.dart';

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
      context.pushNamed(
        RouteNames.otp,
        arguments: _emailController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
                          _buildHeader(l10n, isDark),
                          AppDimensions.spacingXL.heightBox,
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
    );
  }

  Widget _buildHeader(AppLocalizations l10n, bool isDark) {
    return Column(
      children: [
        Text(
          l10n.loginTitle,
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
          l10n.loginSubtitle,
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
                color: isDark ? Colors.white : const Color(0xFF1A1A1A),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            AppDimensions.spacingS.heightBox,
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

  Widget _buildTermsCheckbox(AppLocalizations l10n, bool isDark) {
    return Container(
      color: isDark ? Colors.black : const Color(0xFFF8F9FA),
      padding: EdgeInsets.fromLTRB(
        AppDimensions.paddingL,
        0,
        AppDimensions.paddingL,
        AppDimensions.paddingL,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform.scale(
            scale: 0.9,
            child: Checkbox(
              value: _isChecked,
              onChanged: (v) => setState(() => _isChecked = v!),
              activeColor: isDark ? Colors.orange : AppColors.primary,
              checkColor: Colors.white,
              side: BorderSide(
                color: isDark 
                  ? Colors.white.withOpacity(0.5)
                  : const Color(0xFFCCCCCC),
                width: 2,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusXS),
              ),
            ),
          ),
          SizedBox(width: AppDimensions.spacingXS),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text.rich(
                TextSpan(
                  text: l10n.termsAccept,
                  style: TextStyle(
                    color: isDark 
                      ? Colors.white.withOpacity(0.8)
                      : const Color(0xFF666666),
                    fontSize: 13,
                    height: 1.4,
                  ),
                  children: [
                    TextSpan(
                      text: l10n.termsText,
                      style: TextStyle(
                        color: isDark ? Colors.orange : AppColors.primary,
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