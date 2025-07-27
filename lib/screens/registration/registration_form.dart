// Main registration form entry point
export 'basic_info_form.dart';
export 'profile_verification_form.dart';
export 'skills_and_services_form.dart';
export 'work_location_form.dart';

import 'package:flutter/material.dart';
import '../models/service_provider_registration_data.dart';
import 'basic_info_form.dart';

class RegistrationForm extends StatelessWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize empty registration data
    final registrationData = ServiceProviderRegistrationData();
    
    return BasicInfoForm(registrationData: registrationData);
  }
}