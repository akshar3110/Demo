import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/service_provider_registration_data.dart';
import '../service_provider/service_providers_home_screen.dart';

class RegistrationForm extends StatefulWidget {
  final ServiceProviderRegistrationData registrationData;
  const RegistrationForm({Key? key, required this.registrationData}) : super(key: key);

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _dobController = TextEditingController();
  
  String selectedGender = 'Male';

  @override
  void initState() {
    super.initState();
    // Pre-populate fields if data exists
    _firstNameController.text = widget.registrationData.firstName ?? '';
    _middleNameController.text = widget.registrationData.middleName ?? '';
    _lastNameController.text = widget.registrationData.lastName ?? '';
    _addressController.text = widget.registrationData.address ?? '';
    _phoneController.text = widget.registrationData.phoneNumber ?? '';
    _emailController.text = widget.registrationData.email ?? '';
    _dobController.text = widget.registrationData.dateOfBirth ?? '';
    selectedGender = widget.registrationData.gender ?? 'Male';
  }

  void _saveFormData() {
    widget.registrationData.firstName = _firstNameController.text;
    widget.registrationData.middleName = _middleNameController.text;
    widget.registrationData.lastName = _lastNameController.text;
    widget.registrationData.address = _addressController.text;
    widget.registrationData.phoneNumber = _phoneController.text;
    widget.registrationData.email = _emailController.text;
    widget.registrationData.dateOfBirth = _dobController.text;
    widget.registrationData.gender = selectedGender;
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
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _saveFormData();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegistrationFormProfileVerification(
                      registrationData: widget.registrationData,
                    ),
                  ),
                );
              }
            },
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
          child: Form(
            key: _formKey,
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
                              Image.asset('assets/images/serve_xpert_x_logo.png',
                                  width: 50, height: 50),
                              Image.asset(
                                  'assets/images/serve_xpert_name_logo.png',
                                  width: 150),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            _buildRequiredTextField(
                              controller: _firstNameController,
                              hintText: 'First Name',
                              icon: Icons.person_3_outlined,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'First name is required';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10),
                            _buildTextField(
                              controller: _middleNameController,
                              hintText: 'Enter Middle Name',
                              icon: Icons.person_3_outlined,
                            ),
                            SizedBox(height: 10),
                            _buildRequiredTextField(
                              controller: _lastNameController,
                              hintText: 'Last Name',
                              icon: Icons.person_3_outlined,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Last name is required';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: _addressController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                hintText: 'Address',
                                hintStyle: TextStyle(color: Colors.grey),
                                contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                                isDense: true,
                              ),
                              style: TextStyle(fontFamily: 'Fredoka', fontSize: 14),
                              maxLines: 4,
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                              decoration: BoxDecoration(border: Border.all(color: Color(0xFFCDD4DA))),
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Select your gender', style: TextStyle(fontFamily: 'SansSerif', fontSize: 14)),
                                      Padding(padding: EdgeInsets.only(right: 8), child: Text('*',style: TextStyle(color: Colors.red)))
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      buildRadioButton('Male'),
                                      SizedBox(width: 10),
                                      buildRadioButton('Female'),
                                      SizedBox(width: 10),
                                      buildRadioButton('Other'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            _buildRequiredTextField(
                              controller: _phoneController,
                              hintText: '+91 84879 09673',
                              keyboardType: TextInputType.phone,
                              prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                child: Image.asset('assets/icons/india_flag.png', width: 24, height: 24, fit: BoxFit.contain),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Phone number is required';
                                }
                                if (value.length < 10) {
                                  return 'Please enter a valid phone number';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10),
                            _buildRequiredTextField(
                              controller: _emailController,
                              hintText: 'Email Address',
                              icon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email is required';
                                }
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10),
                            _buildRequiredTextField(
                              controller: _dobController,
                              hintText: 'Date of Birth (DD/MM/YYYY)',
                              icon: Icons.calendar_today_outlined,
                              keyboardType: TextInputType.datetime,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Date of birth is required';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    IconData? icon,
    Widget? prefixIcon,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
        border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
        prefixIcon: prefixIcon ?? (icon != null ? Icon(icon) : null),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(vertical: 3),
        isDense: true,
      ),
      style: TextStyle(fontFamily: 'SansSerif', fontSize: 14),
      keyboardType: keyboardType,
    );
  }

  Widget _buildRequiredTextField({
    required TextEditingController controller,
    required String hintText,
    IconData? icon,
    Widget? prefixIcon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Stack(
      children: [
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
            border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
            prefixIcon: prefixIcon ?? (icon != null ? Icon(icon) : null),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey),
            contentPadding: EdgeInsets.symmetric(vertical: 3),
            isDense: true,
          ),
          style: TextStyle(fontFamily: 'SansSerif', fontSize: 14),
          keyboardType: keyboardType,
          validator: validator,
        ),
        Positioned(top: 6, right: 8, child: Text('*', style: TextStyle(color: Colors.red))),
      ],
    );
  }

  Widget buildRadioButton(String value) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          activeColor: Color(0xFFE7B958),
          groupValue: selectedGender,
          onChanged: (val) {
            setState(() {
              selectedGender = val!;
            });
          },
          visualDensity: VisualDensity(horizontal: -4, vertical: -4),
        ),
        Text(value, style: TextStyle(fontFamily: 'SansSerif', fontSize: 12)),
      ],
    );
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
}

