class GenderModel {
    String value;
    String label;

    GenderModel({
        required this.value,
        required this.label,
    });

    factory GenderModel.fromJson(Map<String, dynamic> json) => GenderModel(
        value: json['value'],
        label: json['label'],
    );

    Map<String, dynamic> toJson() => {
        'value': value,
        'label': label,
    };
}