import 'dart:convert' show json;
import 'package:calculater/model/boundtype.dart';
import 'package:calculater/model/coverBoard.dart';
import 'package:calculater/model/coverModel.dart';
import 'package:calculater/model/model.dart';
import 'package:calculater/model/noOfPage.dart';
import 'package:calculater/model/pageTypeModel.dart';
import 'package:calculater/repositeries/calculator_repo.dart';
import 'package:calculater/utils/SnackbarUtils.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String coverColor = 'Select a cover';
  String boardType = 'Select a board';

  /// Lists
  List<Boundtype> boundTypePage = [];
  List<ModelPage> spiralList = [];
  List<ModelPage> stapleList = [];
  List<ModelPage> filteredBrands = [];
  List<CoverModel> coverList = [];
  List<CoverBoard> coverBoard = [];
  List<PageType> pageM = [];
  List<NoOfPageModel> noOfPage = [];

  /// Selected items
  Boundtype? selectedboundTypePage;
  ModelPage? selectedModelPage;
  CoverModel? selectedCover;
  CoverBoard? selectedBoard;
  PageType? selectedPageM;
  NoOfPageModel? selectedNoOfPage;

  List<CoverModel> coverType = [];
  CoverModel? selectedCoverType;

  /// LOAD JSON FROM ASSETS /// ---------------------
  Future<void> loadAllJsonData() async {
    boundTypePage = await CalculatorRepository().boundtyperomAsset();
    spiralList = await CalculatorRepository().modelspiralboundFromAsset();
    stapleList = await CalculatorRepository().modelstapleboundFromAsset();
    coverList = await CalculatorRepository().loadCoverAsset();
    coverBoard = await CalculatorRepository().boardCoverTypeAsset();
    pageM = await CalculatorRepository().pageMTypeAsset();
    noOfPage = await CalculatorRepository().loadNoofPageAsset();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadAllJsonData();
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

              Text(
                "Bound type",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.normal,
                ),
              ),
              SizedBox(height: 15),

              /// FIRST DROPDOWN — BINDING
              DropdownButtonFormField<Boundtype>(
                isExpanded: true,
                hint: Text("Select Bound Type "),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                value: selectedboundTypePage,
                items:
                    boundTypePage.map((b) {
                      return DropdownMenuItem(
                        value: b,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(b.name),
                        ),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedboundTypePage = value;
                    selectedModelPage = null; // CLEAR BRAND
                    filteredBrands = []; // CLEAR LIST

                    // Load related list
                    if (value!.id == 0) {
                      filteredBrands = spiralList;
                    } else if (value.id == 1) {
                      filteredBrands = stapleList;
                    } else {
                      filteredBrands = [];
                    }
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

              /// SECOND DROPDOWN — BRAND
              DropdownButtonFormField<ModelPage>(
                isExpanded: true,
                hint: Text("Select Model Type "),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                value: selectedModelPage,
                items:
                    filteredBrands.map((b) {
                      return DropdownMenuItem(
                        value: b,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(b.name),
                        ),
                      );
                    }).toList(),
                onChanged:
                    filteredBrands.isEmpty
                        ? null
                        : (value) {
                          setState(() {
                            selectedModelPage = value;
                            // cover color logic
                            if (value!.name == "A5/DC" ||
                                value!.name == "Crown") {
                              coverColor = "Color & Brown";
                            } else if (value!.name == "Crown 10") {
                              coverColor = "Brown";
                            } else {
                              coverColor = "Colour";
                            }

                            // board type logic
                            if (value!.name == "Notes Lover" ||
                                value!.name == "A4 Primum") {
                              boardType = "SBS/WB/270";
                            } else if (value!.name == "Youva Spiral" ||
                                value!.name == "Youva") {
                              boardType = "Duplex/WB/A4/250";
                            } else if (value!.name == "Sawera" ||
                                value!.name == "Sawera Spiral") {
                              boardType = "Bahal/GB/190";
                            } else if (value!.name == "Oblong Sprial" ||
                                value!.name == "Oblong") {
                              boardType = "Duplex/WB/OB/250";
                            } else if (value!.name == "A5/DC" ||
                                value!.name == "A5/DC Sprial") {
                              boardType = "SBS/WB/250";
                            } else if (value!.name == "RangRiti" ||
                                value!.name == "Rangriti Spiral") {
                              boardType = "Duplex/WB/RR/250";
                            } else if (value!.name == "Star Kid") {
                              boardType = "Duplex/WB/A5/250";
                            } else if (value!.name == "Saptrishi") {
                              boardType = "GB/NL/A5";
                            } else if (value!.name == "Crown") {
                              boardType = "Duplex/GB/230";
                            } else if (value!.name == "Crown 10") {
                              boardType = "Board/GB/180";
                            } else if (value!.name == "Mogli") {
                              boardType = "GB/NL/CR";
                            } else if (value!.name == "Practical") {
                              boardType = "Duplex/WB/PT/250";
                            } else if (value!.name == "Scrape Book") {
                              boardType = "Comming soon..";
                            } else {
                              boardType = "250 GSM";
                            }
                          });
                        },
              ),

              SizedBox(height: 15),

              /// AUTO SIZE LABEL
              // if (selectedModelPage != null)
              //   Text(
              //     "Size: ${selectedModelPage!.value}",
              //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              //   ),
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
                      selectedModelPage != null ? coverColor : 'Select a cover',
                ),
                readOnly: true,
                style: TextStyle(
                  fontSize: 18,
                  // color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
                decoration: InputDecoration(
                  filled: false,
                  contentPadding: EdgeInsets.only(left: 30.0),
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

              // DropdownButtonFormField<CoverBoard>(
              //   value: selectedBoard,
              //   hint: Text("Select a board"),
              //   items:
              //       coverBoard.map((coverValue) {
              //         return DropdownMenuItem<CoverBoard>(
              //           value: coverValue,
              //           child: Padding(
              //             padding: const EdgeInsets.only(left: 16.0),
              //             child: Text(coverValue.name),
              //           ),
              //         );
              //       }).toList(),
              //   onChanged: (CoverBoard? newValueCover) {
              //     setState(() {
              //       selectedBoard = newValueCover;
              //     });
              //   },
              //   decoration: InputDecoration(
              //     //labelText: 'Cover',
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(20),
              //     ),
              //   ),
              // ),
              TextField(
                controller: TextEditingController(
                  text:
                      selectedModelPage != null ? boardType : 'Select a board',
                ),
                readOnly: true,
                style: TextStyle(
                  fontSize: 18,
                  // color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
                decoration: InputDecoration(
                  filled: false,
                  contentPadding: EdgeInsets.only(left: 30.0),
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

              DropdownButtonFormField<PageType>(
                value: selectedPageM,
                hint: Text("Select a page"),
                items:
                    pageM.map((coverValue) {
                      return DropdownMenuItem<PageType>(
                        value: coverValue,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(coverValue.name),
                        ),
                      );
                    }).toList(),
                onChanged: (PageType? newValueCover) {
                  setState(() {
                    selectedPageM = newValueCover;
                  });
                },
                decoration: InputDecoration(
                  //labelText: 'Cover',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
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
                selectedboundTypePage == null &&
                        selectedCover == null &&
                        selectedBoard == null &&
                        selectedPageM == null &&
                        selectedNoOfPage == null
                    ? "No value selected"
                    : selectedboundTypePage == null
                    ? "No value selected"
                    : selectedCover == null
                    ? "No value selected"
                    : selectedBoard == null
                    ? "No value selected"
                    : selectedPageM == null
                    ? "No value selected"
                    : selectedNoOfPage == null
                    ? "No value selected"
                    : "You selected: ${selectedboundTypePage!.value} , ${selectedCover!.name}, ${selectedBoard!.value}, ${selectedPageM!.value},${selectedNoOfPage!.value}",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 25),
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
                      selectedboundTypePage,
                      selectedModelPage,
                      selectedCover,
                      selectedBoard,

                      selectedPageM,
                      selectedNoOfPage,
                      selectedCoverType,
                    );

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackbarUtils().snackBar);
                  },
                  child: Text(
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

  void _multiply(
    Boundtype? selectedModelPage,
    ModelPage? selectedboundTypePage,
    CoverModel? selectedCover,
    CoverBoard? selectedBoard,

    PageType? selectedPageM,
    NoOfPageModel? selectedNoOfPage,
    CoverModel? selectedCoverType,
  ) {
    final stPageSize = double.tryParse(selectedboundTypePage!.value.toString());
    // final stGsm = double.tryParse(selectedquality!.name.toString());

    print("Result: ${selectedboundTypePage!.value}, ");
  }
}
