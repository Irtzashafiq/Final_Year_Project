// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

import 'package:final_year_project/pages/budget_page.dart';
import 'package:final_year_project/pages/create_budget_page.dart';

import 'package:final_year_project/pages/daily_page.dart';
import 'package:final_year_project/pages/profile_page.dart';
import 'package:final_year_project/pages/stats.dart';
import 'package:flutter/material.dart';

import '../theme/colors.dart';

class RootApp extends StatefulWidget {
  const RootApp({super.key});

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getbody(),
      bottomNavigationBar: getfooter(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setTabs(4);
        },
        backgroundColor: primary,
        child: Icon(
          Icons.add,
          size: 25,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget getbody() {
    return IndexedStack(
      index: pageIndex,
      children: [
        DailyPage(),
        StatsPage(),
        BudgetPage(),
        MyProfile(),
        CreateBudget(),
      ],
    );
  }

  Widget getfooter() {
    List<IconData> iconItems = [
      Icons.calendar_month_outlined,
      Icons.auto_graph,
      Icons.wallet,
      Icons.person,
    ];
    return AnimatedBottomNavigationBar(
        icons: iconItems,
        activeColor: primary,
        inactiveColor: grey,
        splashColor: black.withOpacity(0.5),
        activeIndex: pageIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        iconSize: 25,
        rightCornerRadius: 10,
        leftCornerRadius: 10,
        onTap: (index) {
          setTabs(index);
        });
  }

  setTabs(index) {
    setState(() {
      pageIndex = index;
    });
  }
}
