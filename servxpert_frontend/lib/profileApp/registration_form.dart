import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:servxpert_frontend/profileApp/registration_form.dart';
import 'package:servxpert_frontend/service_provider/service_providers_home_screen.dart';
import '../models/service_provider_registration_data.dart';

class RegistrationForm_1 extends StatefulWidget {
  final ServiceProviderRegistrationData registrationData;
  final String token;
  const RegistrationForm_1({Key? key, required this.registrationData, required this.token}) : super(key: key);

  @override
  State<RegistrationForm_1> createState() => _RegistrationFormState();
}



class _RegistrationFormState extends State<RegistrationForm_1> {
  String selectedValue = 'Male';
  String? gender;

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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegistrationFormProfileVerification(),
                  ));
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
                          Stack(
                            children: [
                              TextField(
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
                          SizedBox(height: 10),
                          TextField(
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                prefixIcon: Icon(Icons.person_3_outlined),
                                hintText: 'Enter Middle Name',
                                hintStyle: TextStyle(color: Colors.grey),
                                contentPadding: EdgeInsets.symmetric(vertical: 3),
                                isDense: true
                            ),
                            style: TextStyle(fontFamily: 'SansSerif', fontSize: 14),
                          ),
                          SizedBox(height: 10),
                          Stack(
                            children: [
                              TextField(
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
                                    Text('select your gender', style: TextStyle(fontFamily: 'SansSerif', fontSize: 14)),
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
                          Stack(
                            children: [
                              TextField(
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                  border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                  prefixIcon: Padding(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                    child: Image.asset('assets/icons/india_flag.png', width: 24, height: 24, fit: BoxFit.contain),
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
                          SizedBox(height: 10),
                          Stack(
                            children: [
                              TextField(
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                  border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                                  prefixIcon: Icon(Icons.email_outlined),
                                  hintText: 'aksharbhad123@gmail.com',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  contentPadding: EdgeInsets.symmetric(vertical: 3),
                                  isDense: true,
                                ),
                                style: TextStyle(fontFamily: 'SansSerif', fontSize: 14),
                                keyboardType: TextInputType.emailAddress,
                              ),
                              Positioned(top: 6, right: 8, child: Text('*', style: TextStyle(color: Colors.red))),
                            ],
                          ),
                          SizedBox(height: 10),
                          Stack(
                            children: [
                              TextField(
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
                                keyboardType: TextInputType.datetime,
                              ),
                              Positioned(top: 6, right: 8, child: Text('*', style: TextStyle(color: Colors.red))),
                            ],
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

class RegistrationFormProfileVerification extends StatefulWidget {
  const RegistrationFormProfileVerification({super.key});

  @override
  State<RegistrationFormProfileVerification> createState() =>
      _RegistrationFormProfileVerificationState();
}

class _RegistrationFormProfileVerificationState
    extends State<RegistrationFormProfileVerification> {
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationFormSkillsAndServices()));
            },
            child: Text('Continue', style: TextStyle(fontSize: 18, fontFamily: 'Fredoka', color: Colors.white, fontWeight: FontWeight.bold),
            ),
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
                      onPressed: () {},
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
                    Stack(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            hintText: 'Enter Serviceable Pincode',
                            hintStyle: TextStyle(color: Colors.grey),
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            isDense: true,
                          ),
                          style: TextStyle(fontFamily: 'SansSerif', fontSize: 14),
                          keyboardType: TextInputType.number,
                        ),
                        Positioned(top: 6, right: 8, child: Text('*', style: TextStyle(color: Colors.red))),
                      ],
                    ),

                    SizedBox(height: 15),
                    Stack(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            hintText: 'Enter Aadhar Number',
                            hintStyle: TextStyle(color: Colors.grey),
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            isDense: true,
                          ),
                          style: TextStyle(fontFamily: 'SansSerif', fontSize: 14),
                          keyboardType: TextInputType.number,
                        ),
                        Positioned(top: 6, right: 8, child: Text('*', style: TextStyle(color: Colors.red))),
                      ],
                    ),
                    SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {},
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
                          Text('Select File', style: TextStyle(fontFamily: 'SansSerif',color: Colors.grey)),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Stack(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            hintText: 'Enter PAN Number',
                            hintStyle: TextStyle(color: Colors.grey),
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            isDense: true,
                          ),
                          style: TextStyle(fontFamily: 'SansSerif', fontSize: 14),
                          keyboardType: TextInputType.text,
                        ),
                        Positioned(top: 6, right: 8, child: Text('*', style: TextStyle(color: Colors.red))),
                      ],
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
}

