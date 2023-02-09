class Bus {
  final String name;
  final int id, group_id;
  final DateTime timestamp;

  Bus({
    required this.id,
    required this.name,
    required this.timestamp,
    required this.group_id,
  });
}

List<Bus> buses_list = [
  Bus(id: 1, name: "1号車", timestamp: DateTime.now(), group_id: 1),
  Bus(id: 2, name: "2号車", timestamp: DateTime.now(), group_id: 1),
  Bus(id: 3, name: "3号車", timestamp: DateTime.now(), group_id: 1),
  Bus(id: 4, name: "4号車", timestamp: DateTime.now(), group_id: 1),
];

class Groups {
  final String name, address;
  final int id;
  final DateTime timestamp;

  Groups({
    required this.id,
    required this.name,
    required this.timestamp,
    required this.address,
  });
}

List<Groups> groups_list = [
  Groups(id: 1, name: "ぴよみる幼稚園", timestamp: DateTime.now(), address: "大阪"),
];

class Operations {
  final int id, start, end, bus_id;
  final DateTime timestamp;

  Operations({
    required this.id,
    required this.bus_id,
    required this.timestamp,
    required this.start,
    required this.end,
  });
}

List<Operations> operations_list = [
  Operations(id: 1, start: 1, end: 0, timestamp: DateTime.now(), bus_id: 1),
  Operations(id: 2, start: 1, end: 0, timestamp: DateTime.now(), bus_id: 2),
  Operations(id: 3, start: 0, end: 1, timestamp: DateTime.now(), bus_id: 3),
  Operations(id: 4, start: 0, end: 1, timestamp: DateTime.now(), bus_id: 4),
];

class Passengers {
  final String name, image;
  final int id, operation_id, user_id;
  final DateTime timestamp;
  final bool status;

  Passengers(
      {required this.name,
      required this.image,
      required this.id,
      required this.timestamp,
      required this.operation_id,
      required this.user_id,
      required this.status});
}

List<Passengers> passengers_list = [
  Passengers(
      id: 1,
      name: "ぴよ ぴよこ",
      image: "kid1.png",
      operation_id: 1,
      user_id: 1,
      timestamp: DateTime.now(),
      status: true),
  Passengers(
      id: 2,
      name: "ぴよ ぴよ太郎",
      image: "kid2.png",
      operation_id: 1,
      user_id: 1,
      timestamp: DateTime.now(),
      status: true),
  Passengers(
      id: 4,
      name: "みる みるこ",
      image: "kid3.png",
      operation_id: 1,
      user_id: 1,
      timestamp: DateTime.now(),
      status: true),
  Passengers(
      id: 5,
      name: "みる みる太郎",
      image: "kid4.png",
      operation_id: 1,
      user_id: 1,
      timestamp: DateTime.now(),
      status: true),
  Passengers(
      id: 1,
      name: "ぴよ ぴよこ",
      image: "kid5.png",
      operation_id: 1,
      user_id: 1,
      timestamp: DateTime.now(),
      status: true),
  Passengers(
      id: 2,
      name: "ぴよ ぴよ太郎",
      image: "kid6.png",
      operation_id: 1,
      user_id: 1,
      timestamp: DateTime.now(),
      status: true),
  Passengers(
      id: 4,
      name: "みる みるこ",
      image: "kid7.png",
      operation_id: 1,
      user_id: 1,
      timestamp: DateTime.now(),
      status: true),
  Passengers(
      id: 5,
      name: "みる みる太郎",
      image: "kid8.png",
      operation_id: 1,
      user_id: 1,
      timestamp: DateTime.now(),
      status: true),
  Passengers(
      id: 4,
      name: "みる みるこ",
      image: "kid1.png",
      operation_id: 1,
      user_id: 1,
      timestamp: DateTime.now(),
      status: true),
  Passengers(
      id: 5,
      name: "みる みる太郎",
      image: "kid2.png",
      operation_id: 1,
      user_id: 1,
      timestamp: DateTime.now(),
      status: true),
  Passengers(
      id: 4,
      name: "みる みるこ",
      image: "kid3.png",
      operation_id: 1,
      user_id: 1,
      timestamp: DateTime.now(),
      status: true),
  Passengers(
      id: 5,
      name: "みる みる太郎",
      image: "kid4.png",
      operation_id: 1,
      user_id: 1,
      timestamp: DateTime.now(),
      status: true),
];

