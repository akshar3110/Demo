import 'package:flutter/material.dart';
import 'package:servxpert_frontend/profileApp/registration_form.dart';
import 'package:servxpert_frontend/models/service_provider_registration_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ServXpert Registration',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'SansSerif',
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo placeholder
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Color(0xFFE7B958),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.handyman,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 30),
              Text(
                'ServXpert',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Fredoka',
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Service Provider Registration',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'SansSerif',
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFE7B958),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {
                      // Initialize empty registration data
                      ServiceProviderRegistrationData registrationData = 
                          ServiceProviderRegistrationData();
                      
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistrationForm(
                            registrationData: registrationData,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Start Registration',
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
              SizedBox(height: 20),
              Text(
                'Join thousands of service providers\nand start earning today!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'SansSerif',
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}