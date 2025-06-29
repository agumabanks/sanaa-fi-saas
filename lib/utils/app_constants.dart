import 'package:get/get.dart';
import 'package:sanaa_fi_saas/common/models/language_model.dart';
import 'package:sanaa_fi_saas/common/models/on_boarding_model.dart';
import 'package:sanaa_fi_saas/utils/images.dart';

class AppConstants {
  // ===== Base Configuration =====
  static const String appName = 'Field Agent'; // Keeping your actual app name
  static const String baseUrl = 'https://mbalala.sanaa.co'; // Your actual base URL
  static const String apiPath = '/api/v1';
  static const bool demo = false;
  static const double appVersion = 4.3;

  // ===== Authentication Endpoints =====
  static const String customerPhoneCheckUri = '/customer/auth/check-phone';
  static const String customerPhoneVerifyUri = '/customer/auth/verify-phone';
  static const String customerRegistrationUri = '/customer/auth/register';
  static const String customerLoginUri = '/customer/auth/login';
  static const String customerLogoutUri = '/customer/logout';
  static const String customerForgetPassOtpUri = '/customer/auth/forgot-password';
  static const String customerForgetPassVerification = '/customer/auth/verify-token';
  static const String customerForgetPassReset = '/customer/auth/reset-password';
  static const String customerRemove = '/customer/remove-account';
  static const String customerCheckOtp = '/customer/check-otp';
  static const String customerVerifyOtp = '/customer/verify-otp';
  static const String customerPinVerify = '/customer/verify-pin';
  static const String customerChangePin = '/customer/change-pin';
  static const String customerUpdateTwoFactor = '/customer/update-two-factor';
  
  // Alternative naming for compatibility
  static const String checkPhoneUri = customerPhoneCheckUri;
  static const String verifyOtpUri = customerPhoneVerifyUri;
  static const String loginUri = customerLoginUri;
  static const String logoutUri = customerLogoutUri;
  static const String registrationUri = customerRegistrationUri;
  static const String forgetPassOtpUri = customerForgetPassOtpUri;
  static const String resetPasswordUri = customerForgetPassReset;
  static const String deleteUserUri = customerRemove;

  // ===== Customer/User Endpoints =====
  static const String customerProfileInfo = '/customer/get-customer';
  static const String customerUpdateProfile = '/customer/update-profile';
  static const String getcustomerDataUri = '/getUserByPhone';
  static const String updateKycInformation = '/customer/update-kyc-information';
  
  // Alternative naming
  static const String updateProfileUri = customerUpdateProfile;
  static const String customerByPhoneUri = getcustomerDataUri;

  // ===== Client Management Endpoints =====
  static const String getClients = '/clients';
  static const String getAgentClients = '/agentclients';
  static const String addClients = '/addclients';
  static const String getClientsProfile = '/getClient';
  static const String clientPhotos = '/clientphotos';
  static const String getClientQr = '/getClientQr';
  static const String addClientGuarantor = '/addClientGuarantor';
  static const String clientguarantorsList = '/clientguarantorsList';
  
  // Alternative naming for compatibility
  static const String clientsUri = getClients;
  static const String clientProfileUri = getClientsProfile;

  // ===== Loan Management Endpoints =====
  static const String userLoansList = '/loan-lists';
  static const String addClientLoan = '/create-loans';
  static const String getClientsLoans = '/clientLoans';
  static const String getClientLoansHistory = '/clientLoanspayHistory';
  static const String getAgentLoanAmount = '/today-instal-sum';
  static const String todayScheduledLoans = '/todaysSchedule';
  static const String payLoan = '/loans/pay';
  
  // Alternative naming
  static const String loansUri = userLoansList;
  static const String loansDashboardUri = getAgentLoanAmount;

