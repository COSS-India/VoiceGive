class MockApiResponse {
  static const String contributeSentencesResponse = '''
{
  "success": true,
  "data": {
    "sessionId": "session-123-abc",
    "language": "Marathi",
    "sentences": [
      {
        "sentenceId": "sent-12345",
        "text": "तुम्ही मला नेहमीच किल्ल्यांबाबत सांगता तशी त्या मार्गदर्शकाने आम्हांला किल्ल्याबाबत खूप छान माहिती पुरवली.",
        "sequenceNumber": 1,
        "metadata": {
          "category": "string",
          "difficulty": "string"
        }
      },
      {
        "sentenceId": "sent-12345",
        "text": "तुम्ही मला नेहमीच किल्ल्यांबाबत सांगता तशी त्या मार्गदर्शकाने आम्हांला किल्ल्याबाबत खूप छान माहिती पुरवली.",
        "sequenceNumber": 1,
        "metadata": {
          "category": "string",
          "difficulty": "string"
        }
      },
      {
        "sentenceId": "sent-12345",
        "text": "तुम्ही मला नेहमीच किल्ल्यांबाबत सांगता तशी त्या मार्गदर्शकाने आम्हांला किल्ल्याबाबत खूप छान माहिती पुरवली.",
        "sequenceNumber": 1,
        "metadata": {
          "category": "string",
          "difficulty": "string"
        }
      },
      {
        "sentenceId": "sent-12345",
        "text": "तुम्ही मला नेहमीच किल्ल्यांबाबत सांगता तशी त्या मार्गदर्शकाने आम्हांला किल्ल्याबाबत खूप छान माहिती पुरवली.",
        "sequenceNumber": 1,
        "metadata": {
          "category": "string",
          "difficulty": "string"
        }
      },
      {
        "sentenceId": "sent-12345",
        "text": "तुम्ही मला नेहमीच किल्ल्यांबाबत सांगता तशी त्या मार्गदर्शकाने आम्हांला किल्ल्याबाबत खूप छान माहिती पुरवली.",
        "sequenceNumber": 1,
        "metadata": {
          "category": "string",
          "difficulty": "string"
        }
      }
    ],
    "totalCount": 5
  }
}
''';
  String submitContributeAudio = '''{
  "success": true,
  "message": "Recording submitted successfully",
  "data": {
    "contributionId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "audioUrl": "string",
    "duration": 20,
    "status": "pending",
    "sequenceNumber": 1,
    "totalInSession": 5,
    "remainingInSession": 4,
    "progressPercentage": 20
  }
}''';
  String skipContribution = '''{
  "success": true,
  "data": {
    "nextSentence": {
      "sentenceId": "string",
      "text": "string",
      "sequenceNumber": 0
    }
  }
}''';
  String reportContribution = '''{
  "success": true,
  "message": "Report submitted. Thank you for your feedback."
}''';

  String completeSession = '''{
  "success": true,
  "message": "Session completed successfully",
  "data": {
    "sessionId": "string",
    "totalContributions": 5,
    "userTotalContributions": 5,
    "certificateProgress": {
      "contributionsCompleted": 5,
      "contributionsRequired": 5,
      "validationsCompleted": 0,
      "validationsRequired": 25,
      "isEligible": false,
      "percentageComplete": 17
    }
  }
}''';
}
