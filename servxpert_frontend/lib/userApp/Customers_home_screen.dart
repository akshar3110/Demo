import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:servxpert_frontend/constant/colors.dart';
import 'package:servxpert_frontend/profileApp/customers_profile.dart';
import 'package:servxpert_frontend/widgets/bottom_navbar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomersHomeScreen extends StatefulWidget {
  final String city;
  final String area;
  final String email;
  final String firstName;
  final String lastName;

  const CustomersHomeScreen({
    super.key,
    required this.email,
    required this.area,
    required this.city,
    required this.firstName,
    required this.lastName,
  });

  @override
  State<CustomersHomeScreen> createState() => _CustomersHomeScreenState();
}

class _CustomersHomeScreenState extends State<CustomersHomeScreen> {
  int _selectedIndex = 0;
  final _secureStorage = const FlutterSecureStorage();
  late Future<String?> _profilePhotoFuture;

  @override
  void initState() {
    super.initState();
    _profilePhotoFuture = _getProfilePhoto();
  }

  Future<String?> _getProfilePhoto() async {
    return await _secureStorage.read(key: 'profile_photo');
  }
  Future<String?> _getFirstName() async {
    return await _secureStorage.read(key: 'first_name');
  }
  Future<String?> _getLastName() async {
    return await _secureStorage.read(key: 'last_name');
  }
  Future<String?> _getEmail() async {
    return await _secureStorage.read(key: 'email');
  }
  Widget _buildNavItem(IconData icon, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF506D5D) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.grey,
        ),
      ),
    );
  }

  void _onItemTap(String label) {
    print("Tapped on $label");
  }

  Widget _buildCategory(String title, List<Map<String, String>> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold,)),
              GestureDetector(
                onTap:() {
                  if(title == "Appliances"){
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder:(context) => const ListOfAppliances(),
                    //     ),
                    // );
                  }else if (title == "Cleaning"){
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder:(context) => const CleaningListOfSevices(),
                    //     ),
                    // );
                  }
                },
                child: const Text("See All ->", style: TextStyle(color: Colors.green)),
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.map((item) {
              return GestureDetector(
                onTap: () => _onItemTap(item['label']!),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        item['icon']!,
                        width: 40,
                        height: 40,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(item['label']!),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 6),
      ],
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primary,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF506D5D),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(16, 30, 16, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CustomerProfile(
                              email: widget.email,
                              area: widget.area,
                              city: widget.city,
                              firstName: widget.firstName,
                              lastName: widget.lastName
                          )),
                        );
                      },

                      child: FutureBuilder<String?>(
                        future: _getProfilePhoto(),
                        builder: (context, snapshot) {
                          final profilePhoto = snapshot.data;
                          if (profilePhoto != null && profilePhoto.isNotEmpty) {
                            return CircleAvatar(
                              radius: 18,
                              backgroundImage: NetworkImage(profilePhoto),
                              backgroundColor: Colors.white,
                            );
                          } else {
                            return const CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.person_outline, size: 20, color: Colors.black),
                            );
                          }
                        },
                      ),
                    ),
                    // Location in center
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:  [
                        Text(
                          "${widget.firstName} ${widget.lastName}",
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        Text(
                          "${widget.email}",
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Current Location",
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 16, color: Colors.white),
                            SizedBox(width: 4),
                            Text(
                              "${widget.area}, ${widget.city}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Notification Icon
                    const CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.notifications_none, size: 20, color: Colors.black),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCategory("Appliances", [
                        {"label": "AC", "icon": "assets/ac.png"},
                        {"label": "Refrigerator", "icon": "assets/fridge.png"},
                        {"label": "Washing\nMachine", "icon": "assets/washing_machine.png"},
                      ]),
                      _buildCategory("Cleaning", [
                        {"label": "Bathroom", "icon": "assets/shower.png"},
                        {"label": "Washroom", "icon": "assets/wc.png"},
                        {"label": "Sofa", "icon": "assets/sofa.png"},
                      ]),
                      _buildCategory("Water Proofing", [
                        {"label": "Bathroom", "icon": "assets/bathroom.png"},
                        {"label": "Washroom", "icon": "assets/toilet.png"},
                        {"label": "Terrace", "icon": "assets/terrace.png"},
                      ]),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Popular Services",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            Text("See All ->",
                                style: TextStyle(color: Colors.green)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => _onItemTap("Popular Service 1"),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  "assets/cleaning.jpg",
                                  width: 160,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _onItemTap("Popular Service 2"),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  "assets/plumbing.jpg",
                                  width: 160,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNav(
            currentIndex: 0,
            email: widget.email,
            area: widget.area,
            city: widget.city,
            firstName: widget.firstName,
            lastName: widget.lastName
        )
    );
  }
}