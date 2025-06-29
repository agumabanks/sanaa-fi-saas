class AppConstants {
  // Base configuration
  static const String appName = 'Sanaa Fi SaaS';
  static const String baseUrl = 'https://your-api-base-url.com'; // Replace with your actual base URL
  static const String apiPath = '/api/v1';
  
  // API Endpoints
  static const String configUri = '/config';
  static const String loginUri = '/auth/login';
  static const String logoutUri = '/auth/logout';
  static const String registrationUri = '/auth/register';
  static const String checkPhoneUri = '/auth/check-phone';
  static const String verifyOtpUri = '/auth/verify-otp';
  static const String checkOtpUri = '/auth/check-otp';
  static const String forgetPassOtpUri = '/auth/forgot-password-otp';
  static const String resetPasswordUri = '/auth/reset-password';
  static const String deleteUserUri = '/auth/delete-user';
  static const String updateProfileUri = '/auth/update-profile';
  static const String changePasswordUri = '/auth/change-password';
  static const String customerByPhoneUri = '/customer/by-phone';
  
  // Loans endpoints
  static const String loansUri = '/loans';
  static const String loansDashboardUri = '/loans/dashboard';
  static const String transactionHistoryUri = '/loans/transaction-history';
  
  // Clients endpoints
  static const String clientsUri = '/clients';
  static const String clientProfileUri = '/clients/profile';
  
  // Expenses endpoints
  static const String expensesUri = '/expenses';
  static const String cashflowsUri = '/cashflows';
  
  // Reports endpoints
  static const String reportsUri = '/reports';
  
  // SharedPreferences Keys
  static const String theme = 'theme';
  static const String token = 'multivendor_token';
  static const String userData = 'user_data';
  static const String customerCountryCode = 'customer_country_code';
  static const String languageCode = 'language_code';
  static const String sendMoneySuggestList = 'send_money_suggest_list';
  static const String requestMoneySuggestList = 'request_money_suggest_list';
  static const String recentAgentList = 'recent_agent_list';
  static const String biometricAuth = 'biometric_auth';
  static const String contactPermission = 'contact_permission';
  static const String introduction = 'introduction';
  static const String notificationCount = 'notification_count';
  static const String searchAddress = 'search_address';
  static const String topic = 'all_customer';
  static const String localizationKey = 'X-localization';
  
  // Language configuration
  static List<LanguageModel> languages = [
    LanguageModel(
      imageUrl: '',
      languageName: 'English',
      countryCode: 'US',
      languageCode: 'en',
    ),
    LanguageModel(
      imageUrl: '',
      languageName: 'Arabic',
      countryCode: 'SA',
      languageCode: 'ar',
    ),
    // Add more languages as needed
  ];
  
  // Device types
  static const String mobile = 'mobile';
  static const String tablet = 'tablet';
  static const String desktop = 'desktop';
  
  // Network timeouts
  static const int timeoutInSeconds = 30;
  static const int receiveTimeoutInSeconds = 30;
  static const int connectTimeoutInSeconds = 30;
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  
  // File upload limits
  static const int maxFileSize = 5 * 1024 * 1024; // 5MB
  static const List<String> allowedImageTypes = ['jpg', 'jpeg', 'png', 'gif'];
  static const List<String> allowedDocumentTypes = ['pdf', 'doc', 'docx', 'txt'];
  
  // Currency
  static const String defaultCurrency = 'USD';
  static const String currencySymbol = '\$';
  
  // Date formats
  static const String dateFormat = 'yyyy-MM-dd';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm:ss';
  static const String displayDateFormat = 'MMM dd, yyyy';
  static const String displayDateTimeFormat = 'MMM dd, yyyy HH:mm';
  
  // App Store links (update with your actual app store links)
  static const String playStoreUrl = 'https://play.google.com/store/apps/details?id=com.your.app';
  static const String appStoreUrl = 'https://apps.apple.com/app/your-app/id1234567890';
  
  // Social media links (update with your actual social media links)
  static const String facebookUrl = 'https://facebook.com/yourpage';
  static const String twitterUrl = 'https://twitter.com/yourhandle';
  static const String linkedinUrl = 'https://linkedin.com/company/yourcompany';
  
  // Support and legal
  static const String supportEmail = 'support@yourapp.com';
  static const String supportPhone = '+1-555-123-4567';
  static const String termsUrl = 'https://yourwebsite.com/terms';
  static const String privacyUrl = 'https://yourwebsite.com/privacy';
  static const String aboutUrl = 'https://yourwebsite.com/about';
  
  // Validation patterns
  static const String phonePattern = r'^[+]?[0-9]{10,15}$';
  static const String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static const String passwordPattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d@$!%*?&]{8,}$';
  
  // Error messages
  static const String networkError = 'Network error occurred';
  static const String serverError = 'Server error occurred';
  static const String unknownError = 'Unknown error occurred';
  static const String timeoutError = 'Request timeout';
  static const String unauthorizedError = 'Unauthorized access';
  static const String forbiddenError = 'Access forbidden';
  static const String notFoundError = 'Resource not found';
  
  // Success messages
  static const String loginSuccess = 'Login successful';
  static const String logoutSuccess = 'Logout successful';
  static const String registrationSuccess = 'Registration successful';
  static const String profileUpdateSuccess = 'Profile updated successfully';
  static const String passwordChangeSuccess = 'Password changed successfully';
  
  // Biometric authentication
  static const String biometricLocalizedFallbackTitle = 'Use Password';
  static const String biometricSignInTitle = 'Biometric Authentication';
  
  // Notification channels
  static const String generalNotificationChannel = 'general_notifications';
  static const String transactionNotificationChannel = 'transaction_notifications';
  static const String promotionalNotificationChannel = 'promotional_notifications';
}

