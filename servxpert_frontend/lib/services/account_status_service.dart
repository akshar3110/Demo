// lib/services/account_status_service.dart
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:servxpert_frontend/auth/auth_service.dart';
import 'package:servxpert_frontend/service_provider/service_providers_home_screen.dart';
import 'package:servxpert_frontend/userApp/Customers_home_screen.dart';
import 'package:servxpert_frontend/registration_form/Registration_form1.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AccountStatusService {
  static const _secureStorage = FlutterSecureStorage();

  // Check if user can switch to service provider
  static Future<Map<String, dynamic>> checkServiceProviderEligibility() async {
    try {
      final result = await switchToServiceProvider();
      
      if (result != null && result['access'] != null) {
        // User is already a service provider, check verification status
        final statusResult = await checkServiceProviderStatus();
        
        if (statusResult != null && statusResult['is_verified'] == true) {
          return {
            'canSwitch': true,
            'needsRegistration': false,
            'isVerified': true,
            'message': 'Account verified and ready to switch'
          };
        } else if (statusResult != null && statusResult['is_verified'] == false) {
          return {
            'canSwitch': false,
            'needsRegistration': false,
            'isVerified': false,
            'message': 'Account is under approval. Please wait for verification.'
          };
        }
      }

      // User is not registered as service provider
      if (result != null &&
          result['error'] != null &&
          result['error'].toString().toLowerCase().contains('not registered')) {
        return {
          'canSwitch': false,
          'needsRegistration': true,
          'isVerified': false,
          'message': 'Registration required to become a service provider'
        };
      }

      return {
        'canSwitch': false,
        'needsRegistration': false,
        'isVerified': false,
        'message': result?['error'] ?? 'Unable to check service provider status'
      };
    } catch (e) {
      print("❌ Error checking service provider eligibility: $e");
      return {
        'canSwitch': false,
        'needsRegistration': false,
        'isVerified': false,
        'message': 'Error checking account status'
      };
    }
  }

  // Handle service provider registration flow using sequential forms
  static Future<bool> handleServiceProviderRegistration(BuildContext context) async {
    try {
      String accessToken = await _secureStorage.read(key: 'access_token') ?? '';
      
      // Navigate to the first registration form (Registration_form1)
      final registered = await Navigator.push<bool>(
        context,
        MaterialPageRoute(
          builder: (_) => RegistrationForm(jwtToken: accessToken),
        ),
      );

      if (registered == true) {
        // Check if account is immediately verified after registration
        final switchResult = await switchToServiceProvider();
        
        if (switchResult != null && switchResult['access'] != null) {
          final statusResult = await checkServiceProviderStatus();
          
          if (statusResult != null && statusResult['is_verified'] == true) {
            // Immediately verified
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => ServiceProvidersHomeScreen()),
            );
            Fluttertoast.showToast(
              msg: "Registration successful! Welcome to Service Provider.",
              backgroundColor: Colors.green,
              textColor: Colors.white,
            );
            return true;
          } else {
            // Needs approval
            Fluttertoast.showToast(
              msg: "Registration successful! Your account is pending approval. You'll be notified once verified.",
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              toastLength: Toast.LENGTH_LONG,
            );
            return false;
          }
        }
      }
      
      return false;
    } catch (e) {
      print("❌ Error in service provider registration: $e");
      Fluttertoast.showToast(
        msg: "An error occurred during registration",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return false;
    }
  }

  // Handle switching to service provider with complete flow
  static Future<bool> switchToServiceProviderWithFlow(BuildContext context) async {
    try {
      final eligibility = await checkServiceProviderEligibility();
      
      if (eligibility['canSwitch'] == true) {
        // Account is verified, switch immediately
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => ServiceProvidersHomeScreen()),
        );
        Fluttertoast.showToast(
          msg: "Successfully switched to Service Provider",
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        return true;
      } else if (eligibility['needsRegistration'] == true) {
        // Need to register first using sequential forms
        return await handleServiceProviderRegistration(context);
      } else {
        // Show appropriate message
        Fluttertoast.showToast(
          msg: eligibility['message'],
          backgroundColor: eligibility['isVerified'] == false ? Colors.orange : Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
        );
        return false;
      }
    } catch (e) {
      print("❌ Error in service provider switch flow: $e");
      Fluttertoast.showToast(
        msg: "An error occurred while switching accounts",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return false;
    }
  }

  // Handle switching to customer
  static Future<bool> switchToCustomerWithFlow(BuildContext context) async {
    try {
      final result = await switchToCustomer();
      
      if (result != null && result['access'] != null) {
        // Get user data for customer home screen
        final email = await _secureStorage.read(key: 'email') ?? '';
        final firstName = await _secureStorage.read(key: 'first_name') ?? '';
        final lastName = await _secureStorage.read(key: 'last_name') ?? '';
        final area = await _secureStorage.read(key: 'area') ?? '';
        final city = await _secureStorage.read(key: 'city') ?? '';

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => CustomersHomeScreen(
              email: email,
              area: area,
              city: city,
              firstName: firstName,
              lastName: lastName,
            ),
          ),
        );
        
        Fluttertoast.showToast(
          msg: "Successfully switched to Customer",
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        return true;
      } else {
        Fluttertoast.showToast(
          msg: "Failed to switch to customer account",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        return false;
      }
    } catch (e) {
      print("❌ Error switching to customer: $e");
      Fluttertoast.showToast(
        msg: "An error occurred while switching accounts",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return false;
    }
  }

  // Check if user can access service provider features
  static Future<bool> canAccessServiceProviderFeatures() async {
    try {
      final statusResult = await checkServiceProviderStatus();
      return statusResult != null && statusResult['is_verified'] == true;
    } catch (e) {
      print("❌ Error checking service provider access: $e");
      return false;
    }
  }
}