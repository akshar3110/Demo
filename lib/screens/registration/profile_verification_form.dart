import 'package:flutter/material.dart';
import '../../models/service_provider_registration_data.dart';
import '../../widgets/custom_form_field.dart';
import '../../widgets/progress_header.dart';
import 'skills_and_services_form.dart';

class ProfileVerificationForm extends StatefulWidget {
  final ServiceProviderRegistrationData registrationData;

  const ProfileVerificationForm({Key? key, required this.registrationData}) : super(key: key);

  @override
  State<ProfileVerificationForm> createState() => _ProfileVerificationFormState();
}

class _ProfileVerificationFormState extends State<ProfileVerificationForm> {
  late TextEditingController _pincodeController;
  late TextEditingController _aadharController;
  late TextEditingController _panController;

  @override
  void initState() {
    super.initState();
    _pincodeController = TextEditingController(text: widget.registrationData.serviceablePincode);
    _aadharController = TextEditingController(text: widget.registrationData.aadharNumber);
    _panController = TextEditingController(text: widget.registrationData.panNumber);
  }

  @override
  void dispose() {
    _pincodeController.dispose();
    _aadharController.dispose();
    _panController.dispose();
    super.dispose();
  }

  void _saveAndContinue() {
    widget.registrationData.serviceablePincode = _pincodeController.text;
    widget.registrationData.aadharNumber = _aadharController.text;
    widget.registrationData.panNumber = _panController.text;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SkillsAndServicesForm(
          registrationData: widget.registrationData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(30),
        child: SizedBox(
          width: double.infinity,
          height: 45,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFE7B958),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: _saveAndContinue,
            child: Text(
              'Continue',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Fredoka',
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              ProgressHeader(
                message: "Few more steps to see your earnings !",
                progressWidth: 60,
              ),
              SizedBox(height: 30),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Profile Verification',
                        style: TextStyle(
                          fontFamily: 'Fredoka',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildFileUploadButton(
                      'Capture Profile Photo',
                      Icons.insert_drive_file_outlined,
                      () {
                        // TODO: Implement profile photo capture
                      },
                    ),
                    SizedBox(height: 15),
                    CustomFormField(
                      controller: _pincodeController,
                      hintText: 'Enter Serviceable Pincode',
                      keyboardType: TextInputType.number,
                      isRequired: true,
                    ),
                    SizedBox(height: 15),
                    CustomFormField(
                      controller: _aadharController,
                      hintText: 'Enter Aadhar Number',
                      keyboardType: TextInputType.number,
                      isRequired: true,
                    ),
                    SizedBox(height: 15),
                    _buildFileUploadButton(
                      'Select File',
                      Icons.insert_drive_file_outlined,
                      () {
                        // TODO: Implement aadhar document upload
                      },
                    ),
                    SizedBox(height: 15),
                    CustomFormField(
                      controller: _panController,
                      hintText: 'Enter PAN Number',
                      keyboardType: TextInputType.text,
                      isRequired: true,
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFileUploadButton(String text, IconData icon, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFF8F9FA),
        elevation: 0,
        minimumSize: Size.fromHeight(100),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(7)),
          side: BorderSide(color: Color(0xFFCDD4DA)),
        ),
        padding: EdgeInsets.all(0),
        alignment: Alignment.topCenter,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            width: double.infinity,
            alignment: Alignment.topRight,
            child: Text('*', style: TextStyle(color: Colors.red)),
          ),
          Icon(icon, color: Colors.grey, size: 24),
          Text(
            text,
            style: TextStyle(fontFamily: 'SansSerif', color: Colors.grey),
          ),
        ],
      ),
    );
  }
}