# Environment Setup Guide

This guide explains how to set up and use the environment configuration files for the Bhashadaan Flutter application.

## Environment Files Created

The following environment files have been created for you:

- `.env` - Default environment (development)
- `.env.development` - Development environment
- `.env.staging` - Staging environment  
- `.env.production` - Production environment
- `.env.example` - Template file for reference

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

## Next Steps

### 1. Update API Bearer Tokens

Replace the placeholder `your_*_bearer_token_here` values in each environment file with the actual API bearer tokens:

```bash
# For development
API_BEARER_TOKEN=your_actual_development_token

# For staging  
API_BEARER_TOKEN=your_actual_staging_token

# For production
API_BEARER_TOKEN=your_actual_production_token
```

### 2. Verify URLs

Ensure the API URLs in each environment file are correct for your deployment:

- **Development**: Use development/staging API endpoints
- **Staging**: Use staging API endpoints
- **Production**: Use production API endpoints

### 3. Test Configuration

The app will automatically load the appropriate environment file based on the `ENVIRONMENT` variable. You can test this by running:

```bash
flutter run --dart-define=ENVIRONMENT=development
flutter run --dart-define=ENVIRONMENT=staging
flutter run --dart-define=ENVIRONMENT=production
```

## Security Notes

- **Never commit sensitive tokens** to version control
- The `.env.local` files are automatically ignored by git for local overrides
- Use environment-specific tokens for each deployment environment
- Consider using a secrets management system for production deployments

## Usage in Code

The environment variables are automatically loaded by the `AppConfig` class:

```dart
// Access configuration
String baseUrl = AppConfig.instance.apiBaseUrl;
String token = AppConfig.instance.apiBearerToken;
String env = AppConfig.instance.environment;

// Check environment
bool isProduction = AppConfig.instance.isProduction;
```

## Troubleshooting

If you encounter issues:

1. **Environment file not found**: Ensure the `.env` file exists in the project root
2. **Missing variables**: Check that all required variables are defined
3. **Build errors**: Run `flutter pub get` after adding the `flutter_dotenv` dependency
4. **Token issues**: Verify the API bearer tokens are correct and have proper permissions

## Support

For additional help, refer to the `ENVIRONMENT_SETUP.md` file or contact the development team.

