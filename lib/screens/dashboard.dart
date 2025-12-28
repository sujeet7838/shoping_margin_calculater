import 'dart:convert';

import 'package:calculater/model/noOfPage.dart';
import 'package:calculater/repositeries/calculator_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DeshboardPage extends StatefulWidget {
  const DeshboardPage({super.key});

  @override
  State<DeshboardPage> createState() => _DeshboardPageState();
}

class _DeshboardPageState extends State<DeshboardPage> {
  String coverColor = 'Select a cover';
  String boardType = 'Select a board';

  //calculator logic
  String articlevalue = '';
  String modelvalue = '';
  String colorValue = '';
  String boardvalue = '';
  String pagevalue = '';
  String noofpagevalue = '';
  String bindingvalue = '';

  // size of page value
  String sizeOfPage = '';

  // board Value
  String boardPrice = '';
  String finalResult = '';

  /// ------------------ STATIC DROPDOWN 1 ------------------
  final List<String> bindingTypes =
      [
        {"id": 0, "name": "Sprial Bound", "value": "Sprial Bound"},
        {"id": 1, "name": "Staple bound", "value": "Staple bound"},
        {"id": 2, "name": "Glu Bound", "value": "Glu Bound"},
      ].map((e) => e["value"] as String).toList();

  /// ------------------ STATE ------------------
  Map<String, List<dynamic>> pagesData = {};
  String? selectedType;
  String? selectedPage;
  Map<String, dynamic>? selectedPaper;
  List<String> filteredPages = [];
  List<dynamic> filteredPapers = [];
  bool isLoading = true;
  List<NoOfPageModel> noOfPage = [];
  NoOfPageModel? selectedNoOfPage;

  /// ------------------ LOAD ASSET JSON ------------------
  Future<void> loadJson() async {
    final String jsonString = await rootBundle.loadString(
      'assets/deshboard.json',
    );

    final Map<String, dynamic> decoded = json.decode(jsonString);

    pagesData = Map<String, List<dynamic>>.from(decoded["pages"]);
    noOfPage = await CalculatorRepository().loadNoofPageAsset();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadJson();
  }

  /// ------------------ LOGIC ------------------
  void onTypeChanged(String? value) {
    selectedType = value;
    selectedPage = null;
    selectedPaper = null;

    filteredPages =
        pagesData.entries
            .where((e) => e.value.any((item) => item["type"] == selectedType))
            .map((e) => e.key)
            .toList();

    filteredPapers = [];
    setState(() {});
  }

  void onPageChanged(String? value) {
    selectedPage = value;
    selectedPaper = null;

    filteredPapers =
        pagesData[selectedPage]!
            .where((item) => item["type"] == selectedType)
            .toList();

    setState(() {});
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
      body:
          isLoading
              ? CircularProgressIndicator()
              : Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Article",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      SizedBox(height: 10),

                      DropdownButtonFormField<String>(
                        isExpanded: true,
                        hint: Text("Select a bound"),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        value: selectedType,
                        items:
                            bindingTypes
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          setState(() {
                            onTypeChanged(value);
                            articlevalue = value!;
                          });
                        },
                      ),

                      SizedBox(height: 10),

