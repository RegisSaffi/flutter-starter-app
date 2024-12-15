import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter/screens/pages/home_page.dart';
import 'package:starter/screens/pages/settings_page.dart';
import 'package:starter/screens/pages/students_page.dart';

var indexProvider = StateProvider<int>((ref) => 1);

class ProfileScreen extends ConsumerStatefulWidget {
  final String username;
  const ProfileScreen({super.key, required this.username});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  var pageController = PageController();

  @override
  Widget build(BuildContext context) {
    var index = ref.watch(indexProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (value) {
          ref.read(indexProvider.notifier).state = value;
        },
        children: const [HomePage(), StudentsPage(), SettingsPage()],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) {
          ref.read(indexProvider.notifier).state = i;
          pageController.animateToPage(i,
              duration: Duration(milliseconds: 500), curve: Curves.ease);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.people), label: "Students"),
          NavigationDestination(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}
