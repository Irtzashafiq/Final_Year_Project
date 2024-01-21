// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/json/day_month.dart';
import 'package:final_year_project/theme/colors.dart';
import 'package:flutter/material.dart';

// ignore: unused_import
import '../json/daily_json.dart';

class DailyPage extends StatefulWidget {
  const DailyPage({
    super.key,
  });

  @override
  State<DailyPage> createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  int activeDay = 0;

  // ignore: non_constant_identifier_names

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: getBody(),
    );
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    // getincome();
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: white, boxShadow: [
              BoxShadow(
                color: grey.withOpacity(0.01),
                spreadRadius: 10,
                blurRadius: 3,
              ),
            ]),
            child: Padding(
              padding:
                  EdgeInsets.only(top: 60, bottom: 25, right: 20, left: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Daily Transaction",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: black,
                        ),
                      ),
                      Icon(Icons.search)
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      days.length,
                      (index) => GestureDetector(
                        onTap: (() {
                          setState(() {
                            activeDay = index;
                          });
                        }),
                        child: Container(
                          width: (size.width - 40) / 7,
                          child: Column(
                            children: [
                              Text(
                                days[index]["label"],
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: activeDay == index
                                        ? primary
                                        : Colors.transparent,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: activeDay == index
                                            ? primary
                                            : black.withOpacity(0.1))),
                                child: Center(
                                  child: Text(
                                    days[index]['day'],
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: activeDay == index ? white : black,
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
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Income').snapshots(),
            builder: (BuildContext context, snapshot) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                      child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: ListTile(
                      title: Text(snapshot.data!.docs[index]['Budget Name']),
                      trailing: Text(snapshot.data!.docs[index]['Budget Cost']),
                    ),
                  ));
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