class RegistrationFormProfileVerification extends StatefulWidget {
  final ServiceProviderRegistrationData registrationData;
  const RegistrationFormProfileVerification({Key? key, required this.registrationData}) : super(key: key);

  @override
  State<RegistrationFormProfileVerification> createState() =>
      _RegistrationFormProfileVerificationState();
}

class _RegistrationFormProfileVerificationState extends State<RegistrationFormProfileVerification> {
  final _formKey = GlobalKey<FormState>();
  final _pincodeController = TextEditingController();
  final _aadharController = TextEditingController();
  final _panController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _pincodeController.text = widget.registrationData.serviceablePincode ?? '';
    _aadharController.text = widget.registrationData.aadharNumber ?? '';
    _panController.text = widget.registrationData.panNumber ?? '';
  }

  void _saveFormData() {
    widget.registrationData.serviceablePincode = _pincodeController.text;
    widget.registrationData.aadharNumber = _aadharController.text;
    widget.registrationData.panNumber = _panController.text;
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _saveFormData();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegistrationFormSkillsAndServices(
                      registrationData: widget.registrationData,
                    ),
                  ),
                );
              }
            },
            child: Text('Continue', style: TextStyle(fontSize: 18, fontFamily: 'Fredoka', color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20),
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 30,
                      color: Color(0xFFF4E9D1),
                    ),
                    Positioned(
                      left: 0,
                      child: Container(
                        width: 60,
                        height: 50,
                        color: Color(0xFFE7B958),
                      ),
                    ),
                    Container(
                      height: 30,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 20),
                      child: Text("Few more steps to see your earnings !", style: TextStyle(fontFamily: 'SansSerif', fontSize: 12, fontWeight: FontWeight.w500)),
                    )
                  ],
                ),
                SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text('Profile Verification', style: TextStyle(fontFamily: 'Fredoka', fontSize: 24, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Handle profile photo capture
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFF8F9FA),
                            elevation: 0,
                            minimumSize: Size.fromHeight(100),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7)), side: BorderSide(color: Color(0xFFCDD4DA))),
                            padding: EdgeInsets.all(0),
                            alignment: Alignment.topCenter),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                              width: double.infinity,
                              alignment: Alignment.topRight,
                              child: Text('*', style: TextStyle(color: Colors.red)),
                            ),
                            Icon(Icons.insert_drive_file_outlined, color: Colors.grey, size: 24),
                            Text('Capture Profile Photo', style: TextStyle(fontFamily: 'SansSerif',color: Colors.grey)),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      _buildRequiredTextField(
                        controller: _pincodeController,
                        hintText: 'Enter Serviceable Pincode',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Pincode is required';
                          }
                          if (value.length != 6) {
                            return 'Please enter a valid 6-digit pincode';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      _buildRequiredTextField(
                        controller: _aadharController,
                        hintText: 'Enter Aadhar Number',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Aadhar number is required';
                          }
                          if (value.length != 12) {
                            return 'Please enter a valid 12-digit Aadhar number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {
                          // Handle file selection
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFF8F9FA),
                            elevation: 0,
                            minimumSize: Size.fromHeight(100),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7)),side: BorderSide(color: Color(0xFFCDD4DA))),
                            padding: EdgeInsets.all(0),
                            alignment: Alignment.topCenter),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                              width: double.infinity,
                              alignment: Alignment.topRight,
                              child: Text('*', style: TextStyle(color: Colors.red)),
                            ),
                            Icon(Icons.insert_drive_file_outlined, color: Colors.grey, size: 24,),
                            Text('Select Aadhar File', style: TextStyle(fontFamily: 'SansSerif',color: Colors.grey)),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      _buildRequiredTextField(
                        controller: _panController,
                        hintText: 'Enter PAN Number',
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'PAN number is required';
                          }
                          if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(value.toUpperCase())) {
                            return 'Please enter a valid PAN number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRequiredTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Stack(
      children: [
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
            border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            isDense: true,
          ),
          style: TextStyle(fontFamily: 'SansSerif', fontSize: 14),
          keyboardType: keyboardType,
          validator: validator,
        ),
        Positioned(top: 6, right: 8, child: Text('*', style: TextStyle(color: Colors.red))),
      ],
    );
  }

  @override
  void dispose() {
    _pincodeController.dispose();
    _aadharController.dispose();
    _panController.dispose();
    super.dispose();
  }
}

