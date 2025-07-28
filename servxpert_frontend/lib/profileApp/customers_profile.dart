import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:servxpert_frontend/models/service_provider_registration_data.dart';
import 'package:servxpert_frontend/profileApp/registration_form.dart';
import 'package:servxpert_frontend/profileApp/profile_info.dart';
import 'package:servxpert_frontend/profileApp/registration_page1.dart';
import 'package:servxpert_frontend/registration_form/Registration_form1.dart';
import 'package:servxpert_frontend/service_provider/service_providers_home_screen.dart';
import 'package:servxpert_frontend/auth/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:servxpert_frontend/userApp/login_page.dart';
import 'package:servxpert_frontend/widgets/bottom_navbar.dart';
import 'package:servxpert_frontend/services/logout_service.dart';
import 'package:servxpert_frontend/constant/api_constants.dart';
import 'package:servxpert_frontend/constant/colors.dart';
import 'package:servxpert_frontend/services/account_status_service.dart';
import 'package:servxpert_frontend/services/backend_check_service.dart';

class CustomerProfile extends StatefulWidget {
  final String email;
  final String area;
  final String city;
  final String? firstName;
  final String? lastName;

  const CustomerProfile({
    super.key,
    required this.email,
    required this.area,
    required this.city,
    this.firstName,
    this.lastName,
  });

  @override
  State<CustomerProfile> createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  bool _isLoading = false;
  late String? firstName;
  late String? lastName;

  @override
  void initState() {
    super.initState();
    firstName = widget.firstName;
    lastName = widget.lastName;
  }

  Future<String?> _getProfilePhoto() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('profile_photo');
  }

  // Enhanced switching function using AccountStatusService
  void _handleSwipe(BuildContext context) async {
    setState(() => _isLoading = true);
    
    try {
      // Use the new account status service for cleaner flow
      final success = await AccountStatusService.switchToServiceProviderWithFlow(context);
      
      if (!success) {
        // If switching failed, show appropriate message
        // The service already handles toast messages
        print("Account switching was not successful");
      }
    } catch (e) {
      print("❌ Error in account switching: $e");
      Fluttertoast.showToast(
        msg: "An error occurred while switching accounts. Please try again.",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // Debug function to test backend connectivity and data submission
  void _testBackendConnectivity() async {
    setState(() => _isLoading = true);
    
    try {
      print("🔍 Starting Backend Tests...");
      
      // Run backend diagnostics
      await BackendCheckService.runBackendDiagnostics();
      
      // Test data submission
      await BackendCheckService.testDataSubmission();
      
      Fluttertoast.showToast(
        msg: "Backend tests completed. Check console for results.",
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
      );
    } catch (e) {
      print("❌ Backend test error: $e");
      Fluttertoast.showToast(
        msg: "Backend test failed: $e",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }


  String getDisplayName() {
    return (firstName?.isNotEmpty == true || lastName?.isNotEmpty == true)
        ? '${firstName ?? ''} ${lastName ?? ''}'.trim()
        : 'Guest User';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(backgroundColor: AppColors.primary),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            const ProfileListSection(),
            _buildSwipeButton(),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: 3,
        email: widget.email,
        area: widget.area,
        city: widget.city,
        firstName: firstName ?? '',
        lastName: lastName ?? '',
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(left: 20, bottom: 20),
      child: Row(
        children: [
          FutureBuilder<String?>(
            future: _getProfilePhoto(),
            builder: (context, snapshot) {
              final profilePhoto = snapshot.data;
              if (profilePhoto != null && profilePhoto.isNotEmpty) {
                return CircleAvatar(
                  radius: 22.5,
                  backgroundImage: NetworkImage(profilePhoto),
                );
              } else {
                return const Icon(Icons.account_circle_outlined, size: 45);
              }
            },
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        getDisplayName(),
                        style: const TextStyle(
                          fontFamily: 'Fredoka',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: GestureDetector(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileInfo(
                                initialName: getDisplayName(),
                                email: widget.email,
                                phoneNumber: '',
                              ),
                            ),
                          );
                          if (result is Map<String, String>) {
                            setState(() {
                              firstName = result['firstName'];
                              lastName = result['lastName'];
                            });
                          }
                        },
                        child: const Icon(Icons.edit, size: 16),
                      ),
                    ),
                  ],
                ),
                Text(
                  widget.email,
                  style: const TextStyle(
                    fontFamily: 'Fredoka',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0x99999999),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSwipeButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFCDD4DA)),
          borderRadius: BorderRadius.circular(25),
        ),
        child: _isLoading
            ? const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Center(child: CircularProgressIndicator()),
        )
            : SwipeButton.expand(
          thumb: const Icon(Icons.arrow_forward, color: Colors.white),
          activeThumbColor: const Color(0xFFD3DBCE),
          activeTrackColor: const Color(0xFFEFF0F0),
          onSwipe: () => _handleSwipe(context),
          child: const Text(
            "Register as Service Provider",
            style: TextStyle(
              fontFamily: 'Fredoka',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileListSection extends StatelessWidget {
  const ProfileListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader("Personal Info"),
        _tile(context, Icons.person_2_outlined, 'Personal Data', () {}),
        _tile(context, Icons.calendar_month, 'My Bookings', () {}),
        _tile(context, Icons.credit_card_outlined, 'Complaints', () {}),
        _tile(context, Icons.shield_outlined, 'Account Security', () {}),
        _tile(context, Icons.bookmark_border, 'Bookmarks', () {}),
        _tile(context, Icons.home_outlined, 'Saved Address', () {}),
        _sectionHeader("General"),
        _tile(context, Icons.language, 'Language', () {}),
        _tile(context, Icons.delete_outline, 'Clear Cache', () {}),
        _sectionHeader("Debug"),
        _tile(context, Icons.bug_report, 'Test Backend', () {
          // Call the debug function from the parent widget
          if (context.findAncestorStateOfType<_CustomerProfileState>() != null) {
            (context.findAncestorStateOfType<_CustomerProfileState>() as _CustomerProfileState)._testBackendConnectivity();
          }
        }, color: Colors.orange),
        _sectionHeader("About"),
        _tile(context, Icons.help_outline, 'Help Center', () {}),
        const Divider(height: 10, thickness: 1),
        _tile(context, Icons.logout, 'Logout', () => LogoutService.logout(context), color: Colors.red),
      ],
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 20, 25, 10),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Fredoka',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget _tile(BuildContext context, IconData icon, String title, VoidCallback onTap, {Color? color}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 25),
      visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
      leading: Icon(icon, color: color ?? Colors.black87),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Fredoka',
          fontSize: 14,
          color: color ?? Colors.black87,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
      onTap: onTap,
    );
  }
}