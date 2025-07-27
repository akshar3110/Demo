import 'package:flutter/material.dart';
import '../../models/service_provider_registration_data.dart';
import '../../widgets/custom_form_field.dart';
import 'profile_verification_form.dart';

class BasicInfoForm extends StatefulWidget {
  final ServiceProviderRegistrationData registrationData;

  const BasicInfoForm({Key? key, required this.registrationData}) : super(key: key);

  @override
  State<BasicInfoForm> createState() => _BasicInfoFormState();
}

class _BasicInfoFormState extends State<BasicInfoForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _middleNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _addressController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _dobController;
  
  String _selectedGender = 'Male';

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.registrationData.firstName ?? 'Akshar');
    _middleNameController = TextEditingController(text: widget.registrationData.middleName);
    _lastNameController = TextEditingController(text: widget.registrationData.lastName ?? 'Bhad');
    _addressController = TextEditingController(text: widget.registrationData.address);
    _phoneController = TextEditingController(text: widget.registrationData.phoneNumber ?? '+91 84879 09673');
    _emailController = TextEditingController(text: widget.registrationData.email ?? 'aksharbhad123@gmail.com');
    _dobController = TextEditingController(text: widget.registrationData.dateOfBirth ?? '31/10/2001');
    _selectedGender = widget.registrationData.gender ?? 'Male';
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  void _saveAndContinue() {
    widget.registrationData.firstName = _firstNameController.text;
    widget.registrationData.middleName = _middleNameController.text;
    widget.registrationData.lastName = _lastNameController.text;
    widget.registrationData.address = _addressController.text;
    widget.registrationData.gender = _selectedGender;
    widget.registrationData.phoneNumber = _phoneController.text;
    widget.registrationData.email = _emailController.text;
    widget.registrationData.dateOfBirth = _dobController.text;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileVerificationForm(
          registrationData: widget.registrationData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
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
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(30),
                      child: Center(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/serve_xpert_x_logo.png',
                              width: 50,
                              height: 50,
                            ),
                            Image.asset(
                              'assets/images/serve_xpert_name_logo.png',
                              width: 150,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          CustomFormField(
                            controller: _firstNameController,
                            hintText: 'First Name',
                            prefixIcon: Icons.person_3_outlined,
                            isRequired: true,
                          ),
                          SizedBox(height: 10),
                          CustomFormField(
                            controller: _middleNameController,
                            hintText: 'Enter Middle Name',
                            prefixIcon: Icons.person_3_outlined,
                          ),
                          SizedBox(height: 10),
                          CustomFormField(
                            controller: _lastNameController,
                            hintText: 'Last Name',
                            prefixIcon: Icons.person_3_outlined,
                            isRequired: true,
                          ),
                          SizedBox(height: 10),
                          CustomFormField(
                            controller: _addressController,
                            hintText: 'Address',
                            maxLines: 4,
                          ),
                          SizedBox(height: 10),
                          _buildGenderSelection(),
                          SizedBox(height: 10),
                          CustomFormField(
                            controller: _phoneController,
                            hintText: '+91 84879 09673',
                            prefixIconWidget: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              child: Image.asset(
                                'assets/icons/india_flag.png',
                                width: 24,
                                height: 24,
                                fit: BoxFit.contain,
                              ),
                            ),
                            keyboardType: TextInputType.phone,
                            isRequired: true,
                          ),
                          SizedBox(height: 10),
                          CustomFormField(
                            controller: _emailController,
                            hintText: 'aksharbhad123@gmail.com',
                            prefixIcon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            isRequired: true,
                          ),
                          SizedBox(height: 10),
                          CustomFormField(
                            controller: _dobController,
                            hintText: '31/10/2001',
                            prefixIcon: Icons.calendar_today_outlined,
                            keyboardType: TextInputType.datetime,
                            isRequired: true,
                          ),
                          SizedBox(height: 20),
                        ],
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

  Widget _buildGenderSelection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFCDD4DA)),
      ),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select your gender',
                style: TextStyle(fontFamily: 'SansSerif', fontSize: 14),
              ),
              Padding(
                padding: EdgeInsets.only(right: 8),
                child: Text('*', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              CustomRadioButton<String>(
                title: 'Male',
                value: 'Male',
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                },
              ),
              SizedBox(width: 10),
              CustomRadioButton<String>(
                title: 'Female',
                value: 'Female',
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                },
              ),
              SizedBox(width: 10),
              CustomRadioButton<String>(
                title: 'Other',
                value: 'Other',
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}