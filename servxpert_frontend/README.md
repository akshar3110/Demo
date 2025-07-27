# ServXpert Frontend - Service Provider Registration

A Flutter application for service provider registration with a multi-step form process.

## Project Structure

```
servxpert_frontend/
├── lib/
│   ├── main.dart                          # Entry point of the application
│   ├── models/
│   │   └── service_provider_registration_data.dart  # Data model for registration
│   ├── profileApp/
│   │   └── registration_form.dart         # Multi-step registration forms
│   └── service_provider/
│       └── service_providers_home_screen.dart  # Home screen after registration
├── pubspec.yaml                           # Project dependencies
└── README.md                             # This file
```

## Features

### 1. **Multi-Step Registration Process**
- **Step 1: Personal Information**
  - First Name, Middle Name, Last Name
  - Address, Gender selection
  - Phone number, Email, Date of Birth
  - Form validation with required field indicators

- **Step 2: Profile Verification**
  - Profile photo capture
  - Serviceable pincode
  - Aadhar number with file upload
  - PAN number validation

- **Step 3: Skills and Services**
  - Service selection (Cleaning, Plumbing, Electrical, Painting)
  - Years of experience input
  - Single service selection constraint

- **Step 4: Work Location Preferences**
  - Google Maps integration for location selection
  - Service radius selection (5km, 10km, 10km+)
  - Terms and conditions agreement

### 2. **Data Persistence**
- Registration data is preserved across all steps
- Users can navigate back and forward without losing data
- Form validation prevents incomplete submissions

### 3. **UI/UX Features**
- Consistent color scheme with golden accent (#E7B958)
- Progress indicators showing current step
- Responsive design with proper spacing
- Form validation with error messages
- Required field indicators (red asterisks)

### 4. **Technical Improvements Made**

#### **Form Validation**
- Added `GlobalKey<FormState>` for each form step
- Implemented validators for all required fields
- Email regex validation
- Phone number length validation
- PAN number format validation
- Aadhar number length validation

#### **Data Management**
- Created comprehensive `ServiceProviderRegistrationData` model
- Data persistence between form steps
- Pre-population of fields when navigating back
- Proper data serialization with `toJson()` and `fromJson()` methods

#### **Controller Management**
- Added `TextEditingController` for all input fields
- Proper disposal of controllers to prevent memory leaks
- Pre-population of controllers with existing data

#### **User Experience**
- Added validation feedback with SnackBar messages
- Disabled navigation until required fields are filled
- Clear error messages for invalid inputs
- Consistent button styling and interactions

## Dependencies

- `flutter`: Framework
- `google_maps_flutter`: ^2.5.0 - For location selection
- `cupertino_icons`: ^1.0.2 - iOS style icons

## Getting Started

### Prerequisites
- Flutter SDK (>=2.17.0)
- Google Maps API key (for maps functionality)

### Installation

1. Clone the repository
2. Navigate to the project directory:
   ```bash
   cd servxpert_frontend
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Add your Google Maps API key in the appropriate platform files

5. Run the application:
   ```bash
   flutter run
   ```

## Usage

1. Launch the app and tap "Start Registration"
2. Fill in the personal information form
3. Complete profile verification step
4. Select your service and experience
5. Set work location preferences
6. Agree to terms and complete registration

## Asset Requirements

The app expects the following assets:
- `assets/images/serve_xpert_x_logo.png` - Company logo
- `assets/images/serve_xpert_name_logo.png` - Company name logo
- `assets/icons/india_flag.png` - India flag icon for phone number field

## Font Requirements

The app uses custom fonts:
- `Fredoka` family for headings and buttons
- `SansSerif` family for body text and form fields

## Key Improvements from Original Code

1. **Better Architecture**: Separated concerns with proper file structure
2. **Data Persistence**: Registration data is maintained across all steps
3. **Form Validation**: Comprehensive validation for all input fields
4. **Error Handling**: User-friendly error messages and validation feedback
5. **Memory Management**: Proper disposal of controllers and resources
6. **Type Safety**: Strong typing throughout the application
7. **User Experience**: Consistent styling and improved navigation flow

## Future Enhancements

- Image upload functionality for profile photo and documents
- Real-time location services
- API integration for data submission
- Offline data storage
- Enhanced maps functionality with location search
- Multi-language support

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is licensed under the MIT License.