import 'dart:convert';

import 'package:calculater/model/coverModel.dart';
import 'package:calculater/model/gsmModel.dart';
import 'package:calculater/model/noOfPage.dart';
import 'package:calculater/model/pageSize.dart';
import 'package:calculater/model/pageTypeModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RimWeightScreen extends StatefulWidget {
  const RimWeightScreen({super.key});

  @override
  _RimWeightScreenState createState() => _RimWeightScreenState();
}

class _RimWeightScreenState extends State<RimWeightScreen> {
  List<PageSize> pageSize = [];
  PageSize? selectedPageSize;

  List<Gsmmodel> gsmmodel = [];
  Gsmmodel? selectedGsmmodel;
  String _result = '';

  List<PageType> pageType = [];
  PageType? selectedPageType;

  List<NoOfPageModel> noOfPage = [];
  NoOfPageModel? selectedNoOfPage;

  List<CoverModel> coverModel = [];
  CoverModel? selectedCover;

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

  Future<List<PageType>> loadpagetypeFromAsset() async {
    final String jsonString = await rootBundle.loadString(
      'assets/pagetype.json',
    );
    final List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((item) => PageType.fromJson(item)).toList();
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
    loadpagetypeFromAsset().then((data) {
      setState(() {
        pageType = data;
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
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
            SizedBox(height: 15),
            DropdownButtonFormField<PageSize>(
              value: selectedPageSize,
              isExpanded: false,

              hint: Text("Select a page size"),
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

            SizedBox(height: 15),
            DropdownButtonFormField<Gsmmodel>(
              value: selectedGsmmodel,
              hint: Text("Select a gsm"),
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
            SizedBox(height: 15),
            Text(
              "Page Rate",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Roboto',
                fontStyle: FontStyle.normal,
              ),
            ),
            SizedBox(height: 15),
            DropdownButtonFormField<PageType>(
              value: selectedPageType,
              hint: Text("Select a page type"),
              items:
                  pageType.map((pageTypeValue) {
                    return DropdownMenuItem<PageType>(
                      value: pageTypeValue,
                      child: Text(pageTypeValue.name),
                    );
                  }).toList(),
              onChanged: (PageType? newValuePageType) {
                setState(() {
                  selectedPageType = newValuePageType;
                });
              },
              decoration: InputDecoration(
                labelText: 'Page type',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 15),
            Text(
              "No of Page",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Roboto',
                fontStyle: FontStyle.normal,
              ),
            ),
            SizedBox(height: 15),
            DropdownButtonFormField<NoOfPageModel>(
              value: selectedNoOfPage,
              hint: Text("Select a no of page"),
              items:
                  noOfPage.map((nopageValue) {
                    return DropdownMenuItem<NoOfPageModel>(
                      value: nopageValue,
                      child: Text(nopageValue.name),
                    );
                  }).toList(),
              onChanged: (NoOfPageModel? newValueNoPage) {
                setState(() {
                  selectedNoOfPage = newValueNoPage;
                });
              },
              decoration: InputDecoration(
                labelText: 'No of Page',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 15),
            Text(
              "Cover Type",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Roboto',
                fontStyle: FontStyle.normal,
              ),
            ),
            SizedBox(height: 15),
            DropdownButtonFormField<CoverModel>(
              value: selectedCover,
              hint: Text("Select a cover type"),
              items:
                  coverModel.map((coverValue) {
                    return DropdownMenuItem<CoverModel>(
                      value: coverValue,
                      child: Text(coverValue.name),
                    );
                  }).toList(),
              onChanged: (CoverModel? newValueCover) {
                setState(() {
                  selectedCover = newValueCover;
                });
              },
              decoration: InputDecoration(
                labelText: 'Cover',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 15),
            Text(
              selectedPageSize == null &&
                      selectedGsmmodel == null &&
                      selectedPageType == null
                  ? "No Value selected"
                  : selectedPageSize == null
                  ? "No Value selected"
                  : selectedGsmmodel == null
                  ? "No Value selected"
                  : selectedPageType == null
                  ? "No Value selected"
                  : "You selected: ${selectedPageSize!.value} , ${selectedGsmmodel!.name}, ${selectedPageType!.value}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 15),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  _multiply(
                    selectedPageSize,
                    selectedGsmmodel,
                    selectedPageType,
                  );
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
            ),
            SizedBox(height: 15),
            Text(_result),
            // SizedBox(height: 20),
            // Text(
            //   selectedPageSize == null && selectedGsmmodel == null
            //       ? "No Value selected"
            //       : selectedPageSize == null
            //       ? "No Value selected"
            //       : selectedGsmmodel == null
            //       ? "No Value selected"
            //       : "Result: ${double.tryParse(selectedPageSize!.value.toString())} *  ${double.tryParse(selectedGsmmodel!.name.toString())} / ${double.tryParse('20000'.toString())} ",
            //   style: TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.black,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void _multiply(
    PageSize? selectedPageSize,
    Gsmmodel? selectedGsmmodel,
    PageType? selectedPageType,
  ) {
    final stPageSize = double.tryParse(selectedPageSize!.value.toString());
    final stGsm = double.tryParse(selectedGsmmodel!.name.toString());
    final divRW = double.tryParse('20000'.toString());
    final stPageType = double.tryParse(selectedPageType!.value.toString());
    final divPageRate = double.tryParse('8000'.toString());

    if (stPageSize != null &&
        stGsm != null &&
        divRW != null &&
        stPageType != null &&
        divPageRate != null) {
      //   setState(() {
      //   _result = 'Result: ${(num1 * num2) / num3!}';
      // });
      setState(() {
        _result =
            'Result:  ${(((stPageSize * stGsm) / divRW!) * stPageType) / divPageRate}';
      });
    } else {
      setState(() {
        _result = 'Please enter valid numbers.';
      });
    }
  }
}
