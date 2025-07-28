// lib/widgets/switch_role_widget.dart
import 'package:flutter/material.dart';
import 'package:servxpert_frontend/auth/auth_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:servxpert_frontend/service_provider/service_providers_home_screen.dart';
import 'package:servxpert_frontend/userApp/Customers_home_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:servxpert_frontend/profileApp/registration_form.dart';
import 'package:servxpert_frontend/services/account_status_service.dart';

class SwitchRoleWidget extends StatefulWidget {
  final String currentRole;
  final VoidCallback? onRoleSwitched;

  const SwitchRoleWidget({
    super.key,
    required this.currentRole,
    this.onRoleSwitched,
  });

  @override
  State<SwitchRoleWidget> createState() => _SwitchRoleWidgetState();
}

class _SwitchRoleWidgetState extends State<SwitchRoleWidget> {
  bool _isLoading = false;
  final _secureStorage = const FlutterSecureStorage();

  Future<void> _switchRole() async {
    setState(() {
      _isLoading = true;
    });

    try {
      bool success = false;
      
      if (widget.currentRole == 'Customer') {
        success = await AccountStatusService.switchToServiceProviderWithFlow(context);
      } else if (widget.currentRole == 'ServiceProvider') {
        success = await AccountStatusService.switchToCustomerWithFlow(context);
      }

      if (success) {
        // Call the callback to refresh the UI
        widget.onRoleSwitched?.call();
      }
    } catch (e) {
      print('Switch role error: $e');
      Fluttertoast.showToast(
        msg: 'An error occurred while switching roles.',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFCDD4DA),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: _isLoading
            ? const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
            ),
          ),
        )
            : GestureDetector(
          onTap: _switchRole,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.currentRole == 'Customer'
                      ? Icons.work
                      : Icons.person,
                  color: Colors.grey[700],
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  widget.currentRole == 'Customer'
                      ? "Switch to Service Provider"
                      : "Switch to Customer",
                  style: const TextStyle(
                    fontFamily: 'Fredoka',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}