                      Text(
                        "Model",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      SizedBox(height: 10),

                      DropdownButtonFormField<String>(
                        hint: Text("Select a model"),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        value: selectedPage,
                        items:
                            filteredPages
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                        onChanged:
                            filteredPages.isEmpty
                                ? null
                                : (val) {
                                  setState(() {
                                    onPageChanged(val);
                                    modelvalue = val!;

                                    if (selectedPage! == "A5/DC" ||
                                        selectedPage == "Crown") {
                                      coverColor = "Color & Brown";
                                      colorValue = coverColor;
                                    } else if (selectedPage == "Crown 10") {
                                      coverColor = "Brown";
                                      colorValue = coverColor;
                                    } else {
                                      coverColor = "Colour";
                                      colorValue = coverColor;
                                    }

                                    // board type logic
                                    if (selectedPage! == "Notes Lover" ||
                                        selectedPage! == "A4 Premium") {
                                      boardType = "SBS/WB/270";
                                      sizeOfPage = "5040";
                                      boardPrice = "5";
                                      boardvalue = boardType;
                                    } else if (selectedPage! == "Yuva Spiral" ||
                                        selectedPage! == "Yuva") {
                                      boardType = "Duplex/WB/A4/250";
                                      boardvalue = boardType;
                                      sizeOfPage = "5040";
                                      boardPrice = "2.60";
                                    } else if (selectedPage! == "Sawera" ||
                                        selectedPage! == "Sawera Spiral") {
                                      boardType = "Bahal/GB/190";
                                      sizeOfPage = "4212";
                                      boardvalue = boardType;
                                      boardPrice = "2.10";
                                    } else if (selectedPage! ==
                                            "Oblong Spiral" ||
                                        selectedPage! == "Oblong") {
                                      boardType = "Duplex/WB/OB/250";
                                      sizeOfPage = "3795";
                                      boardPrice = "3.50";
                                      boardvalue = boardType;
                                    } else if (selectedPage! == "A5/DC" ||
                                        selectedPage! == "A5/DC Sprial") {
                                      boardType = "SBS/WB/250";
                                      sizeOfPage = "3626";
                                      boardPrice = "3.10";
                                      boardvalue = boardType;
                                    } else if (selectedPage! == "RangRiti" ||
                                        selectedPage! == "Rangriti Spiral") {
                                      boardType = "Duplex/WB/RR/250";
                                      sizeOfPage = "6528 ";
                                      boardPrice = "3.50";
                                      boardvalue = boardType;
                                    } else if (selectedPage! == "Star Kid") {
                                      boardType = "Duplex/WB/A5/250";
                                      sizeOfPage = "3626";
                                      boardPrice = "2.60";
                                      boardvalue = boardType;
                                    } else if (selectedPage! == "Saptrishi") {
                                      boardType = "GB/NL/A5";
                                      sizeOfPage = "3626";
                                      boardPrice = "1.10";
                                      boardvalue = boardType;
                                    } else if (selectedPage! == "Crown") {
                                      boardType = "Duplex/GB/230";
                                      sizeOfPage = "3220";
                                      boardPrice = "2.40";
                                      boardvalue = boardType;
                                    } else if (selectedPage! == "Prime") {
                                      boardType = "Board/GB/180";
                                      sizeOfPage = "3220";
                                      boardPrice = "1.50";
                                      boardvalue = boardType;
                                    } else if (selectedPage! == "Mogli") {
                                      boardType = "GB/NL/CR";
                                      sizeOfPage = "3220";
                                      boardPrice = "0.60";
                                      boardvalue = boardType;
                                    } else if (selectedPage! == "Practical") {
                                      boardType = "Duplex/WB/PT/250";
                                      sizeOfPage = "5104";
                                      boardPrice = "4.50";
                                      boardvalue = boardType;
                                    } else if (selectedPage! == "Mogli 10") {
                                      boardType = "GB/CR 180";
                                      sizeOfPage = "3220";
                                      boardPrice = "1";
                                      boardvalue = boardType;
                                    } else if (selectedPage! == "Scrape Book") {
                                      boardType = "Comming soon..";
                                      sizeOfPage = "5040";
                                      // boardValue=""
                                      boardvalue = boardType;
                                    } else if (selectedPage! == "Creater") {
                                      boardType = "Duplex/WB/A4/250";
                                      sizeOfPage = "5040";
                                      boardPrice = "2.60";
                                      boardvalue = boardType;
                                    } else if (selectedPage! == "Sawera") {
                                      boardType = "Bahal/GB/190";
                                      sizeOfPage = "4212";
                                      boardPrice = "2.10";
                                      boardvalue = boardType;
                                    } else {
                                      boardType = "Select a board";
                                      boardvalue = boardType;
                                    }
                                  });
                                },
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Cover",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      SizedBox(height: 10),

                      TextField(
                        controller: TextEditingController(
                          text:
                              selectedPage != null
                                  ? coverColor
                                  : 'Select a cover',
                        ),
                        readOnly: true,
                        style: TextStyle(
                          fontSize: 18,
                          // color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                        decoration: InputDecoration(
                          filled: false,
                          contentPadding: EdgeInsets.only(left: 15.0),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),

                      SizedBox(height: 10),
                      Text(
                        "Board",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      SizedBox(height: 10),

                      TextField(
                        controller: TextEditingController(
                          text:
                              selectedPage != null
                                  ? boardType
                                  : 'Select a board',
                        ),
                        readOnly: true,
                        style: TextStyle(
                          fontSize: 18,
                          // color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                        decoration: InputDecoration(
                          filled: false,
                          contentPadding: EdgeInsets.only(left: 15.0),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),

                      SizedBox(height: 10),
                      Text(
                        "Page",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      SizedBox(height: 15),

                      /// Dropdown 3 – Paper Name
                      DropdownButtonFormField<Map<String, dynamic>>(
                        hint: Text("Select a page"),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        value: selectedPaper,
                        items:
                            filteredPapers
                                .map<DropdownMenuItem<Map<String, dynamic>>>(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e["name"]),
                                  ),
                                )
                                .toList(),
                        onChanged:
                            filteredPapers.isEmpty
                                ? null
                                : (val) {
                                  setState(() {
                                    selectedPaper = val;
                                    pagevalue = selectedPaper!["value"];
                                  });
                                },
                      ),

                      SizedBox(height: 10),
                      Text(
                        "No of Page",
                        style: TextStyle(
                          fontSize: 18,
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
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Text(nopageValue.name),
                                ),
                              );
                            }).toList(),
                        onChanged: (NoOfPageModel? newValueNoPage) {
                          setState(() {
                            selectedNoOfPage = newValueNoPage;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),

                      SizedBox(height: 15),

                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                selectedNoOfPage == null ||
                                        articlevalue.isEmpty ||
                                        modelvalue.isEmpty ||
                                        colorValue.isEmpty ||
                                        boardvalue.isEmpty ||
                                        pagevalue.isEmpty
                                    ? Colors
                                        .grey // disabled color
                                    : Colors.pinkAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed:
                              selectedNoOfPage == null ||
                                      articlevalue.isEmpty ||
                                      modelvalue.isEmpty ||
                                      colorValue.isEmpty ||
                                      boardvalue.isEmpty ||
                                      pagevalue.isEmpty
                                  ? null // 🚫 button disabled
                                  : () {
                                    _multiply(
                                      sizeOfPage,
                                      boardPrice,
                                      pagevalue,
                                      selectedNoOfPage,
                                    );
                                  },
                          child: const Text(
                            'Calculate',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      Text(
                        'Result : $finalResult',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 25),
                    ],
                  ),
                ),
              ),
    );
  }

  void _multiply(
    String sizeOfPage,
    String boardPrice,
    final pagevalue,
    NoOfPageModel? selectedNoOfPage,
  ) {
    final divRW = double.tryParse('20000'.toString()) ?? 1;
    final divPageRate = double.tryParse('8000'.toString()) ?? 1;
    final stPageType = double.tryParse("49".toString()) ?? 1;
    final sizeOfPageDouble = double.tryParse(sizeOfPage) ?? 0;
    final pagevalueDouble = double.tryParse(pagevalue.toString()) ?? 0;
    final selectedNoOfPageValue = selectedNoOfPage!.value;
    final boardPriceDouble = double.tryParse(boardPrice) ?? 0;
    final rimWeght = sizeOfPageDouble * pagevalueDouble / divRW;
    final riwPrice = rimWeght;
    setState(() {
      finalResult = ((((riwPrice * stPageType / divPageRate) *
                      selectedNoOfPageValue) +
                  boardPriceDouble +
                  0.75) *
              (100 + 18) /
              100)
          .toStringAsFixed(1);
    });

    print("Final Result: $finalResult");
  }
}
