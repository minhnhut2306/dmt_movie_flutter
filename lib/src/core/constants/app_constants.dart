class AppConstants {
  AppConstants._();

  static const String appName = 'DMT Movie';
  static const String appVersion = '1.0.0';

  static const int maxProfiles = 6;
  static const int otpLength = 6;
  static const int otpResendSeconds = 60;

  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration animationDurationShort = Duration(milliseconds: 150);
  static const Duration animationDurationLong = Duration(milliseconds: 500);

  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration debounceDelay = Duration(milliseconds: 500);

  static const String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const String phoneRegex = r'^[0-9]{10}$';

  static const int passwordMinLength = 6;
  static const int nameMinLength = 2;
  static const int nameMaxLength = 50;
}