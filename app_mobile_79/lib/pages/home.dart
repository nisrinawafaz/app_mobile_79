import 'package:flutter/material.dart';
import 'package:taskify/pages/profile.dart';
import 'package:taskify/shared/images.dart';
import 'package:taskify/shared/style.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  final String name;

  const HomePage({super.key, required this.name});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      HomeContent(
        name: widget.name,
      ),
      ProfilePage()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: "Home",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: "Profile",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      navBarStyle: NavBarStyle.style13,
    );
  }
}

class HomeContent extends StatefulWidget {
  final String name;
  const HomeContent({super.key, required this.name});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final List<Map<String, String>> tasks = [
    {'title': 'Personal Task 1', 'description': 'Complete the profile update'},
    {'title': 'Work Task 1', 'description': 'Prepare monthly report'},
    {'title': 'Personal Task 2', 'description': 'Buy groceries'},
    {'title': 'Work Task 2', 'description': 'Team meeting at 10 AM'},
    {'title': 'Personal Task 3', 'description': 'Workout for 30 minutes'},
  ];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Image.asset(
            background_plain,
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            semanticLabel: 'Background Image',
          ),
        ),
        Container(
            padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome, ${widget.name}!',
                  style: TextStyle(
                      fontSize: 24,
                      color: mainColor,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Poppins'),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '5 tasks',
                      style: TextStyle(
                          fontSize: 12,
                          color: failed,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins'),
                    ),
                    Text(
                      ' are waiting for you today',
                      style: TextStyle(
                          fontSize: 12,
                          color: black,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins'),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Due Date ',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: secondaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              '5',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: black,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Poppins'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pending Task ',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: secondaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              '12',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: black,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Poppins'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Category',
                      style: TextStyle(
                          fontSize: 16,
                          color: black,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Poppins'),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'See All',
                          style: TextStyle(
                              fontSize: 14,
                              color: secondaryColor,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Poppins'),
                        ))
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                          color: mainColor.withOpacity(0.1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Personal Task ',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    color: black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Icon(Icons.person, color: mainColor),
                              ],
                            ),
                            SizedBox(height: 5),
                            Text(
                              '12 Tasks Remaining',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: black,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: 'Poppins'),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'See Details',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      color: secondaryColor,
                                      fontWeight: FontWeight.w600),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 14,
                                  color: secondaryColor,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                          color: mainColor.withOpacity(0.1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Work Task ',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    color: black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Icon(Icons.work, color: mainColor),
                              ],
                            ),
                            SizedBox(height: 5),
                            Text(
                              '30 Tasks Remaining',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: black,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: 'Poppins'),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'See Details',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      color: secondaryColor,
                                      fontWeight: FontWeight.w600),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 14,
                                  color: secondaryColor,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'List of Today’s Tasks',
                  style: TextStyle(
                      fontSize: 16,
                      color: black,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Poppins'),
                ),
                SizedBox(
                  height: 210,
                  child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(task['title'] ?? '',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    )),
                                SizedBox(height: 5),
                                Text(task['description'] ?? '',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: 'Poppins')),
                              ],
                            ),
                            Icon(Icons.more_vert),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ))
      ],
    );
  }
}
