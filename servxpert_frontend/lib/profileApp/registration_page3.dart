import 'package:flutter/material.dart';
import '../models/service_provider_registration_data.dart';
import 'registration_page4.dart';

class RegistrationPage3 extends StatefulWidget {
  final ServiceProviderRegistrationData registrationData;
  final String? jwtToken;
  const RegistrationPage3({Key? key, required this.registrationData, required this.jwtToken}) : super(key: key);

  @override
  State<RegistrationPage3> createState() => _RegistrationPage3State();
}

class _RegistrationPage3State extends State<RegistrationPage3> {
  String? selectedService;
  final _experienceController = TextEditingController();

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
  @override
  void initState() {
    super.initState();
    print('📌 JWT Token in RegistrationPage3: ${widget.jwtToken ?? "NULL"}');
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            onPressed: () {
              if (selectedService == null || _experienceController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please select a service and enter years of experience.')),
                );
                return;
              }
              widget.registrationData
                ..selectedService = selectedService
                ..yearsOfExperience = _experienceController.text;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RegistrationPage4(
                    registrationData: widget.registrationData,
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
                    child: Text(
                      "Set Up Your Services !",
                      style: TextStyle(fontFamily: 'SansSerif', fontSize: 12, fontWeight: FontWeight.w700),
                    ),
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
                      child: Text(
                        'Showcase Your Skills and Services !',
                        style: TextStyle(fontFamily: 'Fredoka', fontSize: 24, fontWeight: FontWeight.bold),
                      ),
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
                        ),
                        Positioned(top: 6, right: 8, child: Text('*', style: TextStyle(color: Colors.red))),
                      ],
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