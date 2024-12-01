import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

var indexProvider = StateProvider<int>((ref) => 0);

class ProfileScreen extends ConsumerWidget {
  final String username;
  const ProfileScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context, ref) {
    var index = ref.watch(indexProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Hello: ${username}"),
          OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Back"))
        ],
      )),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) {
          ref.read(indexProvider.notifier).state = i;
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.people), label: "Students"),
          NavigationDestination(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}
