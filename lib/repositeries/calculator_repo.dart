import 'dart:convert';

import 'package:calculater/model/noOfPage.dart';

import 'package:flutter/services.dart';

class CalculatorRepository {
  Future<List<NoOfPageModel>> loadNoofPageAsset() async {
    final String jsonString = await rootBundle.loadString('assets/noPage.json');
    final List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((item) => NoOfPageModel.fromJson(item)).toList();
  }

// Future<void> loadData() async {
//   final snapshot =
//       await FirebaseFirestore.instance.collection('pages').get();

//   for (var doc in snapshot.docs) {
//     final papers =
//         await doc.reference.collection('papers').get();

//     pagesData[doc.id] =
//         papers.docs.map((e) => e.data()).toList();
//   }

//   setState(() {});
// }
}
