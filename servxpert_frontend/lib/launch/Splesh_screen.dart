import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:servxpert_frontend/constant/api_constants.dart';
import 'package:servxpert_frontend/constant/colors.dart';
import 'package:servxpert_frontend/userApp/fetching_location.dart';
import 'package:servxpert_frontend/userApp/login_page.dart';
import 'package:servxpert_frontend/network/dio_client.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _secureStorage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _checkTokenAndNavigate();
  }

  // In your SplashScreen, add debug prints:
  Future<void> _checkTokenAndNavigate() async {
    final accessToken = await _secureStorage.read(key: 'access_token');
    final refreshToken = await _secureStorage.read(key: 'refresh_token');

    print("🔍 SplashScreen - Access Token: ${accessToken != null ? 'Present' : 'Missing'}");
    print("🔍 SplashScreen - Refresh Token: ${refreshToken != null ? 'Present' : 'Missing'}");

    if (accessToken == null || refreshToken == null) {
      print("🚪 No tokens found, going to login");
      _goToLogin();
      return;
    }

    if (!JwtDecoder.isExpired(accessToken)) {
      print("✅ Valid access token, going to home");
      await Future.delayed(const Duration(seconds: 2));
      _goToHome();
      return;
    }

    print("🔄 Access token expired, trying to refresh");
    final success = await _refreshAccessToken(refreshToken);
    if (success) {
      print("✅ Token refreshed successfully, going to home");
      await Future.delayed(const Duration(seconds: 2));
      _goToHome();
    } else {
      print("❌ Token refresh failed, going to login");
      _goToLogin();
    }
  }


  Future<bool> _refreshAccessToken(String refreshToken) async {
    try {
      final response = await dio.post(
        refreshTokenUrl,
        data: {'refresh': refreshToken},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final newAccessToken = data['access'];

        await _secureStorage.write(key: 'access_token', value: newAccessToken);
        return true;
      }
    } catch (e) {
      print('Token refresh error: $e');
    }
    return false;
  }

  Future<void> _goToHome() async {
    if (!mounted) return;

    final email = await _secureStorage.read(key: 'email') ?? '';
    final firstName = await _secureStorage.read(key: 'first_name') ?? '';
    final lastName = await _secureStorage.read(key: 'last_name') ?? '';
    final profilePhoto = await _secureStorage.read(key: 'profile_photo') ?? '';

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => FetchingLocationPage(
          email: email,
          firstName: firstName,
          lastName: lastName,
          profilePhoto: profilePhoto,
        ),
      ),
    );
  }

  void _goToLogin() {
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.primary,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo & Text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFE7B958),
                        Color(0xFFBB9648),
                        Color(0xFF757441),
                      ],
                      stops: [0.0, 0.66, 1.0],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'X',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        fontFamily: "DeRotterDam",
                        color: AppColors.secondary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'serveXpert',
                  style: TextStyle(
                    fontSize: 35,
                    fontFamily: "DeRotterDam",
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 200,
              width: 200,
              child: Lottie.asset(
                'assets/animations/loading_screen.json',
                repeat: true,
              ),

            ),
          ],
        ),
      ),
    );
  }
}
