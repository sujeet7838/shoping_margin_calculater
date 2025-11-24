import 'dart:convert' show json;
import 'package:calculater/model/boundtype.dart';
import 'package:calculater/model/coverBoard.dart';
import 'package:calculater/model/coverModel.dart';
import 'package:calculater/model/coverquality.dart';
import 'package:calculater/model/model.dart';
import 'package:calculater/model/noOfPage.dart';
import 'package:calculater/model/pageTypeModel.dart';
import 'package:calculater/model/pagethikness.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String _result = '';
  String boundValue = '';

  List<Boundtype> boundTypePage = [];
  Boundtype? selectedboundTypePage;

  List<ModelPage> modelPage = [];
  ModelPage? selectedModelPage;

  List<ModelPage> modelPage2 = [];
  ModelPage? selectedModelPage2;

  List<String> listItem = [];




  List<CoverModel> coverModel = [];
  CoverModel? selectedCover;

  List<CoverBoard> coverBoard = [];
  CoverBoard? selectedBoard;

  List<CoverQuality> coverquality = [];
  CoverQuality? selectedquality;

  List<PageType> pageM = [];
  PageType? selectedPageM;

  List<PageThikness> pagethikness = [];
  PageThikness? selectedPagethikness;

  List<NoOfPageModel> noOfPage = [];
  NoOfPageModel? selectedNoOfPage;

  List<CoverModel> coverType = [];
  CoverModel? selectedCoverType;

  // Load JSON data from assets assets/boundtype.json
  Future<List<Boundtype>> boundtyperomAsset() async {
    final String jsonString = await rootBundle.loadString(
      'assets/boundtype.json',
    );
    final List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((item) => Boundtype.fromJson(item)).toList();
  }

  // Load JSON data from assets assets/model.json
  Future<List<ModelPage>> modelstapleboundFromAsset() async {
    final String jsonString = await rootBundle.loadString(
      'assets/model_staplebound.json',
    );
    final List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((item) => ModelPage.fromJson(item)).toList();
  }

  // Load JSON data from assets assets/model2.json
  Future<List<ModelPage>> modelspiralboundFromAsset() async {
    final String jsonString = await rootBundle.loadString(
      'assets/model_sprialbound.json',
    );
    final List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((item) => ModelPage.fromJson(item)).toList();
  }

  // Load JSON data from assets assets/CoverType.json
  Future<List<CoverModel>> loadCoverAsset() async {
    final String jsonString = await rootBundle.loadString('assets/cover.json');
    final List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((item) => CoverModel.fromJson(item)).toList();
  }

  // Load JSON data from assets assets/CoverBoard.json
  Future<List<CoverBoard>> boardCoverTypeAsset() async {
    final String jsonString = await rootBundle.loadString('assets/board.json');
    final List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((item) => CoverBoard.fromJson(item)).toList();
  }

  // Load JSON data from assets assets/CoverQuality.json
  Future<List<CoverQuality>> qualityCoverTypeAsset() async {
    final String jsonString = await rootBundle.loadString(
      'assets/coverquality.json',
    );
    final List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((item) => CoverQuality.fromJson(item)).toList();
  }

  // Load JSON data from assets assets/page.json
  Future<List<PageType>> pageMTypeAsset() async {
    final String jsonString = await rootBundle.loadString('assets/page.json');
    final List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((item) => PageType.fromJson(item)).toList();
  }

  // Load JSON data from assets assets/pagethikness.json
  Future<List<PageThikness>> pagethiknessAsset() async {
    final String jsonString = await rootBundle.loadString(
      'assets/pagethikness.json',
    );
    final List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((item) => PageThikness.fromJson(item)).toList();
  }

  // Load JSON data from assets assets/noPage.json
  Future<List<NoOfPageModel>> loadNoofPageAsset() async {
    final String jsonString = await rootBundle.loadString('assets/noPage.json');
    final List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((item) => NoOfPageModel.fromJson(item)).toList();
  }

  // Load JSON data from assets assets/CoverType.json
  Future<List<CoverModel>> loadCoverTypeAsset() async {
    final String jsonString = await rootBundle.loadString(
      'assets/covertype.json',
    );
    final List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((item) => CoverModel.fromJson(item)).toList();
  }

  var snackBar = SnackBar(
    content: Text(
      ' Please wait, work in progress...',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    duration: Duration(seconds: 3),
    backgroundColor: const Color.fromARGB(255, 240, 107, 151),
  );
  @override
  void initState() {
    super.initState();

    boundtyperomAsset().then((data) {
      setState(() {
        boundTypePage = data;
      });
    });

    modelstapleboundFromAsset().then((data) {
      setState(() {
        modelPage = data;
      });
    });

    modelspiralboundFromAsset().then((data) {
      setState(() {
        modelPage2 = data;
      });
    });

    loadCoverAsset().then((data) {
      setState(() {
        coverModel = data;
      });
    });

    boardCoverTypeAsset().then((data) {
      setState(() {
        coverBoard = data;
      });
    });

    qualityCoverTypeAsset().then((data) {
      setState(() {
        coverquality = data;
      });
    });

    pageMTypeAsset().then((data) {
      setState(() {
        pageM = data;
      });
    });

    pagethiknessAsset().then((data) {
      setState(() {
        pagethikness = data;
      });
    });
    loadNoofPageAsset().then((data) {
      setState(() {
        noOfPage = data;
      });
    });

    loadCoverTypeAsset().then((data) {
      setState(() {
        coverType = data;
      });
    });
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

              DropdownButtonFormField<Boundtype>(
                value: selectedboundTypePage,
                isExpanded: true,
                hint: Text("Select a model"),
                items:
                    boundTypePage
                        .map((boundTypePage) {
                          return DropdownMenuItem<Boundtype>(
                            value: boundTypePage,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(boundTypePage.name),
                            ),
                          );
                        })
                        .toSet()
                        .toList(),
                onChanged: (Boundtype? newValue) {
                  setState(() {
                    selectedboundTypePage = newValue;
                    if (selectedboundTypePage == "Spiral Bound") {
                      modelPage = modelPage2.cast<ModelPage>();
                    } else if (selectedboundTypePage == "Staple Bound") {
                      modelPage = modelPage.cast<ModelPage>();
                    } else if (selectedboundTypePage == "Glu Bound") {
                      //listItem = dataListC;
                    }

                    // if (selectedboundTypePage!.name == "Spiral Bound") {
                    //   modelPage = modelPage2!.firstWhere(
                    //       (element) => element.id == 1,
                    //   ) as List<ModelPage>;
                    //   print("selectet value ...${modelPage}");
                    // } else if (selectedboundTypePage!.name == "Staple Bound") {
                    //   modelPage = boundTypePage.firstWhere(
                    //       (element) => element.id == 12,
                    //   ) as List<ModelPage>;
                    //   print("selectet value ...${boundValue}");
                    // } else {

                    //   print("selectet value ...${boundValue}");
                    // }
                  });
                },

                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
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

              DropdownButtonFormField<ModelPage>(
                value: selectedModelPage,
                isExpanded: true,
                hint: Text("Select a Bound type"),
                items:
                    modelPage
                        .map((modelPage) {
                          return DropdownMenuItem<ModelPage>(
                            value: modelPage,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(modelPage.name),
                            ),
                          );
                        })
                        .toSet()
                        .toList(),
                onChanged: (ModelPage? newValue) {
                  setState(() {
                    selectedModelPage = newValue;
                    // print("selectet Bound Value ..."+selectedboundTypePage!.id.toString());

                    // if (selectedboundTypePage!.id > 0 &&
                    //     selectedboundTypePage!.id <= 11) {
                    //   boundValue = newValue!.name;

                    //   print("Staple bound type ...${boundValue}");
                    // } else {
                    //   boundValue = newValue!.name;
                    //   print("Staple bound type ...${boundValue}");
                    // }
                  });
                },

                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
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

              DropdownButtonFormField<CoverModel>(
                value: selectedCover,
                hint: Text("Select a cover"),
                items:
                    coverModel
                        .map((coverValue) {
                          return DropdownMenuItem<CoverModel>(
                            value: coverValue,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(coverValue.name),
                            ),
                          );
                        })
                        .toSet()
                        .toList(),
                onChanged: (CoverModel? newValueCover) {
                  setState(() {
                    selectedCover = newValueCover;
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

              DropdownButtonFormField<CoverBoard>(
                value: selectedBoard,
                hint: Text("Select a board"),
                items:
                    coverBoard.map((coverValue) {
                      return DropdownMenuItem<CoverBoard>(
                        value: coverValue,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(coverValue.name),
                        ),
                      );
                    }).toList(),
                onChanged: (CoverBoard? newValueCover) {
                  setState(() {
                    selectedBoard = newValueCover;
                  });
                },
                decoration: InputDecoration(
                  //labelText: 'Cover',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              // SizedBox(height: 15),
              // Text(
              //   "Cover thikness",
              //   style: TextStyle(
              //     fontSize: 18,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.black,
              //     fontFamily: 'Roboto',
              //     fontStyle: FontStyle.normal,
              //   ),
              // ),
              // SizedBox(height: 15),

              // DropdownButtonFormField<CoverQuality>(
              //   value: selectedquality,
              //   hint: Text("Select a quality"),
              //   items:
              //       coverquality.map((coverValue) {
              //         return DropdownMenuItem<CoverQuality>(
              //           value: coverValue,
              //           child: Padding(
              //             padding: const EdgeInsets.only(left: 16.0),
              //             child: Text(coverValue.name),
              //           ),
              //         );
              //       }).toList(),
              //   onChanged: (CoverQuality? newValueCover) {
              //     setState(() {
              //       selectedquality = newValueCover;
              //     });
              //   },
              //   decoration: InputDecoration(
              //     //labelText: 'Cover',
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(20),
              //     ),
              //   ),
              // ),
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

              // SizedBox(height: 15),
              // Text(
              //   "Page thikness",
              //   style: TextStyle(
              //     fontSize: 18,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.black,
              //     fontFamily: 'Roboto',
              //     fontStyle: FontStyle.normal,
              //   ),
              // ),
              // SizedBox(height: 15),

              // DropdownButtonFormField<PageThikness>(
              //   value: selectedPagethikness,
              //   hint: Text("Select a page"),
              //   items:
              //       pagethikness.map((pagethikness) {
              //         return DropdownMenuItem<PageThikness>(
              //           value: pagethikness,
              //           child: Padding(
              //             padding: const EdgeInsets.only(left: 16.0),
              //             child: Text(pagethikness.name),
              //           ),
              //         );
              //       }).toList(),
              //   onChanged: (PageThikness? newValuepagethikness) {
              //     setState(() {
              //       selectedPagethikness = newValuepagethikness;
              //     });
              //   },
              //   decoration: InputDecoration(
              //     //labelText: 'Cover',
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(20),
              //     ),
              //   ),
              // ),

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
              // Text(
              //   "Cover Type",
              //   style: TextStyle(
              //     fontSize: 18,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.black,
              //     fontFamily: 'Roboto',
              //     fontStyle: FontStyle.normal,
              //   ),
              // ),
              // SizedBox(height: 15),

              // DropdownButtonFormField<CoverModel>(
              //   value: selectedCoverType,
              //   hint: Text("Select a cover type"),
              //   items:
              //       coverType.map((coverValue) {
              //         return DropdownMenuItem<CoverModel>(
              //           value: coverValue,
              //           child: Text(coverValue.name),
              //         );
              //       }).toList(),
              //   onChanged: (CoverModel? newValueCover) {
              //     setState(() {
              //       selectedCoverType = newValueCover;
              //     });
              //   },
              //   decoration: InputDecoration(
              //     //labelText: 'Cover',
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(20),
              //     ),
              //   ),
              // ),
              // SizedBox(height: 15),
              Text(
                selectedboundTypePage == null &&
                        selectedCover == null &&
                        selectedBoard == null &&
                        selectedquality == null &&
                        selectedPageM == null &&
                        selectedNoOfPage == null
                    ? "No value selected"
                    : selectedboundTypePage == null
                    ? "No value selected"
                    : selectedCover == null
                    ? "No value selected"
                    : selectedBoard == null
                    ? "No value selected"
                    : selectedquality == null
                    ? "No value selected"
                    : selectedPageM == null
                    ? "No value selected"
                    : selectedNoOfPage == null
                    ? "No value selected"
                    : "You selected: ${selectedboundTypePage!.value} , ${selectedCover!.name}, ${selectedBoard!.value}, ${selectedquality!.value}, ${selectedPageM!.value},${selectedNoOfPage!.value}",
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
                      selectedquality,
                      selectedPageM,
                      selectedNoOfPage,
                      selectedCoverType,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
    CoverQuality? selectedquality,
    PageType? selectedPageM,
    NoOfPageModel? selectedNoOfPage,
    CoverModel? selectedCoverType,
  ) {
    final stPageSize = double.tryParse(selectedboundTypePage!.value.toString());
    final stGsm = double.tryParse(selectedquality!.name.toString());

    print("Result: ${selectedboundTypePage!.value}, ${selectedquality!.name}");
  }
}
