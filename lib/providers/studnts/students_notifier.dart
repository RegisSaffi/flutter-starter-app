import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter/models/student.dart';

class StudentsNotifier extends Notifier<List<Student>> {
  @override
  build() {
    return [
      Student(id: 1, names: "Joan doe"),
      Student(id: 2, names: "John doe second")
    ];
  }

  void addStudent(Student student) {
    state = [...state, student];
  }

  void removeStudent(Student student) {
    // state = state.where((s) => s.id != student.id).toList();
    state = List.from(state)..remove(student);
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
