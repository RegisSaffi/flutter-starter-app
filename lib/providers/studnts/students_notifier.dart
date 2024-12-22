import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:starter/models/student.dart';
import 'package:starter/providers/studnts/prviders.dart';

class StudentsNotifier extends Notifier<List<Student>> {
  @override
  build() {
    return [];
  }

  getStudentsFromServer() async {
    var endpoint = Uri.parse("https://jsonplaceholder.typicode.com/users");
    ref.read(studentsStatusProvider.notifier).state = 'loading';
    var res = await http.get(endpoint);
    if (res.statusCode == 200) {
      state = _decodeData(res.body);
      ref.read(studentsStatusProvider.notifier).state = null;
    } else {
      ref.read(studentsStatusProvider.notifier).state = "error";
    }
  }

  List<Student> _decodeData(String data) {
    List students = jsonDecode(data);
    List<Student> students2 = [];
    for (var element in students) {
      Student student = Student.fromJson(element);
      students2.add(student);
    }
    return students2;
  }

  void addStudent(Student student) {
    state = [...state, student];
  }

  void removeStudent(Student student) {
    state = state.where((s) => s.id != student.id).toList();
  }

  void updateStudent(Student student) {
    state = state.map((s) => s.id == student.id ? student : s).toList();
  }

  void clearStudents() {
    state = List.empty();
  }

  void sortStudents() {
    state = List.from(state)..sort((a, b) => a.names.compareTo(b.names));
  }

  void sortStudentsByMarks() {
    state = List.from(state)
      ..sort((a, b) => b.totalMarks.compareTo(a.totalMarks));
  }
}
