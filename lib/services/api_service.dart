import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://api-servic3.bhashini.co.in';

  // TODO: Replace this with a secure token source. Hardcoding is temporary.
  static const String _bearerToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjU3NDIsInVzZXJOYW1lIjoiIFN1cHJpeWEiLCJpYXQiOjE3NTg3ODU1MjQsImV4cCI6MTc1ODg3MTkyNH0.PHORNzKilYNuyLVQbLnkwwH6iTYs0_W1EGIwjWXk5o4';

  static Future<http.Response> skip({
    required String device,
    required String browser,
    required String userName,
    required String language,
    required int sentenceId,
    required String stateRegion,
    required int userNum,
    required String country,
    required double latitude,
    required double longitude,
    required String type,
  }) async {
    final uri = Uri.parse('$_baseUrl/api/skip');

    final Map<String, dynamic> payload = {
      'device': device,
      'browser': browser,
      'userName': userName,
      'language': language,
      'sentenceId': sentenceId,
      'state_region': stateRegion,
      'userNum': userNum,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
      'type': type,
    };

    final headers = <String, String>{
      'accept': '*/*',
      'accept-language': 'en-US,en;q=0.9',
      'content-type': 'application/json',
      'authorization': 'Bearer $_bearerToken',
      'origin': 'https://bhashini.gov.in',
      'referer': 'https://bhashini.gov.in/',
      'Cookie': 'SERVERID=GEN3',
    };

    return await http.post(
      uri,
      headers: headers,
      body: jsonEncode(payload),
    );
  }

  static Future<Map<String, dynamic>> fetchOneSentence() async {
    final response = await skip(
      device: 'Linux null',
      browser: 'Chrome 140.0.0.0',
      userName: 'Supriya',
      language: 'English',
      sentenceId: 2658272,
      stateRegion: 'Karnataka',
      userNum: 5742,
      country: 'India',
      latitude: 12.9753,
      longitude: 77.591,
      type: 'text',
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Skip API failed: ${response.statusCode} ${response.body}');
    }

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    return decoded;
  }

  static Future<http.Response> mediaText({
    required String language,
    required String userName,
    required int userNum,
    required int platformId,
  }) async {
    final uri = Uri.parse('$_baseUrl/api/media/text');

    final payload = {
      'language': language,
      'userName': userName,
      'userNum': userNum,
      'platformId': platformId,
    };

    final headers = <String, String>{
      'accept': '*/*',
      'accept-language': 'en-US,en;q=0.9',
      'content-type': 'application/json',
      'authorization': 'Bearer $_bearerToken',
      'origin': 'https://bhashini.gov.in',
      'referer': 'https://bhashini.gov.in/',
      'Cookie': 'SERVERID=GEN3',
    };

    return await http.post(uri, headers: headers, body: jsonEncode(payload));
  }

  static Future<Map<String, dynamic>> fetchOneSentenceFromMediaText({
    required String language,
    required String userName,
    required int userNum,
    int platformId = 1,
  }) async {
    final response = await mediaText(
      language: language,
      userName: userName,
      userNum: userNum,
      platformId: platformId,
    );
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Media Text API failed: ${response.statusCode} ${response.body}');
    }
    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    return decoded;
  }

  static Future<http.Response> validateAccept({
    required int validateId,
    required String device,
    required String browser,
    required String userName,
    required String fromLanguage,
    required int sentenceId,
    required String state,
    required String country,
    required double latitude,
    required double longitude,
    required String type,
    required int userNum,
  }) async {
    final uri = Uri.parse('$_baseUrl/api/validate/$validateId/accept');

    final payload = {
      'device': device,
      'browser': browser,
      'userName': userName,
      'fromLanguage': fromLanguage,
      'sentenceId': sentenceId,
      'state': state,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
      'type': type,
      'userNum': userNum,
    };

    final headers = <String, String>{
      'accept': '*/*',
      'accept-language': 'en-US,en;q=0.9',
      'content-type': 'application/json',
      'authorization': 'Bearer $_bearerToken',
      'origin': 'https://bhashini.gov.in',
      'referer': 'https://bhashini.gov.in/',
      'Cookie': 'SERVERID=GEN3',
    };

    return await http.post(uri, headers: headers, body: jsonEncode(payload));
  }

  static Future<http.Response> validateReject({
    required int validateId,
    required String device,
    required String browser,
    required String userName,
    required String fromLanguage,
    required int sentenceId,
    required String state,
    required String country,
    required double latitude,
    required double longitude,
    required String type,
    required int userNum,
  }) async {
    final uri = Uri.parse('$_baseUrl/api/validate/$validateId/reject');

    final payload = {
      'device': device,
      'browser': browser,
      'userName': userName,
      'fromLanguage': fromLanguage,
      'sentenceId': sentenceId,
      'state': state,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
      'type': type,
      'userNum': userNum,
    };

    final headers = <String, String>{
      'accept': '*/*',
      'accept-language': 'en-US,en;q=0.9',
      'content-type': 'application/json',
      'authorization': 'Bearer $_bearerToken',
      'origin': 'https://bhashini.gov.in',
      'referer': 'https://bhashini.gov.in/',
      'Cookie': 'SERVERID=GEN3',
    };

    return await http.post(uri, headers: headers, body: jsonEncode(payload));
  }

  static Future<Map<String, dynamic>> getContributionsText({
    required int userNum,
    required String fromLanguage,
    String toLanguage = '',
    required String userName,
    int platformId = 1,
  }) async {
    final uri = Uri.parse(
        '$_baseUrl/api/contributions/text/$userNum?from=$fromLanguage&to=$toLanguage&username=$userName&platformId=$platformId');

    final headers = <String, String>{
      'accept': '*/*',
      'accept-language': 'en-US,en;q=0.9',
      'authorization': 'Bearer $_bearerToken',
      'origin': 'https://bhashini.gov.in',
      'referer': 'https://bhashini.gov.in/',
      'Cookie': 'SERVERID=GEN3',
    };

    final response = await http.get(uri, headers: headers);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Contributions API failed: ${response.statusCode} ${response.body}');
    }
    return jsonDecode(response.body) as Map<String, dynamic>;
  }
}


