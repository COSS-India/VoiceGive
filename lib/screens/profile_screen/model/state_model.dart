class StateModel {
    String stateId;
    String stateName;

    StateModel({
        required this.stateId,
        required this.stateName,
    });

    factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
        stateId: json['stateId']??'',
        stateName: json['stateName']??'',
    );

    Map<String, dynamic> toJson() => {
        'stateId': stateId,
        'stateName': stateName,
    };
}