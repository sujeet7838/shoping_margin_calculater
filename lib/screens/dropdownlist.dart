import 'dart:convert';
import 'package:calculater/model/itemmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';




/// MAIN UI SCREEN
class DropdownUI extends StatefulWidget {
  const DropdownUI({super.key});

  @override
  State<DropdownUI> createState() => _DropdownUIState();
}

class _DropdownUIState extends State<DropdownUI> {
  /// JSON Lists
  List<ItemModel> firstList = [];
  List<ItemModel> secondList = [];
  List<ItemModel> thirdList = [];
  List<ItemModel> fifthList = [];
  List<ItemModel> sixthList = [];

  /// Filtered
  List<ItemModel> filteredSecond = [];
  List<ItemModel> filteredThird = [];

  /// Selections
  ItemModel? selectedFirst;
  ItemModel? selectedSecond;
  ItemModel? selectedThird;
  ItemModel? selectedFifth;
  ItemModel? selectedSixth;

  String coverColor = "white";

  @override
  void initState() {
    super.initState();
    loadAllData();
  }

  /// LOAD JSON FROM assets/data/*.json
  Future<List<ItemModel>> loadJson(String path) async {
    final response = await rootBundle.loadString(path);
    final List jsonData = json.decode(response);
    return jsonData.map((e) => ItemModel.fromJson(e)).toList();
  }

  loadAllData() async {
    firstList = await loadJson("assets/boundtype.json");
    secondList = await loadJson("assets/model_sprialbound.json");
    thirdList = await loadJson("assets/model_staplebound.json");
    fifthList = await loadJson("assets/board.json");
    sixthList = await loadJson("assets/page.json");

    setState(() {});
  }

  /// COVER COLOR LOGIC (4th list logic)
  String getCoverColor(String item) {
    if (item == "Crown" || item == "A5/DC Sprial") {
      return "Brown";
    }
    return "Colour";
  }

  /// DROPDOWN BUILDER
  Widget dropdownBox({
    required String title,
    required ItemModel? selected,
    required List<ItemModel> items,
    required Function(ItemModel?) onChanged,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            DropdownButton<ItemModel>(
              isExpanded: true,
              value: selected,
              hint: Text("Select $title"),
              items: items
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.name),
                      ))
                  .toList(),
              onChanged: onChanged,
              underline: Container(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notebook Calculator UI"),
        centerTitle: true,
      ),

      body: firstList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  /// 1️⃣ FIRST
                  dropdownBox(
                    title: "Binding Type",
                    selected: selectedFirst,
                    items: firstList,
                    onChanged: (value) {
                      selectedFirst = value;

                      filteredSecond = secondList
                          .where((e) => e.value == value!.value)
                          .toList();

                      filteredThird = thirdList
                          .where((e) => e.value == value!.value)
                          .toList();

                      selectedSecond = null;
                      selectedThird = null;

                      coverColor = "";
                      setState(() {});
                    },
                  ),

                  /// 2️⃣ SECOND – FILTERED
                  dropdownBox(
                    title: "Second List",
                    selected: selectedSecond,
                    items: filteredSecond,
                    onChanged: (value) {
                      selectedSecond = value;
                      coverColor = getCoverColor(value!.name);
                      setState(() {});
                    },
                  ),

                  /// 3️⃣ THIRD – FILTERED
                  dropdownBox(
                    title: "Third List",
                    selected: selectedThird,
                    items: filteredThird,
                    onChanged: (value) {
                      selectedThird = value;
                      coverColor = getCoverColor(value!.name);
                      setState(() {});
                    },
                  ),

                  /// 4️⃣ AUTO COLOR DISPLAY
                  if (coverColor.isNotEmpty)
                    Card(
                      elevation: 2,
                      color: coverColor == "Brown"
                          ? Colors.brown.shade200
                          : Colors.blue.shade100,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "Cover Color: $coverColor",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                  const SizedBox(height: 20),

                  /// 5️⃣ FIFTH
                  dropdownBox(
                    title: "Board / Material",
                    selected: selectedFifth,
                    items: fifthList,
                    onChanged: (value) {
                      selectedFifth = value;
                      setState(() {});
                    },
                  ),

                  /// 6️⃣ SIXTH
                  dropdownBox(
                    title: "Paper GSM",
                    selected: selectedSixth,
                    items: sixthList,
                    onChanged: (value) {
                      selectedSixth = value;
                      setState(() {});
                    },
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 16),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "SUBMIT",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
