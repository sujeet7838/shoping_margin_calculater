import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadJsonService {
  static Future<void> uploadData() async {
    final String jsonString =
        await rootBundle.loadString('assets/deshboard.json');

    final Map<String, dynamic> jsonData = json.decode(jsonString);

    final pages = jsonData["pages"];

    for (String pageName in pages.keys) {
      List papers = pages[pageName];

      for (var paper in papers) {
        await FirebaseFirestore.instance
            .collection('pages')
            .doc(pageName)
            .collection('papers')
            .add({
          "id": paper["id"],
          "name": paper["name"],
          "value": int.parse(paper["value"]),
          "type": paper["type"],
        });
      }
    }

    print("✅ Firebase Upload Done");
  }
}