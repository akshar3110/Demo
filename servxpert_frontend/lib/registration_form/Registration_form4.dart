import 'package:flutter/material.dart';

class RegistrationFormPreferredWorkLocation extends StatefulWidget {
  final String name;
  final String contactNo;
  final String address;
  final String gender;
  final String email;
  final String dob;
  final String pincode;
  final String aadhar;
  final String pan;
  final String profilePhoto;
  final String aadharFile;
  final String selectedService;
  final String experience;
  final String jwtToken;


  const RegistrationFormPreferredWorkLocation({
    super.key,
    required this.name,
    required this.contactNo,
    required this.address,
    required this.gender,
    required this.email,
    required this.dob,
    required this.pincode,
    required this.aadhar,
    required this.pan,
    required this.profilePhoto,
    required this.aadharFile,
    required this.selectedService,
    required this.experience,
    required this.jwtToken,


  });

  @override
  State<RegistrationFormPreferredWorkLocation> createState() =>
      _RegistrationFormPreferredWorkLocationState();
}

class _RegistrationFormPreferredWorkLocationState
    extends State<RegistrationFormPreferredWorkLocation> {

  final _formKey = GlobalKey<FormState>();


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
            onPressed: () async {

              //Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceProvidersHomeScreen(),));
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
                                    // child: ClipRRect(
                                    //   borderRadius: BorderRadius.circular(10),
                                    //   child: GoogleMap(
                                    //     initialCameraPosition: CameraPosition(
                                    //       target: LatLng(23.0225, 72.5714),
                                    //       zoom: 12,
                                    //     ),
                                    //     zoomControlsEnabled: false,
                                    //     myLocationButtonEnabled: false,
                                    //   ),
                                    // ),
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
