import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lms_project/actionPage/add_project.dart';
import 'package:lms_project/actionPage/add_task.dart';
import 'task.dart';
import 'dashboard.dart';
import 'analytics.dart';
import 'settings.dart';

class Navs extends StatefulWidget {
  final int initialIndex;

  const Navs({super.key, this.initialIndex = 0});

  @override
  _NavsState createState() => _NavsState();
}

class _NavsState extends State<Navs> {
  late int currentIndex;
  final List<Widget> _pages = [
    const Dashboard(),
    Tasks(),
    const Analytics(),
    const Settings(),
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex; // Set initial index based on Navs input
  }

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(200),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [Color(0xFF40EFEF), Color(0xFF246642)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
              child: SafeArea(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    Row(children: [
                      SizedBox(width: 10),
                      SvgPicture.asset('assets/images/rdc.svg',
                          width: 50, height: 50),
                      SizedBox(width: 10),
                      Text('TaskTics',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: GoogleFonts.fasterOne().fontFamily))
                    ]),
                    Row(
                      children: [
                        Icon(Icons.notifications,
                            color: Colors.white, size: 30),
                        SizedBox(width: 20),
                        Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 30,
                        ),
                        SizedBox(width: 10)
                      ],
                    )
                  ])),
            ),
          )),
      body: _pages[currentIndex],
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF243642),
        shape: const CircularNotchedRectangle(),
        notchMargin: 10.0,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.dashboard, 'Dashboard', 0),
              const SizedBox(width: 15),
              _buildNavItem(Icons.receipt_long, 'Task', 1),
              const SizedBox(width: 50),
              _buildNavItem(Icons.waterfall_chart, 'Analytics', 2),
              const SizedBox(width: 15),
              _buildNavItem(Icons.settings, 'Settings', 3),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            backgroundColor: const Color.fromARGB(81, 0, 0, 0),
            builder: (BuildContext context) {
              return DraggableScrollableSheet(
                initialChildSize: 0.3,
                minChildSize: 0.2,
                maxChildSize: 0.7,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 58, 120, 125),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25.0)),
                    ),
                    child: ListView(
                      controller: scrollController,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Create:',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddProject()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlueAccent,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.add, color: Colors.white),
                              SizedBox(width: 8),
                              Text('Create Project'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddTask()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlueAccent,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.add, color: Colors.white),
                              SizedBox(width: 8),
                              Text('Create Task'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
        tooltip: 'Add',
        backgroundColor: Colors.lightBlueAccent,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: currentIndex == index ? Colors.lightBlueAccent : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              color:
                  currentIndex == index ? Colors.lightBlueAccent : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
