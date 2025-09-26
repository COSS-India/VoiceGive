# Authentication System Implementation Guide

This document explains the comprehensive authentication system implemented in the Bhashadaan Flutter application following enterprise standards.

## Overview

The authentication system provides:
- Secure login with email/password and captcha
- JWT token management with secure storage
- State management for authentication status
- Automatic token injection in API calls
- Enterprise-grade security practices

## Architecture

### Core Components

1. **Models** (`lib/models/auth/`)
   - `LoginRequest` - Login request data structure
   - `LoginResponse` - Login API response structure
   - `User` - User data model

2. **Services** (`lib/services/`)
   - `AuthService` - Login API integration
   - `TokenStorageService` - Secure token storage
   - `AuthManager` - Singleton token management

3. **State Management** (`lib/providers/`)
   - `AuthProvider` - Authentication state management

4. **UI Components** (`lib/screens/auth/login/widgets/`)
   - `LoginFormWidget` - Complete login form with captcha

## API Integration

### Login Endpoint

**URL**: `POST {API_BASE_URL}/login-user`

**Request Body**:
```json
{
    "email": "user@example.com",
    "password": "hashed_password",
    "secureId": "captcha_secure_id",
    "captchaText": "captcha_text"
}
```

**Response**:
```json
{
    "statusCode": 201,
    "status": true,
    "message": "User Logged In Successfull!",
    "result": {
        "userId": 6,
        "firstName": "Geo",
        "lastName": "Joseph",
        "userName": "JosephGeo",
        "email": "geojofficial@gmail.com",
        "role": "role_token",
        "roleName": "Individual",
        "platformId": 1,
        "token": "jwt_token_here"
    }
}
```

### Captcha Endpoint

**URL**: `GET {API_BASE_URL}/get-secure-cap`

**Response**:
```json
{
    "secureId": "captcha_secure_id",
    "captchaImageUrl": "base64_image_or_url"
}
```

## Usage Examples

### 1. Basic Login Implementation

```dart
// In your login screen
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          if (authProvider.isAuthenticated) {
            return HomeScreen();
          }
          
          return LoginFormWidget();
        },
      ),
    );
  }
}
```

### 2. Programmatic Login

```dart
final authProvider = Provider.of<AuthProvider>(context, listen: false);

final loginRequest = LoginRequest(
  email: 'user@example.com',
  password: 'password123',
  secureId: 'captcha_secure_id',
  captchaText: 'CAPTCHA',
);

final success = await authProvider.login(loginRequest);
if (success) {
  // Navigate to home screen
  Navigator.pushReplacementNamed(context, '/home');
}
```

### 3. Check Authentication Status

```dart
// Check if user is logged in
final authProvider = Provider.of<AuthProvider>(context);
if (authProvider.isAuthenticated) {
  // User is logged in
  final user = authProvider.user;
  print('Welcome ${user?.fullName}');
}

// Check authentication status
switch (authProvider.status) {
  case AuthStatus.authenticated:
    // Show authenticated UI
    break;
  case AuthStatus.unauthenticated:
    // Show login screen
    break;
  case AuthStatus.loading:
    // Show loading indicator
    break;
  case AuthStatus.error:
    // Show error message
    break;
}
```

### 4. Logout

```dart
final authProvider = Provider.of<AuthProvider>(context, listen: false);
await authProvider.logout();
```

## Token Management

### Automatic Token Injection

The `ApiService` automatically includes the authentication token in all API requests:

```dart
// This will automatically include the Bearer token
final response = await ApiService.skip(
  device: 'device',
  browser: 'browser',
  // ... other parameters
);
```

### Manual Token Access

```dart
// Get current token
final token = AuthManager.instance.getToken();

// Check if authenticated
final isAuth = AuthManager.instance.isAuthenticated;

// Get authorization header
final authHeader = AuthManager.instance.authorizationHeader;
```

## Security Features

### 1. Secure Token Storage

