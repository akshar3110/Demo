import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:servxpert_frontend/constant/colors.dart';


class ProfileInfo extends StatefulWidget {
  final String initialName;
  final String email;
  final String phoneNumber;

  const ProfileInfo({
    super.key,
    required this.initialName,
    required this.email,
    required this.phoneNumber,
  });

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _phoneController = TextEditingController(text: widget.phoneNumber);
  }

  void _saveDetails() {
    if (_formKey.currentState!.validate()) {
      final updatedName = _nameController.text.trim();
      final updatedPhone = _phoneController.text.trim();

      print("Updated Name: $updatedName");
      print("Updated Phone: $updatedPhone");

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 60,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.close, color: Colors.black, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(width: 8),
            const Text(
              'Edit Profile',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Fredoka',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/icons/user icon.png',
                    width: 45,
                    height: 45,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        TextFormField(
                          controller: _nameController,
                          cursorColor: AppColors.lightgrey_text,
                          decoration: InputDecoration(
                            hintText: 'Full Name',
                            hintStyle: const TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: const Color(0xFFF7F7F7),
                            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Color(0xFFDBDBDB)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Color(0xFFDBDBDB)),
                            ),
                            suffixIcon: const Icon(Icons.edit, size: 16, color: Colors.grey),
                          ),
                          validator: (value) => value == null || value.trim().isEmpty ? 'Required' : null,
                          style: const TextStyle(fontFamily: 'SansSerif', fontSize: 14),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 8, right: 12),
                          child: Text('*', style: TextStyle(color: Colors.red, fontSize: 16)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  TextFormField(
                    initialValue: widget.email,
                    readOnly: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
                      hintText: "Email",
                      filled: true,
                      fillColor: const Color(0xFFF7F7F7),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: const Icon(Icons.lock_outline, size: 16, color: Colors.grey),
                    ),
                    style: const TextStyle(fontFamily: 'SansSerif', fontSize: 14, color: Colors.black87),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8, right: 12),
                    child: Text('*', style: TextStyle(color: Colors.red, fontSize: 16)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  IntlPhoneField(
                    controller: _phoneController,
                    initialCountryCode: 'IN',
                    showDropdownIcon: false,
                    decoration: InputDecoration(
                      hintText: "Mobile number",
                      filled: true,
                      fillColor: const Color(0xFFF7F7F7),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFFBDBDBD)),
                      ),
                      suffixIcon: const Icon(Icons.edit, size: 16, color: Colors.grey),
                    ),
                    dropdownIconPosition: IconPosition.trailing,
                    flagsButtonMargin: const EdgeInsets.only(left: 12, right: 8),
                    disableLengthCheck: true,
                    onChanged: (phone) {},
                    validator: (value) => value == null || value.number.isEmpty ? 'Phone number required' : null,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8, right: 12),
                    child: Text('*', style: TextStyle(color: Colors.red, fontSize: 16)),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveDetails,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE7B958),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text("Save Details", style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
