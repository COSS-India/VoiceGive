import 'dart:convert';
import 'dart:io';

import 'package:bhashadaan/constants/api_url.dart';
import 'package:bhashadaan/constants/network_headers.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

class BoloService {
  Future<Response> getContributionSentances(
      {required String language, int? count}) async {
    Map data = {
      "language": language,
      "count": count ?? 5,
    };

    Response response = await post(
      Uri.parse(ApiUrl.getSentancesForRecordingUrl),
      headers: NetworkHeaders.postHeader,
      body: jsonEncode(data),
    );
    return response;
  }

  Future<Response> submitContributeAudio({
    required String audioFilePath,
    required String sessionId,
    required String sentenceId,
    required int duration,
    required String language,
    required int sequenceNumber,
  }) async {
    final request = MultipartRequest('POST', Uri.parse(ApiUrl.sumbitAudioUrl))
      ..fields['sessionId'] = sessionId
      ..fields['sentenceId'] = sentenceId
      ..fields['duration'] = duration.toString()
      ..fields['language'] = language
      ..fields['sequenceNumber'] = sequenceNumber.toString()
      ..fields['metadata'] = "String"
      ..headers.addAll(NetworkHeaders.postHeader);

    final audioFile = File(audioFilePath);

    request.files.add(
      await MultipartFile.fromPath(
        'audio',
        audioFile.path,
        contentType: MediaType('audio', 'wav'),
      ),
    );

    try {
      final streamedResponse = await request.send();
      return await Response.fromStream(streamedResponse);
    } catch (e) {
      throw Exception('Failed to upload audio: $e');
    }
  }

  Future<Response> skipContribution({
    required String sessionId,
    required String sentenceId,
    required String reason,
    required String comment,
  }) async {
    final body = jsonEncode({
      'sessionId': sessionId,
      'sentenceId': sentenceId,
      'reason': reason,
      'comment': comment,
    });

    final response = await post(
      Uri.parse(ApiUrl.skipContributionUrl),
      headers: NetworkHeaders.postHeader,
      body: body,
    );

    return response;
  }

  Future<Response> reportContribution({
    required String sentenceId,
    required String reportType,
    required String description,
  }) async {
    const url = ApiUrl.reportIssueUrl;

    final body = jsonEncode({
      'sentenceId': sentenceId,
      'reportType': reportType,
      'description': description,
    });

    final response = await post(
      Uri.parse(url),
      headers: NetworkHeaders.postHeader,
      body: body,
    );

    return response;
  }

  Future<Response> contributeSessionCompleted({
    required String sessionId,
  }) async {
    const url = ApiUrl.contributeSessionCompleteUrl;

    final body = jsonEncode({
      'sessionId': sessionId,
    });

    final response = await post(
      Uri.parse(url),
      headers: NetworkHeaders.postHeader,
      body: body,
    );

    return response;
  }

  Future<Response> validateSessionCompleted({
    required String sessionId,
  }) async {
    const url = ApiUrl.validationSessionCompleteUrl;

    final body = jsonEncode({
      'sessionId': sessionId,
    });

    final response = await post(
      Uri.parse(url),
      headers: NetworkHeaders.postHeader,
      body: body,
    );

    return response;
  }

  Future<Response> submitValidation({
    required String sessionId,
    required String contributionId,
    required String sentenceId,
    required String decision,
    required String feedback,
    required int sequenceNumber,
  }) async {
    final body = jsonEncode({
      'sessionId': sessionId,
      'contributionId': contributionId,
      'sentenceId': sentenceId,
      'decision': decision,
      'feedback': feedback,
      'sequenceNumber': sequenceNumber,
    });

    final response = await post(
      Uri.parse(ApiUrl.submitValidationUrl),
      headers: NetworkHeaders.postHeader,
      body: body,
    );

    return response;
  }

  Future<Response> getValidationsQueue({
    required String language,
    required int count,
  }) async {
    final url =
        '${ApiUrl.getValidationsQueUrl}?language=$language&count=$count';

    final response = await get(
      Uri.parse(url),
      headers: NetworkHeaders.getHeader,
    );

    return response;
  }
}
