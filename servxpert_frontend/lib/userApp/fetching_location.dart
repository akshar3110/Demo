import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:lottie/lottie.dart';
import 'package:servxpert_frontend/constant/colors.dart';
import 'package:servxpert_frontend/userApp/Customers_home_screen.dart';



class FetchingLocationPage extends StatefulWidget {
  final String email;
  final String firstName;
  final String lastName;
  final String profilePhoto;


  const FetchingLocationPage({
    super.key,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.profilePhoto,
  });

  @override
  State<FetchingLocationPage> createState() => _FetchingLocationPageState();
}

class _FetchingLocationPageState extends State<FetchingLocationPage> {
  String _city = '';
  String _area = '';
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _startFetching();
  }

  Future<void> _startFetching() async {
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    if (permission == LocationPermission.deniedForever) return;

    Future<void> fetchLocation() async {
      // Step 1: Try last known location
      Position? lastKnown = await Geolocator.getLastKnownPosition();
      if (lastKnown != null) {
        await _handlePosition(lastKnown);
        return;
      }

      // Step 2: Try getting current position quickly
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low,
          timeLimit: const Duration(seconds: 6),
        );
        await _handlePosition(position);
      } catch (e) {
        debugPrint("Location error: $e");
      }
    }

    // Run both delay and location fetching in parallel
    await Future.wait([
      fetchLocation(),
      Future.delayed(const Duration(seconds: 3)),
    ]);

    if (!_navigated) {
      _navigated = true;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => CustomersHomeScreen(
            city: _city,
            area: _area,
            email: widget.email,
            firstName: widget.firstName,
            lastName: widget.lastName,
          ),
        ),
      );
    }
  }


  Future<void> _handlePosition(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      setState(() {
        _city = place.locality ?? '';
        _area = place.subLocality ?? '';
      });
    }

    // ⏳ Add 3-second delay before navigating
    await Future.delayed(const Duration(seconds: 3));

    // Prevent multiple navigations
    if (!_navigated) {
      _navigated = true;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => CustomersHomeScreen(
            city: _city,
            area: _area,
            email: widget.email,
            firstName: widget.firstName,
            lastName: widget.lastName,
          ),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'DISCOVER NOW',
                    style: TextStyle(
                      color: AppColors.gold_highlight,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'FredokaOne',
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Find Your On-Demand\nService Worker",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'FredokaOne',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "We provide better service for you with our\non-demand service app",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'MPlus',
                      fontSize: 12,
                      color: AppColors.lightgrey_text,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F3F3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: Lottie.asset(
                            'assets/animations/loading_location.json',
                            repeat: true,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Fetching your location...",
                          style: TextStyle(
                            fontFamily: 'SansSerif',
                            fontSize: 14,
                            color: AppColors.lightgrey_text,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _badgeTile(Icons.verified, Colors.blue, '1,500+', 'Expert Workers'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _badgeTile(Icons.star, Colors.amber, '9,000+', 'User Reviews'),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.55,
                child: Image.asset(
                  "assets/SpleshHomeScreen.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _badgeTile(IconData icon, Color color, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'MPlus',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontFamily: 'SansSerif',
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
