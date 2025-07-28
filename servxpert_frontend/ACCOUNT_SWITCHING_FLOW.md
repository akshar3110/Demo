# Account Switching Flow with Verification Approval

## Overview
This document describes the complete account switching flow between Customer and Service Provider roles, including the verification approval process.

## Flow Diagram

```
Customer Home Screen
    ↓
Customer Profile (Swipe to Register)
    ↓
Check Service Provider Status
    ↓
┌─────────────────┬─────────────────┬─────────────────┐
│   Not Registered│   Registered    │   Registered    │
│                 │   Not Verified  │   Verified      │
└─────────────────┴─────────────────┴─────────────────┘
    ↓                    ↓                    ↓
Registration Form    Show Approval     Switch to Service
    ↓                    Message         Provider Home
    ↓                    ↓                    ↓
Registration         Wait for Admin    Service Provider
Complete             Approval          Home Screen
    ↓                    ↓                    ↓
Check Verification   User can retry    User can switch
Status               switching later   back to Customer
    ↓                    ↓                    ↓
┌─────────────┬─────────────┐
│  Verified   │ Not Verified│
└─────────────┴─────────────┘
    ↓                    ↓
Switch to SP Home    Show Approval
Screen               Message
```

## Implementation Details

### 1. Customer to Service Provider Flow

#### Step 1: Customer Profile Access
- User navigates from Customer Home Screen to Profile
- Swipe button triggers account switching process

#### Step 2: Status Check
- `AccountStatusService.checkServiceProviderEligibility()` is called
- Checks if user is already registered as service provider
- Verifies approval status if registered

#### Step 3: Flow Branching

**Case A: Not Registered**
- User is redirected to Service Provider Registration Form
- After successful registration, verification status is checked
- If immediately verified → Switch to Service Provider Home
- If pending approval → Show approval message

**Case B: Registered but Not Verified**
- Show toast: "Your account is under approval. Please wait for verification."
- User remains on Customer Profile screen

**Case C: Registered and Verified**
- Immediately switch to Service Provider Home Screen
- Show success toast

### 2. Service Provider to Customer Flow

#### Step 1: Service Provider Profile Access
- User taps profile icon in Service Provider Home Screen
- Triggers account switching to customer

#### Step 2: Switch Process
- `AccountStatusService.switchToCustomerWithFlow()` is called
- Retrieves customer data from secure storage
- Navigates to Customer Home Screen

### 3. Verification Approval Process

#### Registration Flow
1. User completes Service Provider Registration Form
2. Backend processes registration and sets verification status
3. Frontend checks verification status after registration
4. Based on status:
   - **Verified**: Immediate access to Service Provider features
   - **Pending**: User receives approval message

#### Approval Status Checking
- `checkServiceProviderStatus()` API endpoint is called
- Returns verification status from backend
- Frontend handles different status responses

### 4. User Experience Features

#### Toast Messages
- **Success**: Green background, white text
- **Pending Approval**: Orange background, white text
- **Error**: Red background, white text
- **Information**: Blue background, white text

#### Loading States
- Loading indicators during API calls
- Disabled buttons during processing
- Smooth transitions between screens

#### Error Handling
- Network error handling
- API error responses
- Graceful fallbacks

## API Endpoints

### 1. Switch to Service Provider
```
POST /api/v1/auth/customer/switch-to-serviceprovider/
```

### 2. Switch to Customer
```
POST /api/v1/auth/service_provider/switch-to-customer/
```

### 3. Check Service Provider Status
```
GET /api/v1/service_provider_details/status/
```

### 4. Service Provider Registration
```
POST /api/v1/service_provider_details/
```

## Key Components

### 1. AccountStatusService
Centralized service for handling all account switching logic:
- `checkServiceProviderEligibility()`
- `switchToServiceProviderWithFlow()`
- `switchToCustomerWithFlow()`
- `handleServiceProviderRegistration()`

### 2. Enhanced Auth Service
- `checkServiceProviderStatus()` - New function for status checking
- Enhanced error handling and response processing

### 3. Updated UI Components
- Customer Profile with enhanced swipe functionality
- Service Provider Home Screen with account switching
- Switch Role Widget with improved flow

## Security Considerations

### 1. Token Management
- Secure storage of access and refresh tokens
- Automatic token refresh on API calls
- Proper token cleanup on logout

### 2. Data Protection
- User data stored in Flutter Secure Storage
- Sensitive information not logged
- Proper error handling without exposing sensitive data

### 3. Role Validation
- Backend validation of user roles
- Frontend role checking before feature access
- Proper session management

## Testing Scenarios

### 1. New User Flow
1. Customer registers for service provider
2. Completes registration form
3. Waits for approval
4. Receives approval notification
5. Successfully switches to service provider

### 2. Existing Service Provider Flow
1. Customer with verified service provider account
2. Swipes to switch account
3. Immediately accesses service provider features

### 3. Pending Approval Flow
1. Customer with pending service provider account
2. Attempts to switch account
3. Receives approval pending message
4. Cannot access service provider features until approved

### 4. Error Handling Flow
1. Network connectivity issues
2. API server errors
3. Invalid token scenarios
4. Proper error messages displayed

## Future Enhancements

### 1. Real-time Notifications
- Push notifications for approval status changes
- In-app notification system
- Email notifications for status updates

### 2. Enhanced UI/UX
- Animated transitions between roles
- Progress indicators for approval status
- Better visual feedback for different states

### 3. Advanced Features
- Multiple service provider accounts
- Role-based permissions
- Account linking and management

## Troubleshooting

### Common Issues

1. **Account switching fails**
   - Check network connectivity
   - Verify token validity
   - Check backend service status

2. **Approval status not updating**
   - Verify API endpoint responses
   - Check backend approval workflow
   - Ensure proper status checking logic

3. **Registration form issues**
   - Validate form data
   - Check API endpoint availability
   - Verify file upload functionality

### Debug Information
- Console logs for API calls
- Error tracking and reporting
- User feedback collection