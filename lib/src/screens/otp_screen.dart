import 'package:dmt_movie_flutter/src/widgets/custom_component/custom_button.dart';
import 'package:dmt_movie_flutter/src/widgets/custom_component/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:dmt_movie_flutter/src/core/app_assets.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController emailController = TextEditingController();
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight,
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.4,
                child: Stack(
                  children: [
                    // Background poster
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                         image: AssetImage(AppImages.img08),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // Gradient overlay nhẹ ở dưới ảnh
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.8),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.black,
                  child: Transform.translate(
                    offset: const Offset(0, -40),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            "Nhập mã OTP",
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
                          const SizedBox(height: 8),
                          Text(
                            "Nhập mã OTP đã được gửi đến email của bạn",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 15,
                              shadows: const [
                                Shadow(color: Colors.black87, blurRadius: 15),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Card chứa form
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.1),
                                width: 1,
                              ),
                            ),
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
                                const SizedBox(height: 8),
                                CustomTextField(
                                  controller: emailController,
                                  hintText: 'Nhập mã OTP',
                                  keyboardType: TextInputType.number,
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Xử lý gửi lại mã OTP
                                  },
                                  child: const Text(
                                    'Gửi lại mã OTP',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                CustomButton(title: 'Tiếp tục', onPress: () {}),
                              ],
                            ),
                          ),

                          // Spacer để đẩy nút xuống dưới
                          const Spacer(),

                          // Nút quay lại ở dưới cùng, ngoài Container form
                          GestureDetector(
                            onTap: () {
                              // Navigate back to login
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 32),
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
