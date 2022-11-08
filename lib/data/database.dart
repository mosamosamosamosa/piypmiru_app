class Buses {
  final String name;
  final int id, group_id;
  final DateTime timestamp;

  Buses({
    required this.id,
    required this.name,
    required this.timestamp,
    required this.group_id,
  });
}

List<Buses> buses_list = [
  Buses(id: 1, name: "1号車", timestamp: DateTime.now(), group_id: 1),
  Buses(id: 2, name: "2号車", timestamp: DateTime.now(), group_id: 1),
  Buses(id: 3, name: "3号車", timestamp: DateTime.now(), group_id: 1),
  Buses(id: 4, name: "4号車", timestamp: DateTime.now(), group_id: 1),
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
  // Passengers(
  //     id: 1,
  //     name: "ぴよ ぴよこ",
  //     image: "piyo_piyoko.png",
  //     operation_id: 1,
  //     user_id: 1,
  //     timestamp: DateTime.now(),
  //     status: true),
  // Passengers(
  //     id: 2,
  //     name: "ぴよ ぴよ太郎",
  //     image: "piyo_piyotaro.png",
  //     operation_id: 1,
  //     user_id: 1,
  //     timestamp: DateTime.now(),
  //     status: true),
  // Passengers(
  //     id: 3,
  //     name: "ぴよ ぴよみ",
  //     image: "piyo_piyomi.png",
  //     operation_id: 1,
  //     user_id: 1,
  //     timestamp: DateTime.now(),
  //     status: true),
  // Passengers(
  //     id: 4,
  //     name: "みる みるこ",
  //     image: "miru_miruko.png",
  //     operation_id: 1,
  //     user_id: 1,
  //     timestamp: DateTime.now(),
  //     status: true),
  // Passengers(
  //     id: 5,
  //     name: "みる みる太郎",
  //     image: "miru_mirutaro.png",
  //     operation_id: 1,
  //     user_id: 1,
  //     timestamp: DateTime.now(),
  //     status: true),
  // Passengers(
  //     id: 6,
  //     name: "みる みるみ",
  //     image: "miru_mirumi.png",
  //     operation_id: 1,
  //     user_id: 1,
  //     timestamp: DateTime.now(),
  //     status: true),
];
