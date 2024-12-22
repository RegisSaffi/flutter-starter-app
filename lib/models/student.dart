class Student {
  int id;
  String names;
  String? email;
  double totalMarks;

  Student(
      {required this.id, required this.names, this.email, this.totalMarks = 0});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
        id: json['id'],
        names: json['name'],
        email: json['email'],
        totalMarks: 0);
  }

  Map<String, dynamic> toJson() {
    return {'name': names, 'email': email};
  }
}
