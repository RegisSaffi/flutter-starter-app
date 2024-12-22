import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter/models/student.dart';
import 'package:starter/providers/studnts/prviders.dart';

class StudentsPage extends ConsumerStatefulWidget {
  const StudentsPage({super.key});

  @override
  ConsumerState<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends ConsumerState<StudentsPage> {
  confirmDelete(Student student) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: const Text("Delete student"),
            content: Text(
                "This action will delete ${student.names} do you want to continue?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              FilledButton(
                  onPressed: () {
                    ref.read(studentsProvider.notifier).removeStudent(student);
                    Navigator.pop(context);
                  },
                  child: const Text("Delete"))
            ]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var students = ref.watch(studentsProvider);
    var studentsStatus = ref.watch(studentsStatusProvider);

    return Scaffold(
      body: studentsStatus == 'loading'
          ? const Center(child: CircularProgressIndicator())
          : studentsStatus == 'error'
              ? const Center(
                  child: Text(
                    "Error getting students from server",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : students.isEmpty
                  ? const Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.hourglass_empty,
                          size: 35,
                          color: Colors.grey,
                        ),
                        Text(
                          "There are no students yet",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ))
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        var student = students[index];
                        return ListTile(
                          onTap: () {},
                          leading: const CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          title: Text(student.names),
                          subtitle: Text(student.email ?? ""),
                          trailing: PopupMenuButton(
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 0,
                                child: Text("Add marks"),
                              ),
                              const PopupMenuItem(
                                value: 1,
                                child: Text("Edit"),
                              ),
                              const PopupMenuItem(
                                value: 2,
                                child: Text("Remove"),
                              )
                            ],
                            onSelected: (value) {
                              if (value == 0) {
                                //Add a way of adding marks
                              } else if (value == 0) {
                                //Edit is selected
                              } else {
                                confirmDelete(student);
                              }
                            },
                          ),
                        );
                      },
                      itemCount: students.length,
                    ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ///How you add new student to the list by checking the id

          // if (students.any((element) => element.id == 2)) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //       const SnackBar(content: Text("Student already exists")));
          //   return;
          // }
          // var st = Student(id: 2, names: "Another student");
          // ref.read(studentsProvider.notifier).addStudent(st);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(studentsProvider.notifier).getStudentsFromServer();
    });
    super.initState();
  }
}
