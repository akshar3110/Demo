# Backend Troubleshooting Guide

## Issue: Service Provider Registration Data Not Stored in Database

### Problem Description
After successfully submitting the service provider registration form, the data is not being stored in the database, even though the frontend shows a success message.

### Root Cause Analysis

#### 1. Frontend Data Submission Issues

**Problem**: The registration form was only sending limited data to the backend.

**Solution**: Updated `registration_page4.dart` to send comprehensive data including:
- Basic Information (name, gender, DOB, phone, email)
- Address Information (address, pincode)
- Identity Documents (Aadhar number, PAN number)
- Service Information (selected service, experience)
- Location Information (latitude, longitude, service radius)
- Terms Agreement
- File uploads (profile picture, documents)

#### 2. Backend API Endpoint Issues

**Potential Problems**:
- Incorrect API endpoint URL
- Missing required fields in backend validation
- Database connection issues
- Authentication token problems

**Solutions**:
- Verify API endpoint: `POST /api/v1/service_provider_details/`
- Check backend logs for validation errors
- Ensure database connection is working
- Verify JWT token is valid and properly formatted

### Debugging Steps

#### Step 1: Test Backend Connectivity
1. Use the "Test Backend" button in Customer Profile
2. Check console logs for connectivity status
3. Verify API endpoints are responding

#### Step 2: Check Data Submission
1. Monitor network requests in browser dev tools
2. Check request payload contains all required fields
3. Verify response status codes and error messages

#### Step 3: Backend Logs Analysis
1. Check backend server logs for:
   - Request received
   - Validation errors
   - Database connection errors
   - Authentication issues

#### Step 4: Database Verification
1. Check if database tables exist
2. Verify table schema matches expected data
3. Check for database connection issues
4. Verify user permissions

### Common Issues and Solutions

#### Issue 1: 400 Bad Request
**Symptoms**: Registration fails with 400 status
**Causes**: 
- Missing required fields
- Invalid data format
- Validation errors

**Solutions**:
- Check all required fields are sent
- Verify data format (dates, phone numbers, etc.)
- Review backend validation rules

#### Issue 2: 401 Unauthorized
**Symptoms**: Registration fails with 401 status
**Causes**:
- Invalid or expired JWT token
- Missing Authorization header

**Solutions**:
- Refresh user authentication
- Check token format and expiration
- Verify Authorization header is present

#### Issue 3: 500 Internal Server Error
**Symptoms**: Registration fails with 500 status
**Causes**:
- Database connection issues
- Server configuration problems
- Code errors in backend

**Solutions**:
- Check backend server logs
- Verify database connectivity
- Review backend code for errors

#### Issue 4: Success Response but No Data in DB
**Symptoms**: 201 Created response but data not in database
**Causes**:
- Database transaction rollback
- Incorrect database configuration
- Data validation passing but save failing

**Solutions**:
- Check database transaction logs
- Verify database configuration
- Add more detailed error logging

### Enhanced Debugging Tools

#### 1. Backend Check Service
The app now includes `BackendCheckService` with methods to:
- Test backend connectivity
- Check service provider status
- Test data submission
- Run comprehensive diagnostics

#### 2. Enhanced Logging
Added detailed logging in registration form:
- Request payload logging
- Response status and data logging
- Error handling with specific messages

#### 3. Debug Button
Added "Test Backend" button in Customer Profile to:
- Run backend diagnostics
- Test data submission
- Check API endpoints

### Backend API Requirements

#### Expected Request Format
```json
{
  "first_name": "string",
  "last_name": "string",
  "middle_name": "string",
  "gender": "string",
  "date_of_birth": "YYYY-MM-DD",
  "phone": "string",
  "email": "string",
  "address": "string",
  "pincode": "string",
  "aadhar_number": "string",
  "pan_number": "string",
  "selected_service": "string",
  "years_of_experience": "string",
  "latitude": "string",
  "longitude": "string",
  "service_radius": "string",
  "agreed_to_terms": "string",
  "profile_pic_url": "file",
  "aadhar_document": "file",
  "profile_image": "file",
  "document_image": "file"
}
```

#### Expected Response Format
```json
{
  "status": "success",
  "message": "Service provider registered successfully",
  "data": {
    "id": "integer",
    "user_id": "integer",
    "verification_status": "string"
  }
}
```

### Testing Checklist

#### Frontend Testing
- [ ] All form fields are populated correctly
- [ ] File uploads work properly
- [ ] JWT token is valid and included
- [ ] Request payload contains all required fields
- [ ] Error handling works for different scenarios

#### Backend Testing
- [ ] API endpoint is accessible
- [ ] Authentication works correctly
- [ ] Data validation passes
- [ ] Database save operation succeeds
- [ ] Response format is correct

#### Database Testing
- [ ] Database connection is working
- [ ] Tables exist with correct schema
- [ ] User has proper permissions
- [ ] Data is actually saved to database
- [ ] No transaction rollbacks occur

### Monitoring and Logging

#### Frontend Logging
```dart
print("📤 Submitting registration data:");
print("📤 Form data keys: ${formMap.keys.toList()}");
print("📤 Token: $token");
print("📥 Response status: ${response.statusCode}");
print("📥 Response data: ${response.data}");
```

#### Backend Logging Recommendations
```python
# Log incoming request
logger.info(f"Registration request received for user: {user_id}")

# Log validation results
logger.info(f"Validation passed for user: {user_id}")

# Log database operation
logger.info(f"Database save successful for user: {user_id}")

# Log response
logger.info(f"Registration completed for user: {user_id}")
```

### Next Steps

1. **Run Backend Diagnostics**: Use the "Test Backend" button to check connectivity
2. **Monitor Network Requests**: Use browser dev tools to see actual requests/responses
3. **Check Backend Logs**: Review server logs for errors
4. **Verify Database**: Check if data is actually being saved
5. **Test with Minimal Data**: Try submitting with just required fields
6. **Check API Documentation**: Verify endpoint requirements match implementation

### Contact Information

If issues persist after following this guide:
1. Check backend server status
2. Review recent backend deployments
3. Contact backend development team
4. Provide detailed error logs and request/response data