class RegistrationFormSkillsAndServices extends StatefulWidget {
  const RegistrationFormSkillsAndServices({super.key});

  @override
  State<RegistrationFormSkillsAndServices> createState() =>
      _RegistrationFormSkillsAndServicesState();
}

class _RegistrationFormSkillsAndServicesState
    extends State<RegistrationFormSkillsAndServices> {
  String selectedValue = 'Male';
  String? gender;

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
              Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationFormPreferredWorkLocation()));
            },
            child: Text('Continue', style: TextStyle(fontSize: 18, fontFamily: 'Fredoka', color: Colors.white, fontWeight: FontWeight.bold),
            ),
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
                        TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFF0F0F0))),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFF0F0F0))),
                            border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFF0F0F0))),
                            filled: true,
                            fillColor: Color(0xFFF0F0F0),
                            hintText: 'Select Service',
                            hintStyle: TextStyle(color: Colors.grey),
                            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                            isDense: true,
                          ),
                          style: TextStyle(fontFamily: 'SansSerif', fontSize: 14),
                        ),
                        Positioned(top: 6, right: 8, child: Text('*', style: TextStyle(color: Colors.red))),
                      ],
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 50,
                      color: Color(0xFFF0F0F0),
                      child: buildRadioButton('Cleaning'),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 50,
                      color: Color(0xFFF6F6F6),
                      child: buildRadioButton('Plumbing'),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 50,
                      color: Color(0xFFF0F0F0),
                      child: buildRadioButton('Electrical'),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 50,
                      color: Color(0xFFF6F6F6),
                      child: buildRadioButton('Painting'),
                    ),
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
                        TextField(
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
    );
  }

  Widget buildRadioButton(String value) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          activeColor: Color(0xFF6659D7),
          groupValue: selectedValue,
          onChanged: (val) {
            setState(() {
              selectedValue = val!;
            });
          },
          visualDensity: VisualDensity(horizontal: -4, vertical: -4),
        ),
        Text(value, style: TextStyle(fontFamily: 'SansSerif', fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class RegistrationFormPreferredWorkLocation extends StatefulWidget {
  const RegistrationFormPreferredWorkLocation({super.key});

  @override
  State<RegistrationFormPreferredWorkLocation> createState() =>
      _RegistrationFormPreferredWorkLocationState();
}

class _RegistrationFormPreferredWorkLocationState
    extends State<RegistrationFormPreferredWorkLocation> {

  String selectedValue = 'Agreement';
  int selectedToggle = 0;

  void selectToggle(int index) {
    setState(() {
      selectedToggle = index;
    });
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceProvidersHomeScreen(),));
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
                                    isSelected: [selectedToggle == 0],
                                    onPressed: (int index) {
                                      selectToggle(0);
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
                                  isSelected: [selectedToggle == 0],
                                  onPressed: (int index) => selectToggle(0),
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
                                  isSelected: [selectedToggle == 1],
                                  onPressed: (int index) => selectToggle(1),
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
                                  isSelected: [selectedToggle == 3],
                                  onPressed: (int index) => selectToggle(3),
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
                          Radio<String>(
                            activeColor: Color(0xFFE7B958),
                            value: '',
                            groupValue: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value!;
                              });
                            },
                          ),
                          Expanded(
                            child: Wrap(
                              children: [
                                Text("I've read and agreed to ", style: TextStyle(fontFamily: 'SansSerif', fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey)),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text("User Agreement", style: TextStyle(fontFamily: 'SansSerif', fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF2E5432))),
                                ),
                                Text(" and ", style: TextStyle(fontFamily: 'SansSerif', fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black)),
                                GestureDetector(
                                  onTap: () {},
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
