// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_final_fields, unused_field, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/pages/daily_page.dart';
import 'package:final_year_project/pages/root_app.dart';
import 'package:final_year_project/theme/colors.dart';
import 'package:flutter/material.dart';

import '../json/create_budget_json.dart';

class CreateBudget extends StatefulWidget {
  const CreateBudget({super.key});

  @override
  State<CreateBudget> createState() => _CreateBudgetState();
}

class _CreateBudgetState extends State<CreateBudget> {
  int activeCatagory = 0;
  TextEditingController _budgetName = TextEditingController();
  TextEditingController _budgetCost = TextEditingController();
  final firestore = FirebaseFirestore.instance;
  incomeData() async {
    await firestore.collection('Income').doc().set({
      'Budget Name': _budgetName.text.toString(),
      'Budget Cost': _budgetCost.text.toString(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: getbody(),
    );
  }

  Widget getbody() {
    var size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: grey.withOpacity(0.01),
            boxShadow: [
              BoxShadow(blurRadius: 3, spreadRadius: 10, color: white)
            ],
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Create Budget',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: black),
                ),
                Icon(Icons.search),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 35,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Text(
            'Choose Catagory',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: black.withOpacity(0.5)),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(categories.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    activeCatagory = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    width: 150,
                    height: 170,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: activeCatagory == index
                                ? primary
                                : Colors.transparent,
                            width: activeCatagory == index ? 2 : 0),
                        color: white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: grey.withOpacity(0.01),
                              spreadRadius: 10,
                              blurRadius: 3)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 25, bottom: 20, top: 20, right: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: grey.withOpacity(0.15)),
                            child: Center(
                                child: Image.asset(
                              categories[index]["icon"],
                              height: 30,
                              width: 30,
                              fit: BoxFit.cover,
                            )),
                          ),
                          Text(
                            categories[index]["name"],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
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
                'budget name',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: black.withOpacity(0.6)),
              ),
              TextFormField(
                controller: _budgetName,
                cursorColor: black,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: black,
                ),
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: "Enter Budget Name "),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(),
                    width: size.width - 140,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Enter Budget',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: black.withOpacity(0.6)),
                        ),
                        TextFormField(
                          controller: _budgetCost,
                          cursorColor: black,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: black,
                          ),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter Budget Cost "),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  // Container(
                  //   width: 50,
                  //   height: 50,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(15),
                  //       color: primary),
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       setState(() {
                  //         Navigator.of(context)
                  //             .push(MaterialPageRoute(
                  //                 builder: ((context) => DailyPage(
                  //                       budgetName: _budgetName.toString(),
                  //                     ))));
                  //       });
                  //     },
                  //     child: Icon(
                  //       Icons.arrow_forward,
                  //       color: white,
                  //     ),
                  //   ),
                  // )
                  IconButton(
                      onPressed: () {
                        
                        incomeData();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => RootApp()));
                      },
                      icon: Icon(
                        Icons.arrow_forward,
                        color: black,
                      ))
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
