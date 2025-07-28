import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:io';

import 'package:servxpert_frontend/constant/api_constants.dart';
import '../models/service_provider_registration_data.dart';

class RegistrationPage4 extends StatefulWidget {
  final ServiceProviderRegistrationData registrationData;
  final String? jwtToken;

  const RegistrationPage4({
    Key? key,
    required this.registrationData,
    required this.jwtToken,
  }) : super(key: key);

  @override
  State<RegistrationPage4> createState() => _RegistrationPage4State();
}

class _RegistrationPage4State extends State<RegistrationPage4> {
  int _serviceRadius = 5;
  bool _agreed = false;
  bool _isSubmitting = false;
  double _latitude = 23.0225;
  double _longitude = 72.5714;

  Future<void> _submit() async {
    if (!_agreed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must agree to the terms and conditions.')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    widget.registrationData
      ..latitude = _latitude
      ..longitude = _longitude
      ..serviceRadius = _serviceRadius
      ..agreedToTerms = _agreed;

    try {
      final token = widget.jwtToken;
      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Authentication error: No token found.')),
        );
        setState(() => _isSubmitting = false);
        return;
      }

      final dio = Dio();

      final Map<String, dynamic> formMap = {
        'first_name': widget.registrationData.firstName,
        'last_name': widget.registrationData.lastName,
        'gender': widget.registrationData.gender,
        'date_of_birth': widget.registrationData.dob,
      };

      final path = widget.registrationData.profilePhotoPath;

      if (path != null && path.isNotEmpty) {
        final file = File(path);
        final exists = await file.exists();

        if (exists) {
          formMap['profile_pic_url'] = await MultipartFile.fromFile(
            path,
            filename: 'profile.jpg',
          );
        } else {
          debugPrint("⚠️ File path doesn't exist: $path");
        }
      }

      final formData = FormData.fromMap(formMap);

      final response = await dio.post(
        submitUrl,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful!')),
        );
        Navigator.popUntil(context, (route) => route.isFirst);
      } else if (response.statusCode == 400) {
        final error = response.data['error'] ?? 'Registration failed!';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.toString())),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration failed!')),
        );
      }
    } catch (e) {
      debugPrint("❌ Registration Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 30,
                    color: const Color(0xFFF4E9D1),
                  ),
                  Positioned(
                    left: 0,
                    child: Container(
                      width: 270,
                      height: 50,
                      color: const Color(0xFFE7B958),
                    ),
                  ),
                  Container(
                    height: 30,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20),
                    child: const Text(
                      "Last step !",
                      style: TextStyle(fontFamily: 'SansSerif', fontSize: 12, fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Search for the preferred work location in Ahmedabad !',
                      style: TextStyle(fontFamily: 'Fredoka', fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 70),
                    const Text('Set Service Radius', style: TextStyle(fontFamily: 'SansSerif')),
                    DropdownButton<int>(
                      value: _serviceRadius,
                      items: [5, 10, 15, 20]
                          .map((r) => DropdownMenuItem(value: r, child: Text('$r km')))
                          .toList(),
                      onChanged: (val) => setState(() => _serviceRadius = val!),
                    ),
                    const SizedBox(height: 20),
                    CheckboxListTile(
                      value: _agreed,
                      onChanged: (val) => setState(() => _agreed = val!),
                      title: const Text('I agree to the terms and conditions'),
                    ),
                    const SizedBox(height: 20),
                    _isSubmitting
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                      onPressed: _agreed ? _submit : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE7B958),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Fredoka',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
