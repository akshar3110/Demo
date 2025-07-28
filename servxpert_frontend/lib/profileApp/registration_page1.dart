import 'package:flutter/material.dart';
import '../models/service_provider_registration_data.dart';
import 'registration_page2.dart';
import 'package:intl/intl.dart';

class RegistrationPage1 extends StatefulWidget {
  final ServiceProviderRegistrationData registrationData;
  final String jwtToken;
  const RegistrationPage1({Key? key, required this.registrationData, required this.jwtToken}) : super(key: key);

  @override
  State<RegistrationPage1> createState() => _RegistrationPage1State();
}

class _RegistrationPage1State extends State<RegistrationPage1> {
  DateTime? _selectedDob;
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  final _formKey = GlobalKey<FormState>();
  String selectedGender = 'Male';

  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _dobController = TextEditingController();

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
  @override
  void initState() {
    super.initState();
    print('📌 JWT Token in RegistrationPage1: ${widget.jwtToken ?? "NULL"}');
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
                widget.registrationData
                  ..firstName = _firstNameController.text
                  ..middleName = _middleNameController.text
                  ..lastName = _lastNameController.text
                  ..address = _addressController.text
                  ..phone = _phoneController.text
                  ..email = _emailController.text
                  ..dob = _dobController.text
                  ..gender = selectedGender;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RegistrationPage2(
                      registrationData: widget.registrationData,
                      jwtToken: widget.jwtToken,
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
                              Image.asset('assets/images/Group 32.png', width: 50, height: 50),
                              Image.asset('assets/images/serveXpert.png', width: 150),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Stack(
                              children: [
                                TextFormField(
                                  controller: _firstNameController,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                    border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                    prefixIcon: Icon(Icons.person_3_outlined),
                                    hintText: 'First Name',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    contentPadding: EdgeInsets.symmetric(vertical: 3),
                                    isDense: true,
                                  ),
                                  style: TextStyle(fontFamily: 'SansSerif', fontSize: 14),
                                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                                ),
                                Positioned(top: 6, right: 8, child: Text('*', style: TextStyle(color: Colors.red))),
                              ],
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: _middleNameController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                prefixIcon: Icon(Icons.person_3_outlined),
                                hintText: 'Middle Name',
                                hintStyle: TextStyle(color: Colors.grey),
                                contentPadding: EdgeInsets.symmetric(vertical: 3),
                                isDense: true,
                              ),
                              style: TextStyle(fontFamily: 'SansSerif', fontSize: 14),
                            ),
                            SizedBox(height: 10),
                            Stack(
                              children: [
                                TextFormField(
                                  controller: _lastNameController,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                    border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                    prefixIcon: Icon(Icons.person_3_outlined),
                                    hintText: 'Last Name',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    contentPadding: EdgeInsets.symmetric(vertical: 3),
                                    isDense: true,
                                  ),
                                  style: TextStyle(fontFamily: 'SansSerif', fontSize: 14),
                                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                                ),
                                Positioned(top: 6, right: 8, child: Text('*', style: TextStyle(color: Colors.red))),
                              ],
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
                              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
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
                                      Padding(padding: EdgeInsets.only(right: 8), child: Text('*', style: TextStyle(color: Colors.red))),
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
                            Stack(
                              children: [
                                TextFormField(
                                  controller: _phoneController,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                    border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                      child: Icon(Icons.phone, size: 24, color: Colors.grey),
                                    ),
                                    hintText: 'Phone Number',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    contentPadding: EdgeInsets.symmetric(vertical: 3),
                                    isDense: true,
                                  ),
                                  style: TextStyle(fontFamily: 'SansSerif', fontSize: 14),
                                  keyboardType: TextInputType.phone,
                                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                                ),
                                Positioned(top: 6, right: 8, child: Text('*', style: TextStyle(color: Colors.red))),
                              ],
                            ),
                            SizedBox(height: 10),
                            Stack(
                              children: [
                                TextFormField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                    border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                    prefixIcon: Icon(Icons.email_outlined),
                                    hintText: 'Email',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    contentPadding: EdgeInsets.symmetric(vertical: 3),
                                    isDense: true,
                                  ),
                                  style: TextStyle(fontFamily: 'SansSerif', fontSize: 14),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                                ),
                                Positioned(top: 6, right: 8, child: Text('*', style: TextStyle(color: Colors.red))),
                              ],
                            ),

                            SizedBox(height: 10),
                            Stack(
                              children: [
                                TextFormField(
                                  controller: _dobController,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                    border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                    prefixIcon: Icon(Icons.calendar_today_outlined),
                                    hintText: 'Date of Birth (dd/MM/yyyy)',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    contentPadding: EdgeInsets.symmetric(vertical: 3),
                                    isDense: true,
                                  ),
                                  style: TextStyle(fontFamily: 'SansSerif', fontSize: 14),
                                  onTap: () async {
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    DateTime? picked = await showDatePicker(
                                      context: context,
                                      initialDate: _selectedDob ?? DateTime(2000, 1, 1),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now(),
                                    );
                                    if (picked != null) {
                                      setState(() {
                                        _selectedDob = picked;
                                        _dobController.text = _dateFormat.format(picked);
                                      });
                                    }
                                  },
                                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                                ),
                                Positioned(top: 6, right: 8, child: Text('*', style: TextStyle(color: Colors.red))),
                              ],
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
      ),
    );
  }
}