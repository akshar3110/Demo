import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/service_provider_registration_data.dart';
import 'registration_page3.dart';

class RegistrationPage2 extends StatefulWidget {
  final ServiceProviderRegistrationData registrationData;
  final String? jwtToken;

  const RegistrationPage2({Key? key, required this.registrationData, required this.jwtToken}) : super(key: key);

  @override
  State<RegistrationPage2> createState() => _RegistrationPage2State();
}

class _RegistrationPage2State extends State<RegistrationPage2> {
  final _formKey = GlobalKey<FormState>();
  final _pincodeController = TextEditingController();
  final _aadharController = TextEditingController();
  final _panController = TextEditingController();

  File? _profilePhoto;
  File? _documentPhoto;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickAndSetImage({required bool isProfile}) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null && pickedFile.path.isNotEmpty) {
        final File image = File(pickedFile.path);
        final bool exists = await image.exists();

        if (exists) {
          setState(() {
            if (isProfile) {
              _profilePhoto = image;
            } else {
              _documentPhoto = image;
            }
          });

          print('✅ Selected image path: ${image.path}');
        } else {
          print('⚠️ File does not exist at path: ${image.path}');
        }
      } else {
        print('⚠️ No image selected or path is empty.');
      }
    } catch (e) {
      print('❌ Error picking image: $e');
    }
  }



  @override
  void dispose() {
    _pincodeController.dispose();
    _aadharController.dispose();
    _panController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(30),
        child: SizedBox(
          width: double.infinity,
          height: 45,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE7B958),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),

            onPressed: () {
              if (_formKey.currentState!.validate() && _profilePhoto != null && _documentPhoto != null) {
                widget.registrationData
                  ..pincode = _pincodeController.text
                  ..aadharNumber = _aadharController.text
                  ..panNumber = _panController.text
                  ..profileImage = _profilePhoto // Optional: store the file in your data model
                  ..documentImage = _documentPhoto;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RegistrationPage3(
                      registrationData: widget.registrationData,
                      jwtToken: widget.jwtToken,
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please fill all fields and upload both images')),
                );
              }
            },
            child: const Text(
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
                const SizedBox(height: 20),
                _buildHeader(),
                const SizedBox(height: 30),
                _buildForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 30,
          color: const Color(0xFFF4E9D1),
        ),
        Positioned(
          left: 0,
          child: Container(
            width: 60,
            height: 50,
            color: const Color(0xFFE7B958),
          ),
        ),
        Container(
          height: 30,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20),
          child: const Text(
            "Few more steps to see your earnings!",
            style: TextStyle(fontFamily: 'SansSerif', fontSize: 12, fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }

  Widget _buildForm() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          const Text(
            'Profile Verification',
            style: TextStyle(fontFamily: 'Fredoka', fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Profile Image Picker
          _buildImageButton(
            label: 'Capture Profile Photo',
            isProfile: true,
            imageFile: _profilePhoto,
          ),
          const SizedBox(height: 15),

          // Pincode
          _buildTextField(_pincodeController, 'Enter Serviceable Pincode', TextInputType.number),

          const SizedBox(height: 15),

          // Aadhar
          _buildTextField(_aadharController, 'Enter Aadhar Number', TextInputType.number),

          const SizedBox(height: 15),

          // Document Image Picker
          _buildImageButton(
            label: 'Capture ID Document (Aadhar or PAN)',
            isProfile: false,
            imageFile: _documentPhoto,
          ),
          const SizedBox(height: 15),

          // PAN
          _buildTextField(_panController, 'Enter PAN Number', TextInputType.text),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, TextInputType keyboardType) {
    return Stack(
      children: [
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: const Color(0xFFF7F7F7),
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            isDense: true,
          ),
          keyboardType: keyboardType,
          validator: (value) => value == null || value.isEmpty ? 'Required' : null,
        ),
        const Positioned(top: 6, right: 8, child: Text('*', style: TextStyle(color: Colors.red))),
      ],
    );
  }

  Widget _buildImageButton({required String label, required bool isProfile, required File? imageFile}) {
    return GestureDetector(
      onTap: () => _pickAndSetImage(isProfile: isProfile),
      child: Container(
        width: double.infinity,
        height: 140,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFCDD4DA)),
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFFF8F9FA),
        ),
        child: imageFile != null
            ? ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(imageFile, fit: BoxFit.cover),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.insert_drive_file_outlined, color: Colors.grey),
            Text(label, style: const TextStyle(fontFamily: 'SansSerif', color: Colors.grey)),
            const Text('*', style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }

}
