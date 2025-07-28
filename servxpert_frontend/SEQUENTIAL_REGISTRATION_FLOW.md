# Sequential Registration Flow Documentation

## Overview
This document describes the sequential registration flow using individual registration forms (Registration_form1, Registration_form2, Registration_form3, Registration_form4) for service provider registration.

## Flow Structure

```
Customer Profile (Swipe to Register)
    ↓
Registration_form1 (Basic Information)
    ↓
Registration_form2 (Profile Verification)
    ↓
Registration_form3 (Skills and Services)
    ↓
Registration_form4 (Final Submission)
    ↓
Backend API Submission
    ↓
Success/Error Response
```

## Form Details

### Registration_form1.dart
**Purpose**: Collect basic personal information

**Fields Collected**:
- First Name
- Last Name
- Address
- Gender (Male/Female/Other)
- Contact Number
- Date of Birth
- Area
- City
- State
- Country
- Pincode

**Navigation**: 
- Validates all required fields
- Converts gender to code (M/F/O)
- Navigates to Registration_form2 with collected data

### Registration_form2.dart
**Purpose**: Profile verification and document upload

**Fields Collected**:
- Aadhar Number
- PAN Number
- Profile Photo (Camera capture)
- Aadhar Document (File upload)

**Navigation**:
- Validates all required fields and file uploads
- Navigates to Registration_form3 with all previous data

### Registration_form3.dart
**Purpose**: Skills, services, and experience selection

**Fields Collected**:
- Selected Service (from API)
- Years of Experience

**Features**:
- Fetches services from backend API
- Allows single service selection
- Validates experience input

**Navigation**:
- Submits all data to backend API
- Shows success dialog
- Returns boolean result for flow tracking

### Registration_form4.dart
**Purpose**: Final location and radius setup

**Fields Collected**:
- Service Radius (5, 10, 15, 20 km)
- Location coordinates
- Terms agreement

**Features**:
- Google Maps integration
- Service radius selection
- Terms and conditions agreement

## Data Flow

### 1. Data Collection
Each form collects specific data and passes it to the next form:

```dart
// Registration_form1 → Registration_form2
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => RegistrationFormProfileVerification(
      name: nameController.text,
      contactNo: contactController.text,
      address: addressController.text,
      gender: genderCode,
      dob: dobController.text,
      area: areaController.text,
      city: cityController.text,
      state: stateController.text,
      country: countryController.text,
      pincode: pincodeController.text,
      jwtToken: widget.jwtToken,
    ),
  ),
);
```

### 2. Data Aggregation
All collected data is passed through the forms until final submission:

```dart
// Registration_form3 final submission
await submitServiceProviderForm(
  fullName: widget.name,
  dob: widget.dob,
  contactNo: widget.contactNo,
  address: widget.address,
  gender: widget.gender,
  area: widget.area,
  city: widget.city,
  state: widget.state,
  country: widget.country,
  pincode: widget.pincode,
  aadharNumber: widget.aadhar,
  panNumber: widget.pan,
  aadharFile: File(widget.aadharFile),
  profileImageFile: File(widget.profilePhoto),
  selectedCategoryIDs: [selectedServiceId!],
  experience: experienceController.text.trim(),
  jwtToken: widget.jwtToken,
);
```

### 3. Backend Submission
The final form submits comprehensive data to the backend:

```dart
// API Service call
final response = await dio.post(
  submitUrl,
  data: formData,
  options: Options(
    headers: {
      'Authorization': 'Bearer $jwtToken',
      'Content-Type': 'multipart/form-data',
    },
  ),
);
```

## Integration with Account Switching

### Account Status Service
The `AccountStatusService` now uses the sequential forms:

```dart
// Navigate to the first registration form
final registered = await Navigator.push<bool>(
  context,
  MaterialPageRoute(
    builder: (_) => RegistrationForm(jwtToken: accessToken),
  ),
);
```

### Flow Tracking
Each form returns a boolean result to track completion:

```dart
// Registration_form3 success
Navigator.pop(context, true);

// Registration_form3 failure
Navigator.pop(context, false);
```

## Validation Rules

### Registration_form1
- All fields are required
- Phone number must be 10 digits
- Date of birth must be valid
- Gender must be selected

### Registration_form2
- Aadhar number must be 12 digits
- PAN number must be valid format
- Profile photo must be captured
- Aadhar document must be uploaded

