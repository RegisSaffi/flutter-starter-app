class Student {
  int id;
  String names;
  String? email;
  double totalMarks;

  Student(
      {required this.id, required this.names, this.email, this.totalMarks = 0});
}
