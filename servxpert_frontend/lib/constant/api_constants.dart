// api_constants.dart

const String baseUrl = "https://dac35601614c.ngrok-free.app/api/v1";

const String sendOtpUrl = "$baseUrl/auth/email-otp/";
const String verifyOtpUrl = "$baseUrl/auth/email-otp-login/";
const String googleLoginUrl = "$baseUrl/auth/google-login/";
const String switchToSPUrl = "$baseUrl/auth/customer/switch-to-serviceprovider/";
const String switchToCustomerUrl = "$baseUrl/auth/service_provider/switch-to-customer/";
const String refreshTokenUrl = "$baseUrl/token/refresh/";
const String verifyTokenUrl = "$baseUrl/token/verify/";
const String logoutUrl = "$baseUrl/token/logout/";
const String submitUrl = "$baseUrl/service_provider_details/";