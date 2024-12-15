import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter/models/student.dart';
import 'package:starter/providers/studnts/students_notifier.dart';

var studentsProvider =
    NotifierProvider<StudentsNotifier, List<Student>>(() => StudentsNotifier());
