import 'package:flutter_dotenv/flutter_dotenv.dart';

/// AppConfig class manages environment variables and API endpoints
/// following Flutter enterprise standards
class AppConfig {
  static AppConfig? _instance;
  static AppConfig get instance {
    _instance ??= AppConfig._internal();
    return _instance!;
  }

  AppConfig._internal();

  /// Initialize the configuration with environment variables
  static Future<void> initialize({String? environment}) async {
    String envFile = '.env';
    
    // Determine which environment file to load
    if (environment != null) {
      switch (environment.toLowerCase()) {
        case 'development':
          envFile = '.env.development';
          break;
        case 'staging':
          envFile = '.env.staging';
          break;
        case 'production':
          envFile = '.env.production';
          break;
        default:
          envFile = '.env';
      }
    }

    // Load the environment file
    await dotenv.load(fileName: envFile);
  }

  /// API Base URL
  String get apiBaseUrl => dotenv.env['API_BASE_URL'] ?? 'https://agridaan-be.bhashini.co.in';

  /// API Origin URL for CORS headers
  String get apiOriginUrl => dotenv.env['API_ORIGIN_URL'] ?? 'https://bhashini.gov.in';

  /// API Referer URL for CORS headers
  String get apiRefererUrl => dotenv.env['API_REFERER_URL'] ?? 'https://bhashini.gov.in/';

  /// API Bearer Token
  String get apiBearerToken => dotenv.env['API_BEARER_TOKEN'] ?? '';

  /// Current Environment
  String get environment => dotenv.env['ENVIRONMENT'] ?? 'development';

  /// Check if running in development mode
  bool get isDevelopment => environment.toLowerCase() == 'development';

  /// Check if running in staging mode
  bool get isStaging => environment.toLowerCase() == 'staging';

  /// Check if running in production mode
  bool get isProduction => environment.toLowerCase() == 'production';

  /// Get environment-specific API endpoints
  Map<String, String> get apiEndpoints => {
    'login': '$apiBaseUrl/login-user',
    'skip': '$apiBaseUrl/skip',
    'mediaText': '$apiBaseUrl/media/text',
    'validateAccept': '$apiBaseUrl/validate',
    'validateReject': '$apiBaseUrl/validate',
    'contributions': '$apiBaseUrl/contributions/text',
    'captcha': '$apiBaseUrl/get-secure-cap',
  };

  /// Get default headers for API requests
  Map<String, String> get defaultHeaders => {
    'accept': '*/*',
    'accept-language': 'en-US,en;q=0.9',
    'content-type': 'application/json',
    'authorization': 'Bearer $apiBearerToken',
    'origin': apiOriginUrl,
    'referer': apiRefererUrl,
    'Cookie': 'SERVERID=GEN3',
  };

  /// Get minimal headers for API requests (used for CORS-sensitive endpoints)
  Map<String, String> get minimalHeaders => {
    'accept': 'application/json',
    'user-agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36',
  };

  /// Validate that all required environment variables are present
  bool validateConfig() {
    final requiredVars = ['API_BASE_URL', 'API_ORIGIN_URL', 'API_REFERER_URL'];
    
    for (final varName in requiredVars) {
      if (dotenv.env[varName] == null || dotenv.env[varName]!.isEmpty) {
        throw Exception('Required environment variable $varName is not set');
      }
    }
    
    return true;
  }

  /// Get a specific environment variable
  String? getEnv(String key) => dotenv.env[key];

  /// Get a specific environment variable with default value
  String getEnvOrDefault(String key, String defaultValue) => 
      dotenv.env[key] ?? defaultValue;
}
