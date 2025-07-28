import 'dart:async';
import 'dart:io';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:servxpert_frontend/auth/auth_service.dart';
import 'package:servxpert_frontend/constant/api_constants.dart';
import 'package:servxpert_frontend/constant/colors.dart';
import 'package:servxpert_frontend/userApp/fetching_location.dart';
import 'package:servxpert_frontend/userApp/otp_page.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  bool isEmailValid = false;
  String errorMessage = "";
  String error = '';
  bool isLoading = false;
  bool isGoogleLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void validateEmail(String value) {
    final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");

    setState(() {
      if (value.isEmpty) {
        isEmailValid = false;
        errorMessage = "";
      } else if (emailRegex.hasMatch(value)) {
        isEmailValid = true;
        errorMessage = "";
      } else {
        isEmailValid = false;
        errorMessage = "Email is not valid";
      }
    });
  }

  Future<void> handleEmailOtp() async {
    final email = emailController.text.trim();
    setState(() => isLoading = true);

    try {
      final success = await sendOtp(email);

      if (success) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OTPVerificationScreen(
              email: email,
              firstName: '',
              lastName: '',
            ),
          ),
        );
      } else {
        Fluttertoast.showToast(msg: "Failed to send OTP");
      }
    } on SocketException catch (e) {
      Fluttertoast.showToast(
        msg: "Network error: Server Error.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
      );
      error = e.toString();
      print("SocketException: $e");
    } on TimeoutException catch (e) {
      Fluttertoast.showToast(msg: "Request timed out. Please try again.");
      error = e.toString();
      print("TimeoutException: $e");
    } on HttpException catch (e) {
      Fluttertoast.showToast(msg: "HTTP error: ${e.message}");
      error = e.toString();
      print("HttpException: $e");
    } on FormatException catch (e) {
      Fluttertoast.showToast(msg: "Data format error.");
      error = e.toString();
      print("FormatException: $e");
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went wrong: $e");
      error = e.toString();
      print("Unknown exception: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    setState(() => isGoogleLoading = true);
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        setState(() => isGoogleLoading = false);
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final response = await Dio().post(
        googleLoginUrl,
        data: jsonEncode({'id_token': googleAuth.idToken}),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final user = data['user'];
        await _secureStorage.write(key: 'access_token', value: data['access']);
        await _secureStorage.write(key: 'refresh_token', value: data['refresh']);
        await _secureStorage.write(key: 'email', value: user['email'] ?? '');
        await _secureStorage.write(key: 'first_name', value: user['name']?.split(' ')?.first ?? '');
        await _secureStorage.write(key: 'last_name', value: user['name']?.split(' ')?.skip(1).join(' ') ?? '');
        await _secureStorage.write(key: 'profile_photo', value: user['profile_photo'] ?? '');

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => FetchingLocationPage(
              email: user['email'] ?? '',
              firstName: user['name']?.split(' ')?.first ?? '',
              lastName: user['name']?.split(' ')?.skip(1).join(' ') ?? '',
              profilePhoto: user['profile_photo'] ?? '',
            ),
          ),
        );
      } else {
        Fluttertoast.showToast(msg: "Google login failed.");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Google Sign-In failed: $e");
    } finally {
      setState(() => isGoogleLoading = false);
    }
  }


  @override
  Widget build(BuildContext context) {
    final email = emailController.text;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 125),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Branding
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFE7B958),
                          Color(0xFFBB9648),
                          Color(0xFF757441),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'X',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          fontFamily: "DeRotterDam",
                          color: AppColors.secondary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'serveXpert',
                    style: TextStyle(
                      fontSize: 35,
                      fontFamily: "DeRotterdam",
                      color: AppColors.secondary,
                    ),
                  ),
                ],
              ),

              // Tagline
              Center(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Text(
                        'Expert Services On Your Fingertips',
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'MPlus',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        'Quick • Affordable • Trusted',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'MPlus',
                          fontSize: 12,
                          color: AppColors.lightgrey_text,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Email field
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 25, right: 25),
                child: TextField(
                  controller: emailController,
                  onChanged: validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  autofocus: true,
                  cursorColor: AppColors.lightgrey_text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined, color: AppColors.lightgrey_text),
                    hintText: "Enter Email Address",
                    hintStyle: TextStyle(
                      fontFamily: 'SansSerif',
                      color: AppColors.lightgrey_text,
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),

              if (errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 2, left: 30),
                  child: Text(
                    errorMessage,
                    style: const TextStyle(
                      fontFamily: 'SansSerif',
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ),

              // Get OTP Button
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
                child: SizedBox(
                  width: double.infinity,
                  height: 42,
                  child: ElevatedButton(
                    onPressed: isEmailValid && !isLoading ? handleEmailOtp : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isEmailValid ? const Color(0xFFDAA520) : Colors.grey[300],
                      foregroundColor: isEmailValid ? Colors.white : Colors.black54,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                        : const Text("Get Verification Code", style: TextStyle(fontSize: 16)),
                  ),
                ),
              ),

              // Divider
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text("OR"),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
              ),

              // Google Sign-In Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: SizedBox(
                  width: double.infinity,
                  height: 42,
                  child: OutlinedButton.icon(
                    onPressed: isGoogleLoading ? null : () => signInWithGoogle(context),
                    icon: isGoogleLoading
                        ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                        : Image.asset(
                      'assets/google_icon.png',
                      height: 24,
                      width: 24,
                    ),
                    label: Text(
                      isGoogleLoading ? "Signing in..." : "Sign in with Google",
                      style: const TextStyle(fontSize: 16),
                    ),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      side: const BorderSide(color: Colors.black54),
                      foregroundColor: Colors.black87,
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