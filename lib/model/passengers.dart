class Passengers {
  final int id;
  final bool status;
  final String created;
  final int operation_id;
  final int user_id;

  Passengers(
      {required this.id,
      required this.status,
      required this.created,
      required this.operation_id,
      required this.user_id});

  factory Passengers.fromJson(Map<String, dynamic> usersjson) => Passengers(
        id: usersjson["id"],
        status: usersjson["status"],
        created: usersjson["created"],
        operation_id: usersjson["operation_id"],
        user_id: usersjson["user_id"],
      );
}
