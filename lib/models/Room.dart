class Hotel {
  List<Room>? data;

  Hotel({this.data});

  Hotel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Room>[];
      json['data'].forEach((v) {
        data!.add(Room.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    if (data != null) {
      json['data'] = data!.map((v) => v.toJson()).toList();
    }
    return json;
  }
}

class Room {
  String? id;
  String? name;
  String? status;

  Room({this.id, this.name, this.status});

  Room.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'status': status};
  }
}
