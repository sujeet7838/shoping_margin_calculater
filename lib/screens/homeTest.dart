import 'dart:convert' show json;

import 'package:flutter/material.dart';


class HomeScreenTest extends StatefulWidget {
  const HomeScreenTest({super.key});

  @override
  State<HomeScreenTest> createState() => _HomeScreenTestState();
}

class _HomeScreenTestState extends State<HomeScreenTest> {
  List<String> dataList = ["A", "B", "C"];
  List<String> dataListA = ["A1", "A2", "A3", "A4", "A5"];
  List<String> dataListB = ["B1", "B2", "B3", "B4", "B5"];
  List<String> dataListC = ["C1", "C2", "C3", "C4", "C5"];

  String? valueItem;
  List<String> listItem = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NoteBook Calculator',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 238, 112, 154),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),

              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Data list',
                  labelStyle: const TextStyle(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  contentPadding: const EdgeInsets.only(left: 5.0),
                ),
                value: valueItem,
                isExpanded: true,
                items:
                    dataList
                        .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        })
                        .toSet()
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    valueItem = value!;
                    if (valueItem == "A") {
                      listItem = dataListA;
                    } else if (valueItem == "B") {
                      listItem = dataListB;
                    } else if (valueItem == "C") {
                      listItem = dataListC;
                    }
                  });
                },
              ),
              SizedBox(height: 15),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'List dependent',
                  labelStyle: const TextStyle(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  contentPadding: const EdgeInsets.only(left: 5.0),
                ),
                value: listItem.isNotEmpty ? listItem[0] : null,
                isExpanded: true,
                items:
                    listItem
                        .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        })
                        .toSet()
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    //your_value = value!;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
