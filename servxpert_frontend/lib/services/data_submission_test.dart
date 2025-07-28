// lib/services/data_submission_test.dart
import 'package:dio/dio.dart';
import 'package:servxpert_frontend/constant/api_constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DataSubmissionTest {
  static final Dio _dio = Dio();
  static const _secureStorage = FlutterSecureStorage();

  // Test minimal data submission
  static Future<Map<String, dynamic>?> testMinimalSubmission() async {
    try {
      final token = await _secureStorage.read(key: 'access_token');
      
      if (token == null) {
        print("❌ No access token found");
        return null;
      }

      final testData = {
        'first_name': 'Test',
        'last_name': 'User',
        'gender': 'Male',
        'date_of_birth': '1990-01-01',
        'phone': '1234567890',
        'email': 'test@example.com',
        'address': 'Test Address',
        'pincode': '123456',
        'aadhar_number': '123456789012',
        'pan_number': 'ABCDE1234F',
        'selected_service': 'Cleaning',
        'years_of_experience': '5',
        'latitude': '23.0225',
        'longitude': '72.5714',
        'service_radius': '10',
        'agreed_to_terms': 'true',
      };

      print("📤 Testing minimal data submission...");
      print("📤 Data: $testData");

      // Convert to FormData for multipart/form-data
      final formData = FormData.fromMap(testData);

      final response = await _dio.post(
        submitUrl,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
          validateStatus: (_) => true,
        ),
      );

      print("📥 Response status: ${response.statusCode}");
      print("📥 Response data: ${response.data}");

      // Handle different response types
      if (response.data is Map<String, dynamic>) {
        return response.data;
      } else if (response.data is String) {
        return {'error': response.data, 'status': response.statusCode};
      } else {
        return {'error': 'Unexpected response format', 'status': response.statusCode};
      }
    } catch (e) {
      print("❌ Minimal submission error: $e");
      return {'error': e.toString()};
    }
  }

  // Test comprehensive data submission
  static Future<Map<String, dynamic>?> testComprehensiveSubmission() async {
    try {
      final token = await _secureStorage.read(key: 'access_token');
      
      if (token == null) {
        print("❌ No access token found");
        return null;
      }

      final testData = {
        'first_name': 'John',
        'middle_name': 'Michael',
        'last_name': 'Doe',
        'gender': 'Male',
        'date_of_birth': '1985-06-15',
        'phone': '9876543210',
        'email': 'john.doe@example.com',
        'address': '123 Main Street, Downtown Area',
        'pincode': '380001',
        'aadhar_number': '1234567890123456',
        'pan_number': 'ABCDE1234F',
        'selected_service': 'Plumbing',
        'years_of_experience': '8',
        'latitude': '23.0225',
        'longitude': '72.5714',
        'service_radius': '15',
        'agreed_to_terms': 'true',
      };

      print("📤 Testing comprehensive data submission...");
      print("📤 Data: $testData");

      // Convert to FormData for multipart/form-data
      final formData = FormData.fromMap(testData);

      final response = await _dio.post(
        submitUrl,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
          validateStatus: (_) => true,
        ),
      );

      print("📥 Response status: ${response.statusCode}");
      print("📥 Response data: ${response.data}");

      // Handle different response types
      if (response.data is Map<String, dynamic>) {
        return response.data;
      } else if (response.data is String) {
        return {'error': response.data, 'status': response.statusCode};
      } else {
        return {'error': 'Unexpected response format', 'status': response.statusCode};
      }
    } catch (e) {
      print("❌ Comprehensive submission error: $e");
      return {'error': e.toString()};
    }
  }

  // Test file upload submission
  static Future<Map<String, dynamic>?> testFileUploadSubmission() async {
    try {
      final token = await _secureStorage.read(key: 'access_token');
      
      if (token == null) {
        print("❌ No access token found");
        return null;
      }

      final testData = {
        'first_name': 'Jane',
        'last_name': 'Smith',
        'gender': 'Female',
        'date_of_birth': '1992-03-20',
        'phone': '8765432109',
        'email': 'jane.smith@example.com',
        'address': '456 Oak Avenue, Suburban Area',
        'pincode': '380015',
        'aadhar_number': '9876543210987654',
        'pan_number': 'FGHIJ5678K',
        'selected_service': 'Electrical',
        'years_of_experience': '6',
        'latitude': '23.0225',
        'longitude': '72.5714',
        'service_radius': '12',
        'agreed_to_terms': 'true',
      };

      print("📤 Testing file upload submission...");
      print("📤 Data: $testData");

      // Convert to FormData for multipart/form-data
      final formData = FormData.fromMap(testData);

      final response = await _dio.post(
        submitUrl,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
          validateStatus: (_) => true,
        ),
      );

      print("📥 Response status: ${response.statusCode}");
      print("📥 Response data: ${response.data}");

      // Handle different response types
      if (response.data is Map<String, dynamic>) {
        return response.data;
      } else if (response.data is String) {
        return {'error': response.data, 'status': response.statusCode};
      } else {
        return {'error': 'Unexpected response format', 'status': response.statusCode};
      }
    } catch (e) {
      print("❌ File upload submission error: $e");
      return {'error': e.toString()};
    }
  }

  // Run all submission tests
  static Future<void> runAllSubmissionTests() async {
    print("🔍 Starting Data Submission Tests...");
    
    print("\n1️⃣ Testing Minimal Submission...");
    final minimalResult = await testMinimalSubmission();
    print("✅ Minimal test completed: ${minimalResult != null}");
    
    print("\n2️⃣ Testing Comprehensive Submission...");
    final comprehensiveResult = await testComprehensiveSubmission();
    print("✅ Comprehensive test completed: ${comprehensiveResult != null}");
    
    print("\n3️⃣ Testing File Upload Submission...");
    final fileUploadResult = await testFileUploadSubmission();
    print("✅ File upload test completed: ${fileUploadResult != null}");
    
    print("\n🔍 Data Submission Tests Complete!");
    
    // Summary
    print("\n📊 Test Results Summary:");
    print("Minimal Submission: ${minimalResult != null ? '✅ PASS' : '❌ FAIL'}");
    print("Comprehensive Submission: ${comprehensiveResult != null ? '✅ PASS' : '❌ FAIL'}");
    print("File Upload Submission: ${fileUploadResult != null ? '✅ PASS' : '❌ FAIL'}");
  }

  // Test specific field validation
  static Future<void> testFieldValidation() async {
    print("🔍 Testing Field Validation...");
    
    final testCases = [
      {
        'name': 'Missing Required Fields',
        'data': {
          'first_name': 'Test',
          'last_name': 'User',
        },
        'expected': '400 Bad Request'
      },
      {
        'name': 'Invalid Date Format',
        'data': {
          'first_name': 'Test',
          'last_name': 'User',
          'date_of_birth': 'invalid-date',
          'gender': 'Male',
          'phone': '1234567890',
          'email': 'test@example.com',
        },
        'expected': '400 Bad Request'
      },
      {
        'name': 'Invalid Phone Number',
        'data': {
          'first_name': 'Test',
          'last_name': 'User',
          'date_of_birth': '1990-01-01',
          'gender': 'Male',
          'phone': 'invalid-phone',
          'email': 'test@example.com',
        },
        'expected': '400 Bad Request'
      },
    ];

    for (final testCase in testCases) {
      print("\n🧪 Testing: ${testCase['name']}");
      
      try {
        final token = await _secureStorage.read(key: 'access_token');
        
        if (token == null) {
          print("❌ No access token found");
          continue;
        }

        // Convert to FormData for multipart/form-data
        final formData = FormData.fromMap(testCase['data']);

        final response = await _dio.post(
          submitUrl,
          data: formData,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'multipart/form-data',
            },
            validateStatus: (_) => true,
          ),
        );

        print("📥 Status: ${response.statusCode}");
        print("📥 Expected: ${testCase['expected']}");
        print("📥 Result: ${response.statusCode == 400 ? '✅ PASS' : '❌ FAIL'}");
      } catch (e) {
        print("❌ Error: $e");
      }
    }
  }
}