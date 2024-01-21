// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, import_of_legacy_library_into_null_safe

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/theme/colors.dart';
import 'package:final_year_project/widget/chart.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';

import '../json/day_month.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  var getYourIncome;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection('Your Income')
        .doc('jHLZia3bKDUzp6obnxVD')
        .get()
        .then((value) {
      setState(() {
        getYourIncome = value.data();
      });
      print(getYourIncome['Your Income']);
    });
  }

  int activeMonth = 4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.05),
      body: getbody(),
    );
  }

  Widget getbody() {
    var size = MediaQuery.of(context).size;
    List expenses = [
      {
        "icon": Icons.arrow_back,
        "color": blue,
        "label": 'Income',
        "cost": getYourIncome['Your Income']
      },
      {
        "icon": Icons.arrow_forward,
        "color": red,
        "label": 'Expence',
        "cost": '\$2445.75'
      }
    ];
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: white, boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.01),
                  spreadRadius: 10,
                  blurRadius: 3)
            ]),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 60, left: 20, right: 20, bottom: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Stats',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                      Icon(Icons.search),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      months.length,
                      (index) => GestureDetector(
                        onTap: (() {
                          setState(() {
                            activeMonth = index;
                          });
                        }),
                        child: SizedBox(
                          width: (size.width - 40) / 7,
                          child: Column(
                            children: [
                              Text(
                                months[index]["label"],
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: activeMonth == index
                                        ? primary
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: activeMonth == index
                                            ? primary
                                            : black.withOpacity(0.1))),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 7, bottom: 7, right: 12, left: 12),
                                  child: Text(
                                    months[index]['day'],
                                    style: TextStyle(
                                      fontSize: 10,
                                      color:
                                          activeMonth == index ? white : black,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.01),
                      spreadRadius: 10,
                      blurRadius: 3,
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Net Balance',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: black.withOpacity(0.3)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '\$2446.90',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: SizedBox(
                        width: size.width - 20,
                        height: 150,
                        child: LineChart(mainData()),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Wrap(
            spacing: 20,
            children: List.generate(expenses.length, (index) {
              return Container(
                width: (size.width - 60) / 2,
                height: 250,
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.01),
                          spreadRadius: 10,
                          blurRadius: 3),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20, right: 20, left: 20, bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: expenses[index]['color'],
                            borderRadius: BorderRadius.circular(80),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.01),
                                spreadRadius: 10,
                                blurRadius: 3,
                              )
                            ]),
                        child: Icon(
                          expenses[index]['icon'],
                          color: white,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            expenses[index]['label'],
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: black.withOpacity(0.3)),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Text(
                            expenses[index]['cost'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
