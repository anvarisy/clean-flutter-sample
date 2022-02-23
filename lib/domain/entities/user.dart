
class User {
  final int id;
  String name;
  String email;
  String gender;
  String status;

  User(this.id, this.name, this.email, this.gender, this.status);

  @override
  String toString() {
    return 'User{id: $id, name: $name}';
  }

  factory User.fromJson(e) => User(e['id'], e['name'], e['email'], e['gender'], e['status']);
}