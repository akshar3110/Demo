// auth_service.dart
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:servxpert_frontend/constant/api_constants.dart';
import 'package:servxpert_frontend/network/dio_client.dart';
import 'package:servxpert_frontend/userApp/login_page.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();
final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

Future<bool> sendOtp(String email) async {
  final response = await dio.post(
    sendOtpUrl,
    data: {'email': email},
  );
  return response.statusCode == 200;
}

Future<Map<String, dynamic>?> verifyOtp(String email, String otp) async {
  try {
    final response = await dio.post(
      verifyOtpUrl,
      data: {'email': email, 'otp': otp},
    );

    if (response.statusCode == 200) {
      final data = response.data;

      final access = data['access'];
      final refresh = data['refresh'];

      if (access != null && refresh != null) {
        await _secureStorage.write(key: 'access_token', value: access);
        await _secureStorage.write(key: 'refresh_token', value: refresh);
        print("✅ Tokens saved to secure storage");
      }

      return data;
    } else {
      print("❌ OTP verify failed: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    print("❌ OTP verification error: $e");
    return null;
  }
}

// Check Service Provider Verification Status
Future<Map<String, dynamic>?> checkServiceProviderStatus() async {
  try {
    final accessToken = await _secureStorage.read(key: 'access_token');
    final refreshToken = await _secureStorage.read(key: 'refresh_token');

    if (refreshToken == null) {
      print("❌ No refresh token found");
      return {'error': 'Refresh token is missing'};
    }

    final response = await dio.get(
      serviceProviderStatusUrl,
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
          'Content-Type': 'application/json',
        },
        validateStatus: (_) => true,
      ),
    );

    print("📢 Service Provider Status: ${response.statusCode}");
    print("📢 Service Provider Status Response: ${response.data}");

    if (response.statusCode == 200) {
      return response.data;
    } else if (response.data is Map<String, dynamic>) {
      return response.data;
    } else {
      return {'error': 'Failed to check service provider status'};
    }
  } catch (e) {
    print("❌ Check Service Provider Status Exception: $e");
    return {'error': e.toString()};
  }
}

// Enhanced Switch to Service Provider with verification check
Future<Map<String, dynamic>?> switchToServiceProvider() async {
  try {
    final accessToken = await _secureStorage.read(key: 'access_token');
    final refreshToken = await _secureStorage.read(key: 'refresh_token');
    print("🔑 Refresh Token being sent: $refreshToken");

    if (refreshToken == null) {
      print("❌ No refresh token found");
      return {'error': 'Refresh token is missing'};
    }

    final response = await dio.post(
      switchToSPUrl,
      data: {
        "refresh": refreshToken, // 👈 Must match backend expectations
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
          'Content-Type': 'application/json',
        },
        validateStatus: (_) => true,
      ),
    );

    print("📢 switchToSP Status: ${response.statusCode}");
    print("📢 switchToSP Response: ${response.data}");

    if (response.statusCode == 200) {
      return response.data;
    } else if (response.data is Map<String, dynamic>) {
      return response.data;
    } else if (response.data is String) {
      try {
        return jsonDecode(response.data);
      } catch (e) {
        return {'error': 'Response format error: ${response.data}'};
      }
    } else {
      return {'error': 'Unexpected error occurred'};
    }
  } catch (e) {
    print("❌ Exception: $e");
    return {'error': e.toString()};
  }
}




// Switch to Customer
Future<Map<String, dynamic>?> switchToCustomer() async {
  try {
    final accessToken = await _secureStorage.read(key: 'access_token');
    final refreshToken = await _secureStorage.read(key: 'refresh_token');

    if (accessToken == null || refreshToken == null) {
      print("❌ No tokens found for switch to customer");
      return null;
    }

    final response = await dio.post(
      switchToCustomerUrl,
      data: {
        'refresh': refreshToken
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    print("�� Switch to Customer response: ${response.statusCode} - ${response.data}");

    if (response.statusCode == 200) {
      final data = response.data;

      // Update tokens in secure storage
      await _secureStorage.write(key: 'access_token', value: data['access']);
      await _secureStorage.write(key: 'refresh_token', value: data['refresh']);

      // Update user data if provided
      if (data.containsKey('user')) {
        final user = data['user'];
        await _secureStorage.write(key: 'email', value: user['email'] ?? '');
        await _secureStorage.write(key: 'first_name', value: user['first_name'] ?? '');
        await _secureStorage.write(key: 'last_name', value: user['last_name'] ?? '');
        await _secureStorage.write(key: 'profile_photo', value: user['profile_photo'] ?? '');
        await _secureStorage.write(key: 'role', value: 'Customer');
      }

      print("✅ Successfully switched to Customer");
      return data;
    } else {
      print("❌ Switch to Customer failed: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    print("❌ Switch to Customer error: $e");
    return null;
  }
}

// Updated logout function with Flutter Secure Storage
Future<void> logout(BuildContext context) async {
  try {
    final refreshToken = await _secureStorage.read(key: 'refresh_token');

    if (refreshToken != null) {
      final response = await dio.post(
        logoutUrl,
        data: {
          'refresh': refreshToken
        },
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
      );

      print("Logout response: ${response.statusCode} - ${response.data}");

      if (response.statusCode == 200) {
        // Clear ALL stored data from secure storage
        await _secureStorage.deleteAll();

        // Sign out from Google
        await _googleSignIn.signOut();
        await _firebaseAuth.signOut();

        // Navigate to login page and remove all previous routes
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
              (route) => false,
        );

        Fluttertoast.showToast(
          msg: "Logged out successfully",
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      }
    } else {
      // Even if no refresh token, clear data and navigate to login
      await _secureStorage.deleteAll();
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false,
      );
    }
  } catch (e) {
    print('Logout error: $e');

    // Even if logout fails, clear local data and navigate to login
    await _secureStorage.deleteAll();
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false,
    );

    Fluttertoast.showToast(
      msg: "Logged out (some data may not have been cleared from server)",
      backgroundColor: Colors.orange,
      textColor: Colors.white,
    );
  }
}

// Helper functions to read from secure storage
Future<String?> getAccessToken() async {
  final storage = FlutterSecureStorage();
  return await storage.read(key: 'access_token');
}

Future<Response> getProtectedData() async {
  final token = await getAccessToken();
  return await Dio().get(
    'http://your-backend-url/api/protected/',
    options: Options(
      headers: {'Authorization': 'Bearer $token'},
    ),
  );
}
Future<String?> getRefreshToken() async {
  return await _secureStorage.read(key: 'refresh_token');
}

Future<String?> getUserEmail() async {
  return await _secureStorage.read(key: 'email');
}

Future<String?> getUserFirstName() async {
  return await _secureStorage.read(key: 'first_name');
}

Future<String?> getUserLastName() async {
  return await _secureStorage.read(key: 'last_name');
}

Future<String?> getUserProfilePhoto() async {
  return await _secureStorage.read(key: 'profile_photo');
}

Future<String?> getUserRole() async {
  return await _secureStorage.read(key: 'role');
}