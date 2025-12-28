import 'dart:convert';

import 'package:calculater/model/noOfPage.dart';
import 'package:calculater/repositeries/calculator_repo.dart';
import 'package:calculater/utils/SnackbarUtils.dart';
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
  String result = '';

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

  /// ------------------ UI ------------------

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
                      /// Dropdown 1 – Binding Type
                      ///               SizedBox(height: 15),
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
                      SizedBox(height: 15),

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
                            print('Selected Type: $value.value');
                          });
                        },
                      ),

                      SizedBox(height: 15),

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
                      SizedBox(height: 15),

                      /// Dropdown 2 – Page
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
                                    print('Selected Page: $selectedPage');

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
                                      boardvalue = boardType;
                                    } else if (selectedPage! == "Yuva Spiral" ||
                                        selectedPage! == "Yuva") {
                                      boardType = "Duplex/WB/A4/250";
                                      boardvalue = boardType;
                                    } else if (selectedPage! == "Sawera" ||
                                        selectedPage! == "Sawera Spiral") {
                                      boardType = "Bahal/GB/190";
                                      boardvalue = boardType;
                                    } else if (selectedPage! ==
                                            "Oblong Spiral" ||
                                        selectedPage! == "Oblong") {
                                      boardType = "Duplex/WB/OB/250";
                                      boardvalue = boardType;
                                    } else if (selectedPage! == "A5/DC" ||
                                        selectedPage! == "A5/DC Sprial") {
                                      boardType = "SBS/WB/250";
                                      boardvalue = boardType;
                                    } else if (selectedPage! == "RangRiti" ||
                                        selectedPage! == "Rangriti Spiral") {
                                      boardType = "Duplex/WB/RR/250";
                                      boardvalue = boardType;
                                    } else if (selectedPage! == "Star Kid") {
                                      boardType = "Duplex/WB/A5/250";
                                      boardvalue = boardType;
                                    } else if (selectedPage! == "Saptrishi") {
                                      boardType = "GB/NL/A5";
                                      boardvalue = boardType;
                                    } else if (selectedPage! == "Crown") {
                                      boardType = "Duplex/GB/230";
                                      boardvalue = boardType;
                                    } else if (selectedPage! == "Crown 10") {
                                      boardType = "Board/GB/180";
                                      boardvalue = boardType;
                                    } else if (selectedPage! == "Mogli") {
                                      boardType = "GB/NL/CR";
                                      boardvalue = boardType;
                                    } else if (selectedPage! == "Practical") {
                                      boardType = "Duplex/WB/PT/250";
                                      boardvalue = boardType;
                                    } else if (selectedPage! == "Mogli 10") {
                                      boardType = "GB/CR 180";
                                      boardvalue = boardType;
                                    } else if (selectedPage! == "Scrape Book") {
                                      boardType = "Comming soon..";
                                      boardvalue = boardType;
                                    } else if (selectedPage! == "Creater") {
                                      boardType = "Duplex/WB/A4/250";
                                      boardvalue = boardType;
                                    } else if (selectedPage! == "Sawera") {
                                      boardType = "Bahal/GB/190";
                                      boardvalue = boardType;
                                    } else {
                                      boardType = "Select a board";
                                      boardvalue = boardType;
                                    }
                                  });
                                },
                      ),
                      SizedBox(height: 15),
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
                      SizedBox(height: 15),

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

                      SizedBox(height: 15),
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
                      SizedBox(height: 15),

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

                      SizedBox(height: 15),
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
                                    pagevalue = selectedPaper!["name"];

                                    print(
                                      'Selected Paper: ${selectedPaper!["name"]}, Price: ${selectedPaper!["value"]}',
                                    );
                                  });
                                },
                      ),

                      SizedBox(height: 15),
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
                          // labelText: 'No of page',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),

                      SizedBox(height: 15),

                      Text(
                    articlevalue == null
                    ? "No value selected"
                    : modelvalue == null
                    ? "No value selected"
                    : colorValue == null
                    ? "No value selected"
                    : boardvalue == null
                    ? "No value selected"
                    : pagevalue == null
                    ? "No value selected"
                    : selectedNoOfPage == null
                    ? "No value selected"
                    : "You selected: ${articlevalue!} , ${modelvalue!}, ${colorValue!}, ${boardvalue!}, ${pagevalue!}, ${selectedNoOfPage!.name}",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 25),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                selectedNoOfPage == null || articlevalue.isEmpty || modelvalue.isEmpty || colorValue.isEmpty || boardvalue.isEmpty || pagevalue.isEmpty
                                    ? Colors
                                        .grey // disabled color
                                    : Colors.pinkAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed:
                              selectedNoOfPage == null || articlevalue.isEmpty || modelvalue.isEmpty || colorValue.isEmpty || boardvalue.isEmpty || pagevalue.isEmpty
                                  ? null // 🚫 button disabled
                                  : () {
                                    _multiply(articlevalue, modelvalue, colorValue, boardvalue, pagevalue, selectedNoOfPage);

                                    ScaffoldMessenger.of(
                                      context,
                                    ).showSnackBar(SnackbarUtils().snackBar);
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
                    ],
                  ),
                ),
              ),
    );
  }

  void _multiply(String? articlevalue, String? modelvalue, String? colorValue, String? boardvalue, String? pagevalue, NoOfPageModel? selectedNoOfPage) {
    print("Result: $articlevalue,$modelvalue,$colorValue,$boardvalue,$pagevalue,${selectedNoOfPage!.value}"); 
  }
}
