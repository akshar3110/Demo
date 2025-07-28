import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:servxpert_frontend/registration_form/Registration_form2.dart';



class RegistrationForm extends StatefulWidget {
  final String jwtToken;
  const RegistrationForm({super.key, required this.jwtToken});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();


  String selectedValue = 'Male';
  String first = '';
  String last = '';

  // Date picker function
  Future<void> _selectDOB() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        dobController.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    contactController.dispose();
    genderController.dispose();
    addressController.dispose();
    emailController.dispose();
    dobController.dispose();
    areaController.dispose();
    cityController.dispose();
    stateController.dispose();
    countryController.dispose();
    pincodeController.dispose();
    super.dispose();
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
              if (firstNameController.text.trim().isEmpty ||
                  lastNameController.text.trim().isEmpty ||
                  contactController.text.trim().isEmpty ||
                  addressController.text.trim().isEmpty ||
                  //emailController.text.trim().isEmpty ||
                  dobController.text.trim().isEmpty ||
                  areaController.text.trim().isEmpty ||
                  cityController.text.trim().isEmpty ||
                  stateController.text.trim().isEmpty ||
                  countryController.text.trim().isEmpty ||
                  pincodeController.text.trim().isEmpty

              )
              {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill all required fields')),
                );
                return;
              }
              // ✅ Gender code mapping: "Male" => "M", "Female" => "F", "Other" => "O"
              String genderCode;
              if (selectedValue == 'Male') {
                genderCode = 'M';
              } else if (selectedValue == 'Female') {
                genderCode = 'F';
              } else {
                genderCode = 'O';
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegistrationFormProfileVerification(
                    name: nameController.text,
                    contactNo: contactController.text,
                    address: addressController.text,
                    gender: genderCode,
                    // email: emailController.text,
                    dob: dobController.text,
                    area: areaController.text,
                    city: cityController.text,
                    state: stateController.text,
                    country: countryController.text,
                    pincode: pincodeController.text,
                    jwtToken: widget.jwtToken,



                  ),
                ),
              );
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
                                'assets/serve_xpert_name_logo.png',
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

                          Stack(
                            children: [
                              TextField(
                                controller: firstNameController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                                ],
                                onChanged: (value) {
                                  nameController.text = "${firstNameController.text.trim()} ${lastNameController.text.trim()}";
                                },
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                  border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                  prefixIcon: Icon(Icons.person_3_outlined),
                                  hintText: 'Akshar',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  contentPadding: EdgeInsets.symmetric(vertical: 3),
                                  isDense: true,
                                ),
                                style: TextStyle(fontFamily: 'SansSerif', fontSize: 14),
                              ),
                              Positioned(top: 6, right: 8, child: Text('*', style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                          // SizedBox(height: 10),
                          // TextField(
                          //   decoration: InputDecoration(
                          //       enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                          //       border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                          //       focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                          //       prefixIcon: Icon(Icons.person_3_outlined),
                          //       hintText: 'Enter Middle Name',
                          //       hintStyle: TextStyle(color: Colors.grey),
                          //       contentPadding: EdgeInsets.symmetric(vertical: 3),
                          //       isDense: true
                          //   ),
                          //   style: TextStyle(fontFamily: 'SansSerif', fontSize: 14),
                          // ),
                          SizedBox(height: 10),
                          Stack(
                            children: [
                              TextField(
                                controller: lastNameController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                                ],
                                onChanged: (value) {
                                  nameController.text = "${firstNameController.text.trim()} ${lastNameController.text.trim()}";
                                },
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                  border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                  prefixIcon: Icon(Icons.person_3_outlined),
                                  hintText: 'Bhad',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  contentPadding: EdgeInsets.symmetric(vertical: 3),
                                  isDense: true,
                                ),
                                style: TextStyle(fontFamily: 'SansSerif', fontSize: 14),
                              ),
                              Positioned(top: 6, right: 8, child: Text('*', style: TextStyle(color: Colors.red))),
                            ],
                          ),

                          SizedBox(height: 10),
                          TextField(
                            controller: addressController,
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
                          Stack(
                            children: [
                              TextField(

                                controller: areaController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                  border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                  prefixIcon: Icon(Icons.home_filled),
                                  hintText: 'Area',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  contentPadding: EdgeInsets.symmetric(vertical: 3),
                                  isDense: true,
                                ),
                                style: TextStyle(fontFamily: 'SansSerif', fontSize: 14),
                              ),
                              Positioned(top: 6, right: 8, child: Text('*', style: TextStyle(color: Colors.red))),
                            ],
                          ),
                          SizedBox(height: 10),
                          Stack(
                            children: [
                              TextField(
                                controller: pincodeController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                maxLength: 6,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                  border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                  prefixIcon: Icon(Icons.location_on_outlined),
                                  hintText: 'Pincode',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  contentPadding: EdgeInsets.symmetric(vertical: 3),
                                  isDense: true,
                                ),

                                style: TextStyle(fontFamily: 'SansSerif', fontSize: 14),
                              ),
                              Positioned(top: 6, right: 8, child: Text('*', style: TextStyle(color: Colors.red))),
                            ],
                          ),
                          SizedBox(height: 10),
                          Stack(
                            children: [
                              TextField(
                                controller: cityController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                  border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                  prefixIcon: Icon(Icons.location_city),
                                  hintText: 'city',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  contentPadding: EdgeInsets.symmetric(vertical: 3),
                                  isDense: true,
                                ),
                                style: TextStyle(fontFamily: 'SansSerif', fontSize: 14),
                              ),
                              Positioned(top: 6, right: 8, child: Text('*', style: TextStyle(color: Colors.red))),
                            ],
                          ),
                          SizedBox(height: 10),
                          Stack(
                            children: [
                              TextField(
                                controller: stateController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                  border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                  prefixIcon: Icon(Icons.location_on_outlined),
                                  hintText: 'state',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  contentPadding: EdgeInsets.symmetric(vertical: 3),
                                  isDense: true,
                                ),
                                style: TextStyle(fontFamily: 'SansSerif', fontSize: 14),
                              ),
                              Positioned(top: 6, right: 8, child: Text('*', style: TextStyle(color: Colors.red))),
                            ],
                          ),
                          SizedBox(height: 10),
                          Stack(
                            children: [
                              TextField(
                                controller: countryController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                  border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                  prefixIcon: Icon(Icons.public),
                                  hintText: 'country',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  contentPadding: EdgeInsets.symmetric(vertical: 3),
                                  isDense: true,
                                ),
                                style: TextStyle(fontFamily: 'SansSerif', fontSize: 14),
                              ),
                              Positioned(top: 6, right: 8, child: Text('*', style: TextStyle(color: Colors.red))),
                            ],
                          ),

                          SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(left: 10, top:0, bottom:5 ),
                            decoration: BoxDecoration(border: Border.all(color: Color(0xFFCDD4DA))),
                            alignment: Alignment.topLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    buildRadioButton('Male'),
                                    SizedBox(width: 10),
                                    buildRadioButton('Female'),
                                    SizedBox(width: 10),
                                    buildRadioButton('Other'),
                                    Positioned(top: 6, right: 8, child: Text('', style: TextStyle(color: Colors.red))),
                                  ],

                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Stack(
                            children: [
                              TextField(
                                controller: contactController,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                maxLength: 10,

                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                  border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                  prefixIcon: Padding(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                    child: Image.asset('assets/india_flag.png', width: 24, height: 24, fit: BoxFit.contain),
                                  ),
                                  hintText: '+91 84879 09673',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  contentPadding: EdgeInsets.symmetric(vertical: 3),
                                  isDense: true,
                                ),
                                style: TextStyle(fontFamily: 'SansSerif', fontSize: 14),
                                keyboardType: TextInputType.phone,
                              ),
                              Positioned(top: 6, right: 8, child: Text('*', style: TextStyle(color: Colors.red))),
                            ],
                          ),
                          // SizedBox(height: 10),
                          // Stack(
                          //   children: [
                          //     TextField(
                          //       controller: emailController,
                          //       decoration: InputDecoration(
                          //         enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                          //         border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                          //         focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                          //         prefixIcon: Icon(Icons.email_outlined),
                          //         hintText: 'aksharbhad123@gmail.com',
                          //         hintStyle: TextStyle(color: Colors.grey),
                          //         contentPadding: EdgeInsets.symmetric(vertical: 3),
                          //         isDense: true,
                          //       ),
                          //       style: TextStyle(fontFamily: 'SansSerif', fontSize: 14),
                          //       keyboardType: TextInputType.emailAddress,
                          //     ),
                          //     Positioned(top: 6, right: 8, child: Text('*', style: TextStyle(color: Colors.red))),
                          //   ],
                          // ),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: _selectDOB, // Function to open date picker
                            child: AbsorbPointer(
                              child: Stack(
                                children: [
                                  TextField(
                                    controller: dobController,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                      border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                      prefixIcon: Icon(Icons.calendar_today_outlined),
                                      hintText: '31/10/2001',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      contentPadding: EdgeInsets.symmetric(vertical: 3),
                                      isDense: true,
                                    ),
                                    style: TextStyle(fontFamily: 'SansSerif', fontSize: 14),
                                  ),
                                  Positioned(top: 6, right: 8, child: Text('*', style: TextStyle(color: Colors.red))),
                                ],
                              ),
                            ),
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
    );
  }
  Widget buildRadioButton(String value) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          activeColor: Color(0xFFE7B958),
          groupValue: selectedValue,
          onChanged: (val) {
            setState(() {
              selectedValue = val!;
            });
          },
          visualDensity: VisualDensity(horizontal: -4, vertical: -4),
        ),
        Text(value, style: TextStyle(fontFamily: 'SansSerif', fontSize: 12)),
      ],
    );
  }
}