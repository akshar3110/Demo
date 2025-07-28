// lib/services/logout_service.dart
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:servxpert_frontend/constant/api_constants.dart';
import 'package:servxpert_frontend/userApp/login_page.dart';

class LogoutService {
  static const _secureStorage = FlutterSecureStorage();
  static final _googleSignIn = GoogleSignIn();
  static final _firebaseAuth = FirebaseAuth.instance;

  static Future<void> logout(BuildContext context) async {
    try {
      final refreshToken = await _secureStorage.read(key: 'refresh_token');

      if (refreshToken != null) {
        final response = await Dio().post(
          logoutUrl,
          data: {'refresh': refreshToken},
          options: Options(
            headers: {
              'Content-Type': 'application/json',
            },
          ),
        );

        print('Logout response: ${response.statusCode} - ${response.data}');

        if (response.statusCode == 200) {
          await _clearAllData();
          _navigateToLogin(context);

          Fluttertoast.showToast(
            msg: "Logged out successfully",
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
        } else {
          print('Logout failed with status: ${response.statusCode}');
          await _clearAllData();
          _navigateToLogin(context);

          Fluttertoast.showToast(
            msg: "Logged out (server logout failed)",
            backgroundColor: Colors.orange,
            textColor: Colors.white,
          );
        }
      } else {
        print('No refresh token found');
        await _clearAllData();
        _navigateToLogin(context);
      }
    } catch (e) {
      print('Logout error: $e');
      await _clearAllData();
      _navigateToLogin(context);

      Fluttertoast.showToast(
        msg: "Logged out (some data may not have been cleared from server)",
        backgroundColor: Colors.orange,
        textColor: Colors.white,
      );
    }
  }

  static Future<void> _clearAllData() async {
    // Clear all secure storage
    await _secureStorage.deleteAll();

    // Sign out from Google
    await _googleSignIn.signOut();

    // Sign out from Firebase
    await _firebaseAuth.signOut();

    print("✅ All data cleared from secure storage and services");
  }

  static void _navigateToLogin(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false,
    );
  }
}