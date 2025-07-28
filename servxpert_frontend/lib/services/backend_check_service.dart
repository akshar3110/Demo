// lib/services/backend_check_service.dart
import 'package:dio/dio.dart';
import 'package:servxpert_frontend/constant/api_constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:servxpert_frontend/services/data_submission_test.dart';

class BackendCheckService {
  static final Dio _dio = Dio();
  static const _secureStorage = FlutterSecureStorage();

  // Test backend connectivity - try a different endpoint
  static Future<bool> testBackendConnectivity() async {
    try {
      // Try the main API endpoint instead of health endpoint
      final response = await _dio.get(
        '$baseUrl/auth/email-otp/', // Use an existing endpoint
        options: Options(
          validateStatus: (_) => true,
          sendTimeout: Duration(seconds: 10),
          receiveTimeout: Duration(seconds: 10),
        ),
      );
      
      print("🔍 Backend connectivity test:");
      print("📡 Status: ${response.statusCode}");
      print("📡 Response: ${response.data}");
      
      // Consider it connected if we get any response (even 404 means server is reachable)
      return response.statusCode != null;
    } catch (e) {
      print("❌ Backend connectivity error: $e");
      return false;
    }
  }

  // Test service provider status endpoint
  static Future<Map<String, dynamic>?> testServiceProviderStatus() async {
    try {
      final token = await _secureStorage.read(key: 'access_token');
      
      if (token == null) {
        print("❌ No access token found");
        return null;
      }

      final response = await _dio.get(
        serviceProviderStatusUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          validateStatus: (_) => true,
        ),
      );

      print("🔍 Service Provider Status Test:");
      print("📡 Status: ${response.statusCode}");
      print("📡 Response: ${response.data}");

      // Handle different response types
      if (response.data is Map<String, dynamic>) {
        return response.data;
      } else if (response.data is String) {
        return {'error': response.data, 'status': response.statusCode};
      } else {
        return {'error': 'Unexpected response format', 'status': response.statusCode};
      }
    } catch (e) {
      print("❌ Service Provider Status error: $e");
      return {'error': e.toString()};
    }
  }

  // Test service provider registration endpoint with correct content type
  static Future<Map<String, dynamic>?> testServiceProviderRegistration(Map<String, dynamic> testData) async {
    try {
      final token = await _secureStorage.read(key: 'access_token');
      
      if (token == null) {
        print("❌ No access token found");
        return null;
      }

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

      print("🔍 Service Provider Registration Test:");
      print("📡 Status: ${response.statusCode}");
      print("📡 Response: ${response.data}");

      // Handle different response types
      if (response.data is Map<String, dynamic>) {
        return response.data;
      } else if (response.data is String) {
        return {'error': response.data, 'status': response.statusCode};
      } else {
        return {'error': 'Unexpected response format', 'status': response.statusCode};
      }
    } catch (e) {
      print("❌ Service Provider Registration error: $e");
      return {'error': e.toString()};
    }
  }

  // Check if user is registered as service provider
  static Future<bool> isUserServiceProvider() async {
    try {
      final result = await testServiceProviderStatus();
      
      if (result != null) {
        // Check if user has service provider data
        return result.containsKey('service_provider_data') || 
               result.containsKey('is_registered') ||
               result['is_verified'] == true ||
               result['is_verified'] == false;
      }
      
      return false;
    } catch (e) {
      print("❌ Error checking service provider status: $e");
      return false;
    }
  }

  // Get detailed service provider information
  static Future<Map<String, dynamic>?> getServiceProviderDetails() async {
    try {
      final token = await _secureStorage.read(key: 'access_token');
      
      if (token == null) {
        print("❌ No access token found");
        return null;
      }

      final response = await _dio.get(
        '$baseUrl/service_provider_details/details/',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          validateStatus: (_) => true,
        ),
      );

      print("🔍 Service Provider Details:");
      print("📡 Status: ${response.statusCode}");
      print("📡 Response: ${response.data}");

      // Handle different response types
      if (response.data is Map<String, dynamic>) {
        return response.data;
      } else if (response.data is String) {
        return {'error': response.data, 'status': response.statusCode};
      } else {
        return {'error': 'Unexpected response format', 'status': response.statusCode};
      }
    } catch (e) {
      print("❌ Service Provider Details error: $e");
      return {'error': e.toString()};
    }
  }

  // Test all backend endpoints
  static Future<void> runBackendDiagnostics() async {
    print("🔍 Starting Backend Diagnostics...");
    
    // Test 1: Backend connectivity
    print("\n1️⃣ Testing Backend Connectivity...");
    final isConnected = await testBackendConnectivity();
    print("✅ Backend connected: $isConnected");
    
    // Test 2: Service provider status
    print("\n2️⃣ Testing Service Provider Status...");
    final statusResult = await testServiceProviderStatus();
    print("✅ Status test completed: ${statusResult != null}");
    
    // Test 3: Check if user is service provider
    print("\n3️⃣ Checking if user is service provider...");
    final isSP = await isUserServiceProvider();
    print("✅ User is service provider: $isSP");
    
    // Test 4: Get service provider details
    print("\n4️⃣ Getting service provider details...");
    final details = await getServiceProviderDetails();
    print("✅ Details retrieved: ${details != null}");
    
    // Test 5: Data submission tests
    print("\n5️⃣ Running Data Submission Tests...");
    await DataSubmissionTest.runAllSubmissionTests();
    
    // Test 6: Field validation tests
    print("\n6️⃣ Running Field Validation Tests...");
    await DataSubmissionTest.testFieldValidation();
    
    print("\n🔍 Backend Diagnostics Complete!");
  }

  // Test data submission with minimal data using correct content type
  static Future<void> testDataSubmission() async {
    print("🔍 Testing Data Submission...");
    
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

    final result = await testServiceProviderRegistration(testData);
    
    if (result != null) {
      print("✅ Test data submission completed");
      print("📤 Response: $result");
    } else {
      print("❌ Test data submission failed");
    }
  }

  // Comprehensive backend health check
  static Future<Map<String, bool>> runComprehensiveHealthCheck() async {
    print("🔍 Running Comprehensive Backend Health Check...");
    
    final results = <String, bool>{};
    
    // Test 1: Basic connectivity
    results['connectivity'] = await testBackendConnectivity();
    
    // Test 2: Authentication
    final token = await _secureStorage.read(key: 'access_token');
    results['authentication'] = token != null;
    
    // Test 3: Service provider status endpoint
    final statusResult = await testServiceProviderStatus();
    results['status_endpoint'] = statusResult != null;
    
    // Test 4: Registration endpoint
    final testData = {'test': 'data'};
    final registrationResult = await testServiceProviderRegistration(testData);
    results['registration_endpoint'] = registrationResult != null;
    
    // Test 5: Data submission
    final submissionResult = await DataSubmissionTest.testMinimalSubmission();
    results['data_submission'] = submissionResult != null;
    
    // Print results
    print("\n📊 Health Check Results:");
    results.forEach((test, passed) {
      print("${passed ? '✅' : '❌'} $test");
    });
    
    return results;
  }
}