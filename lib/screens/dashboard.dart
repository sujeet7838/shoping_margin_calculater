import 'dart:convert';

import 'package:calculater/model/noOfPage.dart';
import 'package:calculater/repositeries/calculator_repo.dart';
import 'package:calculater/utils/custom_app_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
  String pageRate = '';
  String noofpagevalue = '';
  String bindingvalue = '';
  String labourCost = '';

  double springCost = 1.50;
  double panniCost = 1.50;
  double packingCost = 1.00;
  // size of page value
  String sizeOfPage = '';

  // board Value
  String boardPrice = '';
  String finalResult = '';
  String profit = '';
  double finalResultRounded = 0.0;
  double profitRounded = 0.0;
  String profitCondition = '';

  // Image slide ////////
  double discountResul = 0;
  int? selectedDiscount;
  bool isSliderVisible = false;
  bool isSliderVisibleSpiral = false;
  bool isSliderVisibleGlu = false;
  int currentIndex = 0;
  List<int> discountList = List.generate(50, (index) => index + 1);

  // spiral image
  final List<String> sPiralImages = [
    "https://5.imimg.com/data5/SELLER/Default/2023/6/313423158/CU/ID/JL/2143736/spiral-book-binding-service-1000x1000.png",
    "https://5.imimg.com/data5/SELLER/Default/2022/9/JD/YQ/NZ/49313558/spiral-binding-notebook-1000x1000.jpg",
    "https://5.imimg.com/data5/SELLER/Default/2024/8/446551119/TS/TR/VQ/12319560/spiral-notebook-500x500.png",
  ];
  // staple image
  final List<String> images = [
    "https://5.imimg.com/data5/SELLER/Default/2023/11/363678670/AG/PG/NW/47274985/new-product-500x500.jpeg",
    "https://5.imimg.com/data5/SELLER/Default/2023/11/363678725/QQ/PA/TR/47274985/new-product-500x500.jpeg",
    "https://5.imimg.com/data5/SELLER/Default/2023/11/363678707/HB/SP/VE/47274985/new-product-500x500.jpeg",
    "https://5.imimg.com/data5/SELLER/Default/2023/11/363572114/TH/SQ/LC/47274985/new-product-500x500.jpeg",
    "https://5.imimg.com/data5/SELLER/Default/2023/11/363572097/NI/FQ/YQ/47274985/new-product-500x500.jpeg",
    "https://5.imimg.com/data5/SELLER/Default/2023/11/363678734/UN/LQ/OY/47274985/new-product-500x500.jpeg",
  ];
  // glu image
  final List<String> gluImages = [
    "https://4.imimg.com/data4/RX/TX/GLADMIN-1823819/perfect-bind-notebooks-250x250.jpg",
    "https://m.media-amazon.com/images/I/71abiNvD7pL._AC_UF350,350_QL80_.jpg",
    "https://avid360.in/public/website_files/img/PERFECT-BIND-NOTEBOOK_jpeg.jpg",
  ];

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
      appBar: CustomAppBar(
        title: "NoteBook B2C",
        subtitle: "Rajsu Enterprises",
        logoPath: "assets/images/logo.png",
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
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Column(
                            children: [
                              /// ARTICLE FIELD
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  /// LABEL
                                  SizedBox( 
                                    width: 90,
                                    child: Text(
                                      "Article",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),

                                  /// INPUT
                                  Expanded(
                                    child: DropdownButtonFormField<String>(
                                      isExpanded: true,
                                      hint: Text("Select a bound"),

                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 0.5,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 0.5,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
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

                                          if (articlevalue == "Sprial Bound") {
                                            isSliderVisibleSpiral = true;
                                            isSliderVisibleGlu = false;
                                            isSliderVisible = false;
                                          } else if (articlevalue ==
                                              "Staple bound") {
                                            isSliderVisibleSpiral = false;
                                            isSliderVisibleGlu = false;
                                            isSliderVisible = true;
                                          } else if (articlevalue ==
                                              "Glu Bound") {
                                            isSliderVisibleSpiral = false;
                                            isSliderVisible = false;
                                            isSliderVisibleGlu = true;
                                          } else {
                                            isSliderVisibleSpiral = false;
                                            isSliderVisible = false;
                                            isSliderVisibleGlu = false;
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 10),

                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Column(
                            children: [
                              /// ARTICLE FIELD
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  /// LABEL
                                  SizedBox(
                                    width: 90,
                                    child: Text(
                                      "Model",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),

                                  /// INPUT
                                  Expanded(
                                    child: DropdownButtonFormField<String>(
                                      hint: Text("Select a model"),
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 0.5,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 0.5,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
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

                                                  if (selectedPage! ==
                                                          "A5/DC" ||
                                                      selectedPage == "Crown") {
                                                    coverColor =
                                                        "Color & Brown";
                                                    colorValue = coverColor;
                                                  } else if (selectedPage ==
                                                      "Crown 10") {
                                                    coverColor = "Brown";
                                                    colorValue = coverColor;
                                                  } else {
                                                    coverColor = "Colour";
                                                    colorValue = coverColor;
                                                  }

                                                  // board type logic
                                                  if (selectedPage! ==
                                                          "Notes Lover" ||
                                                      selectedPage! ==
                                                          "A4 Premium") {
                                                    boardType = "SBS/WB/270";
                                                    sizeOfPage = "5040";
                                                    boardPrice = "5";
                                                    boardvalue = boardType;
                                                  } else if (selectedPage! ==
                                                          "Yuva Spiral" ||
                                                      selectedPage! == "Yuva") {
                                                    boardType =
                                                        "Duplex/WB/A4/250";
                                                    boardvalue = boardType;
                                                    sizeOfPage = "5040";
                                                    boardPrice = "2.60";
                                                  } else if (selectedPage! ==
                                                          "Sawera" ||
                                                      selectedPage! ==
                                                          "Sawera Spiral") {
                                                    boardType = "Bahal/GB/190";
                                                    sizeOfPage = "4212";
                                                    boardvalue = boardType;
                                                    boardPrice = "2.10";
                                                  } else if (selectedPage! ==
                                                          "Oblong Spiral" ||
                                                      selectedPage! ==
                                                          "Oblong") {
                                                    boardType =
                                                        "Duplex/WB/OB/250";
                                                    sizeOfPage = "3795";
                                                    boardPrice = "3.50";
                                                    boardvalue = boardType;
                                                  } else if (selectedPage! ==
                                                          "A5/DC" ||
                                                      selectedPage! ==
                                                          "A5/DC Sprial") {
                                                    boardType = "SBS/WB/250";
                                                    sizeOfPage = "3626";
                                                    boardPrice = "3.10";
                                                    boardvalue = boardType;
                                                  } else if (selectedPage! ==
                                                          "RangRiti" ||
                                                      selectedPage! ==
                                                          "Rangriti Spiral") {
                                                    boardType =
                                                        "Duplex/WB/RR/250";
                                                    sizeOfPage = "6528 ";
                                                    boardPrice = "3.50";
                                                    boardvalue = boardType;
                                                  } else if (selectedPage! ==
                                                      "Star Kid") {
                                                    boardType =
                                                        "Duplex/WB/A5/250";
                                                    sizeOfPage = "3626";
                                                    boardPrice = "2.60";
                                                    boardvalue = boardType;
                                                  } else if (selectedPage! ==
                                                      "Saptrishi") {
                                                    boardType = "GB/NL/A5";
                                                    sizeOfPage = "3626";
                                                    boardPrice = "1.10";
                                                    boardvalue = boardType;
                                                  } else if (selectedPage! ==
                                                      "Crown") {
                                                    boardType = "Duplex/GB/230";
                                                    sizeOfPage = "3220";
                                                    boardPrice = "2.40";
                                                    boardvalue = boardType;
                                                  } else if (selectedPage! ==
                                                      "Prime") {
                                                    boardType = "Board/GB/180";
                                                    sizeOfPage = "3220";
                                                    boardPrice = "1.50";
                                                    boardvalue = boardType;
                                                  } else if (selectedPage! ==
                                                      "Mogli") {
                                                    boardType = "GB/NL/CR";
                                                    sizeOfPage = "3220";
                                                    boardPrice = "0.60";
                                                    boardvalue = boardType;
                                                  } else if (selectedPage! ==
                                                      "Practical") {
                                                    boardType =
                                                        "Duplex/WB/PT/250";
                                                    sizeOfPage = "5104";
                                                    boardPrice = "4.50";
                                                    boardvalue = boardType;
                                                  } else if (selectedPage! ==
                                                      "Mogli 10") {
                                                    boardType = "GB/CR 180";
                                                    sizeOfPage = "3220";
                                                    boardPrice = "1";
                                                    boardvalue = boardType;
                                                  } else if (selectedPage! ==
                                                      "Saptrishi") {
                                                    boardType = "GB/NL/A5";
                                                    sizeOfPage = "3626";
                                                    boardPrice = "1.10";
                                                    boardvalue = boardType;
                                                  } else if (selectedPage! ==
                                                      "Scrape Book") {
                                                    boardType =
                                                        "Comming soon..";
                                                    sizeOfPage = "5040";
                                                    // boardValue=""
                                                    boardvalue = boardType;
                                                  } else if (selectedPage! ==
                                                      "Creater") {
                                                    boardType =
                                                        "Duplex/WB/A4/250";
                                                    sizeOfPage = "5040";
                                                    boardPrice = "2.60";
                                                    boardvalue = boardType;
                                                  } else if (selectedPage! ==
                                                      "Sawera") {
                                                    boardType = "Bahal/GB/190";
                                                    sizeOfPage = "4212";
                                                    boardPrice = "2.10";
                                                    boardvalue = boardType;
                                                  } else {
                                                    boardType =
                                                        "Select a board";
                                                    boardvalue = boardType;
                                                  }
                                                });
                                              },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 10),

                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Column(
                            children: [
                              /// ARTICLE FIELD
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  /// LABEL
                                  SizedBox(
                                    width: 90,
                                    child: Text(
                                      "Cover",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),

                                  /// INPUT
                                  Expanded(
                                    child: TextField(
                                      controller: TextEditingController(
                                        text:
                                            selectedPage != null
                                                ? coverColor
                                                : 'Select a cover',
                                      ),
                                      readOnly: true,
                                      style: TextStyle(
                                        fontSize: 16,
                                        // color: Colors.grey,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 0.5,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 0.5,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        filled: false,
                                        contentPadding: EdgeInsets.only(
                                          left: 15.0,
                                        ),
                                        suffixIcon: Icon(Icons.arrow_drop_down),
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                            width: 2.0,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 10),

                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Column(
                            children: [
                              /// ARTICLE FIELD
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  /// LABEL
                                  SizedBox(
                                    width: 90,
                                    child: Text(
                                      "Board",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),

                                  /// INPUT
                                  Expanded(
                                    child: TextField(
                                      controller: TextEditingController(
                                        text:
                                            selectedPage != null
                                                ? boardType
                                                : 'Select a board',
                                      ),
                                      readOnly: true,
                                      style: TextStyle(
                                        fontSize: 16,
                                        // color: Colors.grey,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 0.5,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 0.5,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        filled: false,
                                        contentPadding: EdgeInsets.only(
                                          left: 15.0,
                                        ),
                                        suffixIcon: Icon(Icons.arrow_drop_down),
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                            width: 2.0,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 10),

                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Column(
                            children: [
                              /// ARTICLE FIELD
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  /// LABEL
                                  SizedBox(
                                    width: 90,
                                    child: Text(
                                      "Page",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),

                                  /// INPUT
                                  Expanded(
                                    child: DropdownButtonFormField<
                                      Map<String, dynamic>
                                    >(
                                      hint: Text("Select a page"),
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 0.5,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 0.5,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                      ),
                                      value: selectedPaper,
                                      items:
                                          filteredPapers
                                              .map<
                                                DropdownMenuItem<
                                                  Map<String, dynamic>
                                                >
                                              >(
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
                                                  pagevalue =
                                                      selectedPaper!["value"];

                                                  if (selectedPaper!["name"]! ==
                                                      "Malyscian/58") {
                                                    pageRate = "88.00";
                                                  } else if (selectedPaper!["name"]! ==
                                                      "East Cost/58") {
                                                    pageRate = "92.00";
                                                  } else if (selectedPaper!["name"]! ==
                                                      "JK/58") {
                                                    pageRate = "92.00";
                                                  } else if (selectedPaper!["name"]! ==
                                                      "Century Classic/57") {
                                                    pageRate = "97.00";
                                                  } else if (selectedPaper!["name"]! ==
                                                      "Nani/57") {
                                                    pageRate = "82.00";
                                                  } else if (selectedPaper!["name"]! ==
                                                      "Century/56") {
                                                    pageRate = "94.00";
                                                  } else if (selectedPaper!["name"]! ==
                                                      "ABC/56") {
                                                    pageRate = "84.00";
                                                  } else if (selectedPaper!["name"]! ==
                                                      "Silver/54") {
                                                    pageRate = "74.00";
                                                  } else if (selectedPaper!["name"]! ==
                                                      "Indra Plt/54") {
                                                    pageRate = "62.50";
                                                  } else if (selectedPaper!["name"]! ==
                                                      "Indra Gold/54") {
                                                    pageRate = "49.00";
                                                  } else if (selectedPaper!["name"]! ==
                                                      "DT/52") {
                                                    pageRate = "58.00";
                                                  } else if (selectedPaper!["name"]! ==
                                                      "Indra Gold/48") {
                                                    pageRate = "51.00";
                                                  } else {
                                                    pageRate =
                                                        "Select a page rate";
                                                  }
                                                });
                                              },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      /// Dropdown 3 – Paper Name
                      SizedBox(height: 10),

                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Column(
                            children: [
                              /// ARTICLE FIELD
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  /// LABEL
                                  SizedBox(
                                    width: 90,
                                    child: Text(
                                      "No of Page",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),

                                  /// INPUT
                                  Expanded(
                                    child: DropdownButtonFormField<
                                      NoOfPageModel
                                    >(
                                      value: selectedNoOfPage,
                                      hint: Text("Select a no of page"),
                                      items:
                                          noOfPage.map((nopageValue) {
                                            return DropdownMenuItem<
                                              NoOfPageModel
                                            >(
                                              value: nopageValue,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 16.0,
                                                ),
                                                child: Text(nopageValue.name),
                                              ),
                                            );
                                          }).toList(),
                                      onChanged: (
                                        NoOfPageModel? newValueNoPage,
                                      ) {
                                        setState(() {
                                          selectedNoOfPage = newValueNoPage;

                                          if (articlevalue == "Sprial Bound") {
                                            if (int.parse(
                                                      selectedNoOfPage!.name,
                                                    ) >=
                                                    8 &&
                                                int.parse(
                                                      selectedNoOfPage!.name,
                                                    ) <=
                                                    100) {
                                              final lbrcost = 2.50;
                                              labourCost = double.parse(
                                                (springCost +
                                                        panniCost +
                                                        packingCost +
                                                        lbrcost)
                                                    .toString(),
                                              ).toStringAsFixed(2);
                                            } else if (int.parse(
                                                      selectedNoOfPage!.name,
                                                    ) >=
                                                    104 &&
                                                int.parse(
                                                      selectedNoOfPage!.name,
                                                    ) <=
                                                    148) {
                                              final lbrcost = 3.00;

                                              labourCost = double.parse(
                                                (springCost +
                                                        panniCost +
                                                        packingCost +
                                                        lbrcost)
                                                    .toString(),
                                              ).toStringAsFixed(2);
                                            } else if (int.parse(
                                                      selectedNoOfPage!.name,
                                                    ) >=
                                                    152 &&
                                                int.parse(
                                                      selectedNoOfPage!.name,
                                                    ) <=
                                                    200) {
                                              final lbrcost = 3.25;
                                              // final lbrcost =
                                              //     1.5 /
                                              //     120 *
                                              //     int.parse(selectedNoOfPage!.name);
                                              labourCost = double.parse(
                                                (springCost +
                                                        panniCost +
                                                        packingCost +
                                                        lbrcost)
                                                    .toString(),
                                              ).toStringAsFixed(2);
                                            } else if (int.parse(
                                                      selectedNoOfPage!.name,
                                                    ) >=
                                                    204 &&
                                                int.parse(
                                                      selectedNoOfPage!.name,
                                                    ) <=
                                                    252) {
                                              final lbrcost = 3.50;
                                              // final lbrcost =
                                              //     1.5 /
                                              //     120 *
                                              //     int.parse(selectedNoOfPage!.name);
                                              labourCost = double.parse(
                                                (springCost +
                                                        panniCost +
                                                        packingCost +
                                                        lbrcost)
                                                    .toString(),
                                              ).toStringAsFixed(2);
                                            } else if (int.parse(
                                                      selectedNoOfPage!.name,
                                                    ) >=
                                                    256 &&
                                                int.parse(
                                                      selectedNoOfPage!.name,
                                                    ) <=
                                                    300) {
                                              final lbrcost = 4.00;
                                              // final lbrcost =
                                              //     1.5 /
                                              //     120 *
                                              //     int.parse(selectedNoOfPage!.name);
                                              labourCost = double.parse(
                                                (springCost +
                                                        panniCost +
                                                        packingCost +
                                                        lbrcost)
                                                    .toString(),
                                              ).toStringAsFixed(2);
                                            } else if (int.parse(
                                                      selectedNoOfPage!.name,
                                                    ) >=
                                                    304 &&
                                                int.parse(
                                                      selectedNoOfPage!.name,
                                                    ) <=
                                                    352) {
                                              final lbrcost = 4.50;
                                              // final lbrcost =
                                              //     1.5 /
                                              //     120 *
                                              //     int.parse(selectedNoOfPage!.name);
                                              labourCost = double.parse(
                                                (springCost +
                                                        panniCost +
                                                        packingCost +
                                                        lbrcost)
                                                    .toString(),
                                              ).toStringAsFixed(2);
                                            } else if (int.parse(
                                                      selectedNoOfPage!.name,
                                                    ) >=
                                                    356 &&
                                                int.parse(
                                                      selectedNoOfPage!.name,
                                                    ) <=
                                                    400) {
                                              final lbrcost = 5.00;
                                              // final lbrcost =
                                              //     1.5 /
                                              //     120 *
                                              //     int.parse(selectedNoOfPage!.name);
                                              labourCost = double.parse(
                                                (springCost +
                                                        panniCost +
                                                        packingCost +
                                                        lbrcost)
                                                    .toString(),
                                              ).toStringAsFixed(2);
                                            } else if (int.parse(
                                                      selectedNoOfPage!.name,
                                                    ) >=
                                                    404 &&
                                                int.parse(
                                                      selectedNoOfPage!.name,
                                                    ) <=
                                                    452) {
                                              final lbrcost = 5.50;
                                              // final lbrcost =
                                              //     1.5 /
                                              //     120 *
                                              //     int.parse(selectedNoOfPage!.name);
                                              labourCost = double.parse(
                                                (springCost +
                                                        panniCost +
                                                        packingCost +
                                                        lbrcost)
                                                    .toString(),
                                              ).toStringAsFixed(2);
                                            } else if (int.parse(
                                                      selectedNoOfPage!.name,
                                                    ) >=
                                                    456 &&
                                                int.parse(
                                                      selectedNoOfPage!.name,
                                                    ) <=
                                                    500) {
                                              final lbrcost = 6.00;
                                              // final lbrcost =
                                              //     1.5 /
                                              //     120 *
                                              //     int.parse(selectedNoOfPage!.name);
                                              labourCost = double.parse(
                                                (springCost +
                                                        panniCost +
                                                        packingCost +
                                                        lbrcost)
                                                    .toString(),
                                              ).toStringAsFixed(2);
                                            }

                                            //////////////////////////////////////Sprial Bound///////////////////////////////////
                                          } else if (articlevalue ==
                                              "Staple bound") {
                                            //labourCost Staple bound
                                            if (selectedNoOfPage!.name == "2") {
                                              labourCost = "";
                                            } else if (int.parse(
                                                      selectedNoOfPage!.name,
                                                    ) >=
                                                    8 &&
                                                int.parse(
                                                      selectedNoOfPage!.name,
                                                    ) <=
                                                    60) {
                                              labourCost = "0.35";
                                            } else if (int.parse(
                                                      selectedNoOfPage!.name,
                                                    ) >=
                                                    64 &&
                                                int.parse(
                                                      selectedNoOfPage!.name,
                                                    ) <=
                                                    96) {
                                              labourCost = "0.45";
                                            } else if (int.parse(
                                                      selectedNoOfPage!.name,
                                                    ) >=
                                                    100 &&
                                                int.parse(
                                                      selectedNoOfPage!.name,
                                                    ) <=
                                                    300) {
                                              final lbrcost =
                                                  0.70 /
                                                  120 *
                                                  int.parse(
                                                    selectedNoOfPage!.name,
                                                  );
                                              labourCost = lbrcost
                                                  .toStringAsFixed(3);
                                            } else {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    "Please select GLU Bond Article after 300 pages",
                                                  ),
                                                ),
                                              );
                                            }
                                          } else if (articlevalue ==
                                              "Glu Bound") {
                                            //labourCost "Glu Bound
                                            if (int.parse(
                                                      selectedNoOfPage!.name,
                                                    ) >=
                                                    0 &&
                                                int.parse(
                                                      selectedNoOfPage!.name,
                                                    ) <=
                                                    200) {
                                              final lbrcost = 2.5;

                                              labourCost = double.parse(
                                                (springCost +
                                                        panniCost +
                                                        packingCost +
                                                        lbrcost)
                                                    .toString(),
                                              ).toStringAsFixed(2);
                                            } else if (int.parse(
                                                      selectedNoOfPage!.name,
                                                    ) >=
                                                    204 &&
                                                int.parse(
                                                      selectedNoOfPage!.name,
                                                    ) <=
                                                    500) {
                                              // final lbrcost = "5.00";
                                              final lbrcost =
                                                  1.5 /
                                                  120 *
                                                  int.parse(
                                                    selectedNoOfPage!.name,
                                                  );

                                              labourCost = (0 +
                                                      0 +
                                                      0.50 +
                                                      lbrcost)
                                                  .toStringAsFixed(2);
                                            }
                                          }
                                        });
                                      },
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 0.5,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 0.5,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 15),

                      // spiral bound image slider
                      if (isSliderVisibleSpiral)
                        Column(
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                //height: 150,
                                autoPlay: true, // 🔥 auto scroll ON
                                autoPlayInterval: Duration(seconds: 3),
                                autoPlayAnimationDuration: Duration(
                                  milliseconds: 800,
                                ),
                                enlargeCenterPage: true,
                                viewportFraction: 0.9,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    currentIndex = index;
                                  });
                                },
                              ),
                              items:
                                  sPiralImages.map((url) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(0),
                                      child: Image.network(
                                        url,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  }).toList(),
                            ),

                            // 🔵 Indicator (dots)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                                  sPiralImages.asMap().entries.map((entry) {
                                    return Container(
                                      width: currentIndex == entry.key ? 12 : 8,
                                      height:
                                          currentIndex == entry.key ? 12 : 8,
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 4,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            currentIndex == entry.key
                                                ? Colors.blue
                                                : Colors.grey,
                                      ),
                                    );
                                  }).toList(),
                            ),
                          ],
                        ),
                      // staple bound image slider
                      if (isSliderVisible)
                        Column(
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                //height: 150,
                                autoPlay: true, // 🔥 auto scroll ON
                                autoPlayInterval: Duration(seconds: 3),
                                autoPlayAnimationDuration: Duration(
                                  milliseconds: 800,
                                ),
                                enlargeCenterPage: true,
                                viewportFraction: 0.9,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    currentIndex = index;
                                  });
                                },
                              ),
                              items:
                                  images.map((url) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(0),
                                      child: Image.network(
                                        url,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  }).toList(),
                            ),

                            // 🔵 Indicator (dots)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                                  images.asMap().entries.map((entry) {
                                    return Container(
                                      width: currentIndex == entry.key ? 12 : 8,
                                      height:
                                          currentIndex == entry.key ? 12 : 8,
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 4,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            currentIndex == entry.key
                                                ? Colors.blue
                                                : Colors.grey,
                                      ),
                                    );
                                  }).toList(),
                            ),
                          ],
                        ),

                      // glu bound image slider
                      if (isSliderVisibleGlu)
                        Column(
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                //height: 150,
                                autoPlay: true, // 🔥 auto scroll ON
                                autoPlayInterval: Duration(seconds: 3),
                                autoPlayAnimationDuration: Duration(
                                  milliseconds: 800,
                                ),
                                enlargeCenterPage: true,
                                viewportFraction: 0.9,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    currentIndex = index;
                                  });
                                },
                              ),
                              items:
                                  gluImages.map((url) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(0),
                                      child: Image.network(
                                        url,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  }).toList(),
                            ),

                            // 🔵 Indicator (dots)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                                  gluImages.asMap().entries.map((entry) {
                                    return Container(
                                      width: currentIndex == entry.key ? 12 : 8,
                                      height:
                                          currentIndex == entry.key ? 12 : 8,
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 4,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            currentIndex == entry.key
                                                ? Colors.blue
                                                : Colors.grey,
                                      ),
                                    );
                                  }).toList(),
                            ),
                          ],
                        ),

                      SizedBox(height: 15),

                      Center(
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),

                            /// 👇 Disable logic
                            onTap:
                                (selectedNoOfPage == null ||
                                        articlevalue.isEmpty ||
                                        modelvalue.isEmpty ||
                                        colorValue.isEmpty ||
                                        boardvalue.isEmpty ||
                                        pagevalue.isEmpty)
                                    ? null
                                    : () {
                                      _multiply(
                                        articlevalue,
                                        sizeOfPage,
                                        boardPrice,
                                        pagevalue,
                                        pageRate,
                                        labourCost,
                                        selectedNoOfPage,
                                      );
                                    },

                            child: Container(
                              height: 40,
                              width: 150,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),

                                /// 👇 Dynamic color (enabled / disabled)
                                color:
                                    (selectedNoOfPage == null ||
                                            articlevalue.isEmpty ||
                                            modelvalue.isEmpty ||
                                            colorValue.isEmpty ||
                                            boardvalue.isEmpty ||
                                            pagevalue.isEmpty)
                                        ? Colors.grey
                                        : Colors.pinkAccent,
                              ),

                              child: Text(
                                "Calculate",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),

                      Row(
                        children: [
                          /// 🟢 Result Text
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Result : $finalResultRounded',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),

                          SizedBox(height: 10),

                          /// 🔵 Discount Dropdown
                          Expanded(
                            flex: 1,
                            child: DropdownButtonFormField<int>(
                              decoration: InputDecoration(
                                labelText: "Discount %",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),

                              value: selectedDiscount,

                              items:
                                  discountList.map((e) {
                                    return DropdownMenuItem(
                                      value: e,
                                      child: Text("$e%"),
                                    );
                                  }).toList(),

                              onChanged: (value) {
                                setState(() {
                                  selectedDiscount = value;
                                });
                                applyDiscount("$value%");
                              },
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 25),
                      Center(
                        child: Text(
                          'Discount Cost : $discountResul',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
    );
  }

  void _multiply(
    String articlevalue,
    String sizeOfPage,
    String boardPrice,
    final pagevalue,
    String pageRate,
    String labourCost,
    NoOfPageModel? selectedNoOfPage,
  ) async {
    final divRW = double.tryParse('20000'.toString()) ?? 1;
    final divPageRate = double.tryParse('8000'.toString()) ?? 1;
    // final stPageType = double.tryParse("49".toString()) ?? 1;
    final stPageType = double.tryParse(pageRate.toString()) ?? 1;
    final sizeOfPageDouble = double.tryParse(sizeOfPage) ?? 0;
    final pagevalueDouble = double.tryParse(pagevalue.toString()) ?? 0;
    final selectedNoOfPageValue = selectedNoOfPage!.value;
    final boardPriceDouble = double.tryParse(boardPrice) ?? 0;
    final rimWeght = sizeOfPageDouble * pagevalueDouble / divRW;
    final riwPrice = rimWeght;
    double value = double.parse(riwPrice.toString());
    double result = (value * 10) / 10;
    final labourCostDouble = double.tryParse(labourCost) ?? 0;
    print("resultCost>>>> $result");
    print("stPageType>>>> $stPageType");
    print("divPageRate>>>> $divPageRate");
    print("selectedNoOfPageValue>>>> $selectedNoOfPageValue");
    print("boardPriceDouble>>>> $boardPriceDouble");
    print("labourCostDouble>>>> $labourCostDouble");

    setState(() {
      profit =
          (((((result * stPageType / divPageRate) * selectedNoOfPageValue) +
                  boardPriceDouble +
                  labourCostDouble)))
              .toString();

      print("profitCost>>>> " + profit.toString());

      profitRounded = (double.parse(profit) * 10).ceil() / 10;
      print("final profit..$profitRounded");

      if (articlevalue == "Staple bound") {
        if (profitRounded >= 0 && profitRounded <= 10) {
          profitCondition = '18';
          print(profitCondition);
        } else if (profitRounded >= 10 && profitRounded <= 20) {
          profitCondition = '18';
          print(profitCondition);
        } else if (profitRounded >= 20 && profitRounded <= 30) {
          profitCondition = '22';
          print(profitCondition);
          print(profitCondition);
        } else if (profitRounded >= 30 && profitRounded <= 40) {
          profitCondition = '25';
          print(profitCondition);
          print(profitRounded);
        } else if (profitRounded >= 40) {
          profitCondition = '28';
          print(profitCondition);
        }
      } else if (articlevalue == "Glu Bound") {
        print("Gluprofit$profitRounded");
        if (profitRounded >= 0 && profitRounded <= 20) {
          profitCondition = '18';
          print(profitCondition);
        } else if (profitRounded >= 20 && profitRounded <= 30) {
          profitCondition = '22';
          print(profitCondition);
        } else if (profitRounded >= 30 && profitRounded <= 40) {
          profitCondition = '25';
          print(profitCondition);
        } else if (profitRounded >= 40) {
          profitCondition = '28';
          print(profitCondition);
        }
      } else if (articlevalue == "Sprial Bound") {
        print("Sprial==profitCondition..$profitRounded");
        profitCondition = '25';
        print(profitCondition);
      }

      finalResult = ((((result * stPageType / divPageRate) *
                      selectedNoOfPageValue) +
                  boardPriceDouble +
                  labourCostDouble) *
              (100 + int.parse(profitCondition)) /
              100)
          .toStringAsFixed(3);

      double finalValue = double.parse(finalResult);
      finalResultRounded = (finalValue * 10).ceil() / 10;
      selectedDiscount = null;
      discountResul = 0;
    });
  }

  void applyDiscount(String? value) {
    setState(() {
      selectedDiscount = value != null ? int.parse(value.replaceAll('%', '')) : null;

      double discount = double.parse(value!.replaceAll('%', ''));

      discountResul = double.parse(
        (finalResultRounded - (finalResultRounded * discount / 100))
            .toStringAsFixed(3),
      );
    });
  }
}
