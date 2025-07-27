import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../models/service_provider_registration_data.dart';
import '../../widgets/progress_header.dart';

class WorkLocationForm extends StatefulWidget {
  final ServiceProviderRegistrationData registrationData;

  const WorkLocationForm({Key? key, required this.registrationData}) : super(key: key);

  @override
  State<WorkLocationForm> createState() => _WorkLocationFormState();
}

class _WorkLocationFormState extends State<WorkLocationForm> {
  int _selectedRadiusIndex = 0;
  bool _agreedToTerms = false;
  final List<String> _radiusOptions = ['5km', '10km', '10km+'];

  @override
  void initState() {
    super.initState();
    _agreedToTerms = widget.registrationData.agreedToTerms ?? false;
  }

  void _saveAndComplete() {
    widget.registrationData.serviceRadius = _radiusOptions[_selectedRadiusIndex];
    widget.registrationData.agreedToTerms = _agreedToTerms;
    widget.registrationData.latitude = 23.0225; // Default Ahmedabad coordinates
    widget.registrationData.longitude = 72.5714;

    // TODO: Navigate to home screen or show success message
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/service_provider_home',
      (route) => false,
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
            onPressed: _agreedToTerms ? _saveAndComplete : null,
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
                message: "Last step !",
                progressWidth: 270,
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
                        'Search for the preferred work location in Ahmedabad !',
                        style: TextStyle(
                          fontFamily: 'Fredoka',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 70),
                    _buildServiceLocationSection(),
                    SizedBox(height: 20),
                    _buildServiceRadiusSection(),
                    SizedBox(height: 70),
                    _buildTermsAgreement(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.all(0),
          child: Text(
            'Service location',
            style: TextStyle(fontFamily: 'SansSerif'),
          ),
        ),
        Container(
          width: double.infinity,
          height: 250,
          padding: EdgeInsets.only(left: 30),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFCDD4DA)),
            borderRadius: BorderRadius.all(Radius.circular(7)),
          ),
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
                          onMapCreated: (GoogleMapController controller) {
                            // TODO: Handle map creation
                          },
                          onTap: (LatLng location) {
                            setState(() {
                              widget.registrationData.latitude = location.latitude;
                              widget.registrationData.longitude = location.longitude;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  _buildToggleButton('5km', 0, isSelected: true),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServiceRadiusSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.all(0),
          child: Text(
            'Set Service Radius',
            style: TextStyle(fontFamily: 'SansSerif'),
          ),
        ),
        Stack(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFCDD4DA)),
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
              child: Row(
                children: [
                  SizedBox(width: 10),
                  _buildToggleButton('5km', 0),
                  SizedBox(width: 10),
                  _buildToggleButton('10km', 1),
                  SizedBox(width: 10),
                  _buildToggleButton('10km+', 2),
                ],
              ),
            ),
            Positioned(
              top: 4,
              right: 8,
              child: Text('*', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildToggleButton(String text, int index, {bool isSelected = false}) {
    bool selected = isSelected || _selectedRadiusIndex == index;
    return SizedBox(
      height: 25,
      child: ToggleButtons(
        isSelected: [selected],
        onPressed: (int buttonIndex) {
          setState(() {
            _selectedRadiusIndex = index;
          });
        },
        borderRadius: BorderRadius.circular(15),
        color: Colors.black,
        selectedColor: Colors.black,
        fillColor: Colors.white,
        selectedBorderColor: Colors.black,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(text),
          ),
        ],
      ),
    );
  }

  Widget _buildTermsAgreement() {
    return Container(
      margin: EdgeInsets.all(0),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Radio<bool>(
            activeColor: Color(0xFFE7B958),
            value: true,
            groupValue: _agreedToTerms ? true : null,
            onChanged: (value) {
              setState(() {
                _agreedToTerms = value ?? false;
              });
            },
          ),
          Expanded(
            child: Wrap(
              children: [
                Text(
                  "I've read and agreed to ",
                  style: TextStyle(
                    fontFamily: 'SansSerif',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // TODO: Show user agreement
                  },
                  child: Text(
                    "User Agreement",
                    style: TextStyle(
                      fontFamily: 'SansSerif',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2E5432),
                    ),
                  ),
                ),
                Text(
                  " and ",
                  style: TextStyle(
                    fontFamily: 'SansSerif',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // TODO: Show privacy policy
                  },
                  child: Text(
                    "Privacy Policy",
                    style: TextStyle(
                      fontFamily: 'SansSerif',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2E5432),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}