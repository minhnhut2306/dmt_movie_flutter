// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'DMT Movie';

  @override
  String get homeTitle => 'Movies';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get searchTitle => 'Search';

  @override
  String get openSettings => 'Open settings';

  @override
  String get seeDetails => 'See details';

  @override
  String get noMovies => 'No movies';

  @override
  String get tabHome => 'Home';

  @override
  String get tabSearch => 'Search';

  @override
  String get tabSettings => 'Settings';

  @override
  String get loginTitle => 'Login / Register';

  @override
  String get loginSubtitle => 'Enter your email to continue';

  @override
  String get email => 'Email';

  @override
  String get emailHint => 'example@email.com';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get emailInvalid => 'Invalid email address';

  @override
  String get password => 'Password';

  @override
  String get passwordHint => 'Enter password';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String passwordMinLength(int length) {
    return 'Password must be at least $length characters';
  }

  @override
  String get continue => 'Continue';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get add => 'Add';

  @override
  String get back => 'Back';

  @override
  String get retry => 'Retry';

  @override
  String get ok => 'OK';

  @override
  String get otpTitle => 'Enter OTP Code';

  @override
  String otpSubtitle(String email) {
    return 'Enter the OTP code sent to $email';
  }

  @override
  String get otpCode => 'OTP Code';

  @override
  String get otpHint => 'Enter OTP code';

  @override
  String get otpRequired => 'OTP code is required';

  @override
  String otpInvalid(int length) {
    return 'OTP must be $length digits';
  }

  @override
  String get resendOtp => 'Resend OTP';

  @override
  String get backToLogin => 'Back to login screen';

  @override
  String get otpVerified => 'Verification successful';

  @override
  String get otpResent => 'OTP code has been resent';

  @override
  String get selectProfile => 'Who\'s watching?';

  @override
  String get manageProfiles => 'Manage Profiles';

  @override
  String get addProfile => 'Add';

  @override
  String get addNewProfile => 'Add new profile';

  @override
  String get editProfile => 'Edit profile';

  @override
  String maxProfilesReached(int max) {
    return 'Maximum $max profiles reached';
  }

  @override
  String profileSelected(String name) {
    return '$name selected';
  }

  @override
  String get user => 'User';

  @override
  String get kids => 'Kids';

  @override
  String get name => 'Name';

  @override
  String get nameHint => 'Enter name';

  @override
  String get nameRequired => 'Name is required';

  @override
  String nameMinLength(int length) {
    return 'Name must be at least $length characters';
  }

  @override
  String nameMaxLength(int length) {
    return 'Name cannot exceed $length characters';
  }

  @override
  String get phone => 'Phone';

  @override
  String get phoneHint => 'Enter phone number';

  @override
  String get phoneRequired => 'Phone number is required';

  @override
  String get phoneInvalid => 'Invalid phone number';

  @override
  String get theme => 'Theme';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get language => 'Language';

  @override
  String get languageSystem => 'System';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageVietnamese => 'Tiếng Việt';

  @override
  String get error => 'Error';

  @override
  String get success => 'Success';

  @override
  String get warning => 'Warning';

  @override
  String get info => 'Information';

  @override
  String get loadingMovies => 'Loading movies...';

  @override
  String errorLoadingMovies(String error) {
    return 'Unable to load movies: $error';
  }

  @override
  String get termsAccept => 'I have read ';

  @override
  String get termsText => 'Just adding this to make it look more professional, you know what I mean 😏';

  @override
  String get registerSuccess => 'Registration successful';

  @override
  String get loginSuccess => 'Login successful';

  @override
  String get movieDetails => 'Movie Details';

  @override
  String movieId(String id) {
    return 'Movie ID: $id';
  }
}
