import 'package:flutter/material.dart';
import '../../models/service_provider_registration_data.dart';
import '../../widgets/custom_form_field.dart';
import '../../widgets/progress_header.dart';
import 'work_location_form.dart';

class SkillsAndServicesForm extends StatefulWidget {
  final ServiceProviderRegistrationData registrationData;

  const SkillsAndServicesForm({Key? key, required this.registrationData}) : super(key: key);

  @override
  State<SkillsAndServicesForm> createState() => _SkillsAndServicesFormState();
}

class _SkillsAndServicesFormState extends State<SkillsAndServicesForm> {
  late TextEditingController _experienceController;
  String _selectedService = '';
  final List<String> _services = ['Cleaning', 'Plumbing', 'Electrical', 'Painting'];

  @override
  void initState() {
    super.initState();
    _experienceController = TextEditingController(text: widget.registrationData.yearsOfExperience);
    _selectedService = widget.registrationData.selectedService ?? '';
  }

  @override
  void dispose() {
    _experienceController.dispose();
    super.dispose();
  }

  void _saveAndContinue() {
    widget.registrationData.selectedService = _selectedService;
    widget.registrationData.yearsOfExperience = _experienceController.text;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkLocationForm(
          registrationData: widget.registrationData,
        ),
      ),
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
              SizedBox(height: 20),
              ProgressHeader(
                message: "Set Up Your Services !",
                progressWidth: 130,
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
                        style: TextStyle(
                          fontFamily: 'Fredoka',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 70),
                    Stack(
                      children: [
                        TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFF0F0F0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFF0F0F0)),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFF0F0F0)),
                            ),
                            filled: true,
                            fillColor: Color(0xFFF0F0F0),
                            hintText: 'Select Service',
                            hintStyle: TextStyle(color: Colors.grey),
                            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                            isDense: true,
                          ),
                          style: TextStyle(fontFamily: 'SansSerif', fontSize: 14),
                        ),
                        Positioned(
                          top: 6,
                          right: 8,
                          child: Text('*', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    _buildServiceSelection(),
                    Container(
                      width: double.infinity,
                      height: 50,
                      color: Color(0xFFF6F6F6),
                      alignment: Alignment.center,
                      child: Text(
                        'You can select only one service',
                        style: TextStyle(color: Colors.red, fontFamily: 'SansSerif'),
                      ),
                    ),
                    SizedBox(height: 30),
                    CustomFormField(
                      controller: _experienceController,
                      hintText: 'Years of experience',
                      fillColor: Color(0xFFF7F7F7),
                      isRequired: true,
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

  Widget _buildServiceSelection() {
    return Column(
      children: _services.asMap().entries.map((entry) {
        int index = entry.key;
        String service = entry.value;
        Color backgroundColor = index % 2 == 0 ? Color(0xFFF0F0F0) : Color(0xFFF6F6F6);
        
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 50,
          color: backgroundColor,
          child: Row(
            children: [
              Radio<String>(
                value: service,
                activeColor: Color(0xFF6659D7),
                groupValue: _selectedService,
                onChanged: (value) {
                  setState(() {
                    _selectedService = value!;
                  });
                },
                visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              ),
              Text(
                service,
                style: TextStyle(
                  fontFamily: 'SansSerif',
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}