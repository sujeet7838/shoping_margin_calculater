import 'dart:convert';

import 'package:calculater/model/boundtype.dart';
import 'package:calculater/model/coverBoard.dart';
import 'package:calculater/model/coverModel.dart';
import 'package:calculater/model/model.dart';
import 'package:calculater/model/noOfPage.dart';
import 'package:calculater/model/pageTypeModel.dart';
import 'package:flutter/services.dart';

class CalculatorRepository {
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

  // Load JSON data from assets assets/model_glubound.json
  Future<List<ModelPage>> modelgluboundFromAsset() async {
    final String jsonString = await rootBundle.loadString(
      'assets/model_glubound.json',
    );
    final List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((item) => ModelPage.fromJson(item)).toList();
  }

  //Load JSON data from assets assets/CoverType.json
  Future<List<CoverModel>> loadCoverAsset() async {
    final String jsonString = await rootBundle.loadString('assets/cover.json');
    final List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((item) => CoverModel.fromJson(item)).toList();
  }

  // // Load JSON data from assets assets/CoverBoard.json
  Future<List<CoverBoard>> boardCoverTypeAsset() async {
    final String jsonString = await rootBundle.loadString('assets/board.json');
    final List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((item) => CoverBoard.fromJson(item)).toList();
  }



  // // Load JSON data from assets assets/page.json
  Future<List<PageType>> pageMTypeAsset() async {
    final String jsonString = await rootBundle.loadString('assets/page.json');
    final List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((item) => PageType.fromJson(item)).toList();
  }


  // // Load JSON data from assets assets/noPage.json
  Future<List<NoOfPageModel>> loadNoofPageAsset() async {
    final String jsonString = await rootBundle.loadString('assets/noPage.json');
    final List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((item) => NoOfPageModel.fromJson(item)).toList();
  }
}
