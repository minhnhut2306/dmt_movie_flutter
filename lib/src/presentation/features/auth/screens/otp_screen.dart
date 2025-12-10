import 'package:flutter/material.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/validators.dart';
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
      context.showSuccessSnackBar('Xác thực thành công');
    }
  }

  void _handleResendOtp() {
    context.showSnackBar('Mã OTP đã được gửi lại');
  }

  @override
  Widget build(BuildContext context) {
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
                          _buildHeader(),
                          AppDimensions.spacingXL.heightBox,
                          _buildOtpForm(),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              _buildBackButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        const Text(
          'Nhập mã OTP',
          textAlign: TextAlign.center,
          style: TextStyle(
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
              ? 'Nhập mã OTP đã được gửi đến ${widget.email}'
              : 'Nhập mã OTP đã được gửi đến email của bạn',
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

  Widget _buildOtpForm() {
    return AuthCard(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'OTP Code',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            AppDimensions.spacingS.heightBox,
            CustomTextField(
              controller: _otpController,
              hintText: 'Nhập mã OTP',
              keyboardType: TextInputType.number,
              validator: Validators.otp,
              maxLength: AppConstants.otpLength,
            ),
            TextButton(
              onPressed: _handleResendOtp,
              child: const Text(
                'Gửi lại mã OTP',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            AppDimensions.spacingL.heightBox,
            PrimaryButton(
              title: 'Tiếp tục',
              onPressed: _handleSubmit,
              isLoading: _isLoading,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton() {
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
          'Quay lại màn hình đăng nhập',
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