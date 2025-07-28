import 'package:flutter/material.dart';

import 'package:servxpert_frontend/constant/colors.dart';

class ErrorPage extends StatelessWidget {
  final String errorMessage;
  final int? errorCode;

  const ErrorPage({super.key, required this.errorMessage, this.errorCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Oops..',
              style: TextStyle(
                fontFamily: 'Fredoka',
                fontSize: 30,
                color: Color(0xFFE7B958),
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 40),
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFFEECA),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFF1E0BD),
                    offset: Offset(0, 0),
                    blurRadius: 10,
                    spreadRadius: 10,
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                '!',
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'Fredoka',
                  color: Color(0xFFE7B958),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Error ${errorCode ?? ''}",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                errorMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
              child: const Text("Go Back"),
            ),
          ],
        ),
      ),
    );
  }
}
