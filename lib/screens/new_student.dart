import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter/models/student.dart';
import 'package:starter/providers/studnts/prviders.dart';

class NewStudentScreen extends ConsumerStatefulWidget {
  const NewStudentScreen({super.key});

  @override
  ConsumerState createState() => _NewStudentScreenState();
}

class _NewStudentScreenState extends ConsumerState<NewStudentScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController marksController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  Future<void> validate() async {
    if (formKey.currentState!.validate()) {
      var students = ref.read(studentsProvider);
      var id = students.isEmpty ? 1 : students.last.id + 1;

      var student = Student(
          names: nameController.text,
          email: emailController.text,
          totalMarks: double.tryParse(marksController.text) ?? 0,
          id: id);

      var res = await ref.read(studentsProvider.notifier).addStudent(student);
      if (res == 201) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Student is saved successfuly"),
          backgroundColor: Colors.green,
        ));
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Failed saving the student"),
          backgroundColor: Colors.redAccent,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var studentStatus = ref.watch(newStudentProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("New student"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Form(
          key: formKey,
          child: Column(children: [
            TextFormField(
              controller: nameController,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value?.isEmpty == true) {
                  return "Name is required";
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Input your Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value != "") {
                    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                    if (!emailRegex.hasMatch("$value")) {
                      return "Enter a valid email";
                    }
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Input your Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: TextFormField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                controller: marksController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d+\.?\d{0,2}'),
                  )
                ],
                decoration: InputDecoration(
                    labelText: 'Marks',
                    hintText: 'Input your Marks',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: FilledButton.icon(
                      onPressed: studentStatus == "loading"
                          ? null
                          : () {
                              validate();
                            },
                      icon: const Icon(Icons.save),
                      label: studentStatus == "loading"
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator.adaptive())
                          : const Text('Save'))),
            )
          ]),
        ),
      ),
    );
  }
}
