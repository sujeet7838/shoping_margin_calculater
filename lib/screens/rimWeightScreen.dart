import 'dart:convert';

import 'package:calculater/model/gsmModel.dart';
import 'package:calculater/model/pageSize.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RimWeightScreen extends StatefulWidget {
  @override
  _RimWeightScreenState createState() => _RimWeightScreenState();
}

class _RimWeightScreenState extends State<RimWeightScreen> {
  List<PageSize> pageSize = [];
  PageSize? selectedPageSize;

  List<Gsmmodel> gsmmodel = [];
  Gsmmodel? selectedGsmmodel;
  String _result = '';

  Future<List<PageSize>> loadpageSizeFromAsset() async {
    final String jsonString = await rootBundle.loadString(
      'assets/pagesize.json',
    );
    final List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((item) => PageSize.fromJson(item)).toList();
  }

  Future<List<Gsmmodel>> loadgsmmodelFromAsset() async {
    final String jsonString = await rootBundle.loadString('assets/gsm.json');
    final List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((item) => Gsmmodel.fromJson(item)).toList();
  }

  @override
  void initState() {
    super.initState();
    loadpageSizeFromAsset().then((data) {
      setState(() {
        pageSize = data;
      });
    });
    loadgsmmodelFromAsset().then((data) {
      setState(() {
        gsmmodel = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calculator App',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              "RIM Weight",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Roboto',
                fontStyle: FontStyle.normal,
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<PageSize>(
              value: selectedPageSize,
              hint: Text("Select a Page Size"),
              items:
                  pageSize.map((pageSize) {
                    return DropdownMenuItem<PageSize>(
                      value: pageSize,
                      child: Text(pageSize.name),
                    );
                  }).toList(),
              onChanged: (PageSize? newValue) {
                setState(() {
                  selectedPageSize = newValue;
                });
              },
              decoration: InputDecoration(
                labelText: 'Page Size',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            SizedBox(height: 20),
            DropdownButtonFormField<Gsmmodel>(
              value: selectedGsmmodel,
              hint: Text("Select a Gsm"),
              items:
                  gsmmodel.map((gsmValue) {
                    return DropdownMenuItem<Gsmmodel>(
                      value: gsmValue,
                      child: Text(gsmValue.name),
                    );
                  }).toList(),
              onChanged: (Gsmmodel? newValueGsm) {
                setState(() {
                  selectedGsmmodel = newValueGsm;
                });
              },
              decoration: InputDecoration(
                labelText: 'Gsm',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              selectedPageSize == null && selectedGsmmodel == null
                  ? "No Value selected"
                  : selectedPageSize == null
                  ? "No Value selected"
                  : selectedGsmmodel == null
                  ? "No Value selected"
                  : "You selected: ${selectedPageSize!.value},"
                      ", ${selectedGsmmodel!.name}",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                // primary: Colors.pinkAccent,
                backgroundColor: Colors.pinkAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                _multiply(selectedPageSize, selectedGsmmodel);
              },
              child: Text(
                'Multiply',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(_result),
            // SizedBox(height: 20),
            // Text(
            //   selectedPageSize == null
            //       ? "No Value selected"
            //       : "Result:${selectedPageSize!.value} * ${selectedGsmmodel!.name}",
            //   style: TextStyle(fontSize: 18),
            // ),
          ],
        ),
      ),
    );
  }

  void _multiply(PageSize? selectedPageSize, Gsmmodel? selectedGsmmodel) {
    final num1 = double.tryParse(selectedPageSize!.value.toString());
    final num2 = double.tryParse(selectedGsmmodel!.name.toString());
    final num3 = double.tryParse('20000'.toString());

    if (num1 != null && num2 != null) {
      //   setState(() {
      //   _result = 'Result: ${(num1 * num2) / num3!}';
      // });
      setState(() {
        _result =
            'Result: ${(num1 * num2) / num3!}'
            ' / $num3 = ${(num1 * num2) / num3!}';
      });
    } else {
      setState(() {
        _result = 'Please enter valid numbers.';
      });
    }
  }
}
