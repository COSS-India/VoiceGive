class MockApiResponse {
  static const String contributeSentencesResponse = '''
{
  "success": true,
  "data": {
    "sessionId": "session-123-abc",
    "language": "Marathi",
    "sentences": [
     {
    "sentenceId": "sent-001",
    "text": "आपण उद्या सहलीसाठी निघणार आहोत.",
    "sequenceNumber": 1,
    "metadata": {
      "category": "travel",
      "difficulty": "easy"
    }
  },
  {
    "sentenceId": "sent-002",
    "text": "पक्षी उडताना फार सुंदर दिसतात.",
    "sequenceNumber": 2,
    "metadata": {
      "category": "nature",
      "difficulty": "medium"
    }
  },
  {
    "sentenceId": "sent-003",
    "text": "शाळेतील कार्यक्रम खूप छान होता.",
    "sequenceNumber": 3,
    "metadata": {
      "category": "education",
      "difficulty": "easy"
    }
  },
  {
    "sentenceId": "sent-004",
    "text": "संगणकावर काम करताना लक्ष द्यावे.",
    "sequenceNumber": 4,
    "metadata": {
      "category": "technology",
      "difficulty": "medium"
    }
  },
  {
    "sentenceId": "sent-005",
    "text": "आम्ही नवीन खेळ खेळलो.",
    "sequenceNumber": 5,
    "metadata": {
      "category": "sports",
      "difficulty": "easy"
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
