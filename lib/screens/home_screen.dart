import 'package:flutter/material.dart';
import 'package:starter/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var formKey = GlobalKey<FormState>();

  var userNameController = TextEditingController();
  var passwordController = TextEditingController();
  void login() {
    if (formKey.currentState!.validate()) {
      String username = userNameController.text;
      String password = userNameController.text;
      var page = MaterialPageRoute(
        builder: (context) => ProfileScreen(
          username: username,
        ),
      );

      Navigator.of(context).push(page);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Starter app"),
      ),
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  Icons.person,
                  size: 100,
                ),
                const Text(
                  'Welcome to Starter app',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: TextFormField(
                    controller: userNameController,
                    validator: (value) {
                      if (value == "") {
                        return "Enter your usernname please";
                      } else if (value!.length <= 3) {
                        return "Username must be more than 3 characters";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                        isDense: true,
                        hintText: "Enter your username",
                        labelText: "Username",
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder()),
                  ),
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == "") {
                      return "Enter your password";
                    } else if (value == userNameController.text) {
                      return 'Username and password cant be the same';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      isDense: true,
                      hintText: "Enter your password",
                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder()),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: FilledButton(
                        onPressed: () {
                          login();
                        },
                        child: const Text("Login")),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
