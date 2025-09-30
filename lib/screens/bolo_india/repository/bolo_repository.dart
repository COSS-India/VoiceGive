import 'dart:convert';

import 'package:bhashadaan/screens/bolo_india/models/bolo_contribute_sentence.dart';
import 'package:bhashadaan/screens/bolo_india/models/bolo_session_completed_model.dart';
import 'package:bhashadaan/screens/bolo_india/service/bolo_service.dart';
import 'package:http/http.dart';

class BoloRepository {
  BoloService boloService = BoloService();
  Future<BoloContributeSentence?> getContributionSentances(
      {required String language, int? count}) async {
    try {
      Response response = await boloService.getContributionSentances(
          language: language, count: count);
      if (response.statusCode == 200) {
        var content = jsonDecode(response.body);
        var data = content['data'];
        if (data != null) {
          return BoloContributeSentence.fromJson(data);
        }
      } else {
        throw Exception('Failed to load sentences');
      }
    } catch (e) {
      throw Exception('Failed to load sentences: $e');
    }
    return null;
  }

  Future<bool> submitContributeAudio({
    required String audioFilePath,
    required String sessionId,
    required String sentenceId,
    required int duration,
    required String language,
    required int sequenceNumber,
  }) async {
    try {
      Response response = await boloService.submitContributeAudio(
        language: language,
        sequenceNumber: sequenceNumber,
        audioFilePath: audioFilePath,
        sessionId: sessionId,
        sentenceId: sentenceId,
        duration: duration,
      );
      if (response.statusCode == 200) {
        var content = jsonDecode(response.body);
        var data = content['data'];

        return data['success'] ?? false;
      } else {
        throw Exception('Failed to upload audio');
      }
    } catch (e) {
      throw Exception('Failed to upload audio: $e');
    }
  }

  Future<Sentence?> skipContribution({
    required String sessionId,
    required String sentenceId,
    required String reason,
    required String comment,
  }) async {
    try {
      Response response = await boloService.skipContribution(
          sessionId: sessionId,
          sentenceId: sentenceId,
          reason: reason,
          comment: comment);
      if (response.statusCode == 200) {
        var content = jsonDecode(response.body);
        if (content['success'] == true) {
          return content['data']?['nextSentence'] != null
              ? Sentence.fromJson(content['data']['nextSentence'])
              : null;
        }
        return null;
      }
    } catch (e) {
      throw Exception('Failed to skip contribution: $e');
    }
    return null;
  }

  Future<bool> reportSentence({
    required String sentenceId,
    required String reportType,
    required String description,
  }) async {
    try {
      Response response = await boloService.reportContribution(
          sentenceId: sentenceId,
          reportType: reportType,
          description: description);
      if (response.statusCode == 200) {
        var content = jsonDecode(response.body);
        return content['success'] ?? false;
      }
    } catch (e) {
      throw Exception('Failed to report contribution: $e');
    }
    return false;
  }

  Future<BoloSessionCompletedModel?> completeSession({
    required String sessionId,
  }) async {
    try {
      Response response =
          await boloService.completeSession(sessionId: sessionId);
      if (response.statusCode == 200) {
        var content = jsonDecode(response.body);
        return BoloSessionCompletedModel.fromJson(content);
      }
    } catch (e) {
      throw Exception('Failed to complete session: $e');
    }
    return null;
  }
}
