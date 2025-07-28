class ServiceModel {
  final int id;
  final String title;

  ServiceModel({required this.id, required this.title});

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      title: json['title'],
    );
  }
}
