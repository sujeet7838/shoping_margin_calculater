import 'package:flutter/material.dart';

class RimWeight extends StatefulWidget {
  const RimWeight({super.key});

  @override
  State<RimWeight> createState() => _RimWeightState();
}

class _RimWeightState extends State<RimWeight> {
  String? _selectedPageSize, _selectedValueGSM; // To hold selected value
  final List<String> _pageSize = ['46x70', '49x74', '54x78', '58x51'];
  final List<String> _gsm = ['48', '50', '54', '56', '57', '58'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rim Weight")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: _selectedPageSize,
              hint: Text("Select a Page Size"),
              items:
                  _pageSize.map((String stPage) {
                    return DropdownMenuItem<String>(
                      value: stPage,
                      child: Text(stPage),
                    );
                  }).toList(),
              onChanged: (String? newValuePage) {
                setState(() {
                  _selectedPageSize = newValuePage;
                });

                // Do something with the value
                print("Selected: $newValuePage");
              },
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: _selectedValueGSM,
              hint: Text("Select a GSM"),
              items:
                  _gsm.map((String stGSM) {
                    return DropdownMenuItem<String>(
                      value: stGSM,
                      child: Text(stGSM),
                    );
                  }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedValueGSM = newValue;
                });

                // Do something with the value
                print("Selected: $newValue");
              },
            ),
            SizedBox(height: 20),
            Text(
              _selectedValueGSM == null
                  ? "No Value selected"
                  : "You selected: $_selectedPageSize, $_selectedValueGSM",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
