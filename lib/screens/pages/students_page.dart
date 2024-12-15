import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter/providers/studnts/prviders.dart';

class StudentsPage extends ConsumerStatefulWidget {
  const StudentsPage({super.key});

  @override
  ConsumerState<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends ConsumerState<StudentsPage> {
  @override
  Widget build(BuildContext context) {
    var students = ref.watch(studentsProvider);
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          var student = students[index];
          return ListTile(
            onTap: () {},
            leading: const CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text(student.names),
          );
        },
        itemCount: students.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
