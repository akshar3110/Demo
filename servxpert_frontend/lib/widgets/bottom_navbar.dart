import 'package:flutter/material.dart';
import 'package:servxpert_frontend/userApp/Customers_home_screen.dart';
import 'package:servxpert_frontend/profileApp/customers_profile.dart';

// import 'package:servexpert/project/pages/offered_services.dart';

// Import your pages here:
// import 'package:serve/project/pages/service_providers_home_screen.dart';
// import 'package:serve/project/pages/mybookings.dart';
// import 'package:serve/project/pages/complaints.dart';
// import 'package:serve/project/pages/service_providers_profile.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final String email;
  final String area;
  final String city;
  final String firstName;
  final String lastName;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.email,
    required this.area,
    required this.city,
    required this.firstName,
    required this.lastName,
  });


  void _onTabTapped(BuildContext context, int index) {
    if (index == currentIndex) return;

    Widget targetPage;

    switch (index) {
      case 0:
        targetPage = CustomersHomeScreen(email: email, area: area, city: city, firstName: firstName, lastName: lastName);
        break;
      case 1:
        targetPage = CustomersHomeScreen(email: email, area: area, city: city, firstName: firstName, lastName: lastName);
        break;
      case 2:
        targetPage = CustomersHomeScreen(email: email, area: area, city: city, firstName: firstName, lastName: lastName);
        break;
      case 3:
        targetPage = CustomerProfile(email: email, area: area, city: city, firstName: firstName, lastName: lastName);
        break;
      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => targetPage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: (index) => _onTabTapped(context, index),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(size: 25),
      unselectedIconTheme: IconThemeData(size: 25),
      items: [
        BottomNavigationBarItem(
          icon: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey),
              color: currentIndex == 0 ? Color(0xFF506C5C) : Colors.transparent,
            ),
            child: Image.asset(
              currentIndex == 0
                  ? 'assets/icons/X_white.png'
                  : 'assets/icons/X.png',
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey),
              color: currentIndex == 1 ? Color(0xFF506C5C) : Colors.transparent,
            ),
            child: Icon(
              Icons.receipt_long,
              color: currentIndex == 1 ? Colors.white : Colors.grey,
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey),
              color: currentIndex == 2 ? Color(0xFF506C5C) : Colors.transparent,
            ),
            child: Icon(
              Icons.warning,
              color: currentIndex == 2 ? Colors.white : Colors.grey,
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey),
              color: currentIndex == 3 ? Color(0xFF506C5C) : Colors.transparent,
            ),
            child: Icon(
              Icons.person,
              color: currentIndex == 3 ? Colors.white : Colors.grey,
            ),
          ),
          label: '',
        ),
      ],
    );
  }
}

