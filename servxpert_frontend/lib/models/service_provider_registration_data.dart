import 'dart:io';

class ServiceProviderRegistrationData {
  // Page 1
  String? firstName;
  String? middleName;
  String? lastName;
  String? address;
  String? gender;
  String? phone;
  String? email;
  String? dob;

  // Page 2
  String? profilePhotoPath;
  String? pincode;
  String? aadharNumber;
  String? aadharFilePath;
  String? panNumber;
  File? profileImage;
  File? documentImage;


  // Page 3
  String? selectedService;
  String? yearsOfExperience;

  // Page 4
  double? latitude;
  double? longitude;
  int? serviceRadius;
  bool? agreedToTerms;

  ServiceProviderRegistrationData({
    this.firstName,
    this.middleName,
    this.lastName,
    this.address,
    this.gender,
    this.phone,
    this.email,
    this.dob,
    this.profilePhotoPath,
    this.pincode,
    this.aadharNumber,
    this.aadharFilePath,
    this.panNumber,
    this.selectedService,
    this.yearsOfExperience,
    this.latitude,
    this.longitude,
    this.serviceRadius,
    this.agreedToTerms,
  });
}