class User {
  final String name, email, password, image;
  final int id, group_id;
  final DateTime timestamp;
  final bool driver;

  User(
      {required this.name,
      required this.email,
      required this.id,
      required this.timestamp,
      required this.group_id,
      required this.password,
      required this.driver,
      required this.image});
}

List<User> users_list = [
  User(
      id: 1,
      name: "ぴよ ぴよこ",
      email: "abc@mail.com",
      image: "kid1.png",
      group_id: 1,
      password: "abc111",
      timestamp: DateTime.now(),
      driver: false),
  User(
      id: 2,
      name: "ぴよ ぴよみ",
      email: "abc@mail.com",
      image: "kid2.png",
      group_id: 1,
      password: "abc222",
      timestamp: DateTime.now(),
      driver: false),
  User(
      id: 3,
      name: "ぴよ ぴよ太郎",
      email: "abc@mail.com",
      image: "kid3.png",
      group_id: 1,
      password: "abc111",
      timestamp: DateTime.now(),
      driver: false),
  User(
      id: 4,
      name: "みる　みるこ",
      email: "abc@mail.com",
      image: "kid4.png",
      group_id: 1,
      password: "abc111",
      timestamp: DateTime.now(),
      driver: false),
  User(
      id: 5,
      name: "みる　みる太郎",
      email: "abc@mail.com",
      image: "kid5.png",
      group_id: 1,
      password: "abc111",
      timestamp: DateTime.now(),
      driver: false),
  User(
      id: 6,
      name: "みる　みるみ",
      email: "abc@mail.com",
      image: "kid6.png",
      group_id: 1,
      password: "abc111",
      timestamp: DateTime.now(),
      driver: false),
  User(
      id: 7,
      name: "みる　みるみ",
      email: "abc@mail.com",
      image: "kid7.png",
      group_id: 1,
      password: "abc111",
      timestamp: DateTime.now(),
      driver: false),
  User(
      id: 8,
      name: "みる　みるみ",
      email: "abc@mail.com",
      image: "kid8.png",
      group_id: 1,
      password: "abc111",
      timestamp: DateTime.now(),
      driver: false),
  User(
      id: 1,
      name: "ぴよ ぴよこ",
      email: "abc@mail.com",
      image: "kid1.png",
      group_id: 1,
      password: "abc111",
      timestamp: DateTime.now(),
      driver: false),
  User(
      id: 2,
      name: "ぴよ ぴよみ",
      email: "abc@mail.com",
      image: "kid2.png",
      group_id: 1,
      password: "abc222",
      timestamp: DateTime.now(),
      driver: false),
  User(
      id: 3,
      name: "ぴよ ぴよ太郎",
      email: "abc@mail.com",
      image: "kid3.png",
      group_id: 1,
      password: "abc111",
      timestamp: DateTime.now(),
      driver: false),
  User(
      id: 4,
      name: "みる　みるこ",
      email: "abc@mail.com",
      image: "kid4.png",
      group_id: 1,
      password: "abc111",
      timestamp: DateTime.now(),
      driver: false),
  User(
      id: 5,
      name: "みる　みる太郎",
      email: "abc@mail.com",
      image: "kid5.png",
      group_id: 1,
      password: "abc111",
      timestamp: DateTime.now(),
      driver: false),
  User(
      id: 6,
      name: "みる　みるみ",
      email: "abc@mail.com",
      image: "kid6.png",
      group_id: 1,
      password: "abc111",
      timestamp: DateTime.now(),
      driver: false),
  User(
      id: 7,
      name: "みる　みるみ",
      email: "abc@mail.com",
      image: "kid7.png",
      group_id: 1,
      password: "abc111",
      timestamp: DateTime.now(),
      driver: false),
  User(
      id: 8,
      name: "みる　みるみ",
      email: "abc@mail.com",
      image: "kid8.png",
      group_id: 1,
      password: "abc111",
      timestamp: DateTime.now(),
      driver: false),
];