class RegistrationFormSkillsAndServices extends StatefulWidget {
  final ServiceProviderRegistrationData registrationData;
  const RegistrationFormSkillsAndServices({Key? key, required this.registrationData}) : super(key: key);

  @override
  State<RegistrationFormSkillsAndServices> createState() =>
      _RegistrationFormSkillsAndServicesState();
}

class _RegistrationFormSkillsAndServicesState extends State<RegistrationFormSkillsAndServices> {
  final _formKey = GlobalKey<FormState>();
  final _experienceController = TextEditingController();
  String selectedService = '';
  List<String> services = ['Cleaning', 'Plumbing', 'Electrical', 'Painting'];

  @override
  void initState() {
    super.initState();
    selectedService = widget.registrationData.selectedService ?? '';
    _experienceController.text = widget.registrationData.yearsOfExperience?.toString() ?? '';
  }

  void _saveFormData() {
    widget.registrationData.selectedService = selectedService;
    widget.registrationData.yearsOfExperience = int.tryParse(_experienceController.text);
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate() && selectedService.isNotEmpty) {
                _saveFormData();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegistrationFormPreferredWorkLocation(
                      registrationData: widget.registrationData,
                    ),
                  ),
                );
              } else if (selectedService.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please select a service')),
                );
              }
            },
            child: Text('Continue', style: TextStyle(fontSize: 18, fontFamily: 'Fredoka', color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20),
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 30,
                      color: Color(0xFFF4E9D1),
                    ),
                    Positioned(
                      left: 0,
                      child: Container(
                        width: 130,
                        height: 50,
                        color: Color(0xFFE7B958),
                      ),
                    ),
                    Container(
                      height: 30,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 20),
                      child: Text("Set Up Your Services !", style: TextStyle(fontFamily: 'SansSerif', fontSize: 12, fontWeight: FontWeight.w700)),
                    )
                  ],
                ),
                SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text('Showcase Your Skills and Services !', style: TextStyle(fontFamily: 'Fredoka', fontSize: 24, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: 70),
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                            decoration: BoxDecoration(
                              color: Color(0xFFF0F0F0),
                              border: Border.all(color: Color(0xFFF0F0F0)),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              selectedService.isEmpty ? 'Select Service' : selectedService,
                              style: TextStyle(
                                color: selectedService.isEmpty ? Colors.grey : Colors.black,
                                fontFamily: 'SansSerif',
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Positioned(top: 6, right: 8, child: Text('*', style: TextStyle(color: Colors.red))),
                        ],
                      ),
                      SizedBox(height: 5),
                      ...services.asMap().entries.map((entry) {
                        int index = entry.key;
                        String service = entry.value;
                        return Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: 50,
                          color: index % 2 == 0 ? Color(0xFFF0F0F0) : Color(0xFFF6F6F6),
                          child: buildRadioButton(service),
                        );
                      }).toList(),
                      Container(
                        width: double.infinity,
                        height: 50,
                        color: Color(0xFFF6F6F6),
                        alignment: Alignment.center,
                        child: Text('You can select only one service', style: TextStyle(color: Colors.red, fontFamily: 'SansSerif')),
                      ),
                      SizedBox(height: 30),
                      Stack(
                        children: [
                          TextFormField(
                            controller: _experienceController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                              border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                              filled: true,
                              fillColor: Color(0xFFF7F7F7),
                              hintText: 'Years of experience',
                              hintStyle: TextStyle(color: Colors.grey),
                              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                              isDense: true,
                            ),
                            style: TextStyle(fontFamily: 'SansSerif', fontSize: 14),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Experience is required';
                              }
                              int? experience = int.tryParse(value);
                              if (experience == null || experience < 0) {
                                return 'Please enter a valid number';
                              }
                              return null;
                            },
                          ),
                          Positioned(top: 6, right: 8, child: Text('*', style: TextStyle(color: Colors.red))),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRadioButton(String value) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          activeColor: Color(0xFF6659D7),
          groupValue: selectedService,
          onChanged: (val) {
            setState(() {
              selectedService = val!;
            });
          },
          visualDensity: VisualDensity(horizontal: -4, vertical: -4),
        ),
        Text(value, style: TextStyle(fontFamily: 'SansSerif', fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600)),
      ],
    );
  }

  @override
  void dispose() {
    _experienceController.dispose();
    super.dispose();
  }
}

