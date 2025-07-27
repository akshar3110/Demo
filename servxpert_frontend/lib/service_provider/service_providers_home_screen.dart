import 'package:flutter/material.dart';

class ServiceProvidersHomeScreen extends StatelessWidget {
  const ServiceProvidersHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text('Service Provider Dashboard'),
        backgroundColor: Color(0xFFE7B958),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              size: 100,
              color: Color(0xFFE7B958),
            ),
            SizedBox(height: 20),
            Text(
              'Registration Completed!',
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Fredoka',
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Welcome to ServXpert',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'SansSerif',
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}