// Language model class
class LanguageModel {
  final String imageUrl;
  final String languageName;
  final String countryCode;
  final String languageCode;

  LanguageModel({
    required this.imageUrl,
    required this.languageName,
    required this.countryCode,
    required this.languageCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'languageName': languageName,
      'countryCode': countryCode,
      'languageCode': languageCode,
    };
  }

  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(
      imageUrl: json['imageUrl'] ?? '',
      languageName: json['languageName'] ?? '',
      countryCode: json['countryCode'] ?? '',
      languageCode: json['languageCode'] ?? '',
    );
  }
}


// import 'package:get/get.dart';
// import 'package:sanaa_fi_saas/common/models/language_model.dart';
// import 'package:sanaa_fi_saas/common/models/on_boarding_model.dart';
// import 'images.dart';

// class AppConstants {
//   static const String appName = 'Field Agent';
//   // static const String baseUrl = 'https://finmicro.sanaa.co';
//   static const String baseUrl = 'https://lendsup.sanaa.co';
//   static const String apiPath = '/api/v1';
//   static const bool demo = false;
//   static const double appVersion = 4.3;

//   static const String getClients = '/api/v1/clients';
//    static const String getAgentClients = '/api/v1/agentclients';

//   // aadd client addClientLoan
//     static const String addClients = '/api/v1/addclients';
//     static const String addClientLoan = '/api/v1/create-loans';
//     static const String getClientsProfile = '/api/v1/getClient';
//     static const String getClientsLoans = '/api/v1/clientLoans';

//     // getClientLoansHistory
//     static const String getClientLoansHistory = '/api/v1/clientLoanspayHistory';


//       static const String getcustomerDataUri = '/api/v1/getUserByPhone';
//       static const String clientguarantorsList = '/api/v1/clientguarantorsList';



//       // clientPhotos
//        static const String clientPhotos = '/api/v1/clientphotos';
      
//   static const String userLoansList = '/api/v1/loan-lists'; ///api/v1/loan-lists/24  getAgentLoanAmount
//   static const String getAgentLoanAmount = '/api/v1/today-instal-sum';
// // todayScheduledLoans
//   static const String todayScheduledLoans = '/api/v1/todaysSchedule'; 

// // pay loan
// static const String payLoan = '/api/v1/loans/pay';

    
//     static const String getClientQr = '/api/v1/getClientQr';
//     static const String addClientGuarantor = '/api/v1/addClientGuarantor';




