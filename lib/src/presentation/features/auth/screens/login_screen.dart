import 'package:flutter/material.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/validators.dart';
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
      context.pushNamed(
        RouteNames.otp,
        arguments: _emailController.text,
      );
    }
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
                          _buildLoginForm(),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              _buildTermsCheckbox(),
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
          'Đăng nhập / Đăng ký',
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
          'Nhập email để tiếp tục',
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

  Widget _buildLoginForm() {
    return AuthCard(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Email',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            AppDimensions.spacingS.heightBox,
            CustomTextField(
              controller: _emailController,
              hintText: 'example@email.com',
              keyboardType: TextInputType.emailAddress,
              validator: Validators.email,
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

  Widget _buildTermsCheckbox() {
    return Padding(
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
              activeColor: Colors.orange,
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
                  text: 'Tôi đã đọc dòng ',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 13,
                    height: 1.4,
                  ),
                  children: const [
                    TextSpan(
                      text:
                          'Không thêm cũng được, nhưng thêm vô nhìn cho sang chảnh hơn, hiểu hông mấy má 😏',
                      style: TextStyle(
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