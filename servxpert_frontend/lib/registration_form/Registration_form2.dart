import 'package:flutter/material.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:servxpert_frontend/registration_form/Registration_form3.dart';




class RegistrationFormProfileVerification extends StatefulWidget {
  final String name;
  final String contactNo;
  final String address;
  final String gender;
  // final String email;
  final String dob;
  final String area;
  final String city;
  final String state;
  final String country;
  final String pincode;
  final String jwtToken;


  const RegistrationFormProfileVerification({
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
    required this. jwtToken
  });

  @override
  State<RegistrationFormProfileVerification> createState() => _RegistrationFormProfileVerificationState();
}

class _RegistrationFormProfileVerificationState
    extends State<RegistrationFormProfileVerification> {


  final TextEditingController aadharController = TextEditingController();
  final TextEditingController panController = TextEditingController();

  String? profilePhotoPath; // simulate captured profile photo
  String? aadharFilePath;// simulate uploaded aadhar file

  File? _aadhaarFile;
  String? _aadhaarFileName;


  XFile? profilePhoto;

  Future<void> _capturePhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        profilePhoto = photo;
      });
    }
  }

  File? _profileImage;

  Future<void> _pickProfileImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }


  Future<void> _pickAadhaarFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _aadhaarFile = File(result.files.single.path!);
        _aadhaarFileName = result.files.single.name;
      });
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
              if (aadharController.text.isEmpty ||
                  panController.text.isEmpty ||
                  profilePhotoPath == null ||
                  aadharFilePath == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Please fill all required fields")),
                );
                return;
              }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegistrationFormSkillsAndServices(
                        name: widget.name,
                        contactNo: widget.contactNo,
                        address: widget.address,
                        gender: widget.gender,
                        // email: widget.email,
                        dob: widget.dob,
                        area: widget.area,
                        city: widget.city,
                        state: widget.state,
                        country: widget.country,
                        pincode: widget.pincode,
                        // pincode: pincodeController.text,
                        aadhar: aadharController.text,
                        pan: panController.text,
                        profilePhoto: profilePhotoPath!,
                        aadharFile: aadharFilePath!,
                        jwtToken: widget.jwtToken,

                      )));
            },
            child: Text('Continue',
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
                    SizedBox(
                      width: double.infinity,
                      child: Text('Name: ${widget.name}'),

                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
                            if (pickedImage != null) {
                              setState(() {
                                profilePhotoPath = pickedImage.path;
                              });
                            }
                          },
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
                              Icon(Icons.insert_drive_file_outlined, color: Colors.grey, size: 24),
                              Text(
                                'Capture Profile Photo',
                                style: TextStyle(fontFamily: 'SansSerif', color: Colors.grey),
                              ),
                            ],
                          ),
                        ),

                        // 👇 Show captured image preview here
                        if (profilePhotoPath != null)
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.file(
                              File(profilePhotoPath!),
                              fit: BoxFit.cover,
                            ),
                          ),
                      ],
                    ),


                    // SizedBox(height: 15),
                    // Stack(
                    //   children: [
                    //     TextField(
                    //       controller: pincodeController,
                    //       decoration: InputDecoration(
                    //         enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                    //         border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                    //         focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                    //         hintText: 'Enter Serviceable Pincode',
                    //         hintStyle: TextStyle(color: Colors.grey),
                    //         contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    //         isDense: true,
                    //       ),
                    //       style: TextStyle(fontFamily: 'SansSerif', fontSize: 14),
                    //       keyboardType: TextInputType.number,
                    //     ),
                    //     Positioned(top: 6, right: 8, child: Text('*', style: TextStyle(color: Colors.red))),
                    //   ],
                    // ),

                    SizedBox(height: 15),
                    Stack(
                      children: [
                        TextField(
                          controller: aadharController,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            FilePickerResult? result = await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
                            );
                            if (result != null && result.files.single.path != null) {
                              setState(() {
                                aadharFilePath = result.files.single.path!;
                              });
                            }
                          },
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
                              Icon(Icons.insert_drive_file_outlined, color: Colors.grey, size: 24),
                              Text('Select File', style: TextStyle(fontFamily: 'SansSerif', color: Colors.grey)),
                            ],
                          ),
                        ),

                        // 👇 Show selected file name here
                        if (aadharFilePath != null)
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Selected: ${aadharFilePath!.split('/').last}",
                              style: TextStyle(fontSize: 14, fontFamily: 'SansSerif'),
                            ),
                          ),
                      ],
                    ),


                    SizedBox(height: 15),
                    Stack(
                      children: [
                        TextField(
                          controller: panController,
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