//   static const String customerPhoneCheckUri = '/api/v1/customer/auth/check-phone';
//   static const String customerPhoneVerifyUri = '/api/v1/customer/auth/verify-phone';
//   static const String customerRegistrationUri = '/api/v1/customer/auth/register';
//   static const String customerUpdateProfile = '/api/v1/customer/update-profile';
//   static const String customerLoginUri = '/api/v1/customer/auth/login';
//   static const String customerLogoutUri = '/api/v1/customer/logout';
//   static const String customerForgetPassOtpUri = '/api/v1/customer/auth/forgot-password';
//   static const String customerForgetPassVerification = '/api/v1/customer/auth/verify-token';
//   static const String customerForgetPassReset = '/api/v1/customer/auth/reset-password';
//   static const String customerLinkedWebsite= '/api/v1/customer/linked-website';
//   static const String customerBanner= '/api/v1/customer/get-banner';
//   static const String customerTransactionHistory= '/api/v1/customer/transaction-history';
//   static const String customerPurposeUrl = '/api/v1/customer/get-purpose';
//   static const String configUri = '/api/v1/config';
//   static const String imageConfigUrlApiNeed = '/storage/app/public/purpose/';
//   static const String customerProfileInfo = '/api/v1/customer/get-customer';
//   static const String customerCheckOtp = '/api/v1/customer/check-otp';
//   static const String customerVerifyOtp = '/api/v1/customer/verify-otp';
//   static const String customerChangePin = '/api/v1/customer/change-pin';
//   static const String customerUpdateTwoFactor = '/api/v1/customer/update-two-factor';
//   static const String customerSendMoney = '/api/v1/customer/send-money';
//   static const String customerRequestMoney = '/api/v1/customer/request-money';
//   static const String customerCashOut = '/api/v1/customer/cash-out';
//   static const String customerPinVerify = '/api/v1/customer/verify-pin';
//   static const String customerAddMoney = '/api/v1/customer/add-money';
//   static const String faqUri = '/api/v1/faq';
//   static const String notificationUri = '/api/v1/customer/get-notification';
//   static const String transactionHistoryUri = '/api/v1/customer/transaction-history';
//   static const String requestedMoneyUri = '/api/v1/customer/get-requested-money';
//   static const String acceptedRequestedMoneyUri = '/api/v1/customer/request-money/approve';
//   static const String deniedRequestedMoneyUri = '/api/v1/customer/request-money/deny';
//   static const String tokenUri = '/api/v1/customer/update-fcm-token';
//   static const String checkCustomerUri = '/api/v1/check-customer';
//   static const String checkAgentUri = '/api/v1/check-agent';
//   static const String wonRequestedMoney = '/api/v1/customer/get-own-requested-money';
//   static const String customerRemove = '/api/v1/customer/remove-account';
//   static const String updateKycInformation = '/api/v1/customer/update-kyc-information';
//   static const String withdrawMethodList = '/api/v1/customer/withdrawal-methods';
//   static const String withdrawRequest = '/api/v1/customer/withdraw';
//   static const String getWithdrawalRequest = '/api/v1/customer/withdrawal-requests';

//   // Desktop authentication endpoints
//   static const String desktopLogin = '/desktop-api/login';
//   static const String desktopLogout = '/desktop-api/logout';
//   static const String desktopLogoutAll = '/desktop-api/logout-all';
//   static const String desktopRefresh = '/desktop-api/refresh';
//   static const String desktopVerify = '/desktop-api/verify';
//   static const String desktopSession = '/desktop-api/session';


//   // Shared Key
//   static const String theme = 'theme';
//   static const String token = 'token';
//   static const String customerCountryCode = 'customer_country_code';//not in project
//   static const String languageCode = 'language_code';
//   static const String topic = 'notify';

//   static const String sendMoneySuggestList = 'send_money_suggest';
//   static const String requestMoneySuggestList = 'request_money_suggest';
//   static const String recentAgentList = 'recent_agent_list';

//   static const String pending = 'pending';
//   static const String approved = 'approved';
//   static const String denied = 'denied';
//   static const String cashIn = 'cash_in';
//   static const String cashOut = 'cash_out';
//   static const String sendMoney = 'send_money';
//   static const String receivedMoney = 'received_money';
//   static const String adminCharge = 'admin_charge';
//   static const String addMoney = 'add_money';
//   static const String withdraw = 'withdraw';
//   static const String payment = 'payment';

//   static const String biometricAuth = 'biometric_auth';
//   static const String biometricPin = 'biometric';
//   static const String contactPermission = '';
//   static const String userData = 'user';

//   // Desktop session storage keys
//   static const String desktopAuthToken = 'desktop_auth_token';
//   static const String desktopSessionId = 'desktop_session_id';
//   static const String desktopUserEmail = 'desktop_user_email';
//   static const String deviceFingerprint = 'device_fingerprint';



//   //topic
//   static const String all = 'all';
//   static const String users = 'customers';

//   // App Theme
//   static const String theme1 = 'theme_1';
//   static const String theme2 = 'theme_2';
//   static const String theme3 = 'theme_3';

//   //input balance digit length
//   static const int balanceInputLen = 10;

//   static List<LanguageModel> languages = [
//     LanguageModel(imageUrl: Images.english, languageName: 'English', countryCode: 'US', languageCode: 'en'),
//     LanguageModel(imageUrl: Images.saudi, languageName: 'Arabic', countryCode: 'SA', languageCode: 'ar'),

//   ];

//   static  List<OnboardModel> onboardList = [
//     OnboardModel(
//       Images.onboardImage1,
//       Images.onboardBackground1,
//       'on_boarding_title_1'.tr,
//       '${'send_money_from'.tr} $appName ${'easily_at_anytime'.tr}',
//     ),

//     OnboardModel(
//       Images.onboardImage2, Images.onboardBackground2,
//       'on_boarding_title_2'.tr,
//       'withdraw_money_is_even_more'.tr,
//     ),
//     OnboardModel(
//       Images.onboardImage3,
//       Images.onboardBackground3,
//       'on_boarding_title_3'.tr,
//       '${'request_for_money_using'.tr} $appName ${'account_to_any_friend'.tr}',
//     ),
//   ];
// }
