import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:http/http.dart' as http;
import 'package:servxpert_frontend/auth/auth_service.dart';
import 'package:servxpert_frontend/constant/error_page.dart';
import 'package:servxpert_frontend/userApp/fetching_location.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';




class OTPVerificationScreen extends StatefulWidget {
  final String email;
  final String firstName;
  final String lastName;

  const OTPVerificationScreen({
    super.key,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  String otpCode = "";
  bool isButtonEnabled = false;
  bool isLoading = false;

  void handleOTPChange(String otp) {
    setState(() {
      otpCode = otp;
      isButtonEnabled = otp.length == 4;
    });
  }

  Future<void> verifyOTPAndLogin() async {
    setState(() => isLoading = true);
    const secureStorage = FlutterSecureStorage();

    try {
      final responseData = await verifyOtp(widget.email, otpCode);

      if (responseData != null && responseData['access'] != null) {
        // Save tokens securely
        await secureStorage.write(key: 'access_token', value: responseData['access']);
        await secureStorage.write(key: 'refresh_token', value: responseData['refresh']);

        // Optional: save user profile info if available in response
        if (responseData.containsKey('user')) {
          final user = responseData['user'];
          await secureStorage.write(key: 'email', value: user['email'] ?? '');
          await secureStorage.write(key: 'first_name', value: user['first_name'] ?? '');
          await secureStorage.write(key: 'last_name', value: user['last_name'] ?? '');
          await secureStorage.write(key: 'role', value: user['role'] ?? '');
          await secureStorage.write(key: 'profile_photo', value: user['profile_photo'] ?? '');
        }

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => FetchingLocationPage(
                email: widget.email,
                firstName: widget.firstName,
                lastName: widget.lastName,
                profilePhoto: '', // Or load from user['profile_photo']
              ),
            ),
          );
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ErrorPage(
              errorMessage: responseData?['error'] ?? 'OTP verification failed.',
              errorCode: 400,
            ),
          ),
        );
      }
    } catch (e) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ErrorPage(
            errorMessage: "Network error occurred: $e",
          ),
        ),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 100),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: Column(
            children: [
              const Text(
                'Verification Code',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                'Please enter the 4-digit code sent to:',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Text(
                widget.email,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // Dynamically calculate fieldWidth based on screen width
                    double fieldWidth = (constraints.maxWidth - 48) / 4; // 12 padding × 4 fields

                    return OtpTextField(
                      numberOfFields: 4,
                      borderColor: Colors.black,
                      focusedBorderColor: Colors.amber,
                      showFieldAsBox: true,
                      fieldWidth: fieldWidth.clamp(40.0, 60.0), // avoid too small or too big
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      textStyle: const TextStyle(fontSize: 18),
                      cursorColor: Color(0xFF04443C),
                      keyboardType: TextInputType.number,
                      onSubmit: handleOTPChange,
                    );
                  },
                ),
              ),

              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isButtonEnabled && !isLoading ? verifyOTPAndLogin : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE7B958),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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
}
