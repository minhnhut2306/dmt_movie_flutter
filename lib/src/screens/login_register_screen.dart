import 'package:dmt_movie_flutter/src/core/app_assets.dart';
import 'package:dmt_movie_flutter/src/widgets/custom_component/custom_button.dart';
import 'package:dmt_movie_flutter/src/widgets/custom_component/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginRegisterScreen extends StatefulWidget {
  const LoginRegisterScreen({super.key});

  @override
  State<LoginRegisterScreen> createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen> {
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
                height: screenHeight * 0.48,
                child: Stack(
                  children: [
                    // Background poster
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppImages.background),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // Gradient phủ toàn bộ ảnh -> giúp chuyển mượt xuống nền đen
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.0),
                            Colors.black.withOpacity(0.3),
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.9),
                            Colors.black,
                          ],
                          stops: const [0.0, 0.5, 0.7, 0.85, 1.0],
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
                    offset: const Offset(0, -150),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            "Đăng nhập / Đăng ký",
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
                            "Nhập email để tiếp tục",
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
                                  'Email',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                CustomTextField(
                                  controller: emailController,
                                  hintText: 'example@email.com',
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                const SizedBox(height: 24),
                                CustomButton(title: 'Tiếp tục', onPress: () {}),
                              ],
                            ),
                          ),

                          // Spacer đẩy checkbox xuống dưới
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Checkbox nằm ngoài Transform.translate, ở dưới cùng màn hình
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Transform.scale(
                      scale: 0.9,
                      child: Checkbox(
                        value: isChecked,
                        onChanged: (v) => setState(() => isChecked = v!),
                        activeColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
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