  // ===== Transaction & Money Management =====
  static const String customerSendMoney = '/customer/send-money';
  static const String customerRequestMoney = '/customer/request-money';
  static const String customerCashOut = '/customer/cash-out';
  static const String customerAddMoney = '/customer/add-money';
  static const String customerTransactionHistory = '/customer/transaction-history';
  static const String requestedMoneyUri = '/customer/get-requested-money';
  static const String acceptedRequestedMoneyUri = '/customer/request-money/approve';
  static const String deniedRequestedMoneyUri = '/customer/request-money/deny';
  static const String wonRequestedMoney = '/customer/get-own-requested-money';
  
  // Alternative naming
  static const String transactionHistoryUri = customerTransactionHistory;

  // ===== Other API Endpoints =====
  static const String configUri = '/config';
  static const String customerPurposeUrl = '/customer/get-purpose';
  static const String customerLinkedWebsite = '/customer/linked-website';
  static const String customerBanner = '/customer/get-banner';
  static const String faqUri = '/faq';
  static const String notificationUri = '/customer/get-notification';
  static const String tokenUri = '/customer/update-fcm-token';
  static const String checkCustomerUri = '/check-customer';
  static const String checkAgentUri = '/check-agent';
  static const String withdrawMethodList = '/customer/withdrawal-methods';
  static const String withdrawRequest = '/customer/withdraw';
  static const String getWithdrawalRequest = '/customer/withdrawal-requests';

  // ===== Desktop Authentication Endpoints =====
  static const String desktopLogin = '/desktop-api/login';
  static const String desktopLogout = '/desktop-api/logout';
  static const String desktopLogoutAll = '/desktop-api/logout-all';
  static const String desktopRefresh = '/desktop-api/refresh';
  static const String desktopVerify = '/desktop-api/verify';
  static const String desktopSession = '/desktop-api/session';

  // ===== Image & File Paths =====
  static const String imageConfigUrlApiNeed = '/storage/app/public/purpose/';

  // ===== SharedPreferences Keys =====
  static const String theme = 'theme';
  static const String token = 'token';
  static const String userData = 'user';
  static const String customerCountryCode = 'customer_country_code';
  static const String languageCode = 'language_code';
  static const String sendMoneySuggestList = 'send_money_suggest';
  static const String requestMoneySuggestList = 'request_money_suggest';
  static const String recentAgentList = 'recent_agent_list';
  static const String biometricAuth = 'biometric_auth';
  static const String biometricPin = 'biometric';
  static const String contactPermission = 'contact_permission';
  static const String introduction = 'introduction';
  static const String notificationCount = 'notification_count';
  static const String searchAddress = 'search_address';
  static const String topic = 'notify';
  static const String localizationKey = 'X-localization';
  
  // Desktop specific storage keys
  static const String desktopAuthToken = 'desktop_auth_token';
  static const String desktopSessionId = 'desktop_session_id';
  static const String desktopUserEmail = 'desktop_user_email';
  static const String deviceFingerprint = 'device_fingerprint';

  // ===== Transaction Types =====
  static const String pending = 'pending';
  static const String approved = 'approved';
  static const String denied = 'denied';
  static const String cashIn = 'cash_in';
  static const String cashOut = 'cash_out';
  static const String sendMoney = 'send_money';
  static const String receivedMoney = 'received_money';
  static const String adminCharge = 'admin_charge';
  static const String addMoney = 'add_money';
  static const String withdraw = 'withdraw';
  static const String payment = 'payment';

  // ===== Topics =====
  static const String all = 'all';
  static const String users = 'customers';

  // ===== App Themes =====
  static const String theme1 = 'theme_1';
  static const String theme2 = 'theme_2';
  static const String theme3 = 'theme_3';

  // ===== Device Types =====
  static const String mobile = 'mobile';
  static const String tablet = 'tablet';
  static const String desktop = 'desktop';

  // ===== Network Configuration =====
  static const int timeoutInSeconds = 30;
  static const int receiveTimeoutInSeconds = 30;
  static const int connectTimeoutInSeconds = 30;

  // ===== Input Constraints =====
  static const int balanceInputLen = 10;
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  static const int maxFileSize = 5 * 1024 * 1024; // 5MB