- Uses `flutter_secure_storage` for encrypted storage
- Tokens are stored in device keychain/keystore
- Automatic token expiration handling

### 2. Token Validation

- Automatic token expiration checking
- Secure token refresh mechanism
- Token cleanup on logout

### 3. Error Handling

- Comprehensive error handling for network issues
- User-friendly error messages
- Automatic captcha refresh on login failure

## State Management

### AuthProvider States

- `AuthStatus.initial` - Initial state
- `AuthStatus.loading` - Login/logout in progress
- `AuthStatus.authenticated` - User is logged in
- `AuthStatus.unauthenticated` - User is not logged in
- `AuthStatus.error` - Authentication error occurred

### Reactive UI Updates

The `AuthProvider` automatically notifies UI components when authentication state changes:

```dart
Consumer<AuthProvider>(
  builder: (context, authProvider, child) {
    return authProvider.isAuthenticated 
        ? AuthenticatedWidget() 
        : LoginWidget();
  },
)
```

## Environment Configuration

The authentication system uses the environment configuration:

```bash
# .env file
API_BASE_URL=https://agridaan-be.bhashini.co.in
```

Login endpoint is automatically constructed as: `{API_BASE_URL}/login-user`

## Error Handling

### Common Error Scenarios

1. **Network Errors**: Handled with user-friendly messages
2. **Invalid Credentials**: Clear error messages from API
3. **Captcha Errors**: Automatic captcha refresh
4. **Token Expiration**: Automatic logout and re-authentication prompt

### Error Recovery

```dart
// Clear error state
authProvider.clearError();

// Retry login after error
await authProvider.login(loginRequest);
```

## Testing

### Unit Testing

```dart
// Test login request validation
final request = LoginRequest(
  email: 'test@example.com',
  password: 'password',
  secureId: 'secure_id',
  captchaText: 'CAPTCHA',
);

expect(AuthService.validateLoginRequest(request), isTrue);
```

### Widget Testing

```dart
// Test login form
await tester.pumpWidget(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
    ],
    child: MaterialApp(home: LoginFormWidget()),
  ),
);
```

## Deployment Considerations

### 1. Environment Variables

Ensure proper environment configuration for different stages:

```bash
# Development
API_BASE_URL=https://dev-api.bhashini.co.in

# Production
API_BASE_URL=https://agridaan-be.bhashini.co.in
```

### 2. Security

- Never commit sensitive tokens to version control
- Use environment-specific API endpoints
- Implement proper token refresh mechanisms

### 3. Error Monitoring

- Implement error tracking for authentication failures
- Monitor token expiration patterns
- Track login success/failure rates

## Migration from Hardcoded Tokens

The system has been migrated from hardcoded tokens to dynamic token management:

### Before (Hardcoded)
```dart
static const String _bearerToken = 'hardcoded_token';
```

### After (Dynamic)
```dart
// Token is automatically injected from AuthManager
final headers = _getHeadersWithAuth();
```

## Best Practices

1. **Always check authentication status** before making API calls
2. **Handle token expiration** gracefully
3. **Provide clear error messages** to users
4. **Implement proper loading states** during authentication
5. **Use secure storage** for sensitive data
6. **Validate input** before making API requests
7. **Implement proper logout** functionality
8. **Monitor authentication metrics** in production

## Troubleshooting

### Common Issues

1. **Token not being sent**: Check if `AuthManager` is properly initialized
2. **Login failing**: Verify API endpoint and request format
3. **Captcha not loading**: Check network connectivity and API response
4. **Token expiration**: Implement proper token refresh logic

### Debug Information

```dart
// Check current authentication state
print('Auth Status: ${authProvider.status}');
print('Is Authenticated: ${authProvider.isAuthenticated}');
print('Current Token: ${AuthManager.instance.getToken()}');
print('User: ${authProvider.user}');
```

This authentication system provides a robust, secure, and enterprise-grade solution for user authentication in the Bhashadaan application.
