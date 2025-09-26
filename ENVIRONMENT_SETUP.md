# Environment Configuration Setup

This document explains how to configure and use environment variables in the Bhashadaan Flutter application following enterprise standards.

## Overview

The application now uses environment-based configuration instead of hardcoded URLs and API keys. This allows for:
- Different configurations for development, staging, and production environments
- Secure management of sensitive data like API keys
- Easy deployment across different environments

## Environment Files

The following environment files are available:

- `.env` - Default environment (development)
- `.env.development` - Development environment
- `.env.staging` - Staging environment  
- `.env.production` - Production environment

## Configuration Variables

Each environment file contains the following variables:

```bash
# API Configuration
API_BASE_URL=https://agridaan-be.bhashini.co.in
API_ORIGIN_URL=https://bhashini.gov.in
API_REFERER_URL=https://bhashini.gov.in/

# Authentication
API_BEARER_TOKEN=your_bearer_token_here

# Environment
ENVIRONMENT=development
```

## Usage

### Automatic Environment Detection

The app automatically loads the appropriate environment file based on the `ENVIRONMENT` variable or defaults to `.env` for development.

### Manual Environment Selection

You can specify a particular environment when initializing the app:

```dart
// In main.dart
await AppConfig.initialize(environment: 'production');
```

### Accessing Configuration

Use the `AppConfig` singleton to access configuration values:

```dart
// Get API base URL
String baseUrl = AppConfig.instance.apiBaseUrl;

// Get environment-specific endpoints
Map<String, String> endpoints = AppConfig.instance.apiEndpoints;

// Get default headers
Map<String, String> headers = AppConfig.instance.defaultHeaders;

// Check environment
bool isProduction = AppConfig.instance.isProduction;
```

## Security Considerations

### Sensitive Data

- **Never commit sensitive data** like production API keys to version control
- Use `.env.local` files for local development with sensitive data
- The `.gitignore` file excludes `.env.local` files from version control

### Environment File Management

1. **Development**: Use `.env` or `.env.development` with test/development API keys
2. **Staging**: Use `.env.staging` with staging environment URLs and keys
3. **Production**: Use `.env.production` with production URLs and keys

### Local Development Setup

For local development with sensitive data:

1. Create a `.env.local` file:
```bash
cp .env .env.local
```

2. Update `.env.local` with your local configuration:
```bash
# Local development overrides
API_BASE_URL=http://localhost:3000
API_BEARER_TOKEN=your_local_token
```

3. The `.env.local` file is automatically ignored by git

## Deployment

### CI/CD Integration

For CI/CD pipelines, set environment variables in your deployment platform:

```bash
# Example for GitHub Actions
env:
  API_BASE_URL: ${{ secrets.API_BASE_URL }}
  API_BEARER_TOKEN: ${{ secrets.API_BEARER_TOKEN }}
  ENVIRONMENT: production
```

### Environment-Specific Builds

You can create environment-specific builds:

```bash
# Development build
flutter build apk --dart-define=ENVIRONMENT=development

# Production build  
flutter build apk --dart-define=ENVIRONMENT=production
```

## API Service Integration

The `ApiService` class now automatically uses the environment configuration:

- All API endpoints are dynamically constructed from the base URL
- Headers are centrally managed through `AppConfig`
- No more hardcoded URLs or tokens in the service layer

## Validation

The configuration is validated on app startup. If required environment variables are missing, the app will throw an exception with details about what's missing.

## Troubleshooting

### Common Issues

1. **Environment file not found**: Ensure the `.env` file exists in the project root
2. **Missing variables**: Check that all required variables are defined in your environment file
3. **Build errors**: Run `flutter pub get` after adding the `flutter_dotenv` dependency

### Debugging

You can check the current configuration:

```dart
print('Current environment: ${AppConfig.instance.environment}');
print('API Base URL: ${AppConfig.instance.apiBaseUrl}');
```

## Migration from Hardcoded Values

The migration from hardcoded URLs to environment-based configuration is complete. All API calls now use the centralized configuration system.

### Benefits Achieved

- ✅ Centralized configuration management
- ✅ Environment-specific deployments
- ✅ Secure handling of sensitive data
- ✅ Easy maintenance and updates
- ✅ Enterprise-standard practices
- ✅ No more hardcoded URLs in source code
