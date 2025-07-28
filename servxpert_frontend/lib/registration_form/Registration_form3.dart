import 'package:flutter/material.dart';
import 'package:servxpert_frontend/models/api_service.dart';
import 'package:servxpert_frontend/models/service_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';



class RegistrationFormSkillsAndServices extends StatefulWidget {

  final String name;
  final String contactNo;
  final String address;
  final String gender;
  // final String email;
  final String dob;
  final String city;
  final String state;
  final String area;
  final String country;
  final String pincode;
  final String aadhar;
  final String pan;
  final String profilePhoto;
  final String aadharFile;
  final String jwtToken;
  const RegistrationFormSkillsAndServices({
    super.key,
    required this.name,
    required this.contactNo,
    required this.address,
    required this.gender,
    // required this.email,
    required this.dob,
    required this.area,
    required this.city,
    required this.state,
    required this.country,
    required this.pincode,
    required this.aadhar,
    required this.pan,
    required this.profilePhoto,
    required this.aadharFile,
    required this.jwtToken,

  });



  @override
  State<RegistrationFormSkillsAndServices> createState() =>
      _RegistrationFormSkillsAndServicesState();
}

class _RegistrationFormSkillsAndServicesState
    extends State<RegistrationFormSkillsAndServices> {

  List<ServiceModel> services = [];
  int? selectedServiceId;
  String? selectedServiceName;
  bool isLoading = true;



  final TextEditingController experienceController = TextEditingController();
  String selectedValue = '';// Initially empty to ensure validation works



  @override
  void dispose() {
    experienceController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadServices();
  }

  Future<void> loadServices() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken'); // ✅ Get token from local storage

      if (token != null) {
        List<ServiceModel> fetched = await fetchServices(token); // ✅ Pass token
        setState(() {
          services = fetched;      // ✅ Update your local service list
          isLoading = false;
        });
      } else {
        throw Exception('Token not found');
      }
    } catch (e) {
      print('Error fetching services: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  Widget buildRadioButton(String name, int id) {
    return Row(
      children: [
        Radio<int>(
          value: id,
          activeColor: const Color(0xFF6659D7),
          groupValue: selectedServiceId,
          onChanged: (val) {
            setState(() {
              selectedServiceId = val!;
              selectedServiceName = name; // optional, if you still need the name
              selectedValue = name;
            });
          },
          visualDensity: VisualDensity(horizontal: -4, vertical: -4),
        ),
        Text(name, style: const TextStyle(fontFamily: 'SansSerif', fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600)),
      ],
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            onPressed: () async {
              // if (selectedServiceId == null || experienceController.text.trim().isEmpty) {
              //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please complete all fields')));
              //   return;
              // }

              // Show loading spinner
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => Center(child: CircularProgressIndicator()),
              );

              try{
                final prefs = await SharedPreferences.getInstance();
                final token = widget.jwtToken;

                if (token == null) {
                  Navigator.of(context).pop(); // close loading dialog
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Token not found')));
                  return;
                }

                await submitServiceProviderForm(
                  fullName: widget.name,
                  dob: widget.dob,
                  contactNo: widget.contactNo,
                  address: widget.address,
                  gender: widget.gender,
                  area: widget.area,
                  city: widget.city,
                  state: widget.state,
                  country: widget.country,
                  pincode: widget.pincode,
                  aadharNumber: widget.aadhar,
                  panNumber: widget.pan,
                  aadharFile: File(widget.aadharFile),
                  profileImageFile: File(widget.profilePhoto),
                  selectedCategoryIDs: selectedServiceId != null  ? [selectedServiceId!] : [],
                  experience: experienceController.text.trim(),
                  jwtToken : widget.jwtToken,
                );

                Navigator.of(context).pop(); // Close loading dialog
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Success"),
                    content: const Text("Your form was submitted successfully."),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // close dialog
                          // Return true to indicate successful registration
                          Navigator.pop(context, true);
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                );
// Optionally go back or redirect

              }catch (e) {
                Navigator.of(context).pop(); // Close loading dialog
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                // Return false to indicate registration failed
                Navigator.pop(context, false);
              }

              // Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => RegistrationFormPreferredWorkLocation(
              //
              //     )));
            },
            child: Text(
              'Continue',
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Fredoka',
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
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
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Column(
                      children: services.map((service) {
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 50,
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F0F0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: buildRadioButton(service.title,service.id),
                        );
                      }).toList(),
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
                          controller: experienceController,
                          keyboardType: TextInputType.number,
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

}