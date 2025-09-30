import 'dart:convert';

import 'package:bhashadaan/screens/bolo_india/models/bolo_validate_model.dart';
import 'package:bhashadaan/screens/bolo_india/service/bolo_service.dart';
import 'package:http/http.dart';

class BoloValidateRepository {
  BoloService boloService = BoloService();

  Future<ValidationQueueModel?> getValidationsQueue({
    required String language,
    required int count,
  }) async {
    try {
      Response response = await boloService.getValidationsQueue(
          count: count, language: language);
      if (response.statusCode == 200) {
        var content = jsonDecode(response.body);
        if (content['success'] == true) {
          return ValidationQueueModel.fromJson(content['data']);
        }
      }
    } catch (e) {
      throw Exception('Failed to fetch validation queue: $e');
    }
    return null;
  }

  // Future<bool> submitValidation({
  //   required String sessionId,
  //   required String contributionId,
  //   required String sentenceId,
  //   required String decision,
  //   required String feedback,
  //   required int sequenceNumber,
  // }) async {
  //   try {
  //     Response response = await boloService.submitValidation(
  //       contributionId: contributionId,
  //       sentenceId: sentenceId,
  //       decision: decision,
  //       feedback: feedback,
  //       sequenceNumber: sequenceNumber,
  //       sessionId: sessionId,
  //     );
  //   } catch (e) {
  //     throw Exception('Failed to submit validation: $e');
  //   }
  // }
}