  // ===== File Types =====
  static const List<String> allowedImageTypes = ['jpg', 'jpeg', 'png', 'gif'];
  static const List<String> allowedDocumentTypes = ['pdf', 'doc', 'docx', 'txt'];

  // ===== Currency Configuration =====
  static const String defaultCurrency = 'UGX'; // Assuming Uganda Shillings based on .co domain
  static const String currencySymbol = 'USh';

  // ===== Date Formats =====
  static const String dateFormat = 'yyyy-MM-dd';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm:ss';
  static const String displayDateFormat = 'MMM dd, yyyy';
  static const String displayDateTimeFormat = 'MMM dd, yyyy HH:mm';

  // ===== Validation Patterns =====
  static const String phonePattern = r'^[+]?[0-9]{10,15}$';
  static const String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static const String passwordPattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d@$!%*?&]{8,}$';

  // ===== Error Messages =====
  static const String networkError = 'Network error occurred';
  static const String serverError = 'Server error occurred';
  static const String unknownError = 'Unknown error occurred';
  static const String timeoutError = 'Request timeout';
  static const String unauthorizedError = 'Unauthorized access';
  static const String forbiddenError = 'Access forbidden';
  static const String notFoundError = 'Resource not found';

  // ===== Success Messages =====
  static const String loginSuccess = 'Login successful';
  static const String logoutSuccess = 'Logout successful';
  static const String registrationSuccess = 'Registration successful';
  static const String profileUpdateSuccess = 'Profile updated successfully';
  static const String passwordChangeSuccess = 'Password changed successfully';

  // ===== Biometric Configuration =====
  static const String biometricLocalizedFallbackTitle = 'Use Password';
  static const String biometricSignInTitle = 'Biometric Authentication';

  // ===== Notification Channels =====
  static const String generalNotificationChannel = 'general_notifications';
  static const String transactionNotificationChannel = 'transaction_notifications';
  static const String promotionalNotificationChannel = 'promotional_notifications';

  // ===== Languages Configuration =====
  static List<LanguageModel> languages = [
    LanguageModel(
      imageUrl: Images.english,
      languageName: 'English',
      countryCode: 'US',
      languageCode: 'en',
    ),
    LanguageModel(
      imageUrl: Images.saudi,
      languageName: 'Arabic',
      countryCode: 'SA',
      languageCode: 'ar',
    ),
  ];

  // ===== Onboarding Configuration =====
  static List<OnboardModel> onboardList = [
    OnboardModel(
      Images.onboardImage1,
      Images.onboardBackground1,
      'on_boarding_title_1'.tr,
      '${'send_money_from'.tr} $appName ${'easily_at_anytime'.tr}',
    ),
    OnboardModel(
      Images.onboardImage2,
      Images.onboardBackground2,
      'on_boarding_title_2'.tr,
      'withdraw_money_is_even_more'.tr,
    ),
    OnboardModel(
      Images.onboardImage3,
      Images.onboardBackground3,
      'on_boarding_title_3'.tr,
      '${'request_for_money_using'.tr} $appName ${'account_to_any_friend'.tr}',
    ),
  ];

  // ===== External Links (Update these with actual values) =====
  static const String playStoreUrl = 'https://play.google.com/store/apps/details?id=com.sanaa.fieldagent';
  static const String appStoreUrl = 'https://apps.apple.com/app/sanaa-field-agent/id1234567890';
  static const String facebookUrl = 'https://facebook.com/sanaafinance';
  static const String twitterUrl = 'https://twitter.com/sanaafinance';
  static const String linkedinUrl = 'https://linkedin.com/company/sanaa-finance';
  static const String supportEmail = 'support@sanaa.co';
  static const String supportPhone = '+256-XXX-XXX-XXX'; // Update with actual number
  static const String termsUrl = 'https://lendsup.sanaa.co/terms';
  static const String privacyUrl = 'https://lendsup.sanaa.co/privacy';
  static const String aboutUrl = 'https://lendsup.sanaa.co/about';
}