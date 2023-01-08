class Users {
  final int id;
  final String name;
  final String email;
  final bool driver;
  final String created;
  final int group_id;
  final int family_id;

  Users(
      {required this.id,
      required this.name,
      required this.email,
      required this.driver,
      required this.created,
      required this.group_id,
      required this.family_id});

  factory Users.fromJson(Map<String, dynamic> usersjson) => Users(
        id: usersjson["id"],
        name: usersjson["name"],
        email: usersjson["email"],
        driver: usersjson["driver"],
        created: usersjson["created"],
        group_id: usersjson["group_id"],
        family_id: usersjson["family_id"],
      );
}