### Registration_form3
- Service must be selected
- Experience must be entered
- API services must be loaded

### Registration_form4
- Service radius must be selected
- Location must be set
- Terms must be agreed to

## Error Handling

### Form Validation
Each form validates its own fields and shows appropriate error messages:

```dart
if (firstNameController.text.trim().isEmpty) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Please fill all required fields')),
  );
  return;
}
```

### API Error Handling
The final submission includes comprehensive error handling:

```dart
try {
  final response = await dio.post(submitUrl, data: formData);
  // Handle success
} on DioException catch (e) {
  // Handle network/API errors
} catch (e) {
  // Handle unexpected errors
}
```

## File Upload Handling

### Profile Photo
- Uses ImagePicker for camera capture
- Stores file path for backend submission
- Validates file existence before upload

### Document Upload
- Uses FilePicker for document selection
- Supports multiple file formats (jpg, jpeg, png, pdf)
- Shows selected file name to user

## API Integration

### Service Fetching
Registration_form3 fetches available services:

```dart
Future<void> loadServices() async {
  final token = prefs.getString('accessToken');
  List<ServiceModel> fetched = await fetchServices(token);
  setState(() {
    services = fetched;
    isLoading = false;
  });
}
```

### Final Submission
Registration_form3 handles the complete data submission:

```dart
await submitServiceProviderForm(
  // All collected data from previous forms
  fullName: widget.name,
  // ... other fields
  jwtToken: widget.jwtToken,
);
```

## User Experience Features

### Progress Indication
- Each form shows current step
- Visual progress indicators
- Clear navigation between steps

### Loading States
- Loading spinners during API calls
- Disabled buttons during processing
- Success/error feedback

### Data Persistence
- Form data is passed through navigation
- No data loss between steps
- Validation at each step

## Testing Scenarios

### 1. Complete Registration Flow
1. Start from Customer Profile
2. Complete Registration_form1
3. Complete Registration_form2
4. Complete Registration_form3
5. Verify backend submission
6. Check account switching

### 2. Partial Registration
1. Start registration
2. Stop at any step
3. Verify no data is lost
4. Resume from same point

### 3. Error Scenarios
1. Network errors during API calls
2. Invalid data validation
3. File upload failures
4. Backend submission errors

### 4. Account Switching
1. Complete registration
2. Switch to service provider
3. Verify verification status
4. Switch back to customer

## Backend Requirements

### API Endpoints
- `GET /api/v1/services/` - Fetch available services
- `POST /api/v1/service_provider_details/` - Submit registration
- `GET /api/v1/service_provider_details/status/` - Check status

### Expected Data Format
```json
{
  "first_name": "string",
  "last_name": "string",
  "contact_no": "string",
  "address": "string",
  "gender": "string",
  "date_of_birth": "string",
  "area": "string",
  "city": "string",
  "state": "string",
  "country": "string",
  "pincode": "string",
  "aadhar_number": "string",
  "pan_number": "string",
  "selected_service": "integer",
  "experience": "string",
  "profile_photo": "file",
  "aadhar_document": "file"
}
```

## Security Considerations

### Data Validation
- Client-side validation at each step
- Server-side validation on final submission
- File type and size validation

### Authentication
- JWT token passed through all forms
- Token validation on API calls
- Secure file upload handling

### Data Protection
- Sensitive data not logged
- Secure file storage
- Proper error handling without data exposure

## Future Enhancements

### 1. Form Persistence
- Save partial form data locally
- Resume registration from any step
- Auto-save functionality

### 2. Enhanced Validation
- Real-time field validation
- Better error messages
- Field-specific validation rules

### 3. UI Improvements
- Progress bar across all forms
- Better visual feedback
- Animated transitions

### 4. Offline Support
- Offline form completion
- Sync when online
- Data caching

## Troubleshooting

### Common Issues

1. **Form Navigation Issues**
   - Check data passing between forms
   - Verify required field validation
   - Ensure proper navigation flow

2. **File Upload Problems**
   - Check file permissions
   - Verify file format support
   - Test file size limits

3. **API Integration Issues**
   - Verify API endpoints
   - Check authentication tokens
   - Monitor network connectivity

4. **Data Submission Errors**
   - Validate all required fields
   - Check backend validation rules
   - Monitor server logs

### Debug Tools
- Use "Test Backend" button in Customer Profile
- Check console logs for detailed information
- Monitor network requests in dev tools
- Verify data flow between forms