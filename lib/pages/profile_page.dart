// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/json/profile_json.dart';
import 'package:final_year_project/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final TextEditingController _email = TextEditingController(text: email);
  final TextEditingController _yourIncome = TextEditingController();
  final TextEditingController _dateOfBirth =
      TextEditingController(text: dateOfBirth);
  final TextEditingController _password = TextEditingController(text: password);
  final firestore = FirebaseFirestore.instance;
  yourIncome() async {
    await firestore
        .collection('Your Income')
        .doc('jHLZia3bKDUzp6obnxVD')
        .update({
      'Your Income': _yourIncome.text.toString(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.05),
      body: getbody(),
    );
  }

  Widget getbody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: size.width,
            decoration: BoxDecoration(color: white, boxShadow: [
              BoxShadow(
                color: grey.withOpacity(0.01),
                spreadRadius: 10,
                blurRadius: 3,
              )
            ]),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 60, right: 20, left: 20, bottom: 25),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Profile',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: black),
                    ),
                    Icon(Icons.settings),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: (size.width - 40) * 0.4,
                      child: Container(
                        child: Stack(
                          children: [
                            RotatedBox(
                              quarterTurns: -2,
                              child: CircularPercentIndicator(
                                circularStrokeCap: CircularStrokeCap.round,
                                backgroundColor: grey.withOpacity(0.3),
                                lineWidth: 6.0,
                                percent: 0.53,
                                radius: 60.0,
                              ),
                            ),
                            Positioned(
                              left: 13,
                              top: 13,
                              child: Container(
                                width: 95,
                                height: 95,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/profile pic.jpeg'),
                                        fit: BoxFit.cover)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: (size.width - 40) * 0.6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: black,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 7),
                            child: Text(
                              "CreditScore$credit",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: black.withOpacity(0.4),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  width: size.width,
                  decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: grey.withOpacity(0.01),
                            spreadRadius: 10,
                            blurRadius: 3)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 25, bottom: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Your Income',
                              style: TextStyle(
                                fontSize: 18,
                                color: white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: white),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    "Update",
                                    style: TextStyle(color: white),
                                  ),
                                ),
                              ),
                              onTap: () {
                                yourIncome();
                              },
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          controller: _yourIncome,
                          cursorColor: black,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: white),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter Your Income',
                              hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.5))),
                        ),
                      ],
                    ),
                  ),
                )
              ]),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email",
                  style: TextStyle(
                    color: grey,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextField(
                  controller: _email,
                  cursorColor: black,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17, color: black),
                  decoration: InputDecoration(border: InputBorder.none),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Date of Birth",
                  style: TextStyle(
                    color: grey,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextField(
                  controller: _dateOfBirth,
                  cursorColor: black,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17, color: black),
                  decoration: InputDecoration(border: InputBorder.none),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Password",
                  style: TextStyle(
                    color: grey,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextField(
                  controller: _password,
                  obscureText: true,
                  cursorColor: black,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17, color: black),
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
