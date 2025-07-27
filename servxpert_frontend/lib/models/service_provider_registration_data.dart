class ServiceProviderRegistrationData {
  String? firstName;
  String? middleName;
  String? lastName;
  String? address;
  String? gender;
  String? phoneNumber;
  String? email;
  String? dateOfBirth;
  String? profilePhotoPath;
  String? serviceablePincode;
  String? aadharNumber;
  String? aadharFilePath;
  String? panNumber;
  String? selectedService;
  int? yearsOfExperience;
  String? preferredWorkLocation;
  double? serviceRadius;
  bool? agreedToTerms;

  ServiceProviderRegistrationData({
    this.firstName,
    this.middleName,
    this.lastName,
    this.address,
    this.gender,
    this.phoneNumber,
    this.email,
    this.dateOfBirth,
    this.profilePhotoPath,
    this.serviceablePincode,
    this.aadharNumber,
    this.aadharFilePath,
    this.panNumber,
    this.selectedService,
    this.yearsOfExperience,
    this.preferredWorkLocation,
    this.serviceRadius,
    this.agreedToTerms,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'address': address,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'email': email,
      'dateOfBirth': dateOfBirth,
      'profilePhotoPath': profilePhotoPath,
      'serviceablePincode': serviceablePincode,
      'aadharNumber': aadharNumber,
      'aadharFilePath': aadharFilePath,
      'panNumber': panNumber,
      'selectedService': selectedService,
      'yearsOfExperience': yearsOfExperience,
      'preferredWorkLocation': preferredWorkLocation,
      'serviceRadius': serviceRadius,
      'agreedToTerms': agreedToTerms,
    };
  }

  factory ServiceProviderRegistrationData.fromJson(Map<String, dynamic> json) {
    return ServiceProviderRegistrationData(
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
      address: json['address'],
      gender: json['gender'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      dateOfBirth: json['dateOfBirth'],
      profilePhotoPath: json['profilePhotoPath'],
      serviceablePincode: json['serviceablePincode'],
      aadharNumber: json['aadharNumber'],
      aadharFilePath: json['aadharFilePath'],
      panNumber: json['panNumber'],
      selectedService: json['selectedService'],
      yearsOfExperience: json['yearsOfExperience'],
      preferredWorkLocation: json['preferredWorkLocation'],
      serviceRadius: json['serviceRadius'],
      agreedToTerms: json['agreedToTerms'],
    );
  }
}