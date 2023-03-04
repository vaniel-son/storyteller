class UserModel {
  UserModel({
    required this.uuid,
    required this.userName,
  });

  String? uuid; // true = creating a new room, false = joining a room
  String? userName; // a story prompt the player will respond to

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'userName': userName,
    };
  }

}
