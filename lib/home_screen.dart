import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'second_screen.dart';
import 'count_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  //Counter
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = [
    Container(),
    CountScreen(),
    SecondScreen(),
    const Placeholder(),
    const Placeholder(),
    const Placeholder(),
  ];

  void _onItemTapped(int index) {
    //Set States
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home ",
        ),
        automaticallyImplyLeading: false,
        centerTitle: false,
        //leading: const BackButton(),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildNavBarItem(CupertinoIcons.home, 'Home', 0),
            buildNavBarItem(CupertinoIcons.list_bullet, 'My Task', 1),
            const SizedBox(width: 20),
            buildNavBarItem(CupertinoIcons.conversation_bubble, 'Message', 3),
            buildNavBarItem(CupertinoIcons.profile_circled, 'Profile', 4),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const ClipOval(
            child: Material(
              color: Color(0xFF7861FF),
              elevation: 50,
              child: InkWell(
                child: SizedBox(
                  width: 56,
                  height: 56,
                  child:
                  Icon(
                    CupertinoIcons.add_circled,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildNavBarItem(IconData icon, String label, int index) {
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: _selectedIndex == index
                ? const Color(0xFF7861FF)
                : Colors.black87,
          ),
          Text(
            label,
            style: TextStyle(
              color: _selectedIndex == index
                  ? const Color(0xFF7861FF)
                  : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
