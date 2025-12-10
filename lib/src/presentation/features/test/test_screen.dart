import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(title: const Text("Test CustomTextField")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppDimensions.paddingM),
        child: Column(
          children: [
            CustomTextField(
              controller: _nameController,
              hintText: 'Nhập tên',
              validator: Validators.name,
            ),
            AppDimensions.spacingM.heightBox,
            CustomTextField(
              controller: _emailController,
              hintText: 'Nhập email',
              prefixIcon: Icons.email_outlined,
              validator: Validators.email,
            ),
            AppDimensions.spacingM.heightBox,
            CustomTextField(
              controller: _passwordController,
              hintText: 'Nhập mật khẩu',
              prefixIcon: Icons.lock_outlined,
              isPassword: true,
              validator: Validators.password,
            ),
            AppDimensions.spacingM.heightBox,
            CustomTextField(
              controller: TextEditingController(),
              hintText: 'Nhập số điện thoại',
              prefixIcon: Icons.phone_outlined,
              validator: (value) => 'Số điện thoại không hợp lệ',
            ),
            AppDimensions.spacingXL.heightBox,
            PrimaryButton(
              title: 'Đăng ký',
              onPressed: () {
                context.showSuccessSnackBar('Đăng ký thành công');
              },
            ),
            AppDimensions.spacingM.heightBox,
            OutlineButton(
              title: 'Huỷ',
              onPressed: () => context.pop(),
            ),
          ],
        ),
      ),
    );
  }
}