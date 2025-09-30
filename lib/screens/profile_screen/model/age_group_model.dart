class AgeModel {
    String value;
    String label;
    int minAge;
    int maxAge;

    AgeModel({
        required this.value,
        required this.label,
        required this.minAge,
        required this.maxAge,
    });

    factory AgeModel.fromJson(Map<String, dynamic> json) => AgeModel(
        value: json['value']??'',
        label: json['label']??'',
        minAge: json['minAge']??0,
        maxAge: json['maxAge']??0,
    );

    Map<String, dynamic> toJson() => {
        'value': value,
        'label': label,
        'minAge': minAge,
        'maxAge': maxAge,
    };
}