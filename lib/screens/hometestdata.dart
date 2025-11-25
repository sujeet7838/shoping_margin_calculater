import 'package:flutter/material.dart';

class HomeScreenTestDatat extends StatefulWidget {
  const  HomeScreenTestDatat ({super.key});

  @override
  State<HomeScreenTestDatat> createState() => _HomeScreenTestDatatState();
}

class _HomeScreenTestDatatState extends State<HomeScreenTestDatat> {

    /// ---------------------
  /// FIRST LIST (Binding Types)
  /// ---------------------
  final List<Map<String, dynamic>> bindingList = [
    {"id": 0, "name": "Sprial Bound", "value": "Sprial Bound"},
    {"id": 1, "name": "Staple bound", "value": "Staple bound"},
    {"id": 2, "name": "Glu Bound", "value": "Glu Bound"},
  ];

  /// ---------------------
  /// SECOND LIST (Spiral products)
  /// ---------------------
  final List<Map<String, dynamic>> spiralList = [
    {"id": 0, "name": "Notes Lover", "value": "60x84"},
    {"id": 1, "name": "Youva Spiral", "value": "60x84"},
    {"id": 2, "name": "Sawera Spiral", "value": "54x78"},
    {"id": 3, "name": "Oblong Sprial", "value": "55x69"},
    {"id": 4, "name": "A5/DC Sprial", "value": "49x74"},
    {"id": 5, "name": "Rangriti Spiral", "value": "68x96"},
  ];

  /// ---------------------
  /// THIRD LIST (Staple products)
  /// ---------------------
  final List<Map<String, dynamic>> stapleList = [
    {"id": 0, "name": "Mogli", "value": "46x70"},
    {"id": 1, "name": "Crown", "value": "46x70"},
    {"id": 2, "name": "A5/DC", "value": "49x74"},
    {"id": 3, "name": "Star Kid", "value": "49x74"},
    {"id": 4, "name": "Saptrishi", "value": "49x74"},
    {"id": 5, "name": "Sawera", "value": "54x78"},
    {"id": 6, "name": "Oblong", "value": "55x69"},
    {"id": 7, "name": "A4 Primum", "value": "60x84"},
    {"id": 8, "name": "Youva", "value": "58x81"},
    {"id": 9, "name": "RangRiti", "value": "68x96"},
    {"id": 10, "name": "Practical", "value": "58x88"},
    {"id": 11, "name": "Scrape Book", "value": "60x84"},
  ];

  /// Selected values
  Map<String, dynamic>? selectedBinding;
  Map<String, dynamic>? selectedBrand;

  /// This will change based on first dropdown
  List<Map<String, dynamic>> filteredBrandList = [];
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

                     /// FIRST DROPDOWN (Binding Type)
            DropdownButtonFormField<Map<String, dynamic>>(
              decoration: InputDecoration(
                labelText: "Select Binding Type",
                border: OutlineInputBorder(),
              ),
              value: selectedBinding,
              items: bindingList.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item['name']),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedBinding = value;
                  selectedBrand = null;

                  /// Decide which list to load
                  if (value!['id'] == 0) {
                    filteredBrandList = spiralList;
                  } else if (value['id'] == 1) {
                    filteredBrandList = stapleList;
                  } else {
                    filteredBrandList = [];
                  }
                });
              },
            ),

            SizedBox(height: 20),

            
            /// SECOND DROPDOWN (Brand)
            DropdownButtonFormField<Map<String, dynamic>>(
              decoration: InputDecoration(
                labelText: "Select Brand",
                border: OutlineInputBorder(),
              ),
              value: selectedBrand,
              items: filteredBrandList.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item['name']),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedBrand = value;
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
