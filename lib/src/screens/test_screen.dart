import 'package:flutter/material.dart';
import 'package:dmt_movie_flutter/src/widgets/custom_component/custom_text_field.dart';
import 'package:dmt_movie_flutter/src/widgets/custom_component/custom_button.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Test CustomTextField")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Không có icon
            CustomTextField(controller: _nameController, hintText: 'Nhập tên'),
            const SizedBox(height: 16),

            // Có icon
            CustomTextField(
              controller: _emailController,
              hintText: 'Nhập email',
              prefixIcon: const Icon(Icons.email_outlined),
            ),
            const SizedBox(height: 16),

            // Password
            CustomTextField(
              controller: _passwordController,
              hintText: 'Nhập mật khẩu',
              prefixIcon: const Icon(Icons.lock_outlined),
              isPassword: true,
            ),
            const SizedBox(height: 16),

            // Có lỗi
            CustomTextField(
              controller: TextEditingController(),
              hintText: 'Nhập số điện thoại',
              prefixIcon: const Icon(Icons.phone_outlined),
              textError: 'Số điện thoại không hợp lệ',
            ),
            const SizedBox(height: 32),
            CustomButton(
              title: 'Đăng ký',
              onPress: () {
                // Xử lý đăng ký
              },
            ),
            CustomButton(
              title: 'Huỷ',
              onPress: () {},
              isOutlineButton: true,
              isSmall: true,
            ),
          ],
        ),
      ),
    );
  }
}