class RegistrationFormPreferredWorkLocation extends StatefulWidget {
  final ServiceProviderRegistrationData registrationData;
  const RegistrationFormPreferredWorkLocation({Key? key, required this.registrationData}) : super(key: key);

  @override
  State<RegistrationFormPreferredWorkLocation> createState() =>
      _RegistrationFormPreferredWorkLocationState();
}

class _RegistrationFormPreferredWorkLocationState extends State<RegistrationFormPreferredWorkLocation> {
  int selectedRadius = 0; // 0: 5km, 1: 10km, 2: 10km+
  bool agreedToTerms = false;

  @override
  void initState() {
    super.initState();
    agreedToTerms = widget.registrationData.agreedToTerms ?? false;
    // Set radius based on saved data
    double? savedRadius = widget.registrationData.serviceRadius;
    if (savedRadius != null) {
      if (savedRadius <= 5) selectedRadius = 0;
      else if (savedRadius <= 10) selectedRadius = 1;
      else selectedRadius = 2;
    }
  }

  void _saveFormData() {
    widget.registrationData.agreedToTerms = agreedToTerms;
    // Set radius based on selection
    switch (selectedRadius) {
      case 0: widget.registrationData.serviceRadius = 5.0; break;
      case 1: widget.registrationData.serviceRadius = 10.0; break;
      case 2: widget.registrationData.serviceRadius = 15.0; break;
    }
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            onPressed: () {
              if (agreedToTerms) {
                _saveFormData();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ServiceProvidersHomeScreen(),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please agree to the terms and conditions')),
                );
              }
            },
            child: Text('Continue', style: TextStyle(fontSize: 18, fontFamily: 'Fredoka', color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 30,
                    color: Color(0xFFF4E9D1),
                  ),
                  Positioned(
                    left: 0,
                    child: Container(
                      width: 270,
                      height: 50,
                      color: Color(0xFFE7B958),
                    ),
                  ),
                  Container(
                    height: 30,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20),
                    child: Text("Last step !", style: TextStyle(fontFamily: 'SansSerif', fontSize: 12, fontWeight: FontWeight.w700)),
                  )
                ],
              ),
              SizedBox(height: 30),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text('Search for the preferred work location in Ahmedabad !', style: TextStyle(fontFamily: 'Fredoka', fontSize: 22, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 70),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.all(0),
                      child: Text('Service location', style: TextStyle(fontFamily: 'SansSerif')),
                    ),
                    Container(
                        width: double.infinity,
                        height: 250,
                        padding: EdgeInsets.only(left: 30),
                        decoration: BoxDecoration(border: Border.all(color: Color(0xFFCDD4DA)), borderRadius: BorderRadius.all(Radius.circular(7))),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                              width: double.infinity,
                              alignment: Alignment.topRight,
                              child: Text('*', style: TextStyle(color: Colors.red)),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 220,
                                  child: Container(
                                    width: double.infinity,
                                    height: 170,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Color(0xFFCDD4DA)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: GoogleMap(
                                        initialCameraPosition: CameraPosition(
                                          target: LatLng(23.0225, 72.5714),
                                          zoom: 12,
                                        ),
                                        zoomControlsEnabled: false,
                                        myLocationButtonEnabled: false,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                SizedBox(
                                  height: 25,
                                  child: ToggleButtons(
                                    isSelected: [selectedRadius == 0],
                                    onPressed: (int index) {
                                      setState(() {
                                        selectedRadius = 0;
                                      });
                                    },
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.black,
                                    selectedColor: Colors.black,
                                    fillColor: Colors.white,
                                    selectedBorderColor: Colors.black,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                                        child: (Text('5km')),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.all(0),
                      child: Text('Set Service Radius', style: TextStyle(fontFamily: 'SansSerif')),
                    ),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(border: Border.all(color: Color(0xFFCDD4DA)), borderRadius: BorderRadius.all(Radius.circular(7))),
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              SizedBox(
                                height: 25,
                                child: ToggleButtons(
                                  isSelected: [selectedRadius == 0],
                                  onPressed: (int index) => setState(() => selectedRadius = 0),
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black,
                                  selectedColor: Colors.black,
                                  fillColor: Colors.white,
                                  selectedBorderColor: Colors.black,
                                  children: [
                                    Padding(padding: EdgeInsets.symmetric(horizontal: 15), child: Text('5km')),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10),
                              SizedBox(
                                height: 25,
                                child: ToggleButtons(
                                  isSelected: [selectedRadius == 1],
                                  onPressed: (int index) => setState(() => selectedRadius = 1),
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black,
                                  selectedColor: Colors.black,
                                  fillColor: Colors.white,
                                  selectedBorderColor: Colors.black,
                                  children: [
                                    Padding(padding: EdgeInsets.symmetric(horizontal: 15), child: Text('10km')),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10),
                              SizedBox(
                                height: 25,
                                child: ToggleButtons(
                                  isSelected: [selectedRadius == 2],
                                  onPressed: (int index) => setState(() => selectedRadius = 2),
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black,
                                  selectedColor: Colors.black,
                                  fillColor: Colors.white,
                                  selectedBorderColor: Colors.black,
                                  children: [
                                    Padding(padding: EdgeInsets.symmetric(horizontal: 15), child: Text('10km+')),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(top: 4, right: 8, child: Text('*', style: TextStyle(color: Colors.red))),
                      ],
                    ),
                    SizedBox(height: 70,),
                    Container(
                      margin: EdgeInsets.all(0),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Radio<bool>(
                            activeColor: Color(0xFFE7B958),
                            value: true,
                            groupValue: agreedToTerms,
                            onChanged: (value) {
                              setState(() {
                                agreedToTerms = value!;
                              });
                            },
                          ),
                          Expanded(
                            child: Wrap(
                              children: [
                                Text("I've read and agreed to ", style: TextStyle(fontFamily: 'SansSerif', fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey)),
                                GestureDetector(
                                  onTap: () {
                                    // Navigate to User Agreement
                                  },
                                  child: Text("User Agreement", style: TextStyle(fontFamily: 'SansSerif', fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF2E5432))),
                                ),
                                Text(" and ", style: TextStyle(fontFamily: 'SansSerif', fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black)),
                                GestureDetector(
                                  onTap: () {
                                    // Navigate to Privacy Policy
                                  },
                                  child: Text("Privacy Policy", style: TextStyle(fontFamily: 'SansSerif', fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF2E5432))),
                                ),
                              ],
                            ),
                          ),